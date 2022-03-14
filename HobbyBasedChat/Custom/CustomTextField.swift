//
//  CustomTextField.swift
//  HobbyBasedChat
//
//  Created by Sang hun Lee on 2022/03/14.
//

import UIKit
import Rswift

class CustomTextField: UITextField, UITextFieldDelegate {
    let border = CALayer()
    var lineColor : UIColor = R.color.grayscale_gray3()!
    var selectedLineColor : UIColor = R.color.systemcolor_focus()!
    var lineHeight : CGFloat = CGFloat(1.0)

    required init?(coder aDecoder: (NSCoder?)) {
        super.init(coder: aDecoder!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        border.borderColor = lineColor.cgColor
        self.delegate = self
        self.attributedPlaceholder = NSAttributedString(
            string: self.placeholder ?? "",
            attributes: [
                .foregroundColor: R.color.grayscale_gray7()!,
                .font : R.font.notoSansCJKkrRegular(size: 14)!
            ]
        )
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = lineHeight
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

    override func draw(_ rect: CGRect) {
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    private let commonInsets = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    private let clearButtonOffset: CGFloat = 5
    private let clearButtonLeftPadding: CGFloat = 5
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: commonInsets)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: commonInsets)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let clearButtonWidth = clearButtonRect(forBounds: bounds).width
        let editingInsets = UIEdgeInsets(
            top: commonInsets.top,
            left: commonInsets.left,
            bottom: commonInsets.bottom,
            right: clearButtonWidth + clearButtonOffset + clearButtonLeftPadding
        )
        return bounds.inset(by: editingInsets)
    }

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var clearButtonRect = super.clearButtonRect(forBounds: bounds)
        clearButtonRect.origin.x -= clearButtonOffset
        return clearButtonRect
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        border.borderColor = R.color.systemcolor_focus()!.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        border.borderColor = R.color.grayscale_gray3()!.cgColor
    }
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
       return (action == #selector(UIResponderStandardEditActions.copy(_:))
           || action == #selector(UIResponderStandardEditActions.paste(_:))) ?
           false : super.canPerformAction(action, withSender: sender)
    }
}
