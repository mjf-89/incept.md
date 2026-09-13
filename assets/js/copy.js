const editor = document.getElementById('file-editor');
const copyButton = document.getElementById('copy-file');
const copyStatus = document.getElementById('copy-status');
let resetStatus;

copyButton.hidden = false;

async function copyFile() {
    clearTimeout(resetStatus);
    try {
        await navigator.clipboard.writeText(document.getElementById('file-content').textContent.trimEnd());
        copyStatus.textContent = 'Copied to clipboard';
    } catch {
        copyStatus.textContent = 'Select the text and copy manually.';
    }
    resetStatus = setTimeout(() => { copyStatus.textContent = ''; }, 3000);
}

copyButton.addEventListener('click', copyFile);
editor.addEventListener('keydown', (event) => {
    if ((event.ctrlKey || event.metaKey) && !event.altKey && !event.shiftKey &&
        event.key.toLowerCase() === 'c' && window.getSelection().isCollapsed) {
        event.preventDefault();
        copyFile();
    }
});
