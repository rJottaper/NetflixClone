//
//  UIViewController+Utils.swift
//  Netflix
//
//  Created by João Pedro on 18/06/23.
//

import UIKit

extension UIViewController {
  func setTabBarImage(imageName: String, title: String) {
    let configuration = UIImage.SymbolConfiguration(scale: .large);
    let image = UIImage(systemName: imageName, withConfiguration: configuration);
    tabBarItem = UITabBarItem(title: title, image: image, tag: 0);
  };
};
