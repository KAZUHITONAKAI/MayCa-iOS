//
//  ImagePicker2StringView.swift
//  SwiftUI-Device-Image
//
//  Created by Kazuya Ueoka on 2019/12/20.
//  Copyright © 2019 fromKK. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

struct ImagePicker2StringView: UIViewControllerRepresentable {
    //@Binding var image: UIImage?
    //@Binding var imageUrl:String
    @Binding var imagestr:String

    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        //@Binding var image: UIImage?
        //@Binding var imageUrl: NSURL?
        @Binding var imagestr_l: String
        //var imageUrl = ""

        //init(image: Binding<UIImage?>) {
        //    _image = image
        //}
        init(imageUrl: Binding<String>) {
            _imagestr_l = imageUrl
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            defer {
                picker.dismiss(animated: true)
            }
            //guard let image = info[.originalImage] as? UIImage else {
            //    return
            //}

            //self.image = image
            let imageUrl = info[.imageURL] as? NSURL
            let tmp:String = (imageUrl?.absoluteString)!
            print("url:\(tmp)")
            //self.imageUrl = tmp
            //self.imageUrl = imageUrl
            self.imagestr_l = tmp
            //self._imagestr = Binding(tmp)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> ImagePicker2StringView.Coordinator {
        //let coordinator = Coordinator(image: $image)
        let coordinator = Coordinator(imageUrl: $imagestr)
        return coordinator
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker2StringView>) -> UIImagePickerController {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.sourceType = .photoLibrary
        imagePickerViewController.delegate = context.coordinator
        return imagePickerViewController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker2StringView>) {
        // Nothing todo
    }
}
