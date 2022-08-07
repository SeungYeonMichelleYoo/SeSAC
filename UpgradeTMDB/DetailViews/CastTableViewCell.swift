//
//  CastTableViewCell.swift
//  UpgradeTMDB
//
//  Created by SeungYeon Yoo on 2022/08/07.
//

import UIKit

class CastTableViewCell: UITableViewCell {
    static let identifier = "CastTableViewCell"
    
    @IBOutlet weak var personImageView: UIImageView!
    
    @IBOutlet weak var personNameLabel: UILabel!
    
    @IBOutlet weak var personInfoLabel: UILabel!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.translatesAutoresizingMaskIntoConstraints = false
//    }
}
