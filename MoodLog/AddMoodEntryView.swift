//
//  AddMoodEntryView.swift
//  MoodLog
//
//  Created by Ignacio Lagos Morales on 05-04-26.
//

// Importa SwiftData para poder usar cosas como `ModelContext`.
import SwiftData
// Importa SwiftUI para construir la interfaz visual.
import SwiftUI

// Esta estructura representa una pantalla de SwiftUI.
// Como adopta `View`, SwiftUI entiende que esto se puede mostrar en la app.
struct AddMoodEntryView: View {

    // `@State` guarda un dato local de esta pantalla.
    // Cuando este valor cambia, la vista se vuelve a dibujar.
    // Aquí guardamos el estado de ánimo elegido por la persona.
    @State var estadoDeAnimo: MoodType = .neutral

    // Otro dato local de la pantalla.
    // Aquí se guarda lo que la persona escribe en la nota.
    @State var nota: String = ""

    // `@StateObject` guarda un objeto que la vista "posee".
    // SwiftUI lo crea una vez y lo mantiene vivo mientras esta vista exista.
    // Aquí usamos el ViewModel que tiene la lógica para crear y guardar entradas.
    @StateObject var modelView: MoodViewModel = MoodViewModel()

    // `@Environment` significa: "quiero que SwiftUI me pase un valor del entorno".
    // El entorno es como una mochila de valores compartidos que SwiftUI reparte
    // automáticamente a las vistas que los necesitan.
    //
    // `\.modelContext` es la clave para pedir el contexto de SwiftData.
    // `modelContext` es el objeto que sabe hablar con la base de datos.
    // Piensa en él como el "administrador" que inserta, busca o borra datos.
    //
    // Muy importante:
    // esta vista NO crea el `modelContext`.
    // SwiftUI se lo entrega porque en un nivel más alto de la app ya se configuró SwiftData.
    //
    // Entonces, esta línea básicamente dice:
    // "SwiftUI, por favor pásame el contexto de la base de datos para usarlo aquí".
    @Environment(\.modelContext) var modelContext

    // También pedimos otra cosa al entorno: la función para cerrar esta pantalla.
    // `dismiss()` sirve para volver atrás o cerrar una hoja/modal.
    @Environment(\.dismiss) var dismiss

    // `body` describe todo lo que se ve en pantalla.
    var body: some View {
        // `VStack` acomoda sus elementos uno debajo del otro, en vertical.
        VStack(alignment: .center) {
            // Texto simple que funciona como título visible.
            Text("Add Mood Entry")

            // `Picker` muestra una lista para elegir una opción.
            // El texto "Selecciona..." es la etiqueta.
            // `selection: $estadoDeAnimo` conecta el picker con la variable `estadoDeAnimo`.
            // El símbolo `$` significa que pasamos un "binding":
            // o sea, una conexión directa para leer y escribir ese valor.
            Picker("Selecciona...", selection: $estadoDeAnimo) {
                // `ForEach` recorre todos los casos posibles del enum `MoodType`.
                ForEach(MoodType.allCases, id: \.self) { estado in
                    // Muestra el texto de cada estado como opción del picker.
                    Text(estado.rawValue)
                }
            }
            // Hace que el picker se vea como un menú desplegable.
            .pickerStyle(.menu)

            // `TextEditor` es una caja de texto grande para escribir varias líneas.
            // También está conectada con `nota`, así que lo escrito se guarda ahí.
            TextEditor(text: $nota)
                // Le da una altura fija al área de texto.
                .frame(height: 150)
                // Le pone un borde gris suave para que se note el área editable.
                .border(Color.gray.opacity(0.3))

            // Botón que ejecuta código cuando la persona toca "Guardar".
            Button("Guardar") {
                // Llamamos al ViewModel para crear y guardar una nueva entrada.
                //
                // Le pasamos:
                // - `modelContext`: el puente hacia SwiftData
                // - `estadoDeAnimo`: lo que la persona eligió
                // - `nota`: lo que la persona escribió
                //
                // El paso importante es este:
                // la vista obtiene `modelContext` desde `@Environment`
                // y se lo entrega al ViewModel para que este pueda insertar el dato.
                modelView.addMoodEntry(modelContext: modelContext, moodType: estadoDeAnimo, notes: nota)

                // Después de guardar, cerramos esta pantalla.
                dismiss()
            }
            // Aplica un estilo visual destacado al botón.
            .buttonStyle(.glassProminent)

        }
        // Agrega espacio interno alrededor de todo el contenido.
        .padding(16)
    }
}
