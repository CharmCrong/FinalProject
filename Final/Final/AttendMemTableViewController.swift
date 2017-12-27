//
//  AttendMemTableViewController.swift
//  Final
//
//  Created by SWUCOMPUTER on 2017. 12. 21..
//  Copyright © 2017년 swucomputer. All rights reserved.
//
//  2015111591 Contents Design 김은정

import UIKit
import CoreData

class AttendMemTableViewController: UITableViewController {
    
    var members: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // View가 보여질 때 자료를 DB에서 가져오도록 한다
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Splash")
        
        let sortDescriptor = NSSortDescriptor (key: "bName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            members = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Member Cell", for: indexPath)
        
        // Configure the cell...
        let member = members[indexPath.row]
        cell.textLabel?.text = member.value(forKey: "bName") as? String
        
        return cell
    }
    
    // 삭제
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Core Data 내의 해당 자료 삭제
            let context = getContext()
            context.delete(members[indexPath.row])
            
            do {
                try context.save()
                print("deleted!")
            } catch let error as NSError {
                print("Could not delete \(error), \(error.userInfo)")
            }
            
            // 배열에서 해당 자료 삭제
            members.remove(at: indexPath.row)
            
            // 테이블뷰 Cell 삭제
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert { }
    }
    
    // 수정하기 위해 인덱스번호를 넘길 준비
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShowMemInfo" {
            if let destination = segue.destination as? ShowMemViewController {
                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    destination.detailMember = members[selectedIndex]
                    destination.indexNum = selectedIndex
                }
            }
        }
    }
}
