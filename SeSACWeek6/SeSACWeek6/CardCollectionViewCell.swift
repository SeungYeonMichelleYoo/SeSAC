//
//  CardCollectionViewCell.swift
//  SeSACWeek6
//
//  Created by SeungYeon Yoo on 2022/08/09.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: CardView!
    
    //변경되지 않는 UI
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("CardCollectionViewCell", #function)        
        setupUI() //한번만 디자인 입혀주면 됨. 계속해서 재사용 x
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cardView.contentLabel.text = "A"
    }
    
    func setupUI() {
        cardView.backgroundColor = .clear
        cardView.posterImageView.backgroundColor = .lightGray
        cardView.posterImageView.layer.cornerRadius = 10
        cardView.likeButton.tintColor = .systemPink
    }

}
