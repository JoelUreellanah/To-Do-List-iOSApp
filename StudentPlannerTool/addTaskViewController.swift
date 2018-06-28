//
//  addTaskViewController.swift
//  StudentPlannerTool
//
//  Created by joel ureellanah on 19/05/2018.
//  Copyright © 2018 joel ureellanah. All rights reserved.
//

import UIKit

class addTaskViewController: UIViewController {

    
    @IBOutlet weak var courseworkName_txt: UILabel!
    @IBOutlet weak var tastName_txt: UITextField!
    @IBOutlet weak var startDate_txt: UITextField!
    @IBOutlet weak var endDate_txt: UITextField!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var notes_txt: UITextView!
    
    
    var courseworkStartDate: Date?
    var courseworkEndDate: Date?
    
    
    var currentCoursework: Coursework?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        endDate_txt.inputAccessoryView = toolbar
        
        //assign date picker to text field
        startDate_txt.inputView = startDatePicker
        endDate_txt.inputView = endDatePicker
    }
    
    
    @objc func donePressed() {
        
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
//        startDate_txt.text = dateFormatter.string(from: datePick.date)
//        endDate_txt.text = dateFormatter.string(from: datePick.date)
        
        if (startDate_txt.isFirstResponder) {
            startDate_txt.text = dateFormatter.string(from: startDatePicker.date)
        } else if (endDate_txt.isFirstResponder) {
            //endDate is after the startDate of the task && Task startDate is equal or after startDate of Coursework
            if endDate_txt.text?.compare(startDate_txt.text!) == .orderedDescending {
                print("date not valid")
            } else {
                endDate_txt.text = dateFormatter.string(from: endDatePicker.date)
            }
        }
        
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //courseworkName_txt.text = currentCoursework?.name
        createDatePicker()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func saveTask(_ sender: Any) {
        
        if currentCoursework != nil {
            
            if (tastName_txt.text != "" || startDate_txt.text != "" || endDate_txt.text != "" || notes_txt.text != "") {
               
                let newTask = Task(context: context)
                newTask.name = tastName_txt.text
                newTask.startDate = startDatePicker.date
                newTask.dueDate = endDatePicker.date
                newTask.notes = notes_txt.text
                newTask.progress = Int16(progressSlider.value*100)
                
                currentCoursework?.addToNewTasks(newTask)
                
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                let tmpController:UIViewController! = self.presentingViewController;
                self.dismiss(animated: false, completion: {()->Void in print("done");
                    tmpController.dismiss(animated: false, completion: nil);
                });
                
            } else {
                displayAlert(title: "Ops..", message: "Please fill all boxes.")
            }
            
            
            
            
            
        } else {
            displayAlert(title: "Ops..", message: "Please select a coursework first.")
        }
        
        
        
        
        
        
    }
    
    
    
    @IBAction func cancelTask(_ sender: Any) {
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
