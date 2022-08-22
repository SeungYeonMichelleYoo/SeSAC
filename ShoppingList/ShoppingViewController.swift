//
//  ShoppingViewController.swift
//  ShoppingList
//
//  Created by SeungYeon Yoo on 2022/08/22.
//
import UIKit
import SnapKit
import RealmSwift //Realm 1.

class ShoppingViewController: BaseViewController {
    
    var mainView = ShoppingView()
    let localRealm = try! Realm() //Realm2. Realm 테이블 경로 가져오기
    
    var tasks: Results<UserShopList>!
    
    //viewDidLoad보다 먼저 호출된다
    override func loadView() { //super.loadView 호출 금지
        self.view = mainView
        
        //3. Realm 데이터를 정렬해 tasks에 담기
        tasks = localRealm.objects(UserShopList.self).sorted(byKeyPath: "shoppingThing", ascending: false)
        
        mainView.listTableView.delegate = self
        mainView.listTableView.dataSource = self
        mainView.listTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.cellId)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at:", localRealm.configuration.fileURL!)

    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        mainView.listTableView.reloadData()
//    }
//
    override func configure() {
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }
    
    //realm create sample
    @objc func addButtonClicked() {

        let data = UserShopList()
        data.shoppingThing = mainView.purchaseTextField.text!
        
        try! localRealm.write {
            localRealm.add(data)
            mainView.purchaseTextField.text = ""
        }
        
        mainView.listTableView.reloadData()
    }
}

extension ShoppingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        guard let cell = mainView.listTableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cellId, for: indexPath) as? CustomTableViewCell else {
            return CustomTableViewCell()
        }
        
        cell.checkImage.image = tasks[indexPath.row].check ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        cell.listLabel.text = tasks[indexPath.row].shoppingThing
        cell.favoriteButton.setImage(tasks[indexPath.row].favorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        return cell
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
