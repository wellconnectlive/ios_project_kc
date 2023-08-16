//
//  ImagePicker.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 13/8/23.
//

import Foundation
import SwiftUI

/**
    `ImagePicker` es una estructura que representa un `UIImagePickerController`
    dentro de SwiftUI. Esta estructura permite a los usuarios seleccionar una imagen
    desde su dispositivo para su uso en una vista SwiftUI.
*/
struct ImagePicker: UIViewControllerRepresentable {
    // Indica si el selector de imagen se está mostrando o no.
    @Binding var isShown: Bool
    
    // Almacena la imagen seleccionada por el usuario.
    @Binding var image: UIImage?

    /**
        `Coordinator` actúa como el delegado para el `UIImagePickerController`.
        Está diseñado para gestionar la selección y cancelación de imágenes.
    */
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var photo: ImagePicker

        init(_ photo: ImagePicker) {
            self.photo = photo
        }

        // Se llama cuando el usuario selecciona una imagen.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // Extrae la imagen seleccionada y la asigna a la variable `image` de `ImagePicker`.
            if let uiImage = info[.originalImage] as? UIImage {
                photo.image = uiImage
            }
            // Cierra el selector de imágenes.
            photo.isShown = false
        }

        // Se llama cuando el usuario cancela la selección de imagen.
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // Cierra el selector de imágenes.
            photo.isShown = false
        }
    }

    // Crea y devuelve un `UIImagePickerController`.
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    // Actualiza el `UIImagePickerController` (en este caso, no necesitamos realizar ninguna actualización).
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    // Crea y devuelve una instancia del `Coordinator`.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
