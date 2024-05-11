//
//  UserViewModel.swift
//  NatureFinder
//
//  Created by Anna on 5/12/23.
//

import Foundation

struct UserViewModel {
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
