//
//  GetMoviesData.swift
//  Netflix
//
//  Created by João Pedro on 07/06/23.
//

import UIKit

struct MovieResponse: Decodable {
  let results: [Movie];
};

struct Movie: Decodable {
  let id: Int?
  let title: String?
  let overview: String?
  let posterPath: String?
  let releaseDate: String?
  let backdropPath: String?
};

enum MyError: Error {
  case runtimeError(String)
};

func GetMovies(endpoint: String, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
  let headers = [
    "accept": "application/json",
    "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2M2RhMzM5OWE1ZjI1MWFmNTk2NDA5NjliNmJkZjU2YyIsInN1YiI6IjYxMzAyMGYyZDIwN2YzMDAyZGI2ODNjYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MrAQpyDM9U2KYuV9FPzdrYAbFwyigG6hrMrn0GOqUIA"
  ];

  let request = NSMutableURLRequest(url: NSURL(string: endpoint)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
  request.httpMethod = "GET";
  request.allHTTPHeaderFields = headers;

  let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
    guard let data = data, error == nil else {
      print("Request Failed")
      completion(.failure(MyError.runtimeError("Request Failed")))
      return
    };

    do {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      let result = try decoder.decode(MovieResponse.self, from: data)
      completion(.success(result));
    } catch {
      print("Failed to get data \(error.localizedDescription)")
      completion(.failure(error));
    };
  };

  task.resume();
};
