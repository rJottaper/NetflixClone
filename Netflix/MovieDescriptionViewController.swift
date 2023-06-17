//
//  MovieDescriptionViewController.swift
//  Netflix
//
//  Created by João Pedro on 14/06/23.
//

import UIKit
import youtube_ios_player_helper

class MovieDescriptionViewController: UIViewController {
  var movie: Movie?
  
  let scrollView = UIScrollView();
  let movieBanner = UIImageView();
  let movieName = UILabel();
  let watchButton = UIButton();
  let movieDescription = UILabel();
  
  var trailerURL: String?
  let trailerViewController = UIViewController();
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    view.backgroundColor = .black;
    navigationController?.navigationBar.tintColor = .red;
    navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil);
    automaticallyAdjustsScrollViewInsets = false;
    
    configureLayouts();
  };
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews();
    
    getUrl();
    configureScrollView();
  };
};

// MARK: - Functions
extension MovieDescriptionViewController: YTPlayerViewDelegate {
  func getUrl() {
    let apiKey = "AIzaSyB6UrCs8riqYvftK2Lasn6eqkRtIHkXSOY";
    let movieName = movie?.title ?? "";
    
    let encodedQuery = movieName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    let requestURL = URL(string: "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(encodedQuery)&maxResults=1&type=video&key=\(apiKey)")

    let task = URLSession.shared.dataTask(with: requestURL!) { data, response, error in
      guard let data = data, error == nil else {
        print("Some Error at URL", error?.localizedDescription as Any);
        
        return
      };
      
      do {
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
        let items = json["items"] as? [[String: Any]],
        let videoID = items.first?["id"] as? [String: Any],
        let videoIDString = videoID["videoId"] as? String {
          self.trailerURL = "\(videoIDString)";
          //https://www.youtube.com/watch?v=
        };
      } catch {
        print("Failed lock json: \(error.localizedDescription)");
      };
    };
    
    task.resume();
  };
  
  @objc func watchMovie() {
    trailerViewController.view = YTPlayerView();
    (trailerViewController.view as? YTPlayerView)?.load(withVideoId: trailerURL!);
  
    present(trailerViewController, animated: true);
  };
};

// MARK: - Layout
extension MovieDescriptionViewController {
  func configureLayouts() {
    configureScrollView();
    configureMovieBanner();
    configureMovieName();
    configureWatchButton();
    configureMovieDescription();
  };
  
  func configureScrollView() {
    view.addSubview(scrollView);
    
    scrollView.translatesAutoresizingMaskIntoConstraints = false;
    scrollView.isScrollEnabled = true;
    scrollView.contentInset.bottom = 20;
    
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      scrollView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
    ]);
  };
  
  func configureMovieBanner() {
    scrollView.addSubview(movieBanner);
    
    movieBanner.translatesAutoresizingMaskIntoConstraints = false;
    movieBanner.contentMode = .scaleAspectFill;
    
    if let imageURL = movie?.backdropPath {
      movieBanner.downloaded(from: "https://image.tmdb.org/t/p/w500\(imageURL)")
    };
    
    NSLayoutConstraint.activate([
      movieBanner.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      movieBanner.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      movieBanner.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -15),
      movieBanner.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
    ]);
  };
  
  func configureMovieName() {
    scrollView.addSubview(movieName);
    
    movieName.translatesAutoresizingMaskIntoConstraints = false;
    movieName.textAlignment = .center;
    movieName.tintColor = .white;
    movieName.font = .preferredFont(forTextStyle: .title1);
    movieName.adjustsFontForContentSizeCategory = true;
    movieName.numberOfLines = 0;
    
    if let name = movie?.title {
      movieName.text = name;
    };
    
    NSLayoutConstraint.activate([
      movieName.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
      scrollView.trailingAnchor.constraint(equalTo: movieName.trailingAnchor, constant: 15),
      movieName.topAnchor.constraint(equalTo: movieBanner.bottomAnchor, constant: 10)
    ]);
  };
  
  func configureWatchButton() {
    scrollView.addSubview(watchButton);
    
    watchButton.translatesAutoresizingMaskIntoConstraints = false;
    watchButton.backgroundColor = .red;
    watchButton.setTitle("Play", for: .normal);
    watchButton.setTitleColor(.white, for: .normal);
    watchButton.titleLabel?.font = .systemFont(ofSize: 24);
    watchButton.layer.cornerRadius = 10;
    watchButton.addTarget(self, action: #selector(watchMovie), for: .touchUpInside)
    
    watchButton.setImage(UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal);
    watchButton.tintColor = .white;
    watchButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30);
    
    NSLayoutConstraint.activate([
      watchButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
      watchButton.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 20),
      watchButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 70),
      scrollView.trailingAnchor.constraint(equalTo: watchButton.trailingAnchor, constant: 70),
      watchButton.heightAnchor.constraint(equalToConstant: 50)
    ]);
  };
  
  func configureMovieDescription() {
    scrollView.addSubview(movieDescription);
    
    movieDescription.translatesAutoresizingMaskIntoConstraints = false;
    movieDescription.tintColor = .white;
    movieDescription.font = .preferredFont(forTextStyle: .title3);
    movieDescription.adjustsFontForContentSizeCategory = true;
    movieDescription.numberOfLines = 0;
    
    if let description = movie?.overview {
      movieDescription.text = description;
    };
    
    NSLayoutConstraint.activate([
      movieDescription.topAnchor.constraint(equalTo: watchButton.bottomAnchor, constant: 20),
      movieDescription.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
      scrollView.trailingAnchor.constraint(equalTo: movieDescription.trailingAnchor, constant: 10),
      movieDescription.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
    ]);
  };
};
