//
//  CoreDataNote.swift
//  NoteApp
//
//  Created by Ana Ioramashvili on 31.10.24.
//

import CoreData

class CoreDataNote: NSManagedObject {
    @NSManaged var title: String!
    @NSManaged var content: String!
}
