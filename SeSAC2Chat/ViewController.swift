//
//  ViewController.swift
//  SeSAC2Chat
//
//  Created by jack on 2022/11/21.
//

import UIKit
import Alamofire
import SocketIO

//오픈채팅방 구현(단톡방 같은 느낌)
//채팅방으로 들어가는 순간 소켓 연결됨, 벗어나는 순간 소켓 연결 해제됨.

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentTextField: UITextField!
    
//    var dummy: [String] = []
    var chat: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        dummyChat()
        fetchChats() //지금까지의 채팅을 보여준거임(아직여기까진 실시간으로 반영은 안됨)
        configureTableView()
        
        //on sesac으로 받은 이벤트를 처리하기 위한 Notification Observer (SocketIOManager의 이벤트 수신에서 달은 NSnotificationcenter 받아오기)
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(notification:)), name: NSNotification.Name("getMessage"), object: nil)
        
    }
    @objc func getMessage(notification: NSNotification) {
            
        let chat = notification.userInfo!["chat"] as! String
        let name = notification.userInfo!["name"] as! String
        let createdAt = notification.userInfo!["createdAt"] as! String
        let userID = notification.userInfo!["userId"] as! String
        
        let value = Chat(text: chat, userID: userID, name: name, username: "", id: "", createdAt: createdAt, updatedAt: "", v: 0, ID: "")
        
        self.chat.append(value)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: self.chat.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    //viewwillappear가 아니라 diddisappear인 이유: back버튼 반 정도로 잡고만 있어도 willdisappear의 경우.. 반응 다름
    override func viewDidDisappear(_ animated: Bool) {
        SocketIOManager.shared.closeConnection()
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
//        dummy.append(contentTextField.text ?? "")
//        tableView.reloadData()
//        tableView.scrollToRow(at: IndexPath(row: dummy.count - 1, section: 0), at: .bottom, animated: false)
        postChat(text: contentTextField.text ?? "")
    }
}
    
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count //dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = chat[indexPath.row]
         
//        if indexPath.row.isMultiple(of: 2) { //홀수인지 짝수인지 기준으로 나눔.
        if data.userID == APIKey.userId { //내 userId
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell", for: indexPath) as! MyChatTableViewCell
            cell.chatLabel.text = data.text
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YourChatTableViewCell", for: indexPath) as! YourChatTableViewCell
            cell.chatLabel.text = data.text
            cell.profileNameLabel.text = data.name
            return cell
        }
    }
    
}

extension ViewController {
    
//    private func dummyChat() {
//        dummy = ["안녕하세요", "반갑습니다", "별명이 왜 고래밥인가요?", "세상에서\n고래밥 과자가 젤\n맛있더라구요", "아..."]
//    }
    
    //채팅 가져오기
    private func fetchChats() {
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(APIKey.header)",
            "Content-Type": "application/json"
        ]

        AF.request(APIKey.url, method: .get, headers: header).responseDecodable(of: [Chat].self) { [weak self] response in
            switch response.result {
            case .success(let value):
                self?.chat = value
                self?.tableView.reloadData()
                self?.tableView.scrollToRow(at: IndexPath(row: self!.chat.count - 1, section: 0), at: .bottom, animated: false)
                SocketIOManager.shared.establishConnection() //소켓 통신이 연결되는 시점 (스크롤 다 내린 시점에서) ->여기부터 실시간으로 데이터 받아오는 것 가능
            case .failure(let error):
                print("FAIL", error)
            }
        }
    }
    
    //채팅 보내기
    private func postChat(text: String) {
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(APIKey.header)",
            "Content-Type": "application/json"
        ]
        AF.request(APIKey.url, method: .post, parameters: ["text": text], encoder: JSONParameterEncoder.default, headers: header).responseString { data in
            print("POST CHAT SUCCEED", data)
        }
    }
    
}
