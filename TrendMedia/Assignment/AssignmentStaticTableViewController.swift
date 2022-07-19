//
//  AssignmentStaticTableViewController.swift
//  TrendMedia
//
//  Created by SeungYeon Yoo on 2022/07/18.
//

import UIKit

class AssignmentStaticTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.lightGray
        header.textLabel?.font = .boldSystemFont(ofSize: 15)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int){
        let footer = view as! UITableViewHeaderFooterView
        footer.textLabel?.textColor = UIColor.lightGray
        footer.textLabel?.font = .boldSystemFont(ofSize: 12)
    }
   

}
