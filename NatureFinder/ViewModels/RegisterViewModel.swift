//
//  RegisterViewModel.swift
//  NatureFinder
//
//  Created by Anna on 4/29/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth

class RegisterViewModel: ObservableObject{
    
    var email: String = ""
    var password: String = ""
    
    func register (completion: @escaping () -> Void){
        
        /* similar process to LoginViewModel*/
        Auth.auth().createUser(withEmail: email, password : password){
            (result, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                completion()
            }
        }
    }
}
