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
    
    var calculator = Calculator()
    var displayValue = 0.0
    var afterOperation = true
    
    override func viewDidLoad() {
        calculator.currentValue = 0.0
        loadDisplayLabel()
    }
    
    func errorBox(errorMessage: String){
        let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            self.clearCalculator()
        }))
        presentViewController(errorAlert, animated: true, completion: nil)
    }
    
    func makeOperation(operation: Calculator.Operation){
        do{
            calculator.operation = operation
            displayValue = try calculator.perfomOperation(displayValue)
            afterOperation = true
            loadDisplayLabel()
        }catch Calculator.Errors.DivisionBy0{
            errorBox("Divisiont by 0")
        }catch {
            errorBox("Unhandle error")
        }
    }
    
    func loadDisplayLabel(){
        displayLabel.text = "\(displayValue)"
    }
    
    func clearCalculator(){
        calculator.clear()
        displayValue = 0.0
        loadDisplayLabel()
    }

    @IBAction func equalPress(button: UIButton){
        do{
            displayValue = try calculator.perfomOperation(displayValue)
            afterOperation = true
            loadDisplayLabel()
        }catch{
            
        }
        
    }
    
    @IBAction func numberPressed(button: UIButton){
        if afterOperation{
            displayValue = 0
        }
        afterOperation = false
        displayValue = (displayValue * 10.0) + Double(button.tag)
        loadDisplayLabel()

    }
    
    @IBAction func clearPress(button: UIButton){
        clearCalculator()
    }
    
    @IBAction func sumPress(button: UIButton){
        makeOperation(Calculator.Operation.Sum)
    }
    
    @IBAction func subtractionPress(button: UIButton){
        makeOperation(Calculator.Operation.Substraction)
    }
    
    @IBAction func multiplicationPress(button: UIButton){
        makeOperation(Calculator.Operation.Multiplication)
    }
    
    @IBAction func dividePress(button: UIButton){
        makeOperation(Calculator.Operation.Divisition)
    }
    
    
    
}

