/* =========================================================
   AI NOTEPAD
   Notes + Rename + Delete + Search + Theme
   Gemini connection will be added in the next step.
   ========================================================= */


// =========================================================
// STORAGE
// =========================================================

const STORAGE_KEY = "ai-notepad-notes";
const ACTIVE_NOTE_KEY = "ai-notepad-active";
const THEME_KEY = "ai-notepad-theme";


// =========================================================
// ELEMENTS
// =========================================================

const newNoteBtn = document.getElementById("newNoteBtn");
const sidebarNewBtn = document.getElementById("sidebarNewBtn");

const saveBtn = document.getElementById("saveBtn");
const downloadBtn = document.getElementById("downloadBtn");

const themeBtn = document.getElementById("themeBtn");

const notesList = document.getElementById("notesList");
const noteCount = document.getElementById("noteCount");

const searchInput = document.getElementById("searchInput");

const noteTitle = document.getElementById("noteTitle");
const noteContent = document.getElementById("noteContent");

const renameBtn = document.getElementById("renameBtn");
const deleteBtn = document.getElementById("deleteBtn");

const undoBtn = document.getElementById("undoBtn");
const redoBtn = document.getElementById("redoBtn");

const cutBtn = document.getElementById("cutBtn");
const copyBtn = document.getElementById("copyBtn");
const pasteBtn = document.getElementById("pasteBtn");

const clearBtn = document.getElementById("clearBtn");

const wordCount = document.getElementById("wordCount");
const charCount = document.getElementById("charCount");
const lineCount = document.getElementById("lineCount");

const saveStatus = document.getElementById("saveStatus");
const lastUpdated = document.getElementById("lastUpdated");


// Rename modal
const renameModal = document.getElementById("renameModal");
const renameInput = document.getElementById("renameInput");

const closeRenameModal =
    document.getElementById("closeRenameModal");

const cancelRename =
    document.getElementById("cancelRename");

const confirmRename =
    document.getElementById("confirmRename");


// Delete modal
const deleteModal = document.getElementById("deleteModal");

const closeDeleteModal =
    document.getElementById("closeDeleteModal");

const cancelDelete =
    document.getElementById("cancelDelete");

const confirmDelete =
    document.getElementById("confirmDelete");


// =========================================================
// APPLICATION STATE
// =========================================================

let notes = [];
let activeNoteId = null;


// =========================================================
// INITIALIZATION
// =========================================================

document.addEventListener("DOMContentLoaded", () => {

    loadTheme();

    loadNotes();

    setupEvents();

    updateStats();

});


// =========================================================
// LOAD NOTES
// =========================================================

function loadNotes() {

    const savedNotes =
        localStorage.getItem(STORAGE_KEY);

    if (savedNotes) {

        try {

            notes = JSON.parse(savedNotes);

        } catch (error) {

            notes = [];

        }

    }

    if (!Array.isArray(notes) || notes.length === 0) {

        createInitialNote();

    }

    const savedActive =
        localStorage.getItem(ACTIVE_NOTE_KEY);

    if (
        savedActive &&
        notes.some(note => note.id === savedActive)
    ) {

        activeNoteId = savedActive;

    } else {

        activeNoteId = notes[0].id;

    }

    renderNotes();

    loadActiveNote();

}


// =========================================================
// INITIAL NOTE
// =========================================================

function createInitialNote() {

    const note = {

        id: generateId(),

        title: "Welcome to AI Notepad",

        content:
`Welcome to AI Notepad!

Start writing your notes here.

You can create multiple notes, rename them, delete them, search them and download them as text files.`,

        createdAt: Date.now(),

        updatedAt: Date.now()

    };

    notes.push(note);

    saveNotesToStorage();

}


// =========================================================
// CREATE NOTE
// =========================================================

function createNote() {

    saveCurrentNote();

    const note = {

        id: generateId(),

        title: "Untitled Note",

        content: "",

        createdAt: Date.now(),

        updatedAt: Date.now()

    };

    notes.unshift(note);

    activeNoteId = note.id;

    localStorage.setItem(
        ACTIVE_NOTE_KEY,
        activeNoteId
    );

    saveNotesToStorage();

    renderNotes();

    loadActiveNote();

    noteTitle.focus();

    noteTitle.select();

}


// =========================================================
// LOAD ACTIVE NOTE
// =========================================================

function loadActiveNote() {

    const note = getActiveNote();

    if (!note) return;

    noteTitle.value = note.title;

    noteContent.value = note.content;

    updateStats();

    updateSaveStatus("Saved");

    updateLastUpdated(note.updatedAt);

} 


// =========================================================
// GET ACTIVE NOTE
// =========================================================

function getActiveNote() {

    return notes.find(
        note => note.id === activeNoteId
    );

}


// =========================================================
// SAVE CURRENT NOTE
// =========================================================

function saveCurrentNote() {

    const note = getActiveNote();

    if (!note) return;

    note.title =
        noteTitle.value.trim() ||
        "Untitled Note";

    note.content =
        noteContent.value;

    note.updatedAt = Date.now();

    saveNotesToStorage();

    renderNotes();

    updateStats();

    updateSaveStatus("Saved");

    updateLastUpdated(note.updatedAt);

}


// =========================================================
// STORAGE
// =========================================================

function saveNotesToStorage() {

    localStorage.setItem(
        STORAGE_KEY,
        JSON.stringify(notes)
    );

}


// =========================================================
// RENDER NOTES
// =========================================================

function renderNotes() {

    const searchTerm =
        searchInput.value
            .trim()
            .toLowerCase();

    const filteredNotes =
        notes.filter(note => {

            return (
                note.title
                    .toLowerCase()
                    .includes(searchTerm) ||

                note.content
                    .toLowerCase()
                    .includes(searchTerm)
            );

        });


    notesList.innerHTML = "";


    filteredNotes.forEach(note => {

        const item =
            document.createElement("div");

        item.className =
            "note-item" +
            (note.id === activeNoteId
                ? " active"
                : "");


        const preview =
            note.content
                .replace(/\s+/g, " ")
                .trim();


        item.innerHTML = `

            <div class="note-item-title">
                ${escapeHtml(note.title)}
            </div>

            <div class="note-item-preview">
                ${escapeHtml(
                    preview || "No content"
                )}
            </div>

            <div class="note-item-date">
                ${formatDate(note.updatedAt)}
            </div>

        `;


        item.addEventListener(
            "click",
            () => {

                saveCurrentNote();

                activeNoteId = note.id;

                localStorage.setItem(
                    ACTIVE_NOTE_KEY,
                    activeNoteId
                );

                renderNotes();

                loadActiveNote();

            }
        );


        notesList.appendChild(item);

    });


    updateNoteCount();

}


// =========================================================
// NOTE COUNT
// =========================================================

function updateNoteCount() {

    const count = notes.length;

    noteCount.textContent =
        `${count} ${count === 1 ? "note" : "notes"}`;

}


// =========================================================
// RENAME NOTE
// =========================================================

function openRenameModal() {

    const note = getActiveNote();

    if (!note) return;

    renameInput.value = note.title;

    renameModal.classList.remove("hidden");

    setTimeout(() => {

        renameInput.focus();

        renameInput.select();

    }, 50);

}


function renameCurrentNote() {

    const note = getActiveNote();

    if (!note) return;

    const newName =
        renameInput.value.trim();

    if (!newName) {

        alert("Please enter a note name.");

        return;

    }

    note.title = newName;

    note.updatedAt = Date.now();

    saveNotesToStorage();

    noteTitle.value = newName;

    renderNotes();

    updateLastUpdated(note.updatedAt);

    closeRename();

}


function closeRename() {

    renameModal.classList.add("hidden");

}


// =========================================================
// DELETE NOTE
// =========================================================

function openDeleteModal() {

    const note = getActiveNote();

    if (!note) return;

    deleteModal.classList.remove("hidden");

}


function deleteCurrentNote() {

    if (notes.length === 1) {

        alert(
            "You must keep at least one note."
        );

        closeDelete();

        return;

    }


    const index =
        notes.findIndex(
            note => note.id === activeNoteId
        );


    if (index === -1) return;


    notes.splice(index, 1);


    activeNoteId =
        notes[Math.max(0, index - 1)].id;


    localStorage.setItem(
        ACTIVE_NOTE_KEY,
        activeNoteId
    );


    saveNotesToStorage();

    renderNotes();

    loadActiveNote();

    closeDelete();

}


function closeDelete() {

    deleteModal.classList.add("hidden");

}


// =========================================================
// SEARCH
// =========================================================

function searchNotes() {

    renderNotes();

}


// =========================================================
// DOWNLOAD
// =========================================================

function downloadNote() {

    const note = getActiveNote();

    if (!note) return;

    const content =
`${note.title}

${note.content}
`;

    const blob =
        new Blob(
            [content],
            { type: "text/plain;charset=utf-8" }
        );

    const url =
        URL.createObjectURL(blob);

    const link =
        document.createElement("a");

    link.href = url;

    link.download =
        `${sanitizeFileName(note.title)}.txt`;

    document.body.appendChild(link);

    link.click();

    link.remove();

    URL.revokeObjectURL(url);

}


// =========================================================
// TEXT EDITING
// =========================================================

function updateStats() {

    const text = noteContent.value;

    const words =
        text.trim()
            ? text.trim().split(/\s+/).length
            : 0;

    const characters =
        text.length;

    const lines =
        text.length === 0
            ? 1
            : text.split("\n").length;


    wordCount.textContent = words;

    charCount.textContent = characters;

    lineCount.textContent = lines;

}


// =========================================================
// SAVE STATUS
// =========================================================

function updateSaveStatus(status) {

    saveStatus.innerHTML = `
        <i class="fa-solid fa-circle"></i>
        ${status}
    `;

}


function updateLastUpdated(timestamp) {

    lastUpdated.textContent =
        formatDate(timestamp);

}


// =========================================================
// TEXT ACTIONS
// =========================================================

function undo() {

    document.execCommand("undo");

    updateStats();

}


function redo() {

    document.execCommand("redo");

    updateStats();

}

async function askGemini() {

    const prompt = "Explain Kubernetes in simple words.";

    try {

        const response = await fetch("/api/ai/ask", {

            method: "POST",

            headers: {
                "Content-Type": "application/json"
            },

            body: JSON.stringify({
                prompt: prompt
            })

        });

        const data = await response.json();

        console.log("Gemini response:", data);

    } catch (error) {

        console.error("Error connecting to Gemini:", error);

    }
}

askGemini();

async function copyText() {

    const selected =
        noteContent.value.substring(
            noteContent.selectionStart,
            noteContent.selectionEnd
        );

    if (!selected) {

        alert("Select some text first.");

        return;

    }

    try {

        await navigator.clipboard.writeText(
            selected
        );

    } catch {

        document.execCommand("copy");

    }

}


async function cutText() {

    const start =
        noteContent.selectionStart;

    const end =
        noteContent.selectionEnd;

    if (start === end) {

        alert("Select some text first.");

        return;

    }

    try {

        await navigator.clipboard.writeText(
            noteContent.value.substring(start, end)
        );

    } catch {}

    noteContent.setRangeText(
        "",
        start,
        end,
        "start"
    );

    handleContentChange();

}


async function pasteText() {

    try {

        const text =
            await navigator.clipboard.readText();

        const start =
            noteContent.selectionStart;

        const end =
            noteContent.selectionEnd;

        noteContent.setRangeText(
            text,
            start,
            end,
            "end"
        );

        handleContentChange();

    } catch {

        alert(
            "Clipboard access is blocked by the browser."
        );

    }

}


function clearNote() {

    if (!noteContent.value.trim()) return;

    const confirmed =
        confirm(
            "Clear all content from this note?"
        );

    if (!confirmed) return;

    noteContent.value = "";

    handleContentChange();

}


// =========================================================
// CONTENT CHANGE
// =========================================================

let autoSaveTimer = null;

function handleContentChange() {

    updateStats();

    updateSaveStatus("Unsaved");

    clearTimeout(autoSaveTimer);

    autoSaveTimer =
        setTimeout(() => {

            saveCurrentNote();

        }, 700);

}


// =========================================================
// THEME
// =========================================================

function loadTheme() {

    const theme =
        localStorage.getItem(THEME_KEY);

    if (theme === "dark") {

        document.body.classList.add("dark");

        themeBtn.innerHTML =
            `<i class="fa-solid fa-sun"></i>`;

    }

}


function toggleTheme() {

    document.body.classList.toggle("dark");

    const isDark =
        document.body.classList.contains("dark");


    localStorage.setItem(
        THEME_KEY,
        isDark ? "dark" : "light"
    );


    themeBtn.innerHTML =
        isDark
            ? `<i class="fa-solid fa-sun"></i>`
            : `<i class="fa-solid fa-moon"></i>`;

}


// =========================================================
// EVENT SETUP
// =========================================================

function setupEvents() {

    newNoteBtn.addEventListener(
        "click",
        createNote
    );

    sidebarNewBtn.addEventListener(
        "click",
        createNote
    );


    saveBtn.addEventListener(
        "click",
        saveCurrentNote
    );


    downloadBtn.addEventListener(
        "click",
        downloadNote
    );


    themeBtn.addEventListener(
        "click",
        toggleTheme
    );


    noteTitle.addEventListener(
        "input",
        handleContentChange
    );


    noteContent.addEventListener(
        "input",
        handleContentChange
    );


    searchInput.addEventListener(
        "input",
        searchNotes
    );


    renameBtn.addEventListener(
        "click",
        openRenameModal
    );


    confirmRename.addEventListener(
        "click",
        renameCurrentNote
    );


    cancelRename.addEventListener(
        "click",
        closeRename
    );


    closeRenameModal.addEventListener(
        "click",
        closeRename
    );


    renameInput.addEventListener(
        "keydown",
        event => {

            if (event.key === "Enter") {

                renameCurrentNote();

            }

            if (event.key === "Escape") {

                closeRename();

            }

        }
    );


    deleteBtn.addEventListener(
        "click",
        openDeleteModal
    );


    confirmDelete.addEventListener(
        "click",
        deleteCurrentNote
    );


    cancelDelete.addEventListener(
        "click",
        closeDelete
    );


    closeDeleteModal.addEventListener(
        "click",
        closeDelete
    );


    undoBtn.addEventListener(
        "click",
        undo
    );


    redoBtn.addEventListener(
        "click",
        redo
    );


    copyBtn.addEventListener(
        "click",
        copyText
    );


    cutBtn.addEventListener(
        "click",
        cutText
    );


    pasteBtn.addEventListener(
        "click",
        pasteText
    );


    clearBtn.addEventListener(
        "click",
        clearNote
    );


    document.addEventListener(
        "keydown",
        handleKeyboardShortcuts
    );


    window.addEventListener(
        "beforeunload",
        saveCurrentNote
    );

}


// =========================================================
// KEYBOARD SHORTCUTS
// =========================================================

function handleKeyboardShortcuts(event) {

    if (!event.ctrlKey) return;


    switch (event.key.toLowerCase()) {

        case "n":

            event.preventDefault();

            createNote();

            break;


        case "s":

            event.preventDefault();

            saveCurrentNote();

            break;


        case "f":

            event.preventDefault();

            searchInput.focus();

            break;

    }

}


// =========================================================
// HELPERS
// =========================================================

function generateId() {

    return (
        Date.now().toString(36) +
        Math.random()
            .toString(36)
            .substring(2, 8)
    );

}


function formatDate(timestamp) {

    const date =
        new Date(timestamp);

    const now =
        new Date();

    const diff =
        now - date;


    if (diff < 60000) {

        return "Just now";

    }


    if (diff < 3600000) {

        return `${Math.floor(diff / 60000)}m ago`;

    }


    if (diff < 86400000) {

        return `${Math.floor(diff / 3600000)}h ago`;

    }


    return date.toLocaleDateString(
        undefined,
        {
            month: "short",
            day: "numeric"
        }
    );

}


function sanitizeFileName(name) {

    return name
        .replace(/[<>:"/\\|?*]/g, "")
        .trim() || "note";

}


function escapeHtml(text) {

    const div =
        document.createElement("div");

    div.textContent = text;

    return div.innerHTML;

}


// =========================================================
// KEYBOARD SHORTCUT FOR GEMINI PANEL
// =========================================================
// Gemini functionality will be connected later.


// =========================================================
// FINISH
// =========================================================

console.log(
    "AI Notepad loaded successfully."
);
  
