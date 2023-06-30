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
  let movieDescriptionView = MovieDescriptionView();
  
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
extension MovieDescriptionViewController: MovieDescriptionViewDelegate {
  func configureLayouts() {
    configureScrollView();
    configureMovieDescriptionView();
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
  
  func configureMovieDescriptionView() {
    scrollView.addSubview(movieDescriptionView);
    
    movieDescriptionView.translatesAutoresizingMaskIntoConstraints = false;
    movieDescriptionView.delegate = self;
    movieDescriptionView.configureScreen(movie: movie)
    
    NSLayoutConstraint.activate([
      movieDescriptionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      movieDescriptionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: movieDescriptionView.trailingAnchor),
      movieDescriptionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      movieDescriptionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ]);
  };
  
  func watchMovieTrailer() {
    watchMovie();
  };
};
