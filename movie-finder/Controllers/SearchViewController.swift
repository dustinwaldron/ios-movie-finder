//
//  SearchViewController.swift
//  movie-finder
//
//  Created by Dustin Waldron on 6/8/19.
//  Copyright © 2019 Dustin Waldron. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var searchResults: [Movie] = []
    weak var movieListDelegate: MovieListController!
    
    @IBOutlet var searchText: UITextField!
    @IBOutlet var searchTableView: UITableView!
    
    @IBAction func search(sender: UIButton) {
        print("Searching for movies after button click")
        let searchTerm = searchText.text!
        if searchTerm.count > 2 {
            MovieService.retrieveMovies(byTerm: searchTerm) { data in
                self.searchResults = data
                DispatchQueue.main.async {
                    self.searchTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func favorite(sender: UIButton) {
        print("Favoriting item: \(sender.tag)")
        self.movieListDelegate.favoriteMovies.append(searchResults[sender.tag])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func displayMovieImage(searchMovieCell: FavoriteMovieTableViewCell, movie: Movie) {
        let url = (URL(string: movie.imageUrl)?.absoluteString)!
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async(execute: {
                let image = UIImage(data: data!)
                searchMovieCell.movieImageView?.image = image
            })
        }).resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchMovieCell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieCell", for: indexPath) as! FavoriteMovieTableViewCell
        let idx: Int = indexPath.row
        let favMovie = searchResults[idx]
        searchMovieCell.favoriteButton.tag = idx
        searchMovieCell.movieTitle?.text = favMovie.title
        searchMovieCell.movieYear?.text = favMovie.year
        displayMovieImage(searchMovieCell: searchMovieCell, movie: favMovie)
        return searchMovieCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search Results"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // grouped vertical sections of the table view
        return 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
