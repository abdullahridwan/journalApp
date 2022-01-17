//
//  CoreDataManager.swift
//  SecondTest
//
//  Created by Abdullah Ridwan on 1/16/22.
//

import Foundation
import CoreData


class CoreDataManager{
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private init() {
        persistentContainer = NSPersistentContainer(name: "NoteModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize CD Stack \(error)")
            }
        }
    }
    
    //Helper Functions
    func getToDoByID(noteId: NSManagedObjectID) -> Note? {
        do{
            return try viewContext.existingObject(with: noteId) as? Note
        } catch {
            return nil
        }
    }
    
    //Main Functions
    func save(){
        do{
            try viewContext.save()
        } catch {
            viewContext.rollback()
        }
    }
    func getAllToDo() -> [Note]{
        //make a request
        let request = NSFetchRequest<Note>(entityName: "Note")
        //execute request
        do{
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    func updateToDo(note: Note){
        save()
    }
    func deleteToDo(note: Note){
        viewContext.delete(note)
        save()
    }
    
}

