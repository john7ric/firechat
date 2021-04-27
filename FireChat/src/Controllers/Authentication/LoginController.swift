//
//  LoginController.swift
//  FireChat
//
//  Created by Richard J on 25/04/21.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    private let iconImage : UIImageView =  {
        let iv  = UIImageView()
        iv.tintColor = .white
        iv.image = UIImage(systemName: "bubble.right")
        return iv
    }()
    
    private let emailContainer : UIView = {
        let emailView = UIView()
        emailView.backgroundColor = .blue
        emailView.setHeight(height: 50)
        return emailView
    }()
    
    private let passowrdContainer : UIView = {
        let passowrdView = UIView()
        passowrdView.backgroundColor = .cyan
        passowrdView.setHeight(height: 50)
        return passowrdView
    }()
    
    private let loginButton : UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.backgroundColor = .yellow
        loginButton.setHeight(height: 50)
        
        return loginButton
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        
        /// added icon image view
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide
                            .topAnchor,paddingTop: 32)
        iconImage.setDimensions(height: 120, width: 120)
        
        /// sets up the container stack for form views
        let containerStack = UIStackView(arrangedSubviews: [emailContainer, passowrdContainer, loginButton])
        containerStack.axis = .vertical
        containerStack.spacing = 16
        
        view.addSubview(containerStack)
        containerStack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        
    }
    
    func configureGradientLayer(){
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.systemPurple.cgColor]
        gradientLayer.locations = [0,1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.frame
        
    }
    
    //MARK: - Selectors
}
