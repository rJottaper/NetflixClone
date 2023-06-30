//
//  HomeView.swift
//  Netflix
//
//  Created by João Pedro on 30/06/23.
//

import UIKit

class HomeView: UIView {
  let mainMovie = UIImageView();
  let mainMovieButton = UIButton();
  
  let topRated = MovieCarousel(carouselTitle: "Top Rated");
  let popular = MovieCarousel(carouselTitle: "Popular");
  let upcoming = MovieCarousel(carouselTitle: "Upcoming");

  override init(frame: CGRect) {
    super.init(frame: frame);
    
    configureLayout();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
};

extension HomeView {
  func configureLayout() {
    configureMainMovie();
    configureMainMovieButton();
    configureTopRated();
    configurePopular();
    configureUpcoming();
  };
  
  func configureMainMovie() {
    addSubview(mainMovie);
    
    mainMovie.translatesAutoresizingMaskIntoConstraints = false;
    mainMovie.contentMode = .scaleAspectFill;
    mainMovie.image = UIImage(named: "mainBanner");
    
    NSLayoutConstraint.activate([
      mainMovie.topAnchor.constraint(equalTo: topAnchor, constant: -80),
      mainMovie.leadingAnchor.constraint(equalTo: leadingAnchor),
      trailingAnchor.constraint(equalTo: mainMovie.trailingAnchor),
      mainMovie.heightAnchor.constraint(equalToConstant: 450),
      mainMovie.widthAnchor.constraint(equalTo: widthAnchor)
    ]);
  };
  
  func configureMainMovieButton() {
    addSubview(mainMovieButton);
    
    mainMovieButton.translatesAutoresizingMaskIntoConstraints = false;
    mainMovieButton.backgroundColor = .white;
    mainMovieButton.titleLabel?.font = .systemFont(ofSize: 24)
    mainMovieButton.setTitle("Play", for: .normal);
    mainMovieButton.setTitleColor(.black, for: .normal);
    mainMovieButton.layer.cornerRadius = 10;
    
    mainMovieButton.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22)), for: .normal);
    mainMovieButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20);
    mainMovieButton.tintColor = .black;
    
    NSLayoutConstraint.activate([
      mainMovieButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      mainMovieButton.topAnchor.constraint(equalTo: mainMovie.bottomAnchor, constant: -20),
      mainMovieButton.widthAnchor.constraint(equalToConstant: 150),
      mainMovieButton.heightAnchor.constraint(equalToConstant: 50)
    ]);
  };
  
  func configureTopRated() {
    addSubview(topRated);
    
    topRated.translatesAutoresizingMaskIntoConstraints = false;
    
    GetMovies(endpoint: "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1") { result in
      switch result {
      case .success(let movieResponse):
        self.topRated.carouselMovies = movieResponse;
      case .failure(let error):
        print(error.localizedDescription);
      };
    };
    
    NSLayoutConstraint.activate([
      topRated.topAnchor.constraint(equalTo: mainMovieButton.bottomAnchor, constant: 10),
      topRated.leadingAnchor.constraint(equalTo: leadingAnchor),
      trailingAnchor.constraint(equalTo: topRated.trailingAnchor),
      topRated.heightAnchor.constraint(equalToConstant: 200),
    ]);
  };
  
  func configurePopular() {
    addSubview(popular);
    
    popular.translatesAutoresizingMaskIntoConstraints = false;
    
    GetMovies(endpoint: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1") { result in
      switch result {
      case .success(let movieResponse):
        self.popular.carouselMovies = movieResponse;
      case .failure(let error):
        print(error.localizedDescription);
      };
    };
    
    NSLayoutConstraint.activate([
      popular.topAnchor.constraint(equalTo: topRated.bottomAnchor, constant: 70),
      popular.leadingAnchor.constraint(equalTo: leadingAnchor),
      trailingAnchor.constraint(equalTo: popular.trailingAnchor),
      popular.heightAnchor.constraint(equalToConstant: 200),
    ]);
  };
  
  func configureUpcoming() {
    addSubview(upcoming);
    
    upcoming.translatesAutoresizingMaskIntoConstraints = false;
    
    GetMovies(endpoint: "https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1") { result in
      switch result {
      case .success(let movieResponse):
        self.upcoming.carouselMovies = movieResponse;
      case .failure(let error):
        print(error.localizedDescription);
      };
    };
    
    NSLayoutConstraint.activate([
      upcoming.topAnchor.constraint(equalTo: popular.bottomAnchor, constant: 70),
      upcoming.leadingAnchor.constraint(equalTo: leadingAnchor),
      trailingAnchor.constraint(equalTo: upcoming.trailingAnchor),
      upcoming.heightAnchor.constraint(equalToConstant: 200),
      upcoming.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -30)
    ]);
  };
};
