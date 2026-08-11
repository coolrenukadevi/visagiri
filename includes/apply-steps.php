<?php
declare(strict_types=1);

/** Shared 3-step progress indicator for the /apply/ wizard. */
function renderApplyStepper(int $current): void
{
    $steps = ['Destination', 'Applicant Details', 'Review & Submit'];
    ?>
    <ol class="apply-stepper">
        <?php foreach ($steps as $i => $label): $n = $i + 1; ?>
        <li class="<?= $n < $current ? 'is-complete' : ($n === $current ? 'is-current' : '') ?>">
            <span class="apply-stepper__num"><?= $n < $current ? '&#10003;' : $n ?></span>
            <span class="apply-stepper__label"><?= e($label) ?></span>
        </li>
        <?php endforeach; ?>
    </ol>
    <?php
}
