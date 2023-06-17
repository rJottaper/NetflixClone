//
//  WelcomeView.swift
//  Netflix
//
//  Created by João Pedro on 27/05/23.
//

import UIKit

protocol WelcomeViewDelegate: AnyObject {
  func accessButtonTapped();
};

class WelcomeView: UIView {
  let netflixIcon = UIImageView();
  let titleWelcome = UILabel();
  let buttonWelcome = UIButton();
  
  weak var delegate: WelcomeViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame);
    
    configureLayouts();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  };
};

extension WelcomeView {
  @objc func accessHome() {
    delegate?.accessButtonTapped();
    buttonWelcome.setTitle("", for: .normal);
    buttonWelcome.configuration?.showsActivityIndicator = true;
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
      self.buttonWelcome.setTitle("Access", for: .normal);
      self.buttonWelcome.configuration?.showsActivityIndicator = false
    };
  };
};

// MARK: Layouts Configs
extension WelcomeView {
  private func configureLayouts() {
    configureNetflixIcon();
    configureTitleWelcome();
    configureButtonWelcome();
  };
  
  private func configureNetflixIcon() {
    addSubview(netflixIcon);
    
    netflixIcon.translatesAutoresizingMaskIntoConstraints = false;
    netflixIcon.contentMode = .scaleAspectFit;
    netflixIcon.image = UIImage(named: "NetflixIcon");
    
    NSLayoutConstraint.activate([
//      netflixIcon.topAnchor.constraint(equalTo: topAnchor, constant: 200),
      netflixIcon.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
      netflixIcon.leadingAnchor.constraint(equalTo: leadingAnchor),
      trailingAnchor.constraint(equalTo: netflixIcon.trailingAnchor),
      netflixIcon.heightAnchor.constraint(equalToConstant: 200)
    ]);
  };
  
  private func configureTitleWelcome() {
    addSubview(titleWelcome);
    
    titleWelcome.translatesAutoresizingMaskIntoConstraints = false;
    titleWelcome.textColor = .white;
    titleWelcome.text = "Do you already know what to watch today?";
    titleWelcome.font = .preferredFont(forTextStyle: .title1);
    titleWelcome.textAlignment = .center;
    titleWelcome.adjustsFontForContentSizeCategory = true;
    titleWelcome.numberOfLines = 0;
    
    NSLayoutConstraint.activate([
      titleWelcome.topAnchor.constraint(equalTo: netflixIcon.bottomAnchor, constant: 80),
      titleWelcome.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      trailingAnchor.constraint(equalTo: titleWelcome.trailingAnchor, constant: 20)
    ]);
  };
  
  private func configureButtonWelcome() {
    addSubview(buttonWelcome);
    
    buttonWelcome.translatesAutoresizingMaskIntoConstraints = false;
    buttonWelcome.setTitle("Access", for: .normal);
    buttonWelcome.setTitleColor(.white, for: .normal);
    buttonWelcome.layer.cornerRadius = 10;
    buttonWelcome.configuration = .filled();
    buttonWelcome.configuration?.imagePadding = 8;
    buttonWelcome.configuration?.background.backgroundColor = .red;
    buttonWelcome.addTarget(self, action: #selector(accessHome), for: .touchUpInside);
    
    NSLayoutConstraint.activate([
      buttonWelcome.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      trailingAnchor.constraint(equalTo: buttonWelcome.trailingAnchor, constant: 20),
      buttonWelcome.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
      buttonWelcome.heightAnchor.constraint(equalToConstant: 50)
    ]);
  };
};
