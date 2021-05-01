//
//  LoginController.swift
//  FireChat
//
//  Created by Richard J on 25/04/21.
//


protocol AutheticationControllerProtocol {
    func validateForm()
}

import UIKit
import Firebase

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel :LoginViewModel = LoginViewModel()
    
    private let iconImage : UIImageView =  {
        let iv  = UIImageView()
        iv.tintColor = .white
        iv.image = UIImage(systemName: "bubble.right")
        return iv
    }()
    
    private lazy var emailContainer : UIView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
    }()
    
    private lazy var passowrdContainer : UIView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
    }()
    
    private let loginButton : UIButton = {
        return CustomButton(title: "Log in")
    }()
    
    private let emailTextField : CustomTextField =  CustomTextField(placeholder: "email")
    
    private let passwordTextField : CustomTextField = {
        let tf = CustomTextField(placeholder: "password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let dontHaveAccountBtn : UIButton = {
        let btn = UIButton(type: .system)
        let titleText : NSMutableAttributedString = NSMutableAttributedString(string: "Dont have an account ?", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        titleText.append(NSAttributedString(string: " Sign Up", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.white]))
        btn.setAttributedTitle(titleText, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
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
        loginButton.addTarget(self, action: #selector(loginHandler), for: .touchUpInside)
        containerStack.axis = .vertical
        containerStack.spacing = 16
        
        view.addSubview(containerStack)
        containerStack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountBtn)
        dontHaveAccountBtn.addTarget(self, action: #selector(navigateToSignUp), for: .touchUpInside)
        dontHaveAccountBtn.anchor( left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        emailTextField.addTarget(self, action: #selector(textDidUpdate), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidUpdate), for: .editingChanged)
        
    }
    
    

    //MARK: - Selectors
    
    @objc func loginHandler(){
        
        guard let email = emailTextField.text else { return }
        guard let pwd = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: pwd) { (result, error) in
            
            if let error = error {
                print("Debug: error in log in \(error.localizedDescription)")
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }

    
    @objc func textDidUpdate(sender : UITextField){
        if sender == emailTextField {
            viewModel.email = sender.text
        }else{
            viewModel.password = sender.text
        }
        validateForm()
    }
    
    @objc func navigateToSignUp(){
        let registrationController : RegistrationController = RegistrationController()
        navigationController?.pushViewController(registrationController, animated: true)
    }
    
}

extension LoginController : AutheticationControllerProtocol{
    func validateForm(){
        if viewModel.isFormEnabled {
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }else{
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}
