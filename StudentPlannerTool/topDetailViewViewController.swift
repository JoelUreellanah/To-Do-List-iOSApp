//
//  topDetailViewViewController.swift
//  StudentPlannerTool
//
//  Created by joel ureellanah on 19/05/2018.
//  Copyright © 2018 joel ureellanah. All rights reserved.
//

import UIKit

class topDetailViewViewController: UIViewController {

    @IBOutlet weak var courseworkName_lbl: UILabel!
    @IBOutlet weak var moduleName_lbl: UILabel!
    @IBOutlet weak var notes_lbl: UILabel!
    @IBOutlet weak var mark_lbl: UILabel!
    @IBOutlet weak var weight_lbl: UILabel!
    @IBOutlet weak var level_lbl: UILabel!
    @IBOutlet weak var dueDate_lbl: UILabel!
    
    
    @IBOutlet weak var circleView: Circle!
    
    var courseworkName: String?
    var moduleName: String?
    var notes: String?
    var mark: Int16?
    var weight: Int16?
    var level: Int16?
    var dueDate: Date?
    var startDate: Date?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dueDate != nil {
            //sliderDueDate.date = courseDueDate! as Date
            courseworkName_lbl.text = courseworkName
            moduleName_lbl.text = moduleName
            weight_lbl.text = "\(weight ?? 0)"
            level_lbl.text = "\(level ?? 0)"
            mark_lbl.text = "\(mark ?? 0)"
            notes_lbl.text = notes
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMMM yyyy HH:mm"
            //endDate_txt.text! = formatter.string(from: datePick.date)
            dueDate_lbl.text! = formatter.string(from: dueDate!)
            //dueDate_lbl.text = dueDate
            
            var progressValue = (1.0 * Double(remainingDays(start: Date(), end: dueDate!))) / Double(totalNumberOfDays(start: startDate!, end: dueDate!))
            
            progressValue = (1.0 - progressValue) - 0.2
            circleView.percentage = progressValue
            
            circleView.percentageLabel.text = "\(String(remainingDays(start: Date(), end: dueDate!))) Days left"
            
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func remainingDays(start: Date, end:Date) -> Int {
        
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    func totalNumberOfDays(start: Date, end:Date) -> Int {
        
        return Calendar.current.dateComponents([.day], from: start, to: end).day! + 1
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
