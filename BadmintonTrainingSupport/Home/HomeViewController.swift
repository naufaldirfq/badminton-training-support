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
    var userID = ""
    
    private var trainingCategory: [TrainingCategory] = []
    private var trainings: [Training] = []
    private var trainingCategoryCollectionRef: CollectionReference!
    private var trainingsCollectionRef: CollectionReference!
    private var trainingHistoryCollectionRef: CollectionReference!
    private var matchHistoryCollectionRef: CollectionReference!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !UserDefaults.exists(key: K.userID) {
            UserDefaults.standard.setValue(UUID().uuidString, forKey: K.userID)
        }
        userID = UserDefaults.standard.string(forKey: K.userID)!
        print(userID)
        setupTableView()
        setupStickyButton()
        fetchData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stickyButton.setStickySide(.right)
        tableView.reloadData()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
                                let trainingImg = data["name"] as! String
                                let newTrainings = Training(name: trainingName, description: trainingDesc, image: trainingImg)
                                self.trainings.append(newTrainings)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }
                        let category = data["name"] as! String
                        let newTrainingCategory = TrainingCategory(name: category, trainings: self.trainings)
                        self.trainingCategory.append(newTrainingCategory)
                        Local.data.categories.append(newTrainingCategory)
                        self.trainings = []
                    }
                }
            }
        }
        
        trainingHistoryCollectionRef = FirestoreReferenceManager.db.collection("training_history")
        self.trainingHistoryCollectionRef.whereField("user", isEqualTo: self.userID).order(by: "date").getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    let name = data["name"] as! String
                    let timestamp = data["date"] as! Timestamp
                    let date = timestamp.dateValue()
                    let time = data["time"] as! Int
                    let pace = data["pace"] as! Int
                    let distance = data["distance"] as! Int
                    let set = data["set"] as! Int
                    let repetition = data["repetition"] as! Int
                    let breakTime = data["breakTime"] as! Int
                    let newHistory = TrainingSession(name: name, date: date, time: time, pace: pace, distance: distance, set: set, repetition: repetition, breakTime: breakTime)
                    Local.data.trainingHistory.append(newHistory)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        matchHistoryCollectionRef = FirestoreReferenceManager.db.collection("match")
        self.matchHistoryCollectionRef.whereField("user", isEqualTo: self.userID).order(by: "date").getDocuments { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            } else {
                guard let snap = snapshot else { return }
                for document in snap.documents {
                    let data = document.data()
                    let timestamp = data["date"] as! Timestamp
                    let date = timestamp.dateValue()
                    let description = data["description"] as! String
                    let durations = data["durations"] as! [Int]
                    let isSingle = data["isSingle"] as! Bool
                    let place = data["place"] as! String
                    var teams: [Team] = []
                    let teamsData = document.data()["team"] as! [[String:Any]]
                    for team in teamsData  {
                        let players = team["players"] as! [String]
                        let scores = team["score"] as! [Int]
                        teams.append(Team(players: players, teamScore: scores))
                    }
                    let newHistory = Match(date: date, description: description, durations: durations, isSingle: isSingle, place: place, team: teams)
                    Local.data.matchHistory.append(newHistory)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    @objc func userPhotoTapped() {
        let vc = ProfileViewController()
        vc.delegate = self
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
        case 2:
            var count = CGFloat(Local.data.trainingHistory.count)
            count = count < 1 ? 1 : count
            count = count > 3 ? 3 : count
            return (Sizes.Recents.CellHeight * count) + Sizes.Recents.TableMargins
        case 3:
            var count = CGFloat(Local.data.matchHistory.count)
            count = count < 1 ? 1 : count
            count = count > 3 ? 3 : count
            return (Sizes.Recents.CellHeight * count) + Sizes.Recents.TableMargins
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeProfileCell.identifier) as? HomeProfileCell {
                cell.configure()
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.userPhotoTapped))
                cell.userPhotoImageView.isUserInteractionEnabled = true
                cell.userPhotoImageView.addGestureRecognizer(tapGestureRecognizer)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TrainingCollectionCell.identifier) as? TrainingCollectionCell {
                cell.configure(name: "Recommendation", with: Local.data.trainings)
                cell.delegate = self
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: RecentsCell.identifier) as? RecentsCell {
                cell.configure(type: .training, trainings: Local.data.trainingHistory)
                cell.delegate = self
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: RecentsCell.identifier) as? RecentsCell {
                cell.configure(type: .match, matches: Local.data.matchHistory)
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
