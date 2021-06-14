//
//  NewTrainingViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit
import Firebase

class NewTrainingViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var trainingCategory: [TrainingCategory] = []
    private var trainings: [Training] = []
    private var trainingCategoryCollectionRef: CollectionReference!
    private var trainingsCollectionRef: CollectionReference!
    
    private var home = HomeViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New Training"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrainingCollectionCell.nib(), forCellReuseIdentifier: TrainingCollectionCell.identifier)
//        print(trainingCategory)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initModels()
    }
    
    func initModels() {
        trainingCategoryCollectionRef = Firestore.firestore().collection("training_category")
        trainingCategoryCollectionRef.getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    self.trainingsCollectionRef = Firestore.firestore().collection("training_category").document(document.documentID).collection("trainings")
                    self.trainingsCollectionRef.getDocuments { (snapshot, error) in
                        if let err = error {
                            debugPrint("Error fetching docs: \(err)")
                        } else {
                            guard let snap = snapshot else { return }
                            self.trainings = []
                            for document in snap.documents {
                                let data = document.data()
                                let trainingName = data["name"] as! String
                                let trainingDesc = data["description"] as! String
                                let trainingImg = data["image_url"] as! String
                                let newTrainings = Training(name: trainingName, description: trainingDesc, image: trainingImg)
                                self.trainings.append(newTrainings)
                            }
                        }
                        let category = data["name"] as! String
                        let newTrainingCategory = TrainingCategory(name: category, trainings: self.trainings)
                        self.trainingCategory.append(newTrainingCategory)
                        print(self.trainingCategory)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}

extension NewTrainingViewController: UITableViewDelegate, UITableViewDataSource, TrainingCollectionDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainingCategory.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Sizes.TrainingCollection.Height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(trainingCategory)
        if let cell = tableView.dequeueReusableCell(withIdentifier: TrainingCollectionCell.identifier) as? TrainingCollectionCell {
            let category = trainingCategory[indexPath.row]
            cell.configure(name: category.name, with: category.trainings)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func collectionView(trainingCell: TrainingCell, index: Int, didTappedInTableViewCell: TrainingCollectionCell) {
        print("Pressed \(trainingCell.name)!")
    }
}
