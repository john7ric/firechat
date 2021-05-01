//
//  CustomButton.swift
//  FireChat
//
//  Created by Richard J on 30/04/21.
//

import UIKit

class CustomButton: UIButton {
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    init(title : String){
        super.init(frame: .zero)
        
            backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            layer.cornerRadius = 5
            setTitle(title, for: .normal)
            setTitleColor(.white, for: .normal)
            titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            isEnabled = false
            setHeight(height: 50)

    }
}
