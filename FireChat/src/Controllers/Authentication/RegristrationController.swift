//
//  RegristrationController.swift
//  FireChat
//
//  Created by Richard J on 25/04/21.
//

import UIKit
import Firebase

class RegistrationController: UIViewController{
    
    //MARK: - properties
    
    private var viewModel : RegistrationViewModel = RegistrationViewModel()
    
    private let imagePickerButton : UIButton = {
        
        let btn = UIButton(type: .system)
        btn.clipsToBounds = true
        btn.tintColor = .white
        return btn
        
        
    }()
    
    private var profilePicture : UIImage?
    
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
    
    private let signUpButton : UIButton = {
        return CustomButton(title: "Sign up")
    }()
    
    private let emailTextField : CustomTextField =  CustomTextField(placeholder: "email")
    private let usernameTextField : CustomTextField =  CustomTextField(placeholder: "username")
    private let pwdTextField : CustomTextField = {
        let tf = CustomTextField(placeholder: "password")
        tf.isSecureTextEntry = true
        return tf
    }()
    private let fullnameTextfield : CustomTextField = CustomTextField(placeholder: "full name")
    
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
        configureUI()
        
    }
    
    
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
                                                            signUpButton])
        containerStack.axis = .vertical
        containerStack.spacing = 16
        
        view.addSubview(containerStack)
        containerStack.anchor(top: imagePickerButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountBtn)
        alreadyHaveAccountBtn.addTarget(self, action: #selector(navigateToLogin), for: .touchUpInside)
        alreadyHaveAccountBtn.anchor( left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        configureNotificationObservers()
        signUpButton.addTarget(self, action: #selector(registrationHandler), for: .touchUpInside)
        
    }
    
    func configureNotificationObservers(){
        emailTextField.addTarget(self, action: #selector(textDidUpdate), for: .editingChanged)
        pwdTextField.addTarget(self, action: #selector(textDidUpdate), for: .editingChanged)
        fullnameTextfield.addTarget(self, action: #selector(textDidUpdate), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidUpdate), for: .editingChanged)

    }
    
    

    
    //MARK: - selectors
    
    /// this method here handles the registration button click
    /// first uploads the profile pic uploaded and get the image url
    /// On its success block it creates the user , which is chained with
    /// updating the user data from form  for the corresponding user
    @objc func registrationHandler(){
        
        
        guard let email = emailTextField.text else { return }
        guard let password = pwdTextField.text else { return }
        guard let username = emailTextField.text?.lowercased() else { return }
        guard let fullname = fullnameTextfield.text else { return }
        guard let profilePictureData = profilePicture?.jpegData(compressionQuality: 0.3) else { return }
        
        //creates the filename
        
        let filename = UUID().uuidString;
        let ref = Storage.storage().reference(withPath: "/profile_path/\(filename)")
        
        ref.putData(profilePictureData, metadata: nil) { (data, error) in
            
            if let error = error {
                print("DEBUG : failed to load profile picture with path \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { (url, error) in
                
                guard let profileImageUrl = url?.absoluteString else { return }
                
                /// the proifile image upload is done
                /// now creating the user with the given email and password
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error{
                        print("DEBUG: create user failed with error \(error.localizedDescription)")
                    }
                    
                    guard let userId = result?.user.uid else { return }
                    
                    let dataToPost : [String: Any] = ["email" : email,
                                                      "password": password,
                                                      "username": username,
                                                      "fullname" : fullname,
                                                      "profileImageUrl": profileImageUrl]
                    Firestore.firestore().collection("users").document(userId).setData(dataToPost) { (error) in
                        if let error = error{
                            print("DEBUG: store user details failed with error \(error.localizedDescription)")
                            return
                        }
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                }
                
                
            }
        }
        
        
        
    }
    
    
    @objc func pickImage(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        navigationController?.present(imagePickerController, animated: true)
    }
    
    
    @objc func navigateToLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidUpdate(sender: UITextField){
        switch sender {
        case usernameTextField:
            viewModel.username = sender.text
        case fullnameTextfield:
            viewModel.fullname = sender.text
        case emailTextField:
            viewModel.email = sender.text
        case pwdTextField:
            viewModel.password = sender.text
        default:
            break
        }
        validateForm()
    }
    
    
    //MARK: - properties
}

    //MARK: - UIImagePickerControllerDelegate
extension RegistrationController : UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image : UIImage? = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        picker.dismiss(animated: true)
        profilePicture = image
        imagePickerButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        imagePickerButton.layer.borderColor = UIColor.white.cgColor
        imagePickerButton.layer.cornerRadius = 200/2
        imagePickerButton.layer.borderWidth = 3.0
    }
}

    //MARK: - UINavigationControllerDelegate
extension RegistrationController : UINavigationControllerDelegate{
    
}

    //MARK: - AutheticationControllerProtocol

extension RegistrationController : AutheticationControllerProtocol{
    
    func validateForm() {
        if viewModel.isFormEnabled {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }else{
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
    
}
