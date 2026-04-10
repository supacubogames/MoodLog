//
//  MoodLogApp.swift
//  MoodLog
//
//  Created by Ignacio Lagos Morales on 27-03-26.
//

// Importa SwiftUI, que se usa para construir la interfaz de la app.
import SwiftUI
// Importa SwiftData, que se usa para guardar y leer datos.
import SwiftData

// `@main` marca este punto como el inicio de la app.
// Cuando la app se abre, Swift comienza aquí.
@main
struct MoodLogApp: App {
    // `body` define la escena principal de la app.
    // Una escena es la parte visible que SwiftUI muestra en pantalla.
    var body: some Scene {
        // `WindowGroup` crea la ventana principal de la app.
        // Dentro de esa ventana, la primera vista que se muestra es `ContentView`.
        WindowGroup {
            ContentView()
        }
        // Aquí se configura SwiftData para esta app.
        // `MoodEntry.self` indica qué tipo de modelo se va a guardar.
        //
        // Desde este punto, las vistas que estén dentro de esta jerarquía
        // pueden acceder a SwiftData usando cosas como:
        // - `@Environment(\\.modelContext)`
        // - `@Query`
        .modelContainer(for: MoodEntry.self)
    }
}
