//
//  HomeViewController.swift
//  SeSAC2DiaryRealm
//
//  Created by SeungYeon Yoo on 2022/08/22.
//

import UIKit
import SnapKit
import RealmSwift // Realm1. import
import FSCalendar

class HomeViewController: UIViewController {
    
    let repository = UserDiaryRepository()
    
    lazy var calendar: FSCalendar = {
        let view = FSCalendar()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        return view
    }()
    
    //var: 나중에 실행해도 된다
    //lazy var: 초기화 다 되고나서 실행하려는 경우. 이 경우-> delegate, datasource도 아래 안에다가 쓸 수 있음
    
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        view.rowHeight = 100
        return view
    }() //즉시 실행 클로저
    //인스턴스가 생성되려고 하는 시점에 즉시 실행됨
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        return formatter
    }()
    
    //여러군데에서 테이블뷰 갱신코드 쓰지 않아도 되게끔 하는 코드
    var tasks: Results<UserDiary>! {
        didSet {
            tableView.reloadData()
            print("Tasks Changed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        view.addSubview(calendar)
        
        
        tableView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            make.topMargin.equalTo(300)
        }
        
        calendar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton]
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        
        fetchRealm()
    }
        
        func fetchRealm() {
            //테이블 이름 가져옴(UserDiary.self = 메타타입임) /Realm자체적으로 정렬을 해서 우리는 그대로 내용을 보여주기만 하면 됨
            //3. Realm 데이터를 정렬해 tasks에 담기
            tasks = repository.fetch()
        }
        
        //화면 갱신은 화면 전환 코드 및 생명 주기 실행 점검 필요!
        //present, overCurrentContext, overFullScreen -> ViewWillAppear 실행되지 않음. fullscreen방식으로 띄우는 경우 reloaddata 됨.
        //추가가 안되는 경우에는 viewwillappear가 실행되지 않았다는 뜻임.
//        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryDate", ascending: false)
//        tableView.reloadData()
    
    @objc func plusButtonClicked() {
        let vc = WriteViewController()
        //extension으로 빼놓은 화면 전환 여기서 씀
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    
    @objc func sortButtonClicked() {
        tasks = repository.fetchSort("regDate")
    }
    
    //realm filter query, NSPredicate
    // == 쓰지 않고 = 쓰는 이유: realm에서 정해놓은 규칙 때문
    // '' 로 안에 써주어야 string format 분석 가능 아니면 parse 오류 남
    // CONTAINS[c] => [c] : 대소문자 여부
    @objc func filterButtonClicked() {
        tasks = repository.fetchFilter()
            //.filter("diaryTitle = '오늘의 일기65'")
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //hometableviewcell 만들기 !!!!! 그래야 이미지 반영할 수 있음
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HomeTableViewCell else { return UITableViewCell() }
        cell.title.text = tasks[indexPath.row].diaryTitle
        print("img : \(tasks[indexPath.row].objectId).jpg")
        cell.diaryImg.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        cell.setData(data: tasks[indexPath.row])
        return cell
    }
    
    //테이블뷰 셀 높이가 작을 경우, 이미지가 없을 때, 시스템 이미지가 아닌 경우
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
//        let task = tasks[indexPath.row]
        
        let favorite = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            print("favorite Button Clicked")
            
            //realm data update (즐겨찾기 true/false에 따라). 데이터 변경시에 항상 써야함
            self.repository.updateFavorite(item: self.tasks[indexPath.row])
//            try! self.repository.localRealm.write {
                //하나의 레코드에서 특정 컬럼 하나만 변경
//                task.favorite = !task.favorite
                
                //하나의 테이블에서 특정 전체 컬럼 전체 값을 변경
//                self.tasks.setValue(true, forKey: "favorite")
                
                //하나의 레코드에서 여러 컬럼들이 변경
//                self.localRealm.create(UserDiary.self, value: ["objectId": self.tasks[indexPath.row].objectId, "diaryContent": "변경 테스트", "diaryTitle": "제목임"], update: .modified)
                
//                print("Realm Udpdate Succeed. reloadRows 필요")
//            }
            //reloadRows 필요하기 때문에 밑에 fetchRealm() 해줌(사실 1,2번 중에 하나로 구현하면 되는데 여기선 2번으로 구현함)
            //1. 스와이프한 셀 하나만 ReloadRows 코드를 구현 => 상대적 효율성
            //2. 데이터가 변경되었으니 다시 realm에서 데이터를 가지고 오기 => didSet 일관적 형태로 갱신
            self.fetchRealm()
        }
        
        //realm 데이터베이스 기준으로 이미지를 다르게 설정해볼 수 있다. indexPath기준
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        favorite.image = UIImage(systemName: image)
        favorite.backgroundColor = .systemPink
        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    //MARK: - trailing swipe action (삭제)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { [self] action, view, completionHandler in
   
            print("task.indexpath.row : \(self.tasks[indexPath.row])")
//            //이미지 먼저 삭제 -> 레코드 삭제 순서로 렘 지우면 문제가 안생겼던 이유
            self.repository.deleteItem(item: self.tasks[indexPath.row])
            self.fetchRealm()
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }

}

//MARK: - 달력 설정
extension HomeViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    //숫자를 표시하기위한 메서드
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return repository.fetchDate(date: date).count
    }

//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "새싹"
//    }

//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(systemName: "star.fill")
//    }

    //date: yyyyMMdd hh:mm:ss => dateformatter
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return formatter.string(from: date) == "220907" ? "오프라인 모임" : nil
    }

    //ex) 데이터 100개 -> 특정 선택한 날짜 : 25일 3개 -> 날짜 기준으로 3개만 보여줌
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        tasks = repository.fetchDate(date: date)
    }
}
