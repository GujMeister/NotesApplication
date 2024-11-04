//
//  NoteModel.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 31.10.24.
//

import CoreData

class NoteModel: NSManagedObject {
    @NSManaged var title: String!
    @NSManaged var body: String!
}
