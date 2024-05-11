//
//  Nature.swift
//  NatureFinder
//
//  Created by Anna on 4/29/23.
//This is a model of what we will be pulling while accesing pictures from our firebase server

import Foundation

struct Nature : Codable{
    var id: String? //doc id for a nature pic
    var name: String = "" //name given to the pic
    var url: String = "" //photo url
    var userId: String = "" //which user added this nature
}
