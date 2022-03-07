//
//  ImagePickerView.swift
//  SwiftUI-Device-Image
//
//  Created by Kazuya Ueoka on 2019/12/20.
//  Copyright © 2019 fromKK. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var image_type: String

    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var image: UIImage?
        var image_type: String

        init(image: Binding<UIImage?>, image_type: String) {
            _image = image
            self.image_type = image_type
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            defer {
                picker.dismiss(animated: true)
            }
            let imageUrl = info[.imageURL] as? NSURL
            guard let image = info[.originalImage] as? UIImage else {
                return
            }
            let tmp:String = (imageUrl?.absoluteString)!
            print("url:\(tmp)")
            self.image = image
            let path = NSString(string: tmp)
            print("filename:\(path.lastPathComponent)")
            let savefiename = fileInDocumentsDirectory(filename: path.lastPathComponent + ".png")
            print("savefiename:\(savefiename)")
            saveImage(image: image, path: savefiename)
            UserDefaults.standard.removeObject(forKey: image_type)
            UserDefaults.standard.set(savefiename, forKey: image_type)
            let image_str = UserDefaults.standard.string(forKey: image_type) ?? image_type
            print("path:\(image_str)")
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }

        // DocumentディレクトリのfileURLを取得
        func getDocumentsURL() -> NSURL {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
            return documentsURL
        }

        // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
        func fileInDocumentsDirectory(filename: String) -> String {
            let fileURL = getDocumentsURL().appendingPathComponent(filename)
            return fileURL!.path
        }

        func saveImage (image: UIImage, path: String ) -> Bool {
            let pngImageData = image.pngData()
            do {
                try pngImageData!.write(to: URL(fileURLWithPath: path), options: .atomic)
            } catch {
                //print(error)
                print("保存に失敗 \(error)")
                return false
            }
            return true
        }
    }

    func makeCoordinator() -> ImagePickerView.Coordinator {
        let coordinator = Coordinator(image: $image, image_type: image_type)
        return coordinator
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.sourceType = .photoLibrary
        imagePickerViewController.delegate = context.coordinator
        return imagePickerViewController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        // Nothing todo
    }
}
