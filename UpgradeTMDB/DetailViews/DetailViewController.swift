//
//  DetailViewController.swift
//  UpgradeTMDB
//
//  Created by SeungYeon Yoo on 2022/08/07.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    //1] SearchVC에서 movieData 값 가져오기 위한 공간 만듬
    var movieData: MovieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //3] 값 전달 받음
        movieTitleLabel.text = "\(movieData.movieTitle)"
        let posterImageUrl = URL(string: movieData.posterImage)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: posterImageUrl!)
            if data != nil {
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: data!)
                }
            }
        }
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(UINib(nibName: OverviewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OverviewTableViewCell.identifier)
        mainTableView.register(UINib(nibName: CastTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CastTableViewCell.identifier)
           
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "OverView"
        } else if section == 1 {
            return "Cast"
        } else {
            return "Crew"
        }
    }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1 // overview
        } else if section == 1 {
            return movieData.castedList.count // cast
        } else {
            return movieData.crewList.count // crew
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        case 1:
            return 150
        case 2:
            return 150
        default:
            return UITableView.automaticDimension
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let overViewCell = mainTableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier, for: indexPath) as? OverviewTableViewCell else { return UITableViewCell() }
            overViewCell.overviewLabel.text = "\(movieData.overview)"
            return overViewCell
        } else if indexPath.section == 1 {
            guard let castViewCell = mainTableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            
            castViewCell.personNameLabel.text = "\(movieData.castedList[indexPath.row].personName)"
            castViewCell.personInfoLabel.text = "\(movieData.castedList[indexPath.row].character)"
            
            let personimageUrl = URL(string: movieData.castedList[indexPath.row].personImage)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: personimageUrl!)
                if data != nil {
                    DispatchQueue.main.async {
                        castViewCell.personImageView.image = UIImage(data: data!)
                    }
                }
            }
            castViewCell.configureCell()
            return castViewCell
            
        } else {
            guard let castViewCell = mainTableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            
            castViewCell.personNameLabel.text = "\(movieData.crewList[indexPath.row].personName)"
            castViewCell.personInfoLabel.text = "\(movieData.crewList[indexPath.row].character)"
            
            let personimageUrl = URL(string: movieData.crewList[indexPath.row].personImage)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: personimageUrl!)
                if data != nil {
                    DispatchQueue.main.async {
                        castViewCell.personImageView.image = UIImage(data: data!)
                    }
                }
            }
            castViewCell.configureCell()
            return castViewCell
        }
    }
}
