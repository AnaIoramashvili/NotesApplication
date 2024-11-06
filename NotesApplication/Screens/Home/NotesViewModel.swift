//
//  NotesViewModel.swift
//  NoteApp
//
//  Created by Ana Ioramashvili on 31.10.24.
//

import Foundation

protocol NotesViewModelDelegate: AnyObject {
    func notesDidUpdate()
}

final class NotesViewModel {
    // MARK: - Properties
    private(set) var notes: [CoreDataNote] = []
    weak var delegate: NotesViewModelDelegate?
    
    // MARK: - Init
    init() {
        fetchNotes()
    }
    
    // MARK: - Public Methods
    func fetchNotes() {
        notes = DataComunication.shared.fetchNotes()
        delegate?.notesDidUpdate()
    }
    
    func addNote(title: String, content: String) {
        DataComunication.shared.addNote(title: title, content: content)
        fetchNotes()
    }
    
    func deleteNote(at index: Int) {
        let note = notes[index]
        DataComunication.shared.deleteNote(note)
        fetchNotes()
    }
    
    func updateNote(at index: Int, title: String, content: String) {
        DataComunication.shared.updateNote(at: index, title: title, content: content)
        fetchNotes()
    }
    
    var numberOfNotes: Int {
        notes.count
    }
    
    func note(at index: Int) -> Note {
        let coreDataNote = notes[index]
        return Note(
            title: coreDataNote.title,
            content: coreDataNote.content,
            timestamp: coreDataNote.timestamp ?? Date()
        )
    }
}
