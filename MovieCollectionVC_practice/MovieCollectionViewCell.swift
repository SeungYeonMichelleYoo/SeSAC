//
//  MovieCollectionViewCell.swift
//  MovieCollectionVC_practice
//
//  Created by SeungYeon Yoo on 2022/07/20.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    func configureCell(data: Movie) {
//        posterImageView.frame = CGRect(x: 80, y: 60, width: 70, height: 70)
//        posterImageView.contentMode = .scaleAspectFit
        posterImageView.image = UIImage(named: data.image)
        movieTitleLabel.text = data.title
        rateLabel.text = "\(data.rate)"
//        movieTitleLabel.sendSubviewToBack(posterImageView)
        backView.layer.cornerRadius = 16
    }
}
