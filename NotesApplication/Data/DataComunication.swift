//
//  DataComunication.swift
//  NoteApp
//
//  Created by Ana Ioramashvili on 31.10.24.
//

import CoreData

protocol DataComunicationDelegate: AnyObject {
    func reloadData()
}

final class DataComunication {
    // MARK: - Properties
    static let shared = DataComunication()
    weak var delegate: DataComunicationDelegate?
    
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NoteApp")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Methods
    
    // Fetch Notes
    func fetchNotes() -> [CoreDataNote] {
        let fetchRequest = CoreDataNote.fetchRequest() as! NSFetchRequest<CoreDataNote>
        
        do {
            let notes = try context.fetch(fetchRequest)
            return notes
        } catch {
            print("Failed to fetch notes: \(error)")
            return []
        }
    }
    
    // Add Note
    func addNote(title: String, content: String) {
        let note = CoreDataNote(context: context)
        note.title = title
        note.content = content
        saveContext()
        delegate?.reloadData()
    }
    
    // Delete Note
    func deleteNote(_ note: CoreDataNote) {
        context.delete(note)
        saveContext()
    }
    
    // Update Note
    func updateNote(at index: Int, title: String, content: String) {
        let notes = fetchNotes()
        guard index < notes.count else { return }
        
        let note = notes[index]
        note.title = title
        note.content = content
        saveContext()
        delegate?.reloadData()
    }
    
    // MARK: - Save Context
    public func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("Saved")
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}


