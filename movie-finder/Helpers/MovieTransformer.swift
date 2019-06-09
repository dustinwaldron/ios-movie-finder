//
//  MovieTransformer.swift
//  movie-finder
//
//  Created by Dustin Waldron on 6/8/19.
//  Copyright © 2019 Dustin Waldron. All rights reserved.
//

import Foundation

class MovieTransformer {
    static private func toString(object: AnyObject?) -> String {
        let objectAsString = object as? String ?? ""
        return objectAsString
    }
    
    static func toMovie(withJson: [String: AnyObject]) -> Movie {
        let id = toString(object: withJson["imdbID"])
        let title = toString(object: withJson["Title"])
        let year = toString(object: withJson["Year"])
        let imageUrl = toString(object: withJson["Poster"])
        return Movie(id: id, title: title, year: year, imageUrl: imageUrl)
    }
    
    static func toMovieList(withJson: [String: AnyObject]?) -> [Movie] {
        guard let withJson = withJson, let movies = withJson["Search"] as? [[String: AnyObject]]
            else { return [] }
        return movies.map(toMovie)
    }
}
