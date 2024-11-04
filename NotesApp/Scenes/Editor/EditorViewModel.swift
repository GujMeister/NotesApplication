//
//  EditorViewModel.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 01.11.24.
//

import Foundation

class EditorViewModel {
    private var note: NoteModel?
    var isNewNote: Bool { note == nil }
    
    var onTitleUpdate: ((String?) -> Void)?
    var onBodyUpdate: ((String?) -> Void)?
    
    init(note: NoteModel?) {
        self.note = note
        if note == nil {
            self.note = DataManager.shared.createEmptyNote()
        }
    }
    
    deinit {
        print("🗑️⬅️ Deiniting EditorViewModel")
    }
    
    // MARK: - Methods
    func loadData() {
        onTitleUpdate?(note?.title)
        onBodyUpdate?(note?.body)
    }
    
    func saveNote(title: String, body: String) {
        note?.title = title
        note?.body = body
        
        if let context = note?.managedObjectContext {
            do {
                try context.save()
            } catch {
                print("Failed to save note: \(error)")
            }
        }
    }
}
