//
//  LoginViewModel.swift
//  NatureFinder
//
//  Created by Anna on 4/29/23.
//

import Foundation
import FirebaseAuth
import FirebaseCore

//make class observable so we can see it
class LoginViewModel : ObservableObject {
    
    var email : String = ""
    var password : String = ""
    
    /* create a function that uses our Authentication,
     this func has an escaping closure*/
    func login(completion : @escaping () -> Void){
        
        /*Auth has some built in funcs you can peice together
          authenticate, signIn, using email and password. (Remember we chose Email/Password for our authentication*/
        Auth.auth().signIn(withEmail: email, password: password){
            
            (result, error) in //get result or error below
            
            //if there is an error
            if let error = error {
                print(error.localizedDescription)
            }
            else{ //if there is no error then result is completion and our escaping closure is activated to outlive our function
                completion()
            }
        }
    }
}
