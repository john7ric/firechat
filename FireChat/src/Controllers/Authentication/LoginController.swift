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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
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
