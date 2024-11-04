//
//  ListViewModel.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 31.10.24.
//

import Foundation

final class ListViewModel {
    // MARK: - Properties
    private var notes: [NoteModel] = [] {
        didSet {
            onNotesUpdated?()
        }
    }
    
    var onNotesUpdated: (() -> Void)?
    
    // MARK: - Lifecycle
    init() {
        print("✅⬅️ Init called in ListViewModel (VIEWMODEL)")
        fetchNotes()
    }
    
    deinit {
        print("🗑️⬅️ Deiniting ListViewModel (VIEWMODEL)")
    }
    
    // MARK: - Methods
    func fetchNotes() {
        notes = DataManager.shared.fetchNotes()
    }
    
    func addNote(title: String, body: String) {
        DataManager.shared.addNote(title: title, body: body)
        fetchNotes()
    }
    
    func deleteNote(at index: Int) {
        let note = notes[index]
        DataManager.shared.deleteNote(note)
        fetchNotes()
    }
    
    func noteCount() -> Int {
        return notes.count
    }
    
    func note(at index: Int) -> Note {
        let noteModel = notes[index]
        return Note(title: noteModel.title, body: noteModel.body)
    }
    
    //For editor ;)
    func coreNote(at index: Int) -> NoteModel {
        return notes[index]
    }
}
