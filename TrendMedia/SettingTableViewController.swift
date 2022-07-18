//
//  SettingTableViewController.swift
//  TrendMedia
//
//  Created by SeungYeon Yoo on 2022/07/18.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    var birthdayFriends = ["뽀로로", "신데렐라", "올라프", "스노기", "모구리", "고래밥"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //섹션의 개수(옵션) 섹션의 디폴트는 1이라서 이 함수는 써도되고 안써도 됨.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    //MARK: - section header & footer
    
    //section 키워드로 해서 검색. optional 이 있다 이 함수만 특이하게(nil일 수도 있어서)
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "생일인 친구"
        } else if section == 1 {
            return "즐겨찾기"
        } else if section == 2 {
            return "친구 140명"
        } else {
            return "섹션"
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "푸터"
    }
    
    //MARK: - 필수 code
    
    
    //1. 셀의 개수(필수) - 키워드: numberOfRowsInSection (섹션 수와 셀 수는 다르니 주의 !)
    //ex. 카톡 친구 수 100명 -> 셀 100개, 3000명 -> 셀 3000개
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return birthdayFriends.count
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 10
        } else {
            return 0
        }
    }
    
    //2. 셀의 디자인과 데이터(필수) - 키워드: cellForRowAt
    //ex. 카톡 이름, 프로필 사진, 상태 메시지 등
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //1개의 셀이 100개로 복붙과 같은 효과가 일어난다. *100
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
    
        if indexPath.section == 0 {
            cell.textLabel?.text = birthdayFriends[indexPath.row]
            cell.textLabel?.textColor = .systemMint
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "1번 인덱스 텍스트"
            cell.textLabel?.textColor = .systemPink
            cell.textLabel?.font = .italicSystemFont(ofSize: 25)
        } else if indexPath.section == 2 {
            cell.textLabel?.text = "2번 인덱스 텍스트"
            cell.textLabel?.textColor = .brown
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        }
        return cell
    }
    
}
