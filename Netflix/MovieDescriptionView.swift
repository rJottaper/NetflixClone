//
//  MovieDescriptionView.swift
//  Netflix
//
//  Created by João Pedro on 30/06/23.
//

import UIKit

protocol MovieDescriptionViewDelegate: AnyObject {
  func watchMovieTrailer();
};

class MovieDescriptionView: UIView {
  let movieBanner = UIImageView();
  let movieName = UILabel();
  let watchButton = UIButton();
  let movieDescription = UILabel();
  
  weak var delegate: MovieDescriptionViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame);
    
    configureLayout();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
  
  func configureScreen(movie: Movie?) {
    if let imageURL = movie?.backdropPath, let name = movie?.title, let description = movie?.overview {
      movieBanner.downloaded(from: "https://image.tmdb.org/t/p/w500\(imageURL)");
      movieName.text = name;
      movieDescription.text = description;
    };
  };
};

extension MovieDescriptionView {
  func configureLayout() {
    configureMovieBanner();
    configureMovieName();
    configureWatchButton();
    configureMovieDescription();
  };
  
  func configureMovieBanner() {
    addSubview(movieBanner);
    
    movieBanner.translatesAutoresizingMaskIntoConstraints = false;
    movieBanner.contentMode = .scaleAspectFill;
    
    NSLayoutConstraint.activate([
      movieBanner.leadingAnchor.constraint(equalTo: leadingAnchor),
      movieBanner.trailingAnchor.constraint(equalTo: trailingAnchor),
      movieBanner.topAnchor.constraint(equalTo: topAnchor, constant: -15),
      movieBanner.widthAnchor.constraint(equalTo: widthAnchor)
    ]);
  };

  func configureMovieName() {
    addSubview(movieName);
    
    movieName.translatesAutoresizingMaskIntoConstraints = false;
    movieName.textAlignment = .center;
    movieName.tintColor = .white;
    movieName.font = .preferredFont(forTextStyle: .title1);
    movieName.adjustsFontForContentSizeCategory = true;
    movieName.numberOfLines = 0;
    
    NSLayoutConstraint.activate([
      movieName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      trailingAnchor.constraint(equalTo: movieName.trailingAnchor, constant: 15),
      movieName.topAnchor.constraint(equalTo: movieBanner.bottomAnchor, constant: 10)
    ]);
  };
  
  func configureWatchButton() {
    addSubview(watchButton);
    
    watchButton.translatesAutoresizingMaskIntoConstraints = false;
    watchButton.backgroundColor = .red;
    watchButton.setTitle("Play", for: .normal);
    watchButton.setTitleColor(.white, for: .normal);
    watchButton.titleLabel?.font = .systemFont(ofSize: 24);
    watchButton.layer.cornerRadius = 10;
    
    watchButton.addTarget(self, action: #selector(watchButtonTapped), for: .touchUpInside)
    
    watchButton.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal);
    watchButton.tintColor = .white;
    watchButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30);
    
    NSLayoutConstraint.activate([
      watchButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      watchButton.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 20),
      watchButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
      trailingAnchor.constraint(equalTo: watchButton.trailingAnchor, constant: 70),
      watchButton.heightAnchor.constraint(equalToConstant: 50)
    ]);
  };
  
  func configureMovieDescription() {
    addSubview(movieDescription);
    
    movieDescription.translatesAutoresizingMaskIntoConstraints = false;
    movieDescription.tintColor = .white;
    movieDescription.font = .preferredFont(forTextStyle: .title3);
    movieDescription.adjustsFontForContentSizeCategory = true;
    movieDescription.numberOfLines = 0;
    
    NSLayoutConstraint.activate([
      movieDescription.topAnchor.constraint(equalTo: watchButton.bottomAnchor, constant: 20),
      movieDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      trailingAnchor.constraint(equalTo: movieDescription.trailingAnchor, constant: 10),
      movieDescription.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]);
  };
};

extension MovieDescriptionView {
  @objc func watchButtonTapped() {
    delegate?.watchMovieTrailer();
  };
};
