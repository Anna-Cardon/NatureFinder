//
//  NatureFinderApp.swift
//  NatureFinder
//
//  Created by Anna on 4/29/23.
// initiates the firebase connection

import SwiftUI
import FirebaseCore

@main
struct NatureFinderApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
