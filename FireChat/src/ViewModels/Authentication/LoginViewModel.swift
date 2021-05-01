//
//  LoginViewModel.swift
//  FireChat
//
//  Created by Richard J on 01/05/21.
//


protocol AuthenticationProtocol {
   var isFormEnabled: Bool {get}
}

import Foundation

struct LoginViewModel : AuthenticationProtocol {
    var email : String?
    var password: String?
    var isFormEnabled: Bool {
        return (!(email?.isEmpty ?? true) && !(password?.isEmpty ?? true))
    }

}
