//
//  ViewController.swift
//  Netflix
//
//  Created by João Pedro on 23/05/23.
//

import UIKit
import LocalAuthentication

protocol WelcomeViewControllerDelegate: AnyObject {
  func loginSuccess();
};

class WelcomeViewController: UIViewController {
  let welcomeView = WelcomeView();
  
  weak var delegate: WelcomeViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    configureWelcomeView();
  };
  
  private func configureWelcomeView() {
    view.addSubview(welcomeView);
    
    welcomeView.translatesAutoresizingMaskIntoConstraints = false;
    welcomeView.delegate = self;
    
    NSLayoutConstraint.activate([
      welcomeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      welcomeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: welcomeView.trailingAnchor),
      welcomeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ]);
  };
};

extension WelcomeViewController: WelcomeViewDelegate {
  func accessButtonTapped() {
    let context = LAContext();
    var error: NSError?
    
    if (context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)) {
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please Authorize With Touch ID") { [weak self] success, error in
        DispatchQueue.main.async {
          guard success, error == nil else {
            let alert = UIAlertController(title: "Failed to Authenticate", message: "Please Try Again", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil));
            self?.present(alert, animated: true);
            
            return
          };
          
          self?.delegate?.loginSuccess();
        };
      };
    } else {
      let alert = UIAlertController(title: "Unavailable", message: "You can't use this feature", preferredStyle: .alert);
      alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil));
      present(alert, animated: true);
    };
  };
};
