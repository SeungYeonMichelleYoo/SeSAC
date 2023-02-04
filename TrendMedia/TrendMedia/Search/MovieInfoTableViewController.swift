//
//  MovieInfoTableViewController.swift
//  TrendMedia
//
//  Created by SeungYeon Yoo on 2022/07/19.
//

import UIKit

class MovieInfoTableViewController: UITableViewController {
    
    var titleList = ["아바타", "7번방의 선물", "국제시장", "택시운전사"]
    var imageList = ["아바타", "7번방의선물", "국제시장", "택시운전사"]
    var dateList = ["2007.12.06", "2012.05.08", "2015.08.26", "2018.05.25"]
    var storyList = ["지구 에너지 고갈 문제를 해결하기 위해 판도라 행성으로 향한 인류는 원주민 '나비족'과 대립하게 된다.", "최악의 흉악범들이 모인 교도소 7번방에 이상한 놈이 들어왔다! 그는 바로 6살 지능의 딸바보 '용구'! 평생 죄만 짓고 살아온 7번방 패밀리들에게 떨어진 미션은 바로 '용구' 딸 '예승'이를 외부인 절대 출입금지인 교도소에 반.입.하.는.것! ", "1950년대 한국전쟁 이후로부터 현재에 이르기까지 격변의 시대를 관통하며 살아온 우리 시대 아버지 ‘덕수’(황정민 분), 그는 하고 싶은 것도 되고 싶은 것도 많았지만 평생 단 한번도 자신을 위해 살아본 적이 없다.", "택시운전사 만섭(송강호)은 외국손님을 태우고 광주에 갔다 통금 전에 돌아오면 밀린 월세를 갚을 수 있는 거금 10만원을 준다는 말에 독일기자 피터(토마스 크레취만)를 태우고 영문도 모른 채 길을 나선다."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieInfoTableViewCell", for: indexPath) as! MovieInfoTableViewCell
        
        cell.titleLabel.text = titleList[indexPath.row]
        cell.posterImage.image = UIImage(named: imageList[indexPath.row])
        cell.dateLabel.text = dateList[indexPath.row]
        cell.storyLabel.text = storyList[indexPath.row]
        
        return cell
    }



}
