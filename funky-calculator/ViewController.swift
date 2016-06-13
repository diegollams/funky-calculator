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
    var operation = ""
    override func viewDidLoad() {
        loadDisplayLabel()
    }
    
    func makeOperation(){
        if leftNumber == nil {
            leftNumber = displayValue
            calculatedOperation = true
        }
        else{
            switch operation {
            case "+":
                displayValue += leftNumber!
                break
            case "-":
                displayValue -= leftNumber!
                break
            case "/":
                if !(displayValue == 0){
                    displayValue /= leftNumber!
                }
                else{
                    let errorAlert = UIAlertController(title: "Error", message: "Division by 0.", preferredStyle: UIAlertControllerStyle.Alert)
                    errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                        self.clearValues()
                    }))
                    presentViewController(errorAlert, animated: true, completion: nil)
                }
                break
            case "*":
                displayValue *= leftNumber!
                break
            default: break
                
            }
            leftNumber = displayValue
            calculatedOperation = true

        }
        loadDisplayLabel()
    }
    
    func clearValues(){
        displayValue = 0
        leftNumber = nil
        calculatedOperation = false
        operation = ""
    }
    
    func loadDisplayLabel(){
        displayLabel.text = "\(displayValue)"
    }

    @IBAction func equalPress(button: UIButton){
        makeOperation()
    }
    
    @IBAction func numberPressed(button: UIButton){
        if calculatedOperation{
            displayValue = Double(button.tag)
            calculatedOperation = false
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
        operation = "+"
        makeOperation()
        
    }
    
    @IBAction func subtractionPress(button: UIButton){
        operation = "-"
        makeOperation()
    }
    
    @IBAction func multiplicationPress(button: UIButton){
        operation = "*"
        makeOperation()
    }
    
    @IBAction func dividePress(button: UIButton){
        operation = "/"
        makeOperation()
    }
    
    
    
}

