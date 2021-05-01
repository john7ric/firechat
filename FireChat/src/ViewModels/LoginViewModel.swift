//
//  LoginViewModel.swift
//  FireChat
//
//  Created by Richard J on 01/05/21.
//

import Foundation

struct LoginViewModel {
    var email : String?
    var password: String?
    var isFormEnabled: Bool {
        return (!(email?.isEmpty ?? true) && !(password?.isEmpty ?? true))
    }
}
