(function () {
  'use strict';

  // Any element with data-vc-print on an unlocked checklist page
  // triggers the browser's print dialog against the branded
  // .print-document (see visa-checklist.css's @media print rules and
  // visa/index.php, which only renders .print-document into the page
  // at all once the visitor's checklist access is verified
  // server-side). "Download A4 PDF" uses the same dialog — the
  // visitor picks "Save as PDF" as the destination, matching the
  // client-supplied reference template rather than standing up a
  // separate server-side PDF pipeline this project's hosting can't
  // run (see AUDIT.md).
  document.querySelectorAll('[data-vc-print]').forEach(function (trigger) {
    trigger.addEventListener('click', function (e) {
      e.preventDefault();
      window.print();
    });
  });
})();
