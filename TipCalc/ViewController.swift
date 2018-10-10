//
//  ViewController.swift
//  TipCalc
//
//  Created by Youssef Elabd on 8/31/18.
//  Copyright © 2018 Youssef Elabd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmoutTextField: UITextField!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipValueSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tipLabelView: UIView!
    var hasValue = false
    let percentages = [0.10,0.15,0.20]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tipLabelView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard

        let integerValue = defaults.integer(forKey: "defaultTip")
        tipValueSegmentedControl.selectedSegmentIndex = integerValue
    }
    
    @IBAction func billDidChange(_ sender: Any) {
        if let billAmount = Double(self.billAmoutTextField.text!) {
            if !self.hasValue {
                self.hasValue = true
                UIView.animate(withDuration: 0.2) {
                    self.tipLabelView.isHidden = false
                    self.tipLabelView.frame.origin.y -= self.tipLabelView.frame.height
                }
            }
            
            let tipValueIndex = self.tipValueSegmentedControl.selectedSegmentIndex
            let tip = billAmount * percentages[tipValueIndex]
            let totalAmount = billAmount + tip
            self.tipAmountLabel.text = "Tip is $\(tip)"
            self.totalAmountLabel.text = "$\(totalAmount)"
        } else {
            self.hasValue = false
            UIView.animate(withDuration: 0.2, animations: {
                 self.tipLabelView.frame.origin.y += self.tipLabelView.frame.height
            }) { (completed) in
                self.tipLabelView.isHidden = true
            }
        }
    }
    
    @IBAction func tipDidChange(_ sender: Any) {
        if let billAmount = Double(self.billAmoutTextField.text!) {
            let tipValueIndex = self.tipValueSegmentedControl.selectedSegmentIndex
            let tip = billAmount * percentages[tipValueIndex]
            let totalAmount = billAmount + tip
            self.tipAmountLabel.text = "Tip is $\(tip)"
            self.totalAmountLabel.text = "$\(totalAmount)"
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.tipLabelView.frame.origin.y = keyboardRectangle.origin.y
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.hasValue = false
        self.tipLabelView.frame.origin.y = self.view.bounds.height - self.tipLabelView.frame.height
    }
    
}

