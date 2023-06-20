//
//  ProfileView.swift
//  Netflix
//
//  Created by João Pedro on 18/06/23.
//

protocol ProfileViewDelegate: AnyObject {
  func getProfilePhoto();
};

import UIKit

class ProfileView: UIView {
  let profilePhoto = UIImageView();
  let profileName = UILabel();
  
  var image: UIImage? = nil {
    didSet {
      profilePhoto.image = image;
    }
  };
  
  weak var delegate: ProfileViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame);
    
    configureLayout();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
};

// MARK: Photo Functions
extension ProfileView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @objc func getImage() {
    delegate?.getProfilePhoto();
  };
};

extension ProfileView {
  func configureLayout() {
    self.translatesAutoresizingMaskIntoConstraints = false;
    
    configureProfilePhoto();
    configureProfileName();
  };
  
  func configureProfilePhoto() {
    addSubview(profilePhoto);
    
    let tapImage = UITapGestureRecognizer(target: self, action: #selector(getImage))
    
    profilePhoto.translatesAutoresizingMaskIntoConstraints = false;
    profilePhoto.backgroundColor = .white
    profilePhoto.layer.cornerRadius = 100
    profilePhoto.clipsToBounds = true
    profilePhoto.isUserInteractionEnabled = true;
    profilePhoto.addGestureRecognizer(tapImage);
    profilePhoto.image = image ?? nil
    
    NSLayoutConstraint.activate([
      profilePhoto.centerXAnchor.constraint(equalTo: centerXAnchor),
      profilePhoto.topAnchor.constraint(equalTo: topAnchor, constant: 100),
      profilePhoto.widthAnchor.constraint(equalToConstant: 200),
      profilePhoto.heightAnchor.constraint(equalToConstant: 200)
    ]);
  };
  
  func configureProfileName() {
    addSubview(profileName);
    
    profileName.translatesAutoresizingMaskIntoConstraints = false;
    profileName.text = "João Pedro";
    profileName.textColor = .white;
    profileName.textAlignment = .center;
    profileName.font = .preferredFont(forTextStyle: .title2);
    profileName.adjustsFontForContentSizeCategory = true;
    profileName.numberOfLines = 0;
    
    NSLayoutConstraint.activate([
      profileName.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 20),
      profileName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      trailingAnchor.constraint(equalTo: profileName.trailingAnchor, constant: 20)
    ]);
  };
};
