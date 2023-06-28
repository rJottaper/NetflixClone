//
//  MovieDownloadCell.swift
//  Netflix
//
//  Created by João Pedro on 27/06/23.
//

import UIKit

class MovieDownloadCell: UITableViewCell {
  let imageMovie = UIImageView();
  let titleMovie = UILabel();
  let playButton = UIImageView();
  
  static let identifier = "moviedownloadcell";
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier);
    
    configureCellLayout();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
  
  func configureCell(image: String, title: String) {
    imageMovie.downloaded(from: "https://image.tmdb.org/t/p/w500\(image)");
    titleMovie.text = title;
  };
};

extension MovieDownloadCell {
  func configureCellLayout() {
    configureImageMovie();
    configureTitleMovie();
    configurePlayButton();
  };
  
  func configureImageMovie() {
    addSubview(imageMovie);
    
    imageMovie.translatesAutoresizingMaskIntoConstraints = false;
    
    NSLayoutConstraint.activate([
      imageMovie.centerYAnchor.constraint(equalTo: centerYAnchor),
      imageMovie.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      imageMovie.widthAnchor.constraint(equalToConstant: 120),
      imageMovie.heightAnchor.constraint(equalToConstant: 160)
    ]);
  };
  
  func configureTitleMovie() {
    addSubview(titleMovie);
    
    titleMovie.translatesAutoresizingMaskIntoConstraints = false;
    titleMovie.tintColor = .white;
    titleMovie.font = .preferredFont(forTextStyle: .title2);
    titleMovie.adjustsFontForContentSizeCategory = true;
    titleMovie.numberOfLines = 0;
    
    NSLayoutConstraint.activate([
      titleMovie.topAnchor.constraint(equalTo: topAnchor),
      titleMovie.leadingAnchor.constraint(equalTo: imageMovie.trailingAnchor, constant: 15),
//      trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 10),
      titleMovie.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]);
  };
  
  func configurePlayButton() {
    addSubview(playButton);
    
    playButton.translatesAutoresizingMaskIntoConstraints = false;
    playButton.image = UIImage(systemName: "play.circle");
    playButton.tintColor = .white;
    
    NSLayoutConstraint.activate([
      playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
      playButton.leadingAnchor.constraint(equalTo: titleMovie.trailingAnchor, constant: 10),
      trailingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 30),
      playButton.widthAnchor.constraint(equalToConstant: 40),
      playButton.heightAnchor.constraint(equalToConstant: 40)
    ]);
  };
};
