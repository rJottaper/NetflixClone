//
//  DownloadMovieView.swift
//  Netflix
//
//  Created by João Pedro on 27/06/23.
//

import UIKit

protocol DownloadMovieViewDelegate: AnyObject {
  func removeMovie(atIndex index: Int);
};

class DownloadMovieView: UIView {
  let moviesTable = UITableView();
  
  weak var delegate: DownloadMovieViewDelegate?
  
  var movies: [MovieDownload]? {
    didSet {
      DispatchQueue.main.async {
        self.moviesTable.reloadData();
      };
    }
  };
  
  override init(frame: CGRect) {
    super.init(frame: frame);
    
    configureMoviesTable();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  };
};

// MARK: TableView
extension DownloadMovieView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies?.count ?? 0;
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MovieDownloadCell.identifier, for: indexPath) as! MovieDownloadCell;
    cell.configureCell(image: movies![indexPath.row].posterPath!, title: movies![indexPath.row].title!)
    
    return cell;
  };
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let delectionAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
      self.delegate?.removeMovie(atIndex: indexPath.row);
    };
    delectionAction.image = UIImage(systemName: "trash");
    delectionAction.backgroundColor = .red;
    
    return UISwipeActionsConfiguration(actions: [delectionAction]);
  };
};

// MARK: Layout

extension DownloadMovieView {
  func configureMoviesTable() {
    addSubview(moviesTable);
    
    moviesTable.translatesAutoresizingMaskIntoConstraints = false;
    moviesTable.rowHeight = 180;
    
    moviesTable.delegate = self;
    moviesTable.dataSource = self;
    moviesTable.register(MovieDownloadCell.self, forCellReuseIdentifier: MovieDownloadCell.identifier);
    
    NSLayoutConstraint.activate([
      moviesTable.topAnchor.constraint(equalTo: topAnchor),
      moviesTable.leadingAnchor.constraint(equalTo: leadingAnchor),
      trailingAnchor.constraint(equalTo: moviesTable.trailingAnchor),
      moviesTable.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]);
  };
};
