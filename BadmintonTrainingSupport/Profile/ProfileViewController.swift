//
//  ProfileViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit
import AuthenticationServices
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTableView: UITableView!
    weak var delegate: HomeViewController?
    
    var semaphoreFetchRecents = 0 {
        didSet {
            if semaphoreFetchRecents == 2 {
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(TrainingChartCell.nib(), forCellReuseIdentifier: TrainingChartCell.identifier)
        profileTableView.register(ProfileInfoCell.nib(), forCellReuseIdentifier: ProfileInfoCell.identifier)
    }
    
    @objc func handleSignInWithAppleTapped() {
        performSignIn()
    }
    
    func performSignIn() {
        let request = createAppleIDRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        
        authorizationController.performRequests()
    }
    
    func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        currentNonce = nonce
        
        return request
    }
    
    func fetchRecents() {
        FirestoreReferenceManager.db.collection("training_history").whereField("user", isEqualTo: UserProfile.uid).order(by: "date").getDocuments { (snapshot, error) in
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
                }
                self.semaphoreFetchRecents += 1
            }
        }
        
        FirestoreReferenceManager.db.collection("match").whereField("user", isEqualTo: UserProfile.uid).order(by: "date").getDocuments { (snapshot, error) in
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
                }
                self.semaphoreFetchRecents += 1
            }
        }
    }
}

extension ProfileViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { (AuthDataResult, Error) in
                if let user = AuthDataResult?.user {
                    print("Nice! You're now signed in as \(user.uid), email: \(user.email ?? "unknown"), name: \(appleIDCredential.fullName?.givenName ?? "unknown") \(appleIDCredential.fullName?.familyName ?? "")")
                    let fullName = "\(appleIDCredential.fullName?.givenName ?? "") \(appleIDCredential.fullName?.familyName ?? "")"
                    UserDefaults.standard.setValue(fullName, forKey: K.UserName)
                    UserDefaults.standard.setValue(user.uid, forKey: K.AppleID)
                    let ref = FirestoreReferenceManager.db.collection("users").document(user.uid)
                    ref.getDocument { document, error in
                        if let doc = document {
                            if doc.exists {
                                if let data = doc.data() {
                                    let id = data["localID"] as! String
                                    let name = data["name"] as! String
                                    let photoURL = data["photoURL"] as! String
                                    UserDefaults.standard.setValue(id, forKey: K.userID)
                                    UserDefaults.standard.setValue(name, forKey: K.UserName)
                                    UserDefaults.standard.setValue(photoURL, forKey: K.PhotoURL)
                                    self.fetchRecents()
                                }
                            } else {
                                FirestoreReferenceManager.db.collection("users").document(user.uid).setData([
                                    "localID" : UserProfile.uid,
                                    "name" : UserProfile.name,
                                    "photoURL" : UserProfile.photoURL
                                ])
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
}

extension ProfileViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
}

// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
private func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
            }
            return random
        }
        
        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }
            
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    
    return result
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + Local.data.trainingsWithValidData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoCell.identifier, for: indexPath) as? ProfileInfoCell{
                cell.configure()
                cell.delegate = self
                return cell
            }
        case 1:
            if let _ = UserProfile.appleID {
                return UITableViewCell()
            }
            let cell = UITableViewCell()
            let button = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
            button.frame = CGRect(x: 32, y: 16, width: tableView.frame.width - 64, height: 40)
            button.addTarget(self, action: #selector(handleSignInWithAppleTapped), for: .touchUpInside)
            button.center = cell.contentView.center
            button.autoresizingMask = [.flexibleLeftMargin,.flexibleBottomMargin,.flexibleRightMargin,.flexibleTopMargin]
            cell.addSubview(button)
            return cell
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TrainingChartCell.identifier, for: indexPath) as? TrainingChartCell{
                cell.configure(with: Local.data.trainingsWithValidData[indexPath.row-2])
                return cell
            }
        }
        
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return Sizes.HomeProfile.ProfileInfoHeight
        case 1:
            if let _ = UserProfile.appleID {
                return 0
            }
            return 72
        default:
            return Sizes.HomeProfile.ChartsHeight
        }
    }
}





import CryptoKit

// Unhashed nonce.
fileprivate var currentNonce: String?

@available(iOS 13, *)
private func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
    }.joined()
    
    return hashString
}
