//
//  CalendarViewController.swift
//  SeSAC_06Week
//
//  Created by 지영 on 2021/11/05.
//

import UIKit
import RealmSwift
import FSCalendar

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var allCountLabel: UILabel!
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.dataSource = self

        tasks = localRealm.objects(UserDiary.self)
        
        let allCount = getAllDiaryCountFromUserDiary()
        allCountLabel.text = "총 \(allCount)개 일기"
        
//        let recent = localRealm.objects(UserDiary.self).sorted(byKeyPath: "writeDate", ascending: false).first?.diaryTitle
//        print("recent: \(recent)")
//        let full = localRealm.objects(UserDiary.self).filter("content != nil").count
//        print("full: \(full)")
//
//        let favorite = localRealm.objects(UserDiary.self).filter("favorite == false")
//        print("favorite: \(favorite)")
//
//        let search = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] 'g' OR content CONTAINS[c] '일기작성'")
//        print("search: \(search)")
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "title"
//    }
//    
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        return "subtitle"
//    }
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(systemName: "star")
//    }
    
    // Date: 시분초까지 모두 동일해야함
    // 1. 영국 표준시 기준으로 표기: 2021-11-27 15:00:00 +0000 -> 11/28
    // 2. 데이트 포맷터
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        let format = DateFormatter()
//        format.dateFormat = "yyyyMMdd"
//        let test = "20211103"
//
//        if format.date(from: test) == date {
//            return 3
//        } else {
//            return 1
//        }
        
        // 11/2 3개의 일기면 점 3개, 없으면 x
        return tasks.filter("writeDate == %@", date).count
        
    }
}
