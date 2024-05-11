//
//  ImagePicker.swift
//  NatureFinder
//
//  Created by Anna on 5/6/23.
// this is the sheet view of our photolibrary, taken from the educational videos on Udemy
//here is a link for similiar coding and explaination: https://designcode.io/swiftui-advanced-handbook-imagepicker and this: https://www.appcoda.com/swiftui-camera-photo-library/
//this current code works better with the current build of our PhotoCaptureView (which allows us to name our picture and view it after selection from photolibrary)
import Foundation
import SwiftUI

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var originalImage: UIImage?
    
    init(isShown: Binding<Bool>, image: Binding<Image?>, originalImage: Binding<UIImage?>) {
        _isShown = isShown
        _image = image
        _originalImage = originalImage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        image = Image(uiImage: uiImage)
        isShown = false
        originalImage = uiImage
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
    
}

struct ImagePicker: UIViewControllerRepresentable { //required, create and manage a UIViewController (PhotoCaptureView)
    
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var originalImage: UIImage?
    var sourceType: SourceType //var for our photolibrary
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(isShown: $isShown, image: $image, originalImage: $originalImage)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
}
