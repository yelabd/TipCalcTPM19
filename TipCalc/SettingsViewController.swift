//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by Youssef Elabd on 8/31/18.
//  Copyright © 2018 Youssef Elabd. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipValueSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Settings"
        
        let defaults = UserDefaults.standard
        
        let integerValue = defaults.integer(forKey: "defaultTip")
        tipValueSegmentedControl.selectedSegmentIndex = integerValue
    }
    
    @IBAction func tipValueChanged(_ sender: Any) {
        let defualts = UserDefaults.standard
        
        defualts.set(tipValueSegmentedControl.selectedSegmentIndex, forKey: "defaultTip")
        defualts.synchronize()
    }
    
}
