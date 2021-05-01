//
//  CustomTextField.swift
//  FireChat
//
//  Created by Richard J on 28/04/21.
//

import UIKit

class CustomTextField: UITextField {
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    init(placeholder: String){
        super.init(frame: .zero)
        textColor = .white
        keyboardAppearance = .dark
        self.borderStyle = .none
        font = UIFont.systemFont(ofSize: 16)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
    }
}
