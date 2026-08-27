document.addEventListener('DOMContentLoaded', function () {
    var grid = document.getElementById('b2bDocGrid');
    if (!grid || typeof B2B_DOC_REF === 'undefined') { return; }

    grid.querySelectorAll('.b2b-doc-file-input').forEach(function (input) {
        input.addEventListener('change', function () {
            if (!input.files || !input.files.length) { return; }
            var box = input.closest('.b2b-doc-box');
            var docType = box.getAttribute('data-doc-type');
            var progress = box.querySelector('.b2b-doc-progress');
            var statusEl = box.querySelector('[data-doc-status]');
            var filenameEl = box.querySelector('[data-doc-filename]');
            var uploadBtn = box.querySelector('.b2b-doc-upload-btn');

            progress.hidden = false;
            progress.textContent = 'Uploading...';
            progress.className = 'b2b-doc-progress';
            box.classList.add('is-uploading');

            var fd = new FormData();
            fd.append('ref', B2B_DOC_REF);
            fd.append('token', B2B_DOC_TOKEN);
            fd.append('doc_type', docType);
            fd.append('file', input.files[0]);

            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'b2b-document-upload.php', true);
            xhr.onload = function () {
                box.classList.remove('is-uploading');
                var data = {};
                try { data = JSON.parse(xhr.responseText); } catch (e) { /* ignore */ }
                if (xhr.status >= 200 && xhr.status < 300 && data.success) {
                    progress.hidden = true;
                    statusEl.textContent = data.status;
                    statusEl.className = 'b2b-doc-badge b2b-doc-pending';
                    filenameEl.outerHTML = '<a href="' + data.view_url + '" target="_blank" rel="noopener" class="b2b-doc-filename" data-doc-filename><i class="fa-solid fa-file-lines" aria-hidden="true"></i> ' + data.filename.replace(/[<>&]/g, '') + '</a>';
                    uploadBtn.childNodes[0].textContent = 'Replace';
                    var rejectNote = box.querySelector('.b2b-doc-reject-note');
                    if (rejectNote) { rejectNote.remove(); }
                } else {
                    progress.hidden = false;
                    progress.textContent = data.message || 'Upload failed. Please try again.';
                    progress.className = 'b2b-doc-progress is-error';
                }
                input.value = '';
            };
            xhr.onerror = function () {
                box.classList.remove('is-uploading');
                progress.hidden = false;
                progress.textContent = 'Network error. Please try again.';
                progress.className = 'b2b-doc-progress is-error';
                input.value = '';
            };
            xhr.send(fd);
        });
    });
});
