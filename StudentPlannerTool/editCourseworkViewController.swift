//
//  editCourseworkViewController.swift
//  StudentPlannerTool
//
//  Created by joel ureellanah on 19/05/2018.
//  Copyright © 2018 joel ureellanah. All rights reserved.
//

import UIKit
import CoreData

class editCourseworkViewController: UIViewController {

    
    @IBOutlet weak var courseworkName_txt: UITextField!
    @IBOutlet weak var moduleName_txt: UITextField!
    @IBOutlet weak var startDate_txt: UITextField!
    @IBOutlet weak var endDate_txt: UITextField!
    @IBOutlet weak var weight_txt: UITextField!
    @IBOutlet weak var level_txt: UITextField!
    @IBOutlet weak var markSlider: UISlider!
    @IBOutlet weak var notes_txt: UITextView!
    
    @IBOutlet weak var markLabel: UILabel!
    
    var courseworkName: String?
    var moduleName: String?
    var weight: Int16?
    var level: Int16?
    var startDate: Date?
    var dueDate: Date?
    var notes: String?
    
    
    @IBAction func slider(_ sender: Any) {
        
        markLabel.text = String(Int(markSlider.value*100))
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        startDatePicker.date = startDate!
        endDatePicker.date = dueDate!
        courseworkName_txt.text = courseworkName
        moduleName_txt.text = moduleName
        weight_txt.text = "\(weight ?? 0)"
        level_txt.text = "\(level ?? 0)"
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy HH:mm"
        
        startDate_txt.text! = formatter.string(from: startDate!)
        endDate_txt.text! = formatter.string(from: dueDate!)
        //dueDate_txt.text = dueDate
        notes_txt.text = notes
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func editCoursework(_ sender: Any) {
        
        
        if (courseworkName_txt.text != "" || moduleName_txt.text != "" || startDate_txt.text != "" || endDate_txt.text != "" || weight_txt.text != "" || level_txt.text != "" || notes_txt.text != "") {
        
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Coursework")
            
            do {
                
                let results = try context.fetch(request)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let username = result.value(forKey: "name") as? String {
                            if username == courseworkName {
                                result.setValue(courseworkName_txt.text, forKey: "name")
                                result.setValue(moduleName_txt.text, forKey: "module")
                                result.setValue(Int16(weight_txt.text!), forKey: "weight")
                                result.setValue(Int16(level_txt.text!), forKey: "level")
                                result.setValue(startDatePicker.date, forKey: "startDate")
                                result.setValue(endDatePicker.date, forKey: "dueDate")
                                result.setValue(notes_txt.text, forKey: "notes")
                                
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
    
    
    @IBAction func cancelCoursework(_ sender: Any) {
    }
    
    
    
    let datePick = UIDatePicker()
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    
    
    func createDatePicker() {
        //format for picker
        datePick.datePickerMode = .date
        startDatePicker.datePickerMode = .dateAndTime
        endDatePicker.datePickerMode = .dateAndTime
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        startDate_txt.inputAccessoryView = toolbar
        endDate_txt.inputAccessoryView = toolbar
        
        //assign date picker to text field
        startDate_txt.inputView = startDatePicker
        endDate_txt.inputView = endDatePicker
    }
    
    
    @objc func donePressed() {
        
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm"
        
//        startDate_txt.text = dateFormatter.string(from: datePick.date)
//        endDate_txt.text = dateFormatter.string(from: datePick.date)
        
        
        if (startDate_txt.isFirstResponder) {
            startDate_txt.text = dateFormatter.string(from: startDatePicker.date)
        } else if (endDate_txt.isFirstResponder) {
            if endDate_txt.text?.compare(startDate_txt.text!) == .orderedDescending {
                print("date not valid")
            } else {
                endDate_txt.text = dateFormatter.string(from: endDatePicker.date)
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
