//
//  ViewController.swift
//  SeSACWeek6
//
//  Created by SeungYeon Yoo on 2022/08/08.
//

import UIKit
import SwiftyJSON

/*
 1. html tag <> </> 기능
 2. 문자열 대체 메서드
 *response에서 처리하는 것 vs. 보여지는 셀에서 처리하는 것의 차이는?
 */

/*
 TableView automaticDimension
 -컨텐츠 양에 따라서 셀 높이가 자유롭게 움직이는 형태
 -이걸 구현하기 위한 조건: label = numberOfLines = 0 이 되어야 함
 -조건2: tableView Height automaticDimension
 -조건3: 레이아웃을 잘 잡아야함 (어디가 줄어들고 어디가 늘어나야할지 명확해야 함)
 */
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var blogList: [String] = []
    var cafeList: [String] = []
    
    var isExpanded = false // false 2줄, true 0줄
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBlog()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension // 모든 섹션의 셀에 대해서 유동적으로 잡겠다!
        
    }
    
    @IBAction func expandCell(_ sender: UIBarButtonItem) {
        isExpanded = !isExpanded
        tableView.reloadData()
    }
    
    
    func searchBlog() {
        KakaoAPIManager.shared.callRequest(type: .blog, query: "고래밥") { json in
            
                     
            for item in json["documents"].arrayValue {
                self.blogList.append(item["contents"].stringValue)
            }
            
            self.searchCafe()
        }
    }
    
    func searchCafe() {
        KakaoAPIManager.shared.callRequest(type: .blog, query: "고래밥") { json in
            
            print(json)
            
            for item in json["documents"].arrayValue {
                let value = item["contents"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "<b>", with: "")
                self.cafeList.append(value)
            }
            print(self.blogList)
            print(self.cafeList)
            
            self.tableView.reloadData()
    }
}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? blogList.count : cafeList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "kakaoCell", for: indexPath) as? kakaoCell else { return  UITableViewCell() }
        
        cell.testLabel.numberOfLines = isExpanded ? 0 : 2
        cell.testLabel.text = indexPath.section == 0 ? blogList[indexPath.row] : cafeList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "블로그 검색결과" : "카페 검색결과"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        //섹션에 따라 높이를 다르게 설정하고 싶을 때 여기 메서드에서 구현하면 됨 (viewdidLoad에 height하는거 말고)
    }
    
}

class kakaoCell: UITableViewCell {
    
    @IBOutlet weak var testLabel: UILabel!
}
