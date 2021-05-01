//
//  RegristrationController.swift
//  FireChat
//
//  Created by Richard J on 25/04/21.
//

import UIKit

class RegistrationController: UIViewController{
    
    //MARK: - properties
    
    private let imagePickerButton : UIButton = {
        
        let btn = UIButton(type: .system)
        btn.clipsToBounds = true
        btn.tintColor = .white
        return btn
        
        
    }()
    
    private lazy var usernameContainer : UIView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: usernameTextField)
    }()

    private lazy var emailContainer : UIView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
    }()
    
    private lazy var pwdContainer : UIView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: pwdTextField)
    }()
    private lazy var fullenameContainer : UIView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullnameTextfield)
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
    private let fullnameTextfield : CustomTextField = {
        let tf = CustomTextField(placeholder: "full name")
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
        view.addSubview(imagePickerButton)
        imagePickerButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        imagePickerButton.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        imagePickerButton.centerX(inView: view)
        imagePickerButton.anchor(top: view.safeAreaLayoutGuide
                            .topAnchor,paddingTop: 32)
        imagePickerButton.setDimensions(height: 200, width: 200)
        
        /// sets up the container stack for form views
        let containerStack = UIStackView(arrangedSubviews: [usernameContainer,
                                                            fullenameContainer,
                                                            emailContainer,
                                                            pwdContainer,
                                                            loginButton])
        containerStack.axis = .vertical
        containerStack.spacing = 16
        
        view.addSubview(containerStack)
        containerStack.anchor(top: imagePickerButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountBtn)
        alreadyHaveAccountBtn.addTarget(self, action: #selector(navigateToLogin), for: .touchUpInside)
        alreadyHaveAccountBtn.anchor( left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
    }
    
    @objc func pickImage(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        navigationController?.present(imagePickerController, animated: true)
    }
    
    
    //MARK: - selectors
    
    @objc func navigateToLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - properties
}

    //MARK: - UIImagePickerControllerDelegate
extension RegistrationController : UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image : UIImage? = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        picker.dismiss(animated: true)
        imagePickerButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        imagePickerButton.layer.borderColor = UIColor.white.cgColor
        imagePickerButton.layer.cornerRadius = 200/2
        imagePickerButton.layer.borderWidth = 3.0
    }
}

    //MARK: - UINavigationControllerDelegate
extension RegistrationController : UINavigationControllerDelegate{
    
}
