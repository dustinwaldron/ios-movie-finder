//
//  MovieListController.swift
//  movie-finder
//
//  Created by Dustin Waldron on 6/7/19.
//  Copyright © 2019 Dustin Waldron. All rights reserved.
//

import UIKit

class MovieListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favoriteMovies: [Movie] = []
    
    @IBOutlet var mainTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchMoviesSegue" {
            let controller = segue.destination as! SearchViewController
            controller.movieListDelegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func displayMovieImage(movieCell: FavoriteMovieTableViewCell, movie: Movie) {
        let url = (URL(string: movie.imageUrl)?.absoluteString)!
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                let image = UIImage(data: data!)
                movieCell.movieImageView?.image = image
            })
        }).resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieCell", for: indexPath) as! FavoriteMovieTableViewCell
        let idx: Int = indexPath.row
        let favMovie = favoriteMovies[idx]
        movieCell.movieTitle?.text = favMovie.title
        movieCell.movieYear?.text = favMovie.year
        displayMovieImage(movieCell: movieCell, movie: favMovie)
        return movieCell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainTableView.reloadData()
        super.viewWillAppear(animated)
        if favoriteMovies.count == 0 {
            favoriteMovies.append(Movie(id: "tt0372784", title: "Batman Begins", year: "2005", imageUrl: "https://images-na.ssl-images-amazon.com/images/M/MV5BNTM3OTc0MzM2OV5BMl5BanBnXkFtZTYwNzUwMTI3._V1_SX300.jpg"))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

