//
//  RegisterView.swift
//  NatureFinder
//
//  Created by Anna on 4/29/23.
//

import SwiftUI

struct RegisterView: View {
    
    /* because we are using .sheet to bring this view forward,
     we need something to dismiss the view when a desired action happens,
     like create account button being pressed, there are multiple ways to do this,
     but this is how I'll do it with the current iOS 15 update. The @Environment also makes sure that the sheet view has same aspects as login*/
    @Environment(\.dismiss) private var dismiss
    
    /* now make vars to create the new account*/
    @State private var email: String = ""
    @State private var password: String = ""
    
    /* now make a reference to the viewModel*/
    @StateObject private var registerVM = RegisterViewModel()
    
    var body: some View {
        NavigationView{
        VStack{
            Image("nature")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .padding(.bottom, 20)
            
            TextField("Email", text: $registerVM.email)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $registerVM.password)
            
            Button("Create Account"){
                registerVM.register { //go to viewModel func register
                    dismiss() //pass email and password, then dismiss the view
                }
            }
            .padding(.top, 30)
            .buttonStyle(.borderedProminent)
            .tint(.mint)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Register")
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
