//
//  FirestoreReferenceManager.swift
//  BadmintonTrainingSupport
//
//  Created by Naufaldi Athallah Rifqi on 15/06/21.
//

import Firebase

struct FirestoreReferenceManager {
    static let db = Firestore.firestore()
    static let physical_db = db.collection("training_category").document("physical").collection("trainings")
}
