//
//  CustomTableViewCell.swift
//  movie-finder
//
//  Created by Dustin Waldron on 6/7/19.
//  Copyright © 2019 Dustin Waldron. All rights reserved.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {
    
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieYear: UILabel!
    @IBOutlet var favoriteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
