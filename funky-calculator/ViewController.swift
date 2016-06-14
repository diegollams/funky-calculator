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
    var clearDisplay = false
    var lastOperation  = Operation.Empty
    enum Operation: String {
        case Sum = "+"
        case Substrac = "-"
        case Divide = "/"
        case Multiply = "*"
        case Equals = "="
        case Empty = "emp"
        
    }
    
    override func viewDidLoad() {
        loadDisplayLabel()
    }
    
    func makeOperation(operation: Operation){
        
        if leftNumber != nil {
            switch operation {
            case Operation.Sum:
                displayValue += leftNumber!
                break
            case Operation.Substrac:
                displayValue = leftNumber! - displayValue
                break
            case Operation.Divide:
                if displayValue != 0{
                    displayValue = leftNumber! / displayValue
                }
                else{
                    errorBox()
                }
                break
            case Operation.Multiply:
                displayValue *= leftNumber!
                break
            case Operation.Equals:
                makeOperation(lastOperation)
                lastOperation = Operation.Empty
                break
            case Operation.Empty:
                break
            }
        }
    
        leftNumber = displayValue
        loadLastOperation(operation)
        clearDisplay = true
        loadDisplayLabel()
    }
    
    func errorBox(){
        let errorAlert = UIAlertController(title: "Error", message: "Division by 0.", preferredStyle: UIAlertControllerStyle.Alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            self.clearValues()
        }))
        presentViewController(errorAlert, animated: true, completion: nil)
    }
    
    func loadLastOperation(operation: Operation){
        if operation != Operation.Equals{
            lastOperation = operation
        }
    }
    
    func clearValues(){
        displayValue = 0
        leftNumber = nil
        clearDisplay = false
    }
    
    func loadDisplayLabel(){
        displayLabel.text = "\(displayValue)"
    }

    @IBAction func equalPress(button: UIButton){
        makeOperation(Operation.Equals)
    }
    
    @IBAction func numberPressed(button: UIButton){
        if clearDisplay{
            displayValue = Double(button.tag)
            clearDisplay = false
        }
        else{
            displayValue = (displayValue * 10.0) + Double(button.tag)
        }
        loadDisplayLabel()
    }
    
    @IBAction func clearPress(button: UIButton){
        clearValues()
        loadDisplayLabel()
        lastOperation = Operation.Equals
    }
    
    @IBAction func sumPress(button: UIButton){
        makeOperation(Operation.Sum)
    }
    
    @IBAction func subtractionPress(button: UIButton){
        makeOperation(Operation.Substrac)
    }
    
    @IBAction func multiplicationPress(button: UIButton){
        makeOperation(Operation.Multiply)
    }
    
    @IBAction func dividePress(button: UIButton){
        makeOperation(Operation.Divide)
    }
    
    
    
}

