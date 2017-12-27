//
//  SaveDateViewController.swift
//  Final
//
//  Created by SWUCOMPUTER on 2017. 12. 21..
//  Copyright © 2017년 swucomputer. All rights reserved.
//
//  2015111591 Contents Design 김은정

import UIKit
import CoreData

class SaveDateViewController: UIViewController, UITextFieldDelegate {

    //@IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var txtScore1: UITextField!
    @IBOutlet var txtScore2: UITextField!
    
    var detailMember: NSManagedObject?
    
    // 수정하기 위해 넘기는 테이블인덱스 번호
    var indexNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func saveDate(_ sender: UIBarButtonItem) {
        print(indexNum)
        let context = getContext()
        
        // Dates record를 새로 생성함
        let editObject = NSFetchRequest<NSFetchRequestResult>(entityName: "Splash")
        
        let memList = try! context.fetch(editObject) as! [Splash]
        
        memList[indexNum].score1 = Double(txtScore1.text!)!
        
        memList[indexNum].score2 = Double(txtScore2.text!)!
        
        memList[indexNum].editDate = Date() as NSDate
        
        // 이전 입력한 평균과 새로 등록한 점수 2개를 합산하여 평균을 냄
        let aver = (memList[indexNum].average + memList[indexNum].score1 + memList[indexNum].score2) / 3
        memList[indexNum].average = aver
        
        // 시드 분류
        if aver >= 160 {
            memList[indexNum].seed = "1시드(160이상)"
        } else if aver >= 140 && aver < 160 {
            memList[indexNum].seed = "2시드(140-160)"
        } else if aver >= 120 && aver < 140 {
            memList[indexNum].seed = "3시드(120-140)"
        } else if aver >= 100 && aver < 120 {
            memList[indexNum].seed = "4시드(100-120)"
        } else if aver >= 80 && aver < 100 {
            memList[indexNum].seed = "5시드(80-100)"
        } else if aver < 80 {
            memList[indexNum].seed = "6시드(80이하)"
        }
    
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
        
    }
}
