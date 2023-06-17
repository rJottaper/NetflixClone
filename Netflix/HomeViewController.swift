//
//  HomeViewController.swift
//  Netflix
//
//  Created by João Pedro on 02/06/23.
//

import UIKit

class HomeViewController: UIViewController {
  let scrollView = UIScrollView();
  
  let mainMovie = UIImageView();
  let mainMovieButton = UIButton();
  
  let topRated = MovieCarousel(carouselTitle: "Top Rated");
  let popular = MovieCarousel(carouselTitle: "Popular");
  let upcoming = MovieCarousel(carouselTitle: "Upcoming");
  
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
    configureMainMovie();
    configureMainMovieButton();
    configureTopRated();
    configurePopular();
    configureUpcoming()
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
  
  func configureMainMovie() {
    scrollView.addSubview(mainMovie);
    
    mainMovie.translatesAutoresizingMaskIntoConstraints = false;
    mainMovie.contentMode = .scaleAspectFill;
    mainMovie.image = UIImage(named: "mainBanner");
    
    NSLayoutConstraint.activate([
      mainMovie.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -80),
      mainMovie.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: mainMovie.trailingAnchor),
      mainMovie.heightAnchor.constraint(equalToConstant: 450),
      mainMovie.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ]);
  };
  
  func configureMainMovieButton() {
    scrollView.addSubview(mainMovieButton);
    
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
      mainMovieButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      mainMovieButton.topAnchor.constraint(equalTo: mainMovie.bottomAnchor, constant: -20),
      mainMovieButton.widthAnchor.constraint(equalToConstant: 150),
      mainMovieButton.heightAnchor.constraint(equalToConstant: 50)
    ]);
  };
  
  func configureTopRated() {
    scrollView.addSubview(topRated);
    
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
      topRated.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: topRated.trailingAnchor),
      topRated.heightAnchor.constraint(equalToConstant: 200),
    ]);
  };
  
  func configurePopular() {
    scrollView.addSubview(popular);
    
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
      popular.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: popular.trailingAnchor),
      popular.heightAnchor.constraint(equalToConstant: 200),
    ]);
  };
  
  func configureUpcoming() {
    scrollView.addSubview(upcoming);
    
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
      upcoming.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: upcoming.trailingAnchor),
      upcoming.heightAnchor.constraint(equalToConstant: 200),
      upcoming.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -30)
    ]);
  };
};
