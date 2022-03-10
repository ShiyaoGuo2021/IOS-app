//
//  InfoVC.swift
//  MetalBeast
//
//  Created by Leon on 12/6/20.
//  Copyright © 2020 Shiyao Guo. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {

    @IBOutlet weak var Name_label: UILabel!
    
    @IBOutlet weak var Version_label: UILabel!
    
    @IBOutlet weak var Build_label: UILabel!
    
    @IBOutlet weak var Copyright_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=col3
        Name_label.text = Bundle.main.displayName
               Version_label.text = Bundle.main.version
               Build_label.text = Bundle.main.build
               Copyright_label.text = Bundle.main.copyright
        // Do any additional setup after loading the view.
    }
    

  
}
