//
//  MovieService.swift
//  movie-finder
//
//  Created by Dustin Waldron on 6/8/19.
//  Copyright © 2019 Dustin Waldron. All rights reserved.
//

import Foundation

class MovieService {
    static func retrieveMovies(byTerm: String, completion: @escaping (_ movies: [Movie]) -> ()) {
        let url = "https://www.omdbapi.com/?apikey=PlzBanMe&s=\(byTerm)&type=movie&r=json"
        HTTPHandler.getJson(fromUrlString: url) { data in
            if let data = data {
                let object = JSONParser.parse(data: data)
                completion(MovieTransformer.toMovieList(withJson: object))
            } else {
                completion([])
            }
        }
    }
}
