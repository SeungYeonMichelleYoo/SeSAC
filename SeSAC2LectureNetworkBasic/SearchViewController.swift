//
//  SearchViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by SeungYeon Yoo on 2022/07/27.
//

import UIKit
import Alamofire
import SwiftyJSON
/*
 Swift Protocol
 -Delegate
 -Datasource
 
 1.왼팔/오른팔
 2.테이블뷰 아웃렛 연결
 3. 1+2 
 */

//각 json value -> list - > 테이블뷰 갱신
//서버의 응답이 몇 개인지 모를 경우에는? 반복문 통해 해결

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    //BoxOffice 배열
    var list: [BoxOfficeModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //연결고리 작업: 테이블뷰가 해야 할 역할 -> 뷰컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        //테이블뷰가 사용할 테이블뷰 셀(XIB)등록
        //XIB: xml interface builder <= Nib
        searchTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        searchBar.delegate = self
        requestBoxOffice(text: "\(makeYesterdayString())")
    }
    
    //어제 날짜 가져오기
    func makeYesterdayString() -> String {
        let y = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let convertY = dateFormatter.string(from: y)
        return convertY
    }
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    func configureLabel() {
    
    }
    
    func requestBoxOffice(text: String) {
        
        //사용자가 다시 검색했을 때 테이블뷰에 또 추가되면 원래 목적에 맞지 않으니까 추가함. 로딩바를 띄워도 됨. 여기에 넣거나 success 안에 self.list.removeAll() 를 넣어도 됨.
        //실패했을 때 지우고 통신 시작
        list.removeAll()
        
        //인증키 제한
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        AF.request(url, method: .get).validate().responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
//                let movieNm1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
//                let movieNm2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
//                let movieNm3 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue
//
//                //list 배열에 데이터 추가
//                self.list.append(movieNm1)
//                self.list.append(movieNm2)
//                self.list.append(movieNm3)
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    let data = BoxOfficeModel(movieTitle: movieNm, releaseDate: openDt, totalCount: audiAcc)
                    
                    self.list.append(data)
                }
                
                //테이블뷰 갱신
                self.searchTableView.reloadData()
                
                print(self.list)

            case .failure(let error):
                print(error)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }

        cell.backgroundColor = .clear
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "\(list[indexPath.row].movieTitle): \(list[indexPath.row].releaseDate)"
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestBoxOffice(text: searchBar.text!) //옵셔널 바인딩, 8글자, 숫자, 날짜로 변경시 유효한 형태의 값인지 등 처리해야함 (! 말고)
    }
}
