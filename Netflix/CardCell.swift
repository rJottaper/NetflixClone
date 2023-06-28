//
//  CardCell.swift
//  Netflix
//
//  Created by João Pedro on 04/06/23.
//

import UIKit

class CardCell: UITableViewCell {
  static let indetifer = "CardCell";
  
  var movies: MovieResponse?;
  
  let card: UICollectionView = {
    let layout = UICollectionViewFlowLayout();
    let cardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout);

    layout.scrollDirection = .horizontal;
    layout.itemSize = CGSize(width: 140, height: 200);

    cardCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell");
    
    return cardCollectionView;
  }();
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier);
    
    contentView.addSubview(card);
    
    card.delegate = self;
    card.dataSource = self;
  };
  
  override func layoutSubviews() {
    super.layoutSubviews();
    
    card.frame = contentView.bounds;
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  };
  
  func configure(with movies: MovieResponse) {
    self.movies = movies;
    card.reloadData();
  };
};

extension CardCell: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies?.results.count ?? 0;
  };
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath);
    
    if let movie = movies?.results[indexPath.item], let imageURL = movie.posterPath {
      let imageView = UIImageView(frame: cell.bounds);
      imageView.clipsToBounds = true;
      imageView.downloaded(from: "https://image.tmdb.org/t/p/w500\(imageURL)");
      
      cell.addSubview(imageView);
    };
    
    return cell;
  };
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let navigationController = self.window?.rootViewController as! UINavigationController;
    let movieDetailsViewController = MovieDescriptionViewController();
    movieDetailsViewController.movie = movies?.results[indexPath.item];
    
    let transition = CATransition();
    transition.duration = 1;
    transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut);
    transition.type = .fade;
    
    navigationController.view.layer.add(transition, forKey: nil);
    navigationController.pushViewController(movieDetailsViewController, animated: true); 
  };
  
  func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ in
      let downloadAction = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
        if let movie = self!.movies?.results[indexPath.item] {
          let movieDownload = MovieDownload(context: self!.context);
          
          movieDownload.title = movie.title;
          movieDownload.posterPath = movie.posterPath;
          
          do {
            try self?.context.save();
            print("Movie saved");
          } catch {
            print("Failed to save movie");
          };
        };
      };
      return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction]);
    };
    return config;
  };
};
