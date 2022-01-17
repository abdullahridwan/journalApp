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
        TextField("\(noteViewModel.title)", text: $noteViewModel.title)
    }
}

//struct SeeNote_Previews: PreviewProvider {
//    static var previews: some View {
//        let contextViewModel = Note(context: CoreDataManager.shared.viewContext)
//        SeeNote(noteViewModel: contextViewModel() )
//    }
//}



    

