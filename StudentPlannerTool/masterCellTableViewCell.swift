//
//  masterCellTableViewCell.swift
//  StudentPlannerTool
//
//  Created by joel ureellanah on 20/05/2018.
//  Copyright © 2018 joel ureellanah. All rights reserved.
//

import UIKit

class masterCellTableViewCell: UITableViewCell {

    @IBOutlet weak var courseworkName_lbl: UILabel!
    @IBOutlet weak var moduleName_lbl: UILabel!
    @IBOutlet weak var dueDate_lbl: UILabel!
    
    
    
    
    @IBOutlet weak var courseworkName_lbl1: UILabel!
    @IBOutlet weak var moduleName_lbl1: UILabel!
    @IBOutlet weak var dueDate_lbl1: UILabel!
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
