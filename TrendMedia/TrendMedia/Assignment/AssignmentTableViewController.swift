//
//  AssignmentTableViewController.swift
//  TrendMedia
//
//  Created by SeungYeon Yoo on 2022/07/18.
//

import UIKit

class AssignmentTableViewController: UITableViewController {
    
    var totalSettings = ["공지사항", "실험실", "버전 정보"]
    var privateSetting = ["개인/보안", "알림", "채팅", "멀티프로필"]
    var etc = ["고객센터/도움말"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.lightGray
        header.textLabel?.font = .boldSystemFont(ofSize: 15)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "전체 설정"
        } else if section == 1 {
            return "개인 설정"
        } else if section == 2 {
            return "기타"
        } else {
            return "섹션"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 4
        } else if section == 2 {
            return 1
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
    
        if indexPath.section == 0 {
            cell.textLabel?.text = totalSettings[indexPath.row]
            cell.textLabel?.textColor = .white
        } else if indexPath.section == 1 {
            cell.textLabel?.text = privateSetting[indexPath.row]
            cell.textLabel?.textColor = .white
        } else if indexPath.section == 2 {
            cell.textLabel?.text = etc[indexPath.row]
            cell.textLabel?.textColor = .white
        }
        return cell
    }

}
