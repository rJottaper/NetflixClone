//
//  ProfileViewController.swift
//  Netflix
//
//  Created by João Pedro on 18/06/23.
//

import UIKit

class ProfileViewController: UIViewController {
  let profileView = ProfileView();
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    view.backgroundColor = .black;
    
    configureProfileView();
  };
};

// MARK: Photo Function
extension ProfileViewController: ProfileViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func getProfilePhoto() {
    let PickerVC = UIImagePickerController();
    PickerVC.sourceType = .photoLibrary;
    PickerVC.allowsEditing = true;
    PickerVC.delegate = self;
    
    present(PickerVC, animated: true);
  };
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
      profileView.image = image;
    };
    
    picker.dismiss(animated: true, completion: nil);
  };
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil);
  };
};

// MARK: LAYOUT
extension ProfileViewController {
  func configureProfileView() {
    view.addSubview(profileView);
    
    profileView.delegate = self;
    
    NSLayoutConstraint.activate([
      profileView.topAnchor.constraint(equalTo: view.topAnchor),
      profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: profileView.trailingAnchor),
      profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ]);
  };
};
