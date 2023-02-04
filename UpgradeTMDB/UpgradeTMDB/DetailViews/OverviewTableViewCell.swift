//
//  OverviewTableViewCell.swift
//  UpgradeTMDB
//
//  Created by SeungYeon Yoo on 2022/08/07.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    static let identifier = "OverviewTableViewCell"
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var overviewDetailInfoBtn: UIButton!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.translatesAutoresizingMaskIntoConstraints = false
//    }
}
