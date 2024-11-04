//
//  DataManager.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 31.10.24.
//

import CoreData

final class DataManager {
    // MARK: - Properties
    static let shared = DataManager()
    
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NotesApp")
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

    // Fetch Notes
    func fetchNotes() -> [NoteModel] {
        let fetchRequest = NoteModel.fetchRequest() as! NSFetchRequest<NoteModel>
        
        do {
            let notes = try context.fetch(fetchRequest)
            return notes
        } catch {
            print("Failed to fetch notes: \(error)")
            return []
        }
    }
    
    // Add Note
    func addNote(title: String, body: String) {
        let note = NoteModel(context: context)
        note.title = title
        note.body = body
        
        saveContext()
    }
    
    // Create Empty Note
    func createEmptyNote() -> NoteModel {
        let note = NoteModel(context: context)
        note.title = ""
        note.body = ""
        
        saveContext()
        return note
    }
    
    //Delete note
    func deleteNote(_ note: NoteModel) {
        context.delete(note)
        saveContext()
    }
    
    // MARK: - Save Context
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
