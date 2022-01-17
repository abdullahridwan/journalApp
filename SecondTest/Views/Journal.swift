//
//  Journal.swift
//  SecondTest
//
//  Created by Abdullah Ridwan on 1/16/22.
//

import SwiftUI

struct Journal: View {
    @StateObject private var journalViewModel: JournalViewModel = JournalViewModel()
    @State private var pressedAdd = false
    
    private func deleteNote (at offsets: IndexSet) {
        offsets.forEach { index in
            let task = journalViewModel.allNotes[index]
            journalViewModel.deleteTodo(todo: task)
        }
        journalViewModel.getAllToDos()
    }
    
    var body: some View {
        NavigationView{
            List{
//                ForEach($journalViewModel.allNotes){$aNote in
//                    NavigationLink(destination: SeeNote(noteViewModel: aNote)){
//                        TextField("\(aNote.title)", text: $aNote.title)
//                    }
//                }
                ForEach(0..<journalViewModel.allNotes.count, id: \.self){index in
                    let aNote = $journalViewModel.allNotes[index]
                    NavigationLink(destination: SeeNote(noteViewModel: aNote)){
                        Text(journalViewModel.allNotes[index].title)
                    }
                }
                .onDelete(perform: deleteNote)
            }
            .onAppear(perform: {
                journalViewModel.getAllToDos()
            })
            .onChange(of: pressedAdd, perform: { value in
                journalViewModel.getAllToDos()
            })
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        addItem()
                        pressedAdd.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
    //.environmentObject(journalViewModel)
}

@ViewBuilder
func seeANote(nvm: NoteViewModel) -> some View {
    VStack{
        TextField("\(nvm.title)", text: .constant(nvm.title))
        Text(nvm.content )
    }
}

private func addItem() {
    withAnimation {
        let newNote = Note(context: CoreDataManager.shared.viewContext)
        newNote.title = "A new Title"
        newNote.content = "Some Content"
        newNote.modifiedDate = Date()
        newNote.createdDate = Date()

        do {
            try CoreDataManager.shared.viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        //journalViewModel.getAllToDos()
        
    }
}





struct Journal_Previews: PreviewProvider {
    static var previews: some View {
        Journal()
    }
}
