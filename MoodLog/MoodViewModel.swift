//
//  MoodViewModel.swift
//  MoodLog
//
//  Created by Ignacio Lagos Morales on 28-03-26.
//

// Importa tipos básicos de Swift y Foundation.
// Aquí viven cosas como `Date`.
import Foundation

// Importa Combine.
// `ObservableObject` viene de aquí.
import Combine

// Importa SwiftData.
// Aquí vive `ModelContext`, que sirve para trabajar con los datos guardados.
import SwiftData

// `public` significa que esta clase puede ser visible fuera de este archivo
// y fuera de su módulo si el proyecto lo necesitara.
//
// `class MoodViewModel` crea una clase llamada `MoodViewModel`.
//
// `: ObservableObject` significa que esta clase puede ser observada por SwiftUI.
// Eso sirve cuando una vista necesita reaccionar a cambios dentro de este objeto.
public class MoodViewModel: ObservableObject {
    
    // Esta función crea una nueva entrada de ánimo y la inserta en SwiftData.
    //
    // Parámetros:
    // - `modelContext`: el contexto que permite hablar con SwiftData.
    // - `moodType`: el tipo de estado de ánimo elegido.
    // - `notes`: la nota opcional escrita por la persona.
    //
    // `notes: String?` significa:
    // puede venir un texto (`String`) o puede venir `nil`.
    // `nil` significa "no hay valor".
    func addMoodEntry(modelContext: ModelContext, moodType: MoodType, notes: String?)
    {
        // `let` crea una constante.
        // `newEntry` será el nombre de la nueva entrada que estamos creando.
        //
        // `MoodEntry(...)` llama al inicializador del modelo `MoodEntry`.
        // En esta línea se crea un objeto nuevo en memoria.
        //
        // Lo que estamos pasando es:
        // - `date: Date()` -> la fecha y hora actual
        // - `moodType: moodType` -> el estado de ánimo que llegó al método
        // - `notes: notes` -> la nota que llegó al método
        let newEntry = MoodEntry(date: Date(), moodType: moodType, notes: notes)
        
        // Esta línea inserta `newEntry` en SwiftData usando el `modelContext`.
        //
        // Muy importante:
        // aquí no estamos creando el `modelContext`.
        // El método lo recibe ya listo desde afuera.
        //
        // También importante:
        // `insert` agrega el objeto al contexto de datos.
        // Eso hace que SwiftData lo empiece a manejar como un dato del modelo.
        modelContext.insert(newEntry)
    }
    
    func deleteMoodEntry(modelContext: ModelContext, registros: [MoodEntry] , id: IndexSet)
    {
        //borrar entry
        let index = id.first ?? 0
        let registroAEliminar = registros[index]
        
        modelContext.delete(registroAEliminar)
        
    }
}
