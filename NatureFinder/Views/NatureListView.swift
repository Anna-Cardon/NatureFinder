//
//  NatureListView.swift
//  NatureFinder
//
//  Created by Anna on 4/29/23.
//This view will show the user all the nature pictures they have taken

import SwiftUI
import UIKit
import URLImage //this will make sure the app can take url links from firebase and display the images

/* use enum to define our own new data types, we will need photolibrary and camera, this is so the user has two options to import nature pictures*/
enum SourceType{
    case photoLibrary
    case camera
}


struct NatureListView: View {
    
    /* make state variables so that we can bring in the image info*/
    @State private var showImagePicker: Bool = false //for when a photolibrary pic is selected
    @State private var image: Image? = nil //optional image
    @State private var originalImage: UIImage? = nil //og image
    @State private var name: String = "" //name the nature pick
    @State private var showActionSheet: Bool = false //show camera or photolibrary
    @State private var sourceType: SourceType = .photoLibrary //setting connection to source type
    @State var isActive: Bool = false //going to group convo view
    
    @StateObject private var natureListVM = NatureListViewModel()
    
    /* create a function to save the pictures of nature*/
    private func saveNature(){
        DispatchQueue.main.async {
            natureListVM.loadingState = .loading
        }
        
        if let originalImage = originalImage {
            /* lets add an extenstion to properly adjust an image we upload*/
            if let resizedImage = originalImage.resized( toWidth: 1024){
                if let data = resizedImage.pngData(){
                    natureListVM.uploadPhoto(data: data){
                        url in
                        if let url = url {
                            natureListVM.save(name: name, url: url){ //save pic
                                error in
                                
                                if let error = error {
                                    print(error.localizedDescription)
                                }else{
                                    DispatchQueue.main.async { //update loading
                                        natureListVM.loadingState = .success
                                    }
                                    natureListVM.getAllNatureForUser() //get new pics
                                }
                                image = nil  //update
                            }
                        }
                    }
                }
            }
        }
    }
    /* build the list of pictures user has taken*/
    var body: some View {
        ZStack {
            NavigationView{
            VStack{
                    List(natureListVM.nature, id: \.natureId){ //builds the list
                        nature in
                        NatureCell(nature: nature) //extenstion at the bottom of how we want the pictures to appear
                    }
                Spacer()
                
            }
            
            //now we need to build code for when we select an image to add
            if image != nil {
                PhotoPreviewView(image: $image, name: $name, save: { /*photoPreviewView is an extension below, passing in the image chosen, a name for the image, and then the save function so it appears once done*/
                    //save pic
                    saveNature()
                }).shadow(color: Color(.systemBlue), radius: 16, x: -8, y: -8)
                    .shadow(color: Color(.systemGray), radius: 16, x: 8, y: 8)
            }
            
            //this is code for our buttons to camera and group convo
        }.navigationTitle("Nature") //title for this page
        .navigationBarItems(leading: Button(action: {
                // show camera
                showActionSheet = true
               }, label: {
            Image(systemName: "camera") //chose a shape for our naviagtion button to be
                .font(.title)
        })
        .actionSheet(isPresented: $showActionSheet, content: { //this pulls up the option for chosing pictures
            ActionSheet(title: Text("Select"), message: nil, buttons: [
                .default(Text("Photo Library")) {
                    showImagePicker = true
                    sourceType = .photoLibrary
                },
                .cancel()
            ])
        }),trailing: Button(action: {
            // navigate to group page by setting var as true
            isActive = true
        }) {
                    Text("Other Nature")
                }
        )
        .sheet(isPresented: $showImagePicker, content: { //once we chose a image we show the sheet view PhotoCaptureView
            PhotoCaptureView(showImagePicker: $showImagePicker, image: $image, originalImage: $originalImage, sourceType: sourceType)
        })
    .onAppear(perform: { //refresh view after adding or returning to this NatureListView
        natureListVM.getAllNatureForUser()
    })
            Spacer()
            NavigationLink( //go to group convo
                destination: UserNatureListView(),
                isActive: $isActive, //if isActive (button pushed) is true go to next view
                label:{
                    EmptyView()
                })
        }
    }
}



struct NatureListView_Previews: PreviewProvider {
    static var previews: some View {
        NatureListView()
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


struct NatureCell: View { //structures the nature pics in the list
    
    let nature: NatureViewModel //connect to our view model
    
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
        }
    }
}
