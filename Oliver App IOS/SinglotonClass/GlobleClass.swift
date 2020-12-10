//
//  GlobleClass.swift
//  Oliver App IOS
//
//  Created by Meena on 28/11/20.
//

import UIKit

class GlobleClass: NSObject {
    
   static func backGroundColor() -> CALayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size.width = UIScreen.main.bounds.width
        gradientLayer.frame.size.height = UIScreen.main.bounds.height
        gradientLayer.colors = [UIColor(displayP3Red: 0.0/255.0, green: 151.0/255.0, blue: 215.0/255.0, alpha: 1).cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradientLayer
    }
}
extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }

        return self
    }
}
class UpdateCornerRadious: NSObject {
    func lableCornerRadious5(labelArray: [UILabel]) -> Void {
        for lbl in labelArray {
            lbl.layer.cornerRadius = 5
            lbl.clipsToBounds = true
        }
    }
    func lableCornerRadious14(labelArray: [UILabel]) -> Void {
        for lbl in labelArray {
            lbl.layer.cornerRadius = 14
            lbl.clipsToBounds = true
        }
    }
    func lableCornerRadiousWithBorderColor(labelArray: [UILabel]) -> Void {
        for lbl in labelArray {
            lbl.layer.cornerRadius = 5
            lbl.layer.borderWidth = 1
            lbl.layer.borderColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            lbl.clipsToBounds = true
        }
    }
    func buttonCornerRadious5(buttonArray: [UIButton]) -> Void {
        for btn in buttonArray {
            btn.layer.cornerRadius = 5
            btn.clipsToBounds = true

        }
    }
    func buttonCornerRadious13(buttonArray: [UIButton]) -> Void {
        for btn in buttonArray {
            btn.layer.cornerRadius = 13
            btn.clipsToBounds = true

        }
    }
    func buttonCornerRadious15(buttonArray: [UIButton]) -> Void {
        for btn in buttonArray {
            btn.layer.cornerRadius = 15
            btn.clipsToBounds = true
        }
    }
    func buttonCornerRadious5WithColor(buttonArray: [UIButton]) -> Void {
        for btn in buttonArray {
            btn.layer.cornerRadius = 5
            btn.layer.borderWidth = 1
            btn.layer.borderColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            btn.clipsToBounds = true
        }
    }
    func buttonCornerRadious13WithColor(buttonArray: [UIButton]) -> Void {
        for btn in buttonArray {
            btn.layer.cornerRadius = 13
            btn.layer.borderWidth = 1
            btn.layer.borderColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            btn.clipsToBounds = true
        }
    }
    func buttonCornerRadious15WithColor(buttonArray: [UIButton]) -> Void {
        for btn in buttonArray {
            btn.layer.cornerRadius = 15
            btn.layer.borderWidth = 1
            btn.layer.borderColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            btn.clipsToBounds = true
        }
    }
    
    func subViewCornerRadious5(subViewArray: [UIView]) -> Void {
        for subView in subViewArray {
            subView.layer.cornerRadius = 5
            subView.clipsToBounds = true
        }
    }
    func subViewCornerRadious10(subViewArray: [UIView]) -> Void {
        for subView in subViewArray {
            subView.layer.cornerRadius = 10
            subView.clipsToBounds = true
        }
    }
}

