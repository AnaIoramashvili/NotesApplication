//
//  AppDelegate.swift
//  NotesApplication
//
//  Created by Ana on 11/4/24.
//

import UIKit
import CoreData
 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NoteApp")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unresolved error \(error), \(error)")
            }
        }
        return container
    }()
}
