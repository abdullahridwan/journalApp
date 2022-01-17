//
//  JournalViewModel.swift
//  SecondTest
//
//  Created by Abdullah Ridwan on 1/16/22.
//


import Foundation
import CoreData


struct NoteViewModel: Identifiable {
    var note: Note
    var id: NSManagedObjectID
    var title: String
    var content: String
    var createdDate: Date
    var modifiedDate: Date
}

struct NewNote {
    var title: String
    var content: String
    var createdDate: Date
    var modifiedDate: Date
}

final class JournalViewModel: ObservableObject {
    @Published var allNotes: [NoteViewModel] = []

    func save(){
        CoreDataManager.shared.save()
    }
    
    func saveNote(newNote: NewNote){
        let newToDo = Note(context: CoreDataManager.shared.viewContext)
        newToDo.title = newNote.title
        newToDo.modifiedDate = newNote.modifiedDate
        newToDo.createdDate = newNote.createdDate
        CoreDataManager.shared.save()
    }
    func getAllToDos(){
        allNotes = CoreDataManager.shared.getAllToDo().map{ (Note) -> NoteViewModel in
            return NoteViewModel(note: Note, id: Note.objectID, title: Note.title ?? "No Title", content: Note.content ?? "No content", createdDate: Note.createdDate ?? Date(), modifiedDate: Note.modifiedDate ?? Date())
            
        }
    }
    func updateTodo(tdvm: NoteViewModel){
        //get the todo
        let existingToDo = CoreDataManager.shared.getToDoByID(noteId: tdvm.id)
        if let existingToDo = existingToDo{
            existingToDo.title = tdvm.title
            existingToDo.content = tdvm.content
            existingToDo.modifiedDate = tdvm.modifiedDate
            CoreDataManager.shared.updateToDo(note: existingToDo)
        }
        //set the values in the view model to the actual todo
        //and then savenote
    }
    func deleteTodo(todo: NoteViewModel){
        //get the todo by the id
        let existingToDo = CoreDataManager.shared.getToDoByID(noteId: todo.id)
        //if it exists, then delete it from the context
        if let existingToDo = existingToDo {
            CoreDataManager.shared.deleteToDo(note: existingToDo)
        }
    }
}

