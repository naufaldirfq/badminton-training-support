//
//  ProfileViewController.swift
//  BadmintonTrainingSupport
//
//  Created by Joanda Febrian on 05/06/21.
//

import UIKit
import AuthenticationServices
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileTableView: UITableView!
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
//                    self.doSignIn(appleIDCredential: appleIDCredential, user: user)
                    let vc = HomeViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    print("Nice! You're now signed in as \(user.uid), email: \(user.email ?? "unknown"), name: \(appleIDCredential.fullName?.givenName ?? "unknown") \(appleIDCredential.fullName?.familyName ?? "")")
                    let fullName = "\(appleIDCredential.fullName?.givenName ?? "") \(appleIDCredential.fullName?.familyName ?? "")"
                    UserDefaults.standard.setValue(fullName, forKey: "UserName")
                }
            }
        }
    }
    
    func doSignIn(appleIDCredential: ASAuthorizationAppleIDCredential, user: User) {
        if let fullName = appleIDCredential.fullName {
            if let givenName = fullName.givenName, let familyName = fullName.familyName {
                let displayName = "\(givenName) \(familyName)"
                updateDisplayName(displayName: displayName)
            }
        }
    }
    
    func updateDisplayName(displayName: String) { // (2)
        if let user = Auth.auth().currentUser {
            let changeRequest = user.createProfileChangeRequest() // (3)
            changeRequest.displayName = displayName
            changeRequest.commitChanges { error in // (4)
                if error != nil {
                    print("Successfully updated display name for user [\(user.uid)] to [\(displayName)]")
                } else {
                    print("failed to update display name \(error?.localizedDescription ?? "error")")
                }
            }
            DispatchQueue.main.async {
                let vc = HomeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
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
            let cell = UITableViewCell()
            let button = ASAuthorizationAppleIDButton()
            button.addTarget(self, action: #selector(handleSignInWithAppleTapped), for: .touchUpInside)
            button.center = cell.contentView.center
            button.autoresizingMask = [.flexibleLeftMargin,.flexibleBottomMargin,.flexibleRightMargin,.flexibleTopMargin]
            cell.addSubview(button)
            button.widthAnchor.constraint(equalToConstant: tableView.frame.width - 64).isActive = true

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
        case 1: return 72
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
