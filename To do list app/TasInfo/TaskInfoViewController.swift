//
//  TaskInfo.swift
//  To do list app
//
//  Created by sreelekh N on 19/04/22.
//

import UIKit

class TaskInfoViewController: UIViewController {

    var taskTitle = ""
    
    @IBOutlet var myTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTitle.text = taskTitle

    }
    
}
