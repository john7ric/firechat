//
//  AuthService.swift
//  FireChat
//
//  Created by Richard J on 02/05/21.
//

import Firebase


struct AuthCredentials {
    let username : String
    let password : String
    let email : String
    let fullname : String
    let imageData : Data
    
}



struct AuthService {
   static let shared = AuthService()
    
    func signInUser(email: String, password: String, completion: @escaping ((AuthDataResult? , Error?)-> Void)) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    
    func signUpUser(credentials : AuthCredentials, completion :@escaping ((Error?)->Void)) {
        //creates the filename
        
        let filename = UUID().uuidString;
        let ref = Storage.storage().reference(withPath: "/profile_path/\(filename)")
        
        ref.putData(credentials.imageData, metadata: nil) { (data, error) in
            
            if let error = error {
                print("DEBUG : failed to load profile picture with path \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { (url, error) in
                
                guard let profileImageUrl = url?.absoluteString else { return }
                
                /// the proifile image upload is done
                /// now creating the user with the given email and password
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                    if let error = error{
                        print("DEBUG: create user failed with error \(error.localizedDescription)")
                    }
                    
                    guard let userId = result?.user.uid else { return }
                    
                    let dataToPost : [String: Any] = ["email" : credentials.email,
                                                      "password": credentials.password,
                                                      "username": credentials.username,
                                                      "fullname" : credentials.fullname,
                                                      "profileImageUrl": profileImageUrl]
                    
                    Firestore.firestore().collection("users").document(userId).setData(dataToPost, completion: completion)
                    
                }
                
                
            }
        }
        
    }
    
}
