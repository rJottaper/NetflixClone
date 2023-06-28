//
//  DownloadMoviesViewController.swift
//  Netflix
//
//  Created by João Pedro on 27/06/23.
//

import UIKit

class DownloadMoviesViewController: UIViewController {
  let downloadMoviesView = DownloadMovieView();
  
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.title = "Downloads";
    self.navigationController?.navigationBar.prefersLargeTitles = true;
    
    getDownloadMovies();
    configureDownloadMoviesView();
  };
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated);
    
    getDownloadMovies();
  };
  
  func getDownloadMovies() {
    do {
      let movies = try context.fetch(MovieDownload.fetchRequest());
      downloadMoviesView.movies = movies;
    } catch {
      print("Failed to get movies");
    };
  };
};

extension DownloadMoviesViewController: DownloadMovieViewDelegate {
  func configureDownloadMoviesView() {
    view.addSubview(downloadMoviesView);
    
    downloadMoviesView.translatesAutoresizingMaskIntoConstraints = false;
    downloadMoviesView.delegate = self;
    
    NSLayoutConstraint.activate([
      downloadMoviesView.topAnchor.constraint(equalTo: view.topAnchor),
      downloadMoviesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: downloadMoviesView.trailingAnchor),
      downloadMoviesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ]);
  };
  
  func removeMovie(atIndex index: Int) {
    guard let movies = downloadMoviesView.movies else { return }
    let movie = movies[index];
    
    context.delete(movie);
    
    do {
      try context.save();
    } catch {
      print("Failed to delete movie");
    };
    
    getDownloadMovies();
  };
};
