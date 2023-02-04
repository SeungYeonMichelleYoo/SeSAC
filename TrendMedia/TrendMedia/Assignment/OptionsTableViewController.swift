//
//  OptionsTableViewController.swift
//  TrendMedia
//
//  Created by SeungYeon Yoo on 2022/07/19.
//

import UIKit

//CaseIterable: 프로토콜(배열처럼 열거형을 활용할 수 있는 특성)
enum SettingOptions: Int, CaseIterable {
    case total, personal, others //섹션
    
    var sectionTitle: String {
        switch self {
        case .total:
            return "전체 설정"
        case .personal:
            return "개인 설정"
        case .others:
            return "기타"
        }
    }
    
    var rowTitle: [String] {
        switch self {
        case .total:
            return ["공지사항", "실험실", "버전 정보"]
        case .personal:
            return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .others:
            return ["고객센터/도움말"]
        }
    }
}

class OptionsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(SettingOptions.allCases.count) // 3
        print(SettingOptions.allCases[0]) // total  각각 요소가 self로 들어감
        print(SettingOptions.allCases[1].sectionTitle) // 개인설정
        print(SettingOptions.allCases[2]) //others

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingOptions.allCases[section].rowTitle.count
    }
   
    //indexPath : 셀의 좌표 cellForRowAt이 계속해서 호출되면서 (0,0)... (100,100)까지 실행되는거.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mySettingCell")!
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].rowTitle[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingOptions.allCases[section].sectionTitle
    }
}
