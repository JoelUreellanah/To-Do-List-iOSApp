//
//  tableCellTableViewCell.swift
//  StudentPlannerTool
//
//  Created by joel ureellanah on 19/05/2018.
//  Copyright © 2018 joel ureellanah. All rights reserved.
//

import UIKit

class tableCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var courseworkName_lbl: UILabel!
    @IBOutlet weak var notes_lbl: UILabel!
    @IBOutlet weak var dueDate_lbl: UILabel!
    
    @IBOutlet weak var taskProgressView: taskProgressCircle!
    
    var percentage: Double?
    var taskPercentage: Int16?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        taskProgressView.percentage = percentage
        taskProgressView.percentageLabel.text = "\(String(taskPercentage!)) %"
        // Configure the view for the selected state
    }

}
