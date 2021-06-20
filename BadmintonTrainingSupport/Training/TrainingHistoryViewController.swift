//
//  TrainingHistoryViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit
import Firebase

class TrainingHistoryViewController: UIViewController {
    
//    let trainingHistory = DummyData.TrainingHistory
    
    private var trainingHistory: [TrainingSession] = []
    private var trainings: [Training] = []
    private var trainingCategoryCollectionRef: CollectionReference!
    private var trainingsCollectionRef: CollectionReference!
    
    @IBOutlet weak var trainingHistoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        navigationItem.title = "Training History"
    }
    
    func initTableView() {
        trainingHistoryTableView.dataSource = self
        trainingHistoryTableView.delegate = self
        trainingHistoryTableView.register(TrainingHistoryTableViewCell.nib(), forCellReuseIdentifier:TrainingHistoryTableViewCell.identifier)
    }
    
//    func initModels() {
//        trainingCategoryCollectionRef = Firestore.firestore().collection("training_category")
//        trainingCategoryCollectionRef.getDocuments { (snapshot, error) in
//            if let err = error {
//                debugPrint("Error fetching docs: \(err)")
//            } else {
//                guard let snap = snapshot else { return }
//                for document in snap.documents {
//                    let data = document.data()
//                    self.trainingsCollectionRef = Firestore.firestore().collection("training_category").document(document.documentID).collection("trainings")
//                    self.trainingsCollectionRef.getDocuments { (snapshot, error) in
//                        if let err = error {
//                            debugPrint("Error fetching docs: \(err)")
//                        } else {
//                            guard let snap = snapshot else { return }
//                            self.trainings = []
//                            for document in snap.documents {
//                                let data = document.data()
//                                let trainingName = data["name"] as! String
//                                let trainingDesc = data["description"] as! String
//                                let trainingImg = data["image_url"] as! String
//                                let newTrainings = Training(name: trainingName, description: trainingDesc, image: trainingImg)
//                                self.trainings.append(newTrainings)
//                            }
//                        }
//                        let category = data["name"] as! String
//                        let newTrainingCategory = TrainingCategory(name: category, trainings: self.trainings)
//                        self.trainingCategory.append(newTrainingCategory)
//                        print(self.trainingCategory)
//                        self.tableView.reloadData()
//                    }
//                }
//            }
//        }
//    }

}
extension TrainingHistoryViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainingHistory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrainingHistoryTableViewCell.identifier, for: indexPath) as! TrainingHistoryTableViewCell
        cell.configure(with: trainingHistory[indexPath.row])
        return cell
    }
    
    
}
