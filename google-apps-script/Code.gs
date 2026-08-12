/**
 * Visagiri enquiry bridge — receives an enquiry submitted from the
 * website's /contact/ form, appends it as a row in this spreadsheet,
 * and saves a copy as a text file in a Drive folder. See
 * docs/google-sheets-setup.md in the website project for the full
 * setup walkthrough (create Sheet, paste this in, deploy as Web App,
 * copy the URL into the site's .env as GOOGLE_APPS_SCRIPT_URL).
 *
 * Nothing here needs editing before deploying — the sheet headers and
 * the Drive folder are created automatically on first use.
 */

var SHEET_NAME = 'Enquiries';
var DRIVE_FOLDER_NAME = 'Visagiri Enquiries';
var SHEET_HEADERS = ['Submitted At', 'Name', 'Email', 'Phone', 'Destination', 'Message'];

function doPost(e) {
  try {
    var data = JSON.parse(e.postData.contents);

    var name = String(data.name || '').trim();
    var email = String(data.email || '').trim();
    if (name === '' || email === '') {
      return jsonResponse({ ok: false, error: 'Missing required field(s).' });
    }

    var phone = String(data.phone || '').trim();
    var destination = String(data.destination || '').trim();
    var message = String(data.message || '').trim();
    var submittedAt = String(data.submitted_at || new Date().toISOString());

    appendToSheet(submittedAt, name, email, phone, destination, message);
    saveToDrive(submittedAt, name, email, phone, destination, message);

    return jsonResponse({ ok: true });
  } catch (err) {
    return jsonResponse({ ok: false, error: String(err) });
  }
}

function appendToSheet(submittedAt, name, email, phone, destination, message) {
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = ss.getSheetByName(SHEET_NAME);
  if (!sheet) {
    sheet = ss.insertSheet(SHEET_NAME);
    sheet.appendRow(SHEET_HEADERS);
    sheet.setFrozenRows(1);
  }
  sheet.appendRow([submittedAt, name, email, phone, destination, message]);
}

function saveToDrive(submittedAt, name, email, phone, destination, message) {
  var folders = DriveApp.getFoldersByName(DRIVE_FOLDER_NAME);
  var folder = folders.hasNext() ? folders.next() : DriveApp.createFolder(DRIVE_FOLDER_NAME);

  var safeStamp = submittedAt.replace(/[:.]/g, '-');
  var fileName = safeStamp + ' - ' + name + '.txt';
  var content = [
    'Submitted: ' + submittedAt,
    'Name: ' + name,
    'Email: ' + email,
    'Phone: ' + (phone || 'Not provided'),
    'Destination: ' + (destination || 'Not specified'),
    '',
    'Message:',
    message,
  ].join('\n');

  folder.createFile(fileName, content, MimeType.PLAIN_TEXT);
}

function jsonResponse(obj) {
  return ContentService
    .createTextOutput(JSON.stringify(obj))
    .setMimeType(ContentService.MimeType.JSON);
}
