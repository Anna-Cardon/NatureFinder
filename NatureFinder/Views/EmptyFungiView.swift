//
//  EmptyFungiView.swift
//  NatureFinder
//
//  Created by Anna on 5/6/23.
//

import Foundation
import SwiftUI

struct EmptyFungiView: View {
    var body: some View {
        VStack {
            Image("nature")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            
            Text("No nature found!")
                .font(.title)
        }.padding()
    }
}

struct EmptyFungiView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyFungiView()
    }
}
