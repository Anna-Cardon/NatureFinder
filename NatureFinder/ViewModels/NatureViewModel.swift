//
//  NatureViewModel.swift
//  NatureFinder
//
//  Created by Anna on 4/30/23.
//This ViewModel directly assigns variables so that we can access, send, and receive

import Foundation

struct NatureViewModel {
    let nature : Nature
    
    var natureId: String{
        nature.id ?? ""
    }
    
    var name: String{
        nature.name
    }

    var photoUrl: String{
        nature.url
    }
}
