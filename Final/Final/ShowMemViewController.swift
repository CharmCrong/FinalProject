//
//  ShowMemViewController.swift
//  Final
//
//  Created by SWUCOMPUTER on 2017. 12. 21..
//  Copyright © 2017년 swucomputer. All rights reserved.
//
//  2015111591 Contents Design 김은정

import UIKit
import CoreData

class ShowMemViewController: UIViewController {

    @IBOutlet var showName: UILabel!
    @IBOutlet var showAge: UILabel!
    @IBOutlet var showPhone: UILabel!
    @IBOutlet var showGender: UILabel!
    @IBOutlet var showJoin: UILabel!
    
    @IBOutlet var showEditDate: UILabel!
    @IBOutlet var showAverage: UILabel!
    @IBOutlet var showScore1: UILabel!
    @IBOutlet var showScore2: UILabel!
    @IBOutlet var showSeed: UILabel!
    
    var detailMember: NSManagedObject?
    var indexNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let member = detailMember {
            showName.text = member.value(forKey: "bName") as? String
            
            showAge.text = member.value(forKey: "age") as? String
            
            showPhone.text = member.value(forKey: "phone") as? String
            
            showGender.text = member.value(forKey: "gender") as? String
            
            showSeed.text = member.value(forKey: "seed") as? String
            
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            let dbJoin = member.value(forKey: "joinDate") as? Date
            if let unwrapDate = dbJoin {
                showJoin.text = formatter.string(from: unwrapDate as Date)
            }
            
            let formatter2: DateFormatter = DateFormatter()
            formatter2.dateFormat = "yyyy-MM-dd h:mm"
            
            let dbEdit = member.value(forKey: "editDate") as? Date
            if let unwrapEdit = dbEdit {
                showEditDate.text = formatter2.string(from: unwrapEdit as Date)
            }
            
            if let shScore1 = member.value(forKey: "score1") as? Double {
                showScore1.text = String(shScore1)
            }
            
            if let shScore2 = member.value(forKey: "score2") as? Double {
                showScore2.text = String(shScore2)
            }
            
            if let shAver = member.value(forKey: "average") as? Double {
                showAverage.text = String(shAver)
            }
        }
    }

    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toEditScore" {
            if let destination = segue.destination as? SaveDateViewController {
                destination.indexNum = indexNum
            }
        }
    }
}

