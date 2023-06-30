//
//  HomeViewController.swift
//  Netflix
//
//  Created by João Pedro on 02/06/23.
//

import UIKit

class HomeViewController: UIViewController {
  let scrollView = UIScrollView();
  let homeView = HomeView();
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    configureLayouts();
  };
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews();
    
    configureScrollView();
  };
};

extension HomeViewController {
  func configureLayouts() {
    configureScrollView();
    configureHomeView();
  };
  
  func configureScrollView() {
    view.addSubview(scrollView);
    
    scrollView.translatesAutoresizingMaskIntoConstraints = false;
    scrollView.isScrollEnabled = true;
    scrollView.contentInset.bottom = 20
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      scrollView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
    ]);
  };

  func configureHomeView() {
    scrollView.addSubview(homeView);
    
    homeView.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      homeView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      homeView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: homeView.trailingAnchor),
      homeView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      homeView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ]);
  };
};
