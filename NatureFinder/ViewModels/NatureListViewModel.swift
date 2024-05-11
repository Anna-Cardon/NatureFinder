//
//  NatureListViewModel.swift
//  NatureFinder
//
//  Created by Anna on 4/30/23.
// This viewModel gets the images belonging to the user from firebase, saves, and uploads

import Foundation
import FirebaseStorage
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

/* use enum to define our own new data types, we will need to know how our firebase is being accessed for pictures*/
enum LoadingState {
    case idle
    case loading
    case success
    case failure
}

class NatureListViewModel: ObservableObject{
    
    let storage = Storage.storage() //connect to storage of certain user
    let db = Firestore.firestore() //connect to our firestore database
    @Published var nature : [NatureViewModel] = [] //as soon as assign refreshes and shows users images as an array
    @Published var loadingState : LoadingState = .idle //not active at first
    
    
    func getAllNatureForUser () {//get images by users based on userid
        
        DispatchQueue.main.async {
            self.loadingState = .loading //we are now trying to get images
        }
        
        /* we need to access the user id, so assign it to a var, guard lets us check if an optional exists and if not then exit the scope*/
        guard let currentUser = Auth.auth().currentUser else{
            return
        }
        
        db.collection("nature") //create a collection called nature in server
            .whereField("userId", isEqualTo: currentUser.uid) //current logged in user
                        /* for a understanding on weak self read: https://matteomanferdini.com/swift-weak-self/ */
            .getDocuments{[weak self] (snapshot, error) in
                if let error = error { //if theres a error getting the doc
                    print(error.localizedDescription) //tell us why
                    DispatchQueue.main.async {
                        self?.loadingState = .failure //update loading state
                    }
                }else{
                    if let snapshot = snapshot {
                        let nature: [NatureViewModel] = /*assign array values */
                        /* to understand compactMaps: https://www.hackingwithswift.com/example-code/language/how-to-use-compactmap-to-transform-an-array */
                            snapshot.documents.compactMap{
                            doc in
                            var nature = try? doc.data(as: Nature.self)
                            nature?.id = doc.documentID
                            if let nature = nature{ //if the pic belongs to our user send it to natureviewmodel
                            return NatureViewModel(nature: nature)
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
    
                                    //we may get an error is what below means
    func save(name: String, url: URL, completion: (Error?)->Void){
        
        guard let currentUser = Auth.auth().currentUser else{
            return
        }
        do{
            let _ = try db.collection("nature") //try to make the _ connect to our nature database collection
                .addDocument(from: Nature(name: name, url: url.absoluteString, userId: currentUser.uid)) //add a pic with these values
            completion(nil) //complete with no error
        }catch let error {
            completion (error) //there's a error
        }
    }
    
    /* heres a good link to understand completion: https://medium.com/@amlcurran/improving-completion-blocks-in-swift-e270506ab48a
     also look into escaping closures if your not sure about @escaping:
     https://www.hackingwithswift.com/example-code/language/what-is-an-escaping-closure */
    
    func uploadPhoto(data: Data, completion: @escaping(URL?)->Void){
        
        let imageName = UUID().uuidString //generate a unique identifier
        let storageRef = storage.reference() //path to save the photo
        let photoRef = storageRef.child("images/\(imageName).png") //makes a file name to store photo
        
        photoRef.putData(data, metadata: nil) { //this is to make sure all goes well
            metadata, error in
            photoRef.downloadURL{
                (url,error) in
                if let error = error {
                    print(error.localizedDescription)
                }else{
                    completion(url)
                }
            }
        }
        
    }
    
}
