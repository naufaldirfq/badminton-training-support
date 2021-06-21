//
//  ProfileInfoCell.swift
//  BadmintonTrainingSupport
//
//  Created by Kevin Leon on 20/06/21.
//

import UIKit
import FirebaseStorage

class ProfileInfoCell: UITableViewCell{
    weak var delegate: UIViewController?
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        // Initialization code
    }
    static let identifier = "ProfileInfoCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    func configure() {
        profileImage.image = UserProfile.photo
        profileNameButton.setTitle(UserProfile.name, for: .normal)
        profileImage.layer.cornerRadius = profileImage.frame.width/2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func didTapPhoto(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        delegate?.present(vc, animated: true)
    }
    @IBAction func changeProfileName(_ sender: Any) {
        let alert = UIAlertController(title: "Rename", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        let save = UIAlertAction(title: "Save", style: .default) { action in
            if let text = alert.textFields?.first?.text, text != "" {
                UserDefaults.standard.setValue(text, forKey: K.UserName)
                if let id = UserProfile.appleID {
                    FirestoreReferenceManager.db.collection("users").document(id).updateData([
                        "name" : UserProfile.name
                    ])
                }
                self.profileNameButton.setTitle(text, for: .normal)
            }
            
        }
        alert.addAction(save)
        
        alert.addTextField { textField in
            textField.placeholder = "Enter Name"
            textField.text = UserProfile.name
        }
        self.delegate?.present(alert, animated: true, completion: nil)
    }
    
}
extension ProfileInfoCell: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            profileImage.image = image
            if let data = image.pngData() {
                FirebaseStorageManager().uploadImageData(data: data, serverFileName: "\(UserProfile.uid).png") { (isSuccess, url) in
                    if let url = url {
                        UserDefaults.standard.setValue(url, forKey: K.PhotoURL)
                        if let id = UserProfile.appleID {
                            FirestoreReferenceManager.db.collection("users").document(id).updateData([
                                "photoURL" : url
                            ])
                        }
                    }
                    print("Successfully uploaded profile picture")
                }
            }
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

