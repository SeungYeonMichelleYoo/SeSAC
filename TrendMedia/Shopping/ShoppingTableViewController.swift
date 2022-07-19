//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by SeungYeon Yoo on 2022/07/19.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    @IBOutlet weak var userTextField: UITextField!
    
    var shoppingList = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func userTextFieldEnter(_ sender: UITextField) {
        shoppingList.append(sender.text!)
        tableView.reloadData()
    }
    
        @IBAction func buttonClicked(_ sender: UIButton) {
            shoppingList.append(userTextField.text!)
            tableView.reloadData()
        }
          
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        cell.shoppingLabel.text = shoppingList[indexPath.row]
        cell.shoppingLabel.font = .boldSystemFont(ofSize: 18)
    
        return cell
    }
    
    //우측 스와이프 디폴트 기능:commit editingStyle. delete색상은 바꿀 수 없음. 디폴트 빨강.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
           //배열 삭제 후 테이블뷰를 갱신
            shoppingList.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
    }

}
