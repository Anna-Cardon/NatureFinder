//
//  UIImage+Extensions.swift
//  NatureFinder
//
//  Created by Anna on 5/6/23.
// website with code: https://www.fabrizioduroni.it/2023/01/10/widget-ios-swiftui-image-problem/

import Foundation
import UIKit

extension UIImage {
    
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
