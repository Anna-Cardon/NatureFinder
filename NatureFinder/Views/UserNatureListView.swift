//
//  UserNatureListView.swift
//  NatureFinder
//
//  Created by Anna on 5/12/23.
//

import SwiftUI
import UIKit
import URLImage

struct UserNatureListView: View {
    @StateObject private var userListVM = UserNatureListViewModel()
    @State var retrievedImages = [UIImage]() //array on images from storage
    @State private var image: Image? = nil //optional image
    @State private var name: String = "" //name the nature pick

    
    
    var body: some View {
        ZStack {
            VStack{
                    List(userListVM.nature, id: \.natureId){ //builds the list
                        nature in
                        UserCell(nature: nature) //extenstion at the bottom of how we want the pictures to appear
                    }
                Spacer()
                
            }
            }.onAppear(perform: { //refresh view
                userListVM.getAllUserNatureImages()})
}
    
    

struct UserNatureListView_Previews: PreviewProvider {
    static var previews: some View {
        UserNatureListView()
    }
}
    
    struct PhotoPreviewView: View { //look at pic taken/selected and give name to pic
        
        @Binding var image: Image?
        @Binding var name: String
        let save: () -> Void
        
        /* build the view so we can see the image as we name it*/
        var body: some View {
            ZStack {
                VStack {
                    /* how we want the image to look*/
                        image?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                        //name our image
                        TextField("Enter name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                       //our save button that connects to the save function we made on top
                        Button("Save") {
                            save()
                            image = nil
                        }.padding(.bottom, 20)
                        .buttonStyle(.borderedProminent)
                        .tint(.mint)

                }.padding()
            }.background(.white)
            .cornerRadius(10)
            .offset(y: 0)
            .padding()
            
        }
    }
    
    struct UserCell: View { //structures the nature pics in the list
        
        let nature: UserViewModel //connect to our view model
        
        var body: some View {
            VStack{
                URLImage(URL(string: nature.photoUrl)!) //take url from viewmodel and put in image
                {
                    image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit) //we want the image it 'fit'
                //choose the shape as rounded and a cornerRadius
                }.clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                Text(nature.name) //put the name of the image under it
                //Text(nature.)
            }
        }
    }

}
