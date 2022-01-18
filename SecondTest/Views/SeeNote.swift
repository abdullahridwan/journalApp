//
//  SeeNote.swift
//  SecondTest
//
//  Created by Abdullah Ridwan on 1/16/22.
//

import SwiftUI

struct SeeNote: View {
    @Binding var noteViewModel: NoteViewModel
    @EnvironmentObject var journalViewModel: JournalViewModel
    var body: some View {
        VStack{
            TextField("\(noteViewModel.title)", text: Binding(
                get: { noteViewModel.title },
                set: { noteViewModel.title = $0 }
                ))
                .padding()
                .textFieldStyle(PlainTextFieldStyle())
            TextEditor(text: $noteViewModel.content)
                .onDebouncedChange(of: $noteViewModel.content, debounceFor: 1, perform: {_ in 
                    journalViewModel.updateTodo(tdvm: noteViewModel)
                })
                            .padding()
            
        }
    }
}

//struct SeeNote_Previews: PreviewProvider {
//    static var previews: some View {
//        let contextViewModel = Note(context: CoreDataManager.shared.viewContext)
//        SeeNote(noteViewModel: contextViewModel() )
//    }
//}

extension NSTextField {
        open override var focusRingType: NSFocusRingType {
                get { .none }
                set { }
        }
}



    

