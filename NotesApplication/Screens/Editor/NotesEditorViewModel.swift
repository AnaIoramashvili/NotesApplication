//
//  NotesEditorViewModel.swift
//  NoteApp
//
//  Created by Ana Ioramashvili on 04.11.24.
//

final class NotesEditorViewModel {
    // MARK: - Properties
    private var existingNote: Note?
    private var noteIndex: Int?
    private(set) var isEditingMode: Bool
    
    var title: String {
        return existingNote?.title ?? ""
    }
    
    var content: String {
        return existingNote?.content ?? ""
    }
    
    // MARK: - Initialization
    init(note: Note? = nil, index: Int? = nil) {
        self.existingNote = note
        self.noteIndex = index
        self.isEditingMode = note != nil
    }
    
    // MARK: - Methods
    func saveNote(title: String, content: String) -> (note: Note, index: Int?) {
        let note = Note(title: title, content: content)
        return (note, noteIndex)
    }
    
    func shouldShowPlaceholder(for text: String, defaultText: String) -> Bool {
        return text.isEmpty || text == defaultText
    }
    
    func isValidNote(title: String, content: String) -> Bool {
        return !title.isEmpty && title != "Title" &&
               !content.isEmpty && content != "Type something..."
    }
}
