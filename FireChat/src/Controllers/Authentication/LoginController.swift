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
    
    private lazy var emailContainer : UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        
        
        let iv = UIImageView()
        iv.image = UIImage(systemName: "envelope")
        iv.tintColor = .white
        
        containerView.addSubview(iv)
        iv.centerY(inView: containerView)
        iv.anchor(left: containerView.leftAnchor, paddingLeft: 8)
        iv.setDimensions(height: 24, width: 24)
        
        containerView.addSubview(emailTextField)
        
        emailTextField.centerY(inView: containerView)
        emailTextField.anchor(
                         left: iv.rightAnchor,
                         bottom: containerView.bottomAnchor,
                         right: containerView.rightAnchor,
                         paddingLeft: 8,
                         paddingBottom: -8,
                         paddingRight: 8
                                     )
        
        containerView.setHeight(height: 50)
        return containerView
    }()
    
    private lazy var passowrdContainer : UIView = {
        let containerView = UIView()
        
        
        let iv = UIImageView()
        iv.image = UIImage(systemName: "lock")
        iv.tintColor = .white
        
        containerView.addSubview(iv)
        iv.centerY(inView: containerView)
        iv.anchor(left: containerView.leftAnchor, paddingLeft: 8)
        iv.setDimensions(height: 24, width: 24)
        
        containerView.addSubview(passwordTextField)
        
        passwordTextField.centerY(inView: containerView)
        passwordTextField.anchor(
                         left: iv.rightAnchor,
                         bottom: containerView.bottomAnchor,
                         right: containerView.rightAnchor,
                         paddingLeft: 8,
                         paddingBottom: -8,
                         paddingRight: 8
                                     )
        
        containerView.setHeight(height: 50)
        return containerView
    }()
    
    private let loginButton : UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.backgroundColor = .red
        loginButton.layer.cornerRadius = 5
        loginButton.setTitle("Log in", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.setHeight(height: 50)
        
        return loginButton
    }()
    
    private let emailTextField : UITextField = {
        let tf = UITextField()
        tf.textColor = .white
        tf.placeholder = "email"
        return tf
    }()
    
    private let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.textColor = .white
        tf.placeholder = "password"
        tf.isSecureTextEntry = true
        return tf
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
