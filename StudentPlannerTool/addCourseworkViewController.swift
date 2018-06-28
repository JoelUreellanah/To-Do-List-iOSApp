//
//  addCourseworkViewController.swift
//  StudentPlannerTool
//
//  Created by joel ureellanah on 19/05/2018.
//  Copyright © 2018 joel ureellanah. All rights reserved.
//

import UIKit

class addCourseworkViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var courseworkName_txt: UITextField!
    @IBOutlet weak var moduleName_txt: UITextField!
    @IBOutlet weak var startDate_txt: UITextField!
    @IBOutlet weak var endDate_txt: UITextField!
    @IBOutlet weak var weight_txt: UITextField!
    @IBOutlet weak var level_txt: UITextField!
    @IBOutlet weak var markSlider: UISlider!
    @IBOutlet weak var notes_txt: UITextView!
    
    
    @IBOutlet weak var markValue: UILabel!
    
    @IBAction func showMark(_ sender: UISlider) {
        
        markValue.text = String(Int(markSlider.value*100))
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCousework(_ sender: Any) {
        
        let newCoursework = Coursework(context: context)
        
        
        if courseworkName_txt.text != "" {
            newCoursework.name = courseworkName_txt.text
            newCoursework.module = moduleName_txt.text
            newCoursework.level = Int16.init(level_txt.text!)!
            newCoursework.weight = Int16.init(weight_txt.text!)!
            newCoursework.startDate = startDatePicker.date
            newCoursework.dueDate = endDatePicker.date
            newCoursework.mark = Int16(markSlider.value*100)
            newCoursework.notes = notes_txt.text
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            let tmpController: UIViewController! = self.presentingViewController;
            
            self.dismiss(animated: false, completion: {()->Void in print("done");
                tmpController.dismiss(animated: false, completion: nil);
            });
            print("datePick12: \(datePick.date)")
        } else {
            //Alert Message
            let alert = UIAlertController(title: "Missing Coursework Name", message: "Please enter coursework name", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKAction)
            self.present(alert,animated: true, completion: nil)
            
        }
        
        
    }
    
    
    @IBAction func cancelCoursework(_ sender: Any) {
    }
    
    
    
    
    
    
    let datePick = UIDatePicker()
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    
    func createDatePicker() {
        //format for picker
        datePick.datePickerMode = .dateAndTime
        startDatePicker.datePickerMode = .dateAndTime
        endDatePicker.datePickerMode = .dateAndTime
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,cancelButton], animated: false)
        
        startDate_txt.inputAccessoryView = toolbar
        endDate_txt.inputAccessoryView = toolbar
        
        //assign date picker to text field
        startDate_txt.inputView = startDatePicker
        endDate_txt.inputView = endDatePicker
        
    }
    
    @objc func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
    @objc func donePressed() {
        
        //        // format date
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateStyle = .short
        //        dateFormatter.timeStyle = .none
        //
        //        dueDate_txt.text = dateFormatter.string(from: datePick.date)
        //        self.view.endEditing(true)
        
        //        dueDate_txt.text = "\(datePick.date)"
        //        self.view.endEditing(true)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy HH:mm"
//        startDate_txt.text! = formatter.string(from: datePick.date)
//        endDate_txt.text! = formatter.string(from: datePick.date)
        
        
        if (startDate_txt.isFirstResponder) {
            startDate_txt.text! = formatter.string(from: startDatePicker.date)
        } else if (endDate_txt.isFirstResponder) {
            
            if endDate_txt.text?.compare(startDate_txt.text!) == .orderedDescending {
                print("date not valid")
            } else {
                endDate_txt.text! = formatter.string(from: endDatePicker.date)
            }
        }
        
        
        //dismiss date picker dialog
        self.view.endEditing(true)
        //print("datePick: \(datePick.date)")
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
