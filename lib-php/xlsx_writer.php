<?php
/**
 * A minimal, dependency-free .xlsx (OOXML spreadsheet) writer.
 *
 * This project has zero external dependencies anywhere — no Composer, no
 * vendor/ directory (.htaccess even blocks composer.json/lock explicitly) —
 * so pulling in a library like PhpSpreadsheet for one export feature would
 * be out of character with everything else here. An .xlsx is just a ZIP of
 * a handful of XML parts; PHP's bundled ZipArchive is enough to build one
 * correctly by hand. Scope is deliberately narrow: one flat sheet, a header
 * row, inline strings (no shared-strings table — simpler, still fully
 * valid OOXML), numbers written as real numeric cells so Excel treats them
 * as numbers. No styles, no formulas, no multiple sheets — nothing this
 * project doesn't actually need.
 */
declare(strict_types=1);

function xlsx_col_letter(int $index): string
{
    $letter = '';
    $index++;
    while ($index > 0) {
        $rem = ($index - 1) % 26;
        $letter = chr(65 + $rem) . $letter;
        $index = intdiv($index - 1, 26);
    }
    return $letter;
}

function xlsx_escape(string $s): string
{
    return htmlspecialchars($s, ENT_XML1 | ENT_COMPAT, 'UTF-8');
}

/**
 * @param string   $path    Destination file path.
 * @param string   $sheet   Sheet name (Excel limits this to 31 chars).
 * @param string[] $headers Column headers, in order.
 * @param array<int, array<int, string|int|float|null>> $rows Row data,
 *        each row the same length/order as $headers.
 */
function xlsx_write(string $path, string $sheet, array $headers, array $rows): bool
{
    $sheetName = xlsx_escape(mb_substr($sheet, 0, 31));

    $rowsXml = '';
    $r = 1;
    $cellsXml = '';
    foreach ($headers as $i => $h) {
        $ref = xlsx_col_letter($i) . $r;
        $cellsXml .= '<c r="' . $ref . '" t="inlineStr"><is><t xml:space="preserve">' . xlsx_escape((string) $h) . '</t></is></c>';
    }
    $rowsXml .= '<row r="' . $r . '">' . $cellsXml . '</row>';

    foreach ($rows as $row) {
        $r++;
        $cellsXml = '';
        foreach (array_values($row) as $i => $val) {
            $ref = xlsx_col_letter($i) . $r;
            if ($val === null || $val === '') {
                continue;
            }
            if (is_int($val) || is_float($val)) {
                $cellsXml .= '<c r="' . $ref . '"><v>' . $val . '</v></c>';
            } else {
                $cellsXml .= '<c r="' . $ref . '" t="inlineStr"><is><t xml:space="preserve">' . xlsx_escape((string) $val) . '</t></is></c>';
            }
        }
        $rowsXml .= '<row r="' . $r . '">' . $cellsXml . '</row>';
    }

    $contentTypes = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' .
        '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">' .
        '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>' .
        '<Default Extension="xml" ContentType="application/xml"/>' .
        '<Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>' .
        '<Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>' .
        '</Types>';

    $rootRels = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' .
        '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">' .
        '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>' .
        '</Relationships>';

    $workbook = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' .
        '<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">' .
        '<sheets><sheet name="' . $sheetName . '" sheetId="1" r:id="rId1"/></sheets>' .
        '</workbook>';

    $workbookRels = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' .
        '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">' .
        '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/>' .
        '</Relationships>';

    $lastCol = xlsx_col_letter(max(0, count($headers) - 1));
    $worksheet = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' .
        '<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">' .
        '<dimension ref="A1:' . $lastCol . $r . '"/>' .
        '<sheetData>' . $rowsXml . '</sheetData>' .
        '</worksheet>';

    $tmp = $path . '.tmp';
    @unlink($tmp);
    $zip = new ZipArchive();
    if ($zip->open($tmp, ZipArchive::CREATE | ZipArchive::OVERWRITE) !== true) {
        return false;
    }
    $zip->addEmptyDir('_rels');
    $zip->addEmptyDir('xl');
    $zip->addEmptyDir('xl/_rels');
    $zip->addEmptyDir('xl/worksheets');
    $zip->addFromString('[Content_Types].xml', $contentTypes);
    $zip->addFromString('_rels/.rels', $rootRels);
    $zip->addFromString('xl/workbook.xml', $workbook);
    $zip->addFromString('xl/_rels/workbook.xml.rels', $workbookRels);
    $zip->addFromString('xl/worksheets/sheet1.xml', $worksheet);
    $zip->close();

    return rename($tmp, $path);
}
