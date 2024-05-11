//
//  LoginView.swift
//  NatureFinder
//
//  Created by Anna on 4/29/23.
//

import SwiftUI

struct LoginView: View {
    /*
     create bool state variables so that
     when we login (isActive) or create new account (isPresented)
     the app will run again
     */
    @State var isPresented: Bool = false
    @State var isActive: Bool = false
    
    //we need access to our viewModel
    @ObservedObject private var loginVM = LoginViewModel()
    
    var body: some View {
        NavigationView {
        VStack{
            /*will need to add images to Assets to put images into your loginView. I used this website for guidence: https://www.simpleswiftguide.com/how-to-add-image-to-xcode-project-in-swiftui/
             */
            Image ("nature")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .padding(.bottom, 20)
            
            /* create textfields to enter info. We want to access the variables from loginVM so add a $ in front*/
            TextField("Username", text: $loginVM.email)
                .padding(.bottom, 20)
            //secureField makes what is typed into special characters **
            SecureField("Password", text: $loginVM.password)
            Spacer()
            /* now make buttons to do our login and Create account*/
            Button("Login"){
                loginVM.login {
                    isActive = true //assign true
                }
            }
            .padding(.bottom, 20)
            .buttonStyle(.borderedProminent)
            .tint(.mint)
            
            Button("Create Account"){
                isPresented = true
            }.padding(.bottom, 20)
                .buttonStyle(.bordered)
                .tint(.mint)
            Spacer()
            /* once the user is logged in or created account we go to the next view*/
            NavigationLink(
                destination: NatureListView(),
                isActive: $isActive, //if isActive (login) is true go to next view
                label:{
                    EmptyView()
                })
        }
        .padding()
            /* .sheet is like a popover view but not a completely new screen,
             we do this if isPresented is true, then go to registerview content*/
        .sheet(isPresented: $isPresented, content: {
            RegisterView()
        })
        .navigationTitle("Nature Finder")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
