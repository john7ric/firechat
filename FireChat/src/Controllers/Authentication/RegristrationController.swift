//
//  RegristrationController.swift
//  FireChat
//
//  Created by Richard J on 25/04/21.
//

import UIKit

class RegistrationController: UIViewController{
    
    //MARK: - properties
    
    private let iconImage : UIImageView =  {
        let iv  = UIImageView()
        iv.tintColor = .white
        iv.image = #imageLiteral(resourceName: "plus_photo")
        return iv
    }()
    
    
    private lazy var usernameContainer : UIView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: usernameTextField)
    }()

    private lazy var emailContainer : UIView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
    }()
    
    private lazy var pwdContainer : UIView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: pwdTextField)
    }()
    private lazy var confirmPwdContainer : UIView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: confirmPwdTextField)
    }()
    
    private let loginButton : UIButton = {
        return CustomButton(title: "Log in")
    }()
    
    private let emailTextField : CustomTextField =  CustomTextField(placeholder: "email")
    private let usernameTextField : CustomTextField =  CustomTextField(placeholder: "username")
    private let pwdTextField : CustomTextField = {
        let tf = CustomTextField(placeholder: "password")
        tf.isSecureTextEntry = true
        return tf
    }()
    private let confirmPwdTextField : CustomTextField = {
        let tf = CustomTextField(placeholder: "confirm password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let alreadyHaveAccountBtn : UIButton = {
        let btn = UIButton(type: .system)
        let titleText : NSMutableAttributedString = NSMutableAttributedString(string: "Already have an account ?", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        titleText.append(NSAttributedString(string: " Log in", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.white]))
        btn.setAttributedTitle(titleText, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()

    //MARK: - lifecycle
    
    override func viewDidLoad() {
        configureUI()    }
    
    
    //MARK: - helpers
    
    func configureUI() {
        configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        
        /// added icon image view
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide
                            .topAnchor,paddingTop: 32)
        iconImage.setDimensions(height: 200, width: 200)
        
        /// sets up the container stack for form views
        let containerStack = UIStackView(arrangedSubviews: [usernameContainer,emailContainer, pwdContainer, confirmPwdContainer, loginButton])
        containerStack.axis = .vertical
        containerStack.spacing = 16
        
        view.addSubview(containerStack)
        containerStack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountBtn)
        alreadyHaveAccountBtn.addTarget(self, action: #selector(navigateToLogin), for: .touchUpInside)
        alreadyHaveAccountBtn.anchor( left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
    }
    
    
    //MARK: - selectors
    
    @objc func navigateToLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - properties
}
