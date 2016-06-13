//
//  ViewController.swift
//  funky-calculator
//
//  Created by Diego Llamas Velasco on 5/18/16.
//  Copyright © 2016 Diego Llamas Velasco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var displayLabel:UILabel!
    var displayValue = 0.0
    var leftNumber:Double?
    var calculatedOperation = false
    
    override func viewDidLoad() {
        loadDisplayLabel()
    }
    
    func clearValues(){
        displayValue = 0
        leftNumber = 0
        calculatedOperation = false
    }
    
    func loadDisplayLabel(){
        displayLabel.text = "\(displayValue)"
    }

    @IBAction func numberPressed(button: UIButton){
        if calculatedOperation{
            clearValues()
        }
        else{
            displayValue = (displayValue * 10.0) + Double(button.tag)
        }
        loadDisplayLabel()
    }
    
    @IBAction func clearPress(button: UIButton){
        clearValues()
        loadDisplayLabel()
    }
    
    @IBAction func sumPress(button: UIButton){
        if (leftNumber == nil) {
            leftNumber = displayValue
            displayValue = 0.0
        }else{
            displayValue += leftNumber!
            leftNumber = displayValue
            calculatedOperation = true
        }
        loadDisplayLabel()
    }
    
    
    
}

