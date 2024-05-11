//
//  UserNatureListViewModel.swift
//  NatureFinder
//
//  Created by Anna on 5/12/23.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth


class UserNatureListViewModel: ObservableObject {
    @State var retrievedImages = [UIImage]() //array on images from storage
    let storage = Storage.storage() //connect to storage of certain user
    let db = Firestore.firestore() //connect to our firestore database
    @Published var nature : [UserViewModel] = [] //as soon as assign refreshes and shows users images as an array
    @Published var loadingState : LoadingState = .idle //not active at first
    @Published var users = [UserViewModel]()
    
    
    func getAllUserNatureImages () {//get images by users based on userid
        
        DispatchQueue.main.async {
            self.loadingState = .loading //we are now trying to get images
        }
        
        db.collection("nature") //create a collection called nature in server
                        /* for a understanding on weak self read: https://matteomanferdini.com/swift-weak-self/ */
            .getDocuments{[weak self] (snapshot, error) in
                if let error = error { //if theres a error getting the doc
                    print(error.localizedDescription) //tell us why
                    DispatchQueue.main.async {
                        self?.loadingState = .failure //update loading state
                    }
                }else{
                    if let snapshot = snapshot {
                        let nature: [UserViewModel] = /*assign array values */
                        /* to understand compactMaps: https://www.hackingwithswift.com/example-code/language/how-to-use-compactmap-to-transform-an-array */
                            snapshot.documents.compactMap{
                            doc in
                            var nature = try? doc.data(as: Nature.self)
                            nature?.id = doc.documentID
                            if let nature = nature{ //if the pic belongs to our user send it to natureviewmodel
                            return UserViewModel(nature: nature)
                            }
                            return nil
                        }
                        DispatchQueue.main.async {
                            self?.nature = nature
                            self?.loadingState = .success
                        }
                    }
                }
            }
    }
    
    
    
    /*
    func listAllFiles() {
        // Create a reference
        let storageRef = storage.reference().child("images")

        // List all items in the images folder
        storageRef.listAll { (result, error) in
          if let error = error {
            print("Error while listing all files: ", error)
          }

          for item in result.items {
            print("Item in images folder: ", item)
          }
        }
    }

    func listItem() {
        // Create a reference
        let storageRef = storage.reference().child("images")

        // Create a completion handler - aka what the function should do after it listed all the items
        let handler: (StorageListResult, Error?) -> Void = { (result, error) in
            if let error = error {
                print("error", error)
            }

            let item = result.items
            print("item: ", item)
        }

        // List the items
        storageRef.list(maxResults: 1, completion: handler)
    }
    */
    
    
   /*
   func getAllNature () {//get images
                db.collection("users").addSnapshotListener { (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        print("No documents")
                        return
                    }
                    
                    self.users = documents.map { (queryDocumentSnapshot) -> UserViewModel in
                        let data = queryDocumentSnapshot.data()
                        let name = data["name"] as? String ?? ""
                        let photoUrl = data["url"] as? String ?? ""
                        return UserViewModel(name: name, photoUrl: photoUrl)
                    }
                }
            }
        */
        
        
        
       /*
        DispatchQueue.main.async {
            self.loadingState = .loading //we are now trying to get images
        }
        
        db.collection("nature").whereField("name", isEqualTo: true) //all users
        /* for a understanding on weak self read: https://matteomanferdini.com/swift-weak-self/ */
            .getDocuments{[weak self] (snapshot, error) in
                if let error = error { //if theres a error getting the doc
                    print(error.localizedDescription) //tell us why
                    DispatchQueue.main.async {
                        self?.loadingState = .failure //update loading state
                    }
                }else{
                    if let snapshot = snapshot {
                        let nature: [UserViewModel] = /*assign array values */
                        /* to understand compactMaps: https://www.hackingwithswift.com/example-code/language/how-to-use-compactmap-to-transform-an-array */
                            snapshot.documents.compactMap{
                            doc in
                            var nature = try? doc.data(as: Nature.self)
                            nature?.id = doc.documentID
                            if let nature = nature{ //if the pic belongs to our user send it to userviewmodel
                            return UserViewModel(nature: nature)
                            }
                            return nil
                        }
                        DispatchQueue.main.async {
                            self?.nature = nature
                            self?.loadingState = .success
                        }
                    }
                }
            }
    }*/
}
    

    
    
    
    
    
    
    
    
    
    
    

    //func retrievePhotos(){
        //get the data from data base
        
        //get the image data in storage for each image
        
        //display the images
        
   // }
    
    /*
    let storage = Storage.storage()
    @Published var nature : [NatureViewModel] = [] //as soon as assign refreshes and shows users images as an array

    func listAllFiles() {
        // Create a reference
        let storageRef = storage.reference().child("images")

        // List all items in the images folder
        storageRef.listAll { (result, error) in
          if let error = error {
            print("Error while listing all files: ", error)
          }

            for item in result?.items {
            print("Item in images folder: ", item)
          }
        }
    }

    func listItem() {
        // Create a reference
        let storageRef = storage.reference().child("images")

        // Create a completion handler - aka what the function should do after it listed all the items
        let handler: (StorageListResult, Error?) -> Void = { (result, error) in
            if let error = error {
                print("error", error)
            }

            let item = result.items
            print("item: ", item)
        }

        // List the items
        storageRef.list(maxResults: 1, completion: handler)
    }
}*/
