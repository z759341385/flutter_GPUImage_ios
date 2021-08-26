//
//  Image+Extension.swift
//  flutter_gpuimage
//
//  Created by swifter on 2021/8/25.
//

import UIKit

// Image extension
extension UIImage {
    func updateImageOrientationUpSide() -> UIImage? {
        if imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        if let normalizedImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        UIGraphicsEndImageContext()
        return nil
    }
}
