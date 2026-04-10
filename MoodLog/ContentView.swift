//
//  ContentView.swift
//  MoodLog
//
//  Created by Ignacio Lagos Morales on 27-03-26.
//

import SwiftData
import SwiftUI

struct ContentView: View {

    //Lee todos los MoodEntry de SwiftData automaticamente
    @Query var moodEntries: [MoodEntry]

    //Instancia el ViewModel y lo observa por cambios
    @StateObject var viewModel: MoodViewModel = MoodViewModel()

    @State private var isSheetDisplayed: Bool = false

    //Es lo que escribe en SwiftData (supongo que hace los insertos de data en la DB)
    @Environment(\.modelContext) private var mContext

    var body: some View {

        NavigationStack {
            List {
                ForEach(moodEntries) { entry in

                    VStack(alignment: .leading, spacing: 5) {
                        Text(entry.moodType.rawValue)
                            .bold()
                        Text(entry.notes ?? "Sin notas")
                    }

                }
                .onDelete(){ indexSet in
                    
                    viewModel.deleteMoodEntry(modelContext: mContext, registros: moodEntries, id: indexSet)
                }
            }
            .sheet(isPresented: $isSheetDisplayed) {
                AddMoodEntryView()
            }
            .navigationTitle("Mood Log")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    (Button("+") {
                        isSheetDisplayed = true
                        //viewModel.addMoodEntry(modelContext: modelContext, moodType: MoodType.cansado, notes: nil)
                    })
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
