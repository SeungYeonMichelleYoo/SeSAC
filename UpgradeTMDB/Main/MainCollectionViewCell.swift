//
//  MainCollectionViewCell.swift
//  UpgradeTMDB
//
//  Created by SeungYeon Yoo on 2022/08/05.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    static let identifier = "MainCollectionViewCell"

    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var bigUIView: UIView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var linkButton: UIButton!
    
    @IBOutlet weak var rateNameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var personLabel: UILabel!
    
    @IBOutlet weak var detailGoButton: UIButton!
    

    func configureLabel() {
        releaseDateLabel.font = .systemFont(ofSize: 14)
        releaseDateLabel.textColor = .lightGray
        
        genreLabel.font = .boldSystemFont(ofSize: 20)
        genreLabel.textColor = .black
        
        rateNameLabel.text = "평점"
        rateNameLabel.font = .systemFont(ofSize: 14)
        rateNameLabel.textColor = .white
        rateNameLabel.backgroundColor = .systemIndigo
        rateNameLabel.textAlignment = .center
        
        rateLabel.font = .systemFont(ofSize: 14)
        rateLabel.textColor = .black
        rateLabel.backgroundColor = .white
        rateLabel.textAlignment = .center
        
        movieTitleLabel.font = .boldSystemFont(ofSize: 20)
        movieTitleLabel.textColor = .black
    }
    
    func configureButton() {
        linkButton.setImage(UIImage(systemName: "paperclip"), for: .normal)
        linkButton.tintColor = .black
        linkButton.backgroundColor = .white
        linkButton.layer.cornerRadius = linkButton.bounds.height / 2
        
        detailGoButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        detailGoButton.tintColor = .darkGray
        detailGoButton.backgroundColor = .clear
        
    }

    func configureBigView() {
        bigUIView.layer.cornerRadius = 8
        bigUIView.layer.masksToBounds = false
        bigUIView.layer.shadowColor = UIColor.gray.cgColor
        bigUIView.layer.shadowOpacity = 1.0
        bigUIView.layer.shadowRadius = 8 //그림자를 둥글게
        bigUIView.layer.shadowOffset = CGSize(width: 0, height: 0) //x쪽으로 ~ y쪽으로 ~ 떨어진 곳부터 그림자를 그리겠다
        
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        posterImageView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner) //뷰의 상단만 모서리 둥글게 (아래는 직각)
    }
    
    
    
    func infoData(indexPath: IndexPath, list: [MovieModel]) {
        let movie = list[indexPath.item] //MovieModel을 가져옴
        self.releaseDateLabel.text = movie.releasedDate
        self.rateLabel.text = "\(movie.rate)"
        self.movieTitleLabel.text = movie.movieTitle
        var peopleNameInLine = ""
        var nameList: [String] = []
//        for i in 0...movie.castedList.count {
//            nameList.append(movie.castedList[i])
//        }
        for cast in movie.castedList {
            nameList.append(cast.personName)
        }
        for crew in movie.crewList {
            nameList.append(crew.personName)
        }
        self.personLabel.text = nameList.joined(separator: ",")
        self.genreLabel.text = movie.genre
        let posterimageUrl = URL(string: movie.posterImage)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: posterimageUrl!)
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data!)
                self.posterImageView.contentMode = .scaleAspectFill
        }
      }
        
    }

//    func peopleInfoData(indexPath: IndexPath, list: [PeopleModel]) {
//        self.personLabel.text = list[indexPath.item].personName
//    }

}

