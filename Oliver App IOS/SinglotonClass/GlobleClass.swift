//
//  GlobleClass.swift
//  Oliver App IOS
//
//  Created by Meena on 28/11/20.
//

import UIKit

class GlobleClass: NSObject {
    
    
    static func showToast(message : String, view : UIView, color : UIColor) {

        let toastLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width/2 - 130, y: UIScreen.main.bounds.size.height-100, width: 270, height: 35))
            toastLabel.backgroundColor = color
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font = UIFont(name: "Montserrat-Light", size: 10.0)
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
    }
    
   static func backGroundColor() -> CALayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size.width = UIScreen.main.bounds.width
        gradientLayer.frame.size.height = UIScreen.main.bounds.height
        gradientLayer.colors = [UIColor(displayP3Red: 0.0/255.0, green: 151.0/255.0, blue: 215.0/255.0, alpha: 1).cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradientLayer
  }

static func backGrayGroundColor() -> CALayer {
     let gradientLayer = CAGradientLayer()
     gradientLayer.frame.size.width = UIScreen.main.bounds.width
     gradientLayer.frame.size.height = UIScreen.main.bounds.height
    gradientLayer.colors = [UIColor.lightGray.cgColor,UIColor(displayP3Red: 94.0/255.0, green: 94.0/255.0, blue: 94.0/255.0, alpha: 1).cgColor]
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

extension UITextField {
    @IBInspectable var padding_left: CGFloat {
        get {
            return 0
        }
        set (f) {
            layer.sublayerTransform = CATransform3DMakeTranslation(f, 0, 0)
        }
    }
    
}
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
@IBDesignable
class CustomButton: UIButton {
    @IBInspectable var cornerRadiusValue: CGFloat = 10.0 {
        didSet {
            setUpView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    func setUpView() {
        self.layer.cornerRadius = self.cornerRadiusValue
        self.clipsToBounds = true
    }
}
