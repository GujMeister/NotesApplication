//
//  AppDelegate.swift
//  NotesApp
//
//  Created by Luka Gujejiani on 31.10.24.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NotesApp")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unresolved error \(error), \(error)")
            }
        }
        return container
    }()
}
