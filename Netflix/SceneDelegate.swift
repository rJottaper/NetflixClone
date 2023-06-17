//
//  SceneDelegate.swift
//  Netflix
//
//  Created by João Pedro on 23/05/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  let welcomeViewController = WelcomeViewController();
  let homeViewController = HomeViewController();

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let windowScene = (scene as? UIWindowScene) else { return };
    
    window = UIWindow(frame: UIScreen.main.bounds);
    window?.windowScene = windowScene;
    window?.makeKeyAndVisible();
    
    welcomeViewController.delegate = self;
    
    displayWelcome();
  };
};

extension SceneDelegate {
  private func setViewController(viewController: UIViewController, animated: Bool = true) {
    guard animated, let window = self.window else {
      self.window?.rootViewController = viewController;
      self.window?.makeKeyAndVisible();
      
      return
    };
    
    let navController = UINavigationController(rootViewController: viewController);
    window.rootViewController = navController;
    window.makeKeyAndVisible();
    window.backgroundColor = .black;
    UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil);
  };
  
  private func displayWelcome() {
    setViewController(viewController: welcomeViewController)
  };
};

extension SceneDelegate: WelcomeViewControllerDelegate {
  func loginSuccess() {
    setViewController(viewController: homeViewController);
  };
};

