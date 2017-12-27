//
//  SaveMemViewController.swift
//  Final
//
//  Created by SWUCOMPUTER on 2017. 12. 21..
//  Copyright © 2017년 swucomputer. All rights reserved.
//
//  2015111591 Contents Design 김은정

import UIKit
import CoreData

class SaveMemViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtAge: UITextField!
    @IBOutlet var segGender: UISegmentedControl!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var txtAver: UITextField!
    @IBOutlet var joinDatePicker: UIDatePicker!
    
    var saveGender: String! = "남"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func saveGender(_ sender: UISegmentedControl) {
        saveGender = sender.titleForSegment(at: sender.selectedSegmentIndex)
    }
    
    @IBAction func saveMem(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Splash", in: context)
        
        // Splash record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(txtName.text, forKey: "bName")
        
        object.setValue(txtAge.text, forKey: "age")
        
        object.setValue(saveGender, forKey: "gender")
        
        object.setValue(txtPhone.text, forKey: "phone")
        
        let aver = Int(txtAver.text!)
        object.setValue(aver, forKey: "average")
        
        object.setValue(joinDatePicker.date, forKey: "joinDate")
        object.setValue(Date(), forKey: "editDate")
        
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
