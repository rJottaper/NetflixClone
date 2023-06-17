//
//  MovieCarousel.swift
//  Netflix
//
//  Created by João Pedro on 03/06/23.
//

import UIKit

class MovieCarousel: UIView {
  let carouselTitle = UILabel();
  let carouselTableView = UITableView();
  
  var carouselMovies: MovieResponse? {
    didSet {
      DispatchQueue.main.async {
        self.carouselTableView.reloadData();
      };
    }
  };

  required init(carouselTitle: String) {
    super.init(frame: CGRect.zero);
    
    self.carouselTitle.text = carouselTitle;
    
    configureLayouts();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
};

extension MovieCarousel {
  func configureLayouts() {
    configureCarouselTitle();
    configureCarouselTableView();
  };
  
  func configureCarouselTitle() {
    addSubview(carouselTitle);
    
    carouselTitle.translatesAutoresizingMaskIntoConstraints = false;
    carouselTitle.textColor = .white;
    carouselTitle.font = .systemFont(ofSize: 28);
    
    NSLayoutConstraint.activate([
      carouselTitle.topAnchor.constraint(equalTo: topAnchor),
      carouselTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      trailingAnchor.constraint(equalTo: carouselTitle.trailingAnchor)
    ]);
  };
  
  func configureCarouselTableView() {
    carouselTableView.frame = bounds;
    addSubview(carouselTableView);
    
    carouselTableView.translatesAutoresizingMaskIntoConstraints = false;
    
    carouselTableView.delegate = self;
    carouselTableView.dataSource = self;
    carouselTableView.register(CardCell.self, forCellReuseIdentifier: CardCell.indetifer);
    
    NSLayoutConstraint.activate([
      carouselTableView.topAnchor.constraint(equalTo: carouselTitle.bottomAnchor, constant: 15),
      carouselTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      trailingAnchor.constraint(equalTo: carouselTableView.trailingAnchor),
      carouselTableView.heightAnchor.constraint(equalToConstant: 200)
    ]);
  };
};

extension MovieCarousel: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1;
  };
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.indetifer, for: indexPath) as! CardCell 
    if let movies = carouselMovies {
      cell.configure(with: movies);
    };
    
    return cell;
  };
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200;
  };
};
