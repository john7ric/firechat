//
//  InputContainerView.swift
//  FireChat
//
//  Created by Richard J on 28/04/21.
//

import UIKit

class InputContainerView: UIView {
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    init(image : UIImage, textField: UITextField){
        super.init(frame: .zero)
        setHeight(height: 50)
        backgroundColor = .clear
        
        let iv = UIImageView()
        iv.image = image
        iv.tintColor = .white
        
        addSubview(iv)
        iv.centerY(inView: self)
        iv.anchor(left: self.leftAnchor, paddingLeft: 8)
        iv.setDimensions(height: 24, width: 24)
        
        addSubview(textField)
        
        textField.centerY(inView: self)
        textField.anchor(
                         left: iv.rightAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingLeft: 8,
                         paddingBottom: -8,
                         paddingRight: 8
                                     )
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        addSubview(dividerView)
        dividerView.anchor( left: leftAnchor,
                            bottom: bottomAnchor,
                            right: rightAnchor,
                            paddingLeft: 8,
                            paddingRight: 8,
                            height: 0.75)
        
                
    }
}
