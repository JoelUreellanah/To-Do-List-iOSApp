//
//  editTaskViewController.swift
//  StudentPlannerTool
//
//  Created by joel ureellanah on 19/05/2018.
//  Copyright © 2018 joel ureellanah. All rights reserved.
//

import UIKit
import CoreData

class editTaskViewController: UIViewController {

    
    @IBOutlet weak var courseworkName_lbl: UILabel!
    @IBOutlet weak var taskName_txt: UITextField!
    @IBOutlet weak var startDate_txt: UITextField!
    @IBOutlet weak var dueDate_txt: UITextField!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var notes_txt: UITextView!
    
    
    var courseworkName: String?
    var taskName: String?
    var startDate: Date?
    var dueDate: Date?
    var notes: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        startDatePicker.date = startDate!
        endDatePicker.date = dueDate!
        // Do any additional setup after loading the view.
        courseworkName_lbl.text = courseworkName
        taskName_txt.text = taskName
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy HH:mm"
        startDate_txt.text! = formatter.string(from: startDate!)
        dueDate_txt.text! = formatter.string(from: dueDate!)
        
        notes_txt.text = notes
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func saveTask(_ sender: Any) {
        
        if (taskName_txt.text != "" && startDate_txt.text != "" && dueDate_txt.text != "" && notes_txt.text != "") {
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            
            do {
                
                let results = try context.fetch(request)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let username = result.value(forKey: "name") as? String {
                            if username == taskName {
                                result.setValue(taskName_txt.text, forKey: "name")
                                result.setValue(startDatePicker.date, forKey: "startDate")
                                result.setValue(endDatePicker.date, forKey: "dueDate")
                                result.setValue(notes_txt.text, forKey: "notes")
                                result.setValue(Int16(progressSlider.value*100), forKey: "progress")
                                do {
                                    try context.save()
                                    
                                    let tmpController:UIViewController! = self.presentingViewController;
                                    self.dismiss(animated: false, completion: {()->Void in print("done");
                                        tmpController.dismiss(animated: false, completion: nil);
                                    });
                                } catch {
                                    
                                    let alert = UIAlertController(title: "Ops.. some problem occur", message: "Please try again later.", preferredStyle: .alert)
                                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                    alert.addAction(OKAction)
                                    self.present(alert,animated: true, completion: nil)
                                    
                                    
                                    
                                }
                            }
                        }
                    }
                }
                
                
            } catch {
                
            }
        
        } else {
            displayAlert(title: "Ops..", message: "Please fill all boxes.")
        }
    }
    
    
    @IBAction func cancelTask(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    
    
    
    
    
    let datePick = UIDatePicker()
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    
    
    func createDatePicker() {
        //format for picker
        datePick.datePickerMode = .date
        startDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        startDate_txt.inputAccessoryView = toolbar
        dueDate_txt.inputAccessoryView = toolbar
        
        //assign date picker to text field
        startDate_txt.inputView = startDatePicker
        dueDate_txt.inputView = endDatePicker
    }
    
    
    @objc func donePressed() {
        
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
//        startDate_txt.text = dateFormatter.string(from: datePick.date)
//        dueDate_txt.text = dateFormatter.string(from: datePick.date)
        
        if (startDate_txt.isFirstResponder) {
            startDate_txt.text = dateFormatter.string(from: startDatePicker.date)
        } else if (dueDate_txt.isFirstResponder) {
            if dueDate_txt.text?.compare(startDate_txt.text!) == .orderedDescending {
                print("date not valid")
            } else {
                dueDate_txt.text = dateFormatter.string(from: endDatePicker.date)
            }
        }
        
        
        self.view.endEditing(true)
    }
    
    
    
    //Alert Message
    func displayAlert(title: String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKAction)
        self.present(alert,animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
