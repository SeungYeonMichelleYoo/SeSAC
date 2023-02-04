//
//  LocationViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by SeungYeon Yoo on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController {

    //Notification 1.
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestAuthorization()
    }
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        sendNotification()
    }
    
    
    //Notification 2. 권한 요청
    func requestAuthorization() {
        
        let authrorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        notificationCenter.requestAuthorization(options: authrorizationOptions) { success, error in
            if success {
                self.sendNotification()
            }
        }
    }
    //Notification 3. 권한 허용한 사용자에게 알림 요청 (언제? 어떤 컨텐츠?)
    //iOS시스템에서 알림을 담당 > 알림을 등록
    
    
    /*
     -권한 허용 해야만 알림이 온다.
     -권한 허용 문구 시스템적으로 최초 한번만 뜬다.
     -허용 안된 경우, 애플 설정으로 직접 유도하는 코드를 구성해야 한다.
     
     -기본적으로 알림은 포그라운드에서 수신되지 않는다. 그래서 밑에 3번에서 구현하는 거임!
     -로컬 알림에서는 60초 이상 반복 가능 / 갯수 제한 : 64개까지 가능 / 커스텀사운드 ~초 제한 있음
     
     
     1. 뱃지 제거? > 언제 제거하는게 맞을까?
     2. 노티 제거? > 노티의 유효 기간은? > 카톡(오픈채팅, 단톡)
     3. 포그라운드 수신?
     
     +a
     아래 내용은 애플 개발자 유료 계정이 있어야 테스트 가능하므로 나중에 배울 내용임.

     -노티는 앱 실행이 기본인데, 특정 노티를 클릭할 때 특정 화면으로 가고 싶다면? ex)쿠팡에서 신발
     -포그라운드 수신, 특정 화면에선 안 받고, 특정 조건에 대해서만 포그라운드 수신 받고 싶다면?
     예를 들어 A와 대화하는 경우 B한테 카톡이 오면 알림 뜨지만, A채팅방 안에 있으니깐 A한테 카톡 와도 알림이 안뜬다.
     -iOS15 집중모드 등 5-6 우선순위 존재
     */
    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "다마고치를 키워보세요."
        notificationContent.subtitle = "오늘 행운의 숫자는 \(Int.random(in: 1...100))입니다."
        notificationContent.body = "저는 따끔따끔 다마고치입니다. 배고파요."
        notificationContent.badge = 40
        
        //언제 알림을 보낼 것인가? 1. 시간 간격 2. 캘린더 3. 위치에 따라 설정 가능
        //시간 간격은 60초 이상 설정해야 반복 가능
        //만약 시간 간격을 5초로 할거면 반복을 false로 해놓으면 됨
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
              
        var dateComponent = DateComponents()
        dateComponent.minute = 18
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
      
        //알림 요청
        //identifier:
        //만약 알림 관리할 필요 X -> 알림 클릭하면 앱을 켜 주는 정도 (날짜 Date()로 찍으면 중복없이 보낼 수 있다. 날짜는 고유하니까)
        //만약 알림 관리할 필요 O -> +1, 고유 이름 뜨게하거나, 규칙 등
        let request = UNNotificationRequest(identifier: "\(Date())", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
    }

}
