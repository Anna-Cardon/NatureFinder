//
//  PhotoCaptureView.swift
//  NatureFinder
//
//  Created by Anna on 5/6/23.
//this is the sheet view where we're able to name our pictures

import Foundation
import SwiftUI

struct PhotoCaptureView: View {
    
    @Binding var showImagePicker: Bool
    @Binding var image: Image?
    @Binding var originalImage: UIImage?
    var sourceType: SourceType
    
    var body: some View {
        ImagePicker(isShown: $showImagePicker, image: $image, originalImage: $originalImage, sourceType: sourceType)
           
    }
}

struct PhotoCaptureView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCaptureView(showImagePicker: .constant(false), image: .constant(Image("")), originalImage: .constant(UIImage()), sourceType: .photoLibrary)
    }
}
