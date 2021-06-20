//
//  HomeViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit
import StickyButton
import Firebase

class HomeViewController: UIViewController {
    
    let stickyButton = StickyButton(size: 60)
    
    var userData: UserProfile?
    
    private var trainingCategory: [TrainingCategory] = []
    private var trainings: [Training] = []
    private var trainingCategoryCollectionRef: CollectionReference!
    private var trainingsCollectionRef: CollectionReference!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserData()
        setupTableView()
        setupStickyButton()
        fetchData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stickyButton.setStickySide(.right)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupUserData() {
        if userData == nil {
            if let user = Auth.auth().currentUser {
                userData = UserProfile(name: user.displayName ?? "jin")
            }
        }
        
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TrainingCollectionCell.nib(), forCellReuseIdentifier: TrainingCollectionCell.identifier)
        tableView.register(RecentsCell.nib(), forCellReuseIdentifier: RecentsCell.identifier)
        tableView.register(HomeProfileCell.nib(), forCellReuseIdentifier: HomeProfileCell.identifier)
    }
    
    func setupStickyButton() {
        view.addSubview(stickyButton)
        stickyButton.itemSize = 60
        stickyButton.itemIconBackground = Colors.AccentColor
        stickyButton.itemTitleBackground = Colors.AccentColor
        stickyButton.itemIconTintColor = .white
        stickyButton.itemTitleTextColor = .white
        stickyButton.itemTitleFontSize = 17
        stickyButton.buttonBackgroundColor = Colors.AccentColor
        stickyButton.buttonImage = UIImage(systemName: "plus")
        stickyButton.closeButtonImage = UIImage(systemName: "plus")
        stickyButton.addItem(title: "New Training", icon: UIImage(systemName: "hare.fill")) { item in
            let vc = NewTrainingViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        stickyButton.addItem(title: "New Match", icon: UIImage(systemName: "sportscourt.fill")) { item in
            let vc = NewMatchViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func fetchData() {
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
                            for document in snap.documents {
                                let data = document.data()
                                let trainingName = data["name"] as! String
                                let trainingDesc = data["description"] as! String
                                let trainingImg = data["image_url"] as! String
                                let newTrainings = Training(name: trainingName, description: trainingDesc, image: trainingImg)
                                self.trainings.append(newTrainings)
                                if self.trainings.count == 4 {
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                        }
                        let category = data["name"] as! String
                        let newTrainingCategory = TrainingCategory(name: category, trainings: self.trainings)
                        self.trainingCategory.append(newTrainingCategory)
                    }
                    
                }
            }
        }
    }
    
    @objc func userPhotoTapped() {
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return Sizes.HomeProfile.Height
        case 1:
            return Sizes.TrainingCollection.Height
        case 2...3:
            return Sizes.Recents.Height
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeProfileCell.identifier) as? HomeProfileCell {
                cell.configure(with: userData ?? DummyData.Profile)
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.userPhotoTapped))
                cell.userPhotoImageView.isUserInteractionEnabled = true
                cell.userPhotoImageView.addGestureRecognizer(tapGestureRecognizer)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TrainingCollectionCell.identifier) as? TrainingCollectionCell {
                cell.configure(name: "Recommendation", with: self.trainings)
                cell.delegate = self
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: RecentsCell.identifier) as? RecentsCell {
                cell.configure(type: .training)
                cell.delegate = self
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: RecentsCell.identifier) as? RecentsCell {
                cell.configure(type: .match)
                cell.delegate = self
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
}

extension HomeViewController: TrainingCollectionDelegate {
    
    func collectionView(trainingCell: TrainingCell, index: Int, didTappedInTableViewCell: TrainingCollectionCell) {
        print("Pressed \(trainingCell.name)!")
    }
    
}

extension HomeViewController: RecentsDelegate {
    
    func recentsView(didTapViewAllIn cell: RecentsCell) {
        print("Pressed View All on \(cell.type!.rawValue)!")
    }
    
    func recentsView(recent: UITableViewCell, index: Int, didTapRecentIn cell: RecentsCell) {
        print("Pressed Recent Number \(index+1) on \(cell.type!.rawValue)!")
    }
    
}
