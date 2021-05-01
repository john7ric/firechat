//
//  RegistrationController.swift
//  FireChat
//
//  Created by Richard J on 01/05/21.
//

import Foundation

struct RegistrationViewModel : AuthenticationProtocol{
    var email : String?
    var password: String?
    var username: String?
    var fullname: String?
    
    var isFormEnabled: Bool {
        return email?.isEmpty == false &&
            password?.isEmpty == false &&
            username?.isEmpty == false &&
            fullname?.isEmpty == false
    }
}
