//
//  FirestoreReferenceManager.swift
//  BadmintonTrainingSupport
//
//  Created by Naufaldi Athallah Rifqi on 15/06/21.
//

import UIKit
import Firebase

struct FirestoreReferenceManager {
    static let db = Firestore.firestore()
    static let physical_db = db.collection("training_category").document("physical").collection("trainings")
}

class FirebaseStorageManager {
    
    public func uploadFile(localFile: URL, serverFileName: String, completionHandler: @escaping (_ isSuccess: Bool, _ url: String?) -> Void) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        // Create a reference to the file you want to upload
        let directory = "uploads/"
        let fileRef = storageRef.child(directory + serverFileName)

        _ = fileRef.putFile(from: localFile, metadata: nil) { metadata, error in
            fileRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    completionHandler(false, nil)
                    return
                }
                // File Uploaded Successfully
                completionHandler(true, downloadURL.absoluteString)
            }
        }
    }
    
    public func uploadImageData(data: Data, serverFileName: String, completionHandler: @escaping (_ isSuccess: Bool, _ url: String?) -> Void) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        // Create a reference to the file you want to upload
        let directory = "uploads/"
        let fileRef = storageRef.child(directory + serverFileName)
        
        _ = fileRef.putData(data, metadata: nil) { metadata, error in
            fileRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    completionHandler(false, nil)
                    return
                }
                // File Uploaded Successfully
                completionHandler(true, downloadURL.absoluteString)
            }
        }
    }

}

