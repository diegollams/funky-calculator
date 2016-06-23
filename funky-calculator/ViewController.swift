//
//  ViewController.swift
//  funky-calculator
//
//  Created by Diego Llamas Velasco on 5/18/16.
//  Copyright © 2016 Diego Llamas Velasco. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
    var calculator = Calculator()
    var displayValue = 0.0
    var afterOperation = true
    //if true whole numbers add to display if false decimal numbers added to display
    var wholeNumbers = true
    //value to add decimal numbers to display
    var decimalMultiplier = 0.1
    
    let buttonSoundFileName = "button-sound"
    let initialDisplayValue = 0.0
    
    override func viewDidLoad() {
        prepareBtnSound()
        
        clearCalculator()
        
        loadDisplayLabel()
    }
    
    func errorBox(errorMessage: String){
        let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            self.clearCalculator()
        }))
        presentViewController(errorAlert, animated: true, completion: nil)
    }
    
    //handle the operation and errors
    func makeOperation(operation: Calculator.Operation){
        do{
            calculator.operation = operation
            displayValue = try calculator.perfomOperation(displayValue)
            afterOperation = true
            loadDisplayLabel()
        }catch Calculator.Errors.DivisionBy0{
            print("caca")
            errorBox("Divisiont by 0")
        }catch Calculator.Errors.PercentageOutOfRange{
            print("cwewe")
            errorBox("Percentage should be between 0 and 100")
        }catch {
            errorBox("Unhandle erro")
        }
        resetToWholeNumbers()
    }
    
    func loadDisplayLabel(){
        displayLabel.text = "\(displayValue)"
        operationLabel.text = calculator.operation.rawValue
    }
    
    func clearCalculator(){
        wholeNumbers = true
        resetToWholeNumbers()
        calculator.clear()
        displayValue = initialDisplayValue
        loadDisplayLabel()
    }
    
    func resetToWholeNumbers(){
        wholeNumbers = true
        decimalMultiplier = 0.1
    }
    
    func prepareBtnSound(){
        let path = NSBundle.mainBundle().pathForResource(buttonSoundFileName, ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func playBtnSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }

    @IBAction func equalPress(button: UIButton){
        playBtnSound()
        makeOperation(calculator.operation)
        
    }
    
    @IBAction func numberPressed(button: UIButton){
        playBtnSound()
        if afterOperation{
            displayValue = initialDisplayValue
        }
        afterOperation = false
        if wholeNumbers{
            displayValue = (displayValue * 10.0) + Double(button.tag)
        }
        else{
            displayValue = displayValue + (Double(button.tag) * decimalMultiplier)
            decimalMultiplier *= 0.1
        }
        
        loadDisplayLabel()

    }
    
    @IBAction func clearPress(button: UIButton){
        playBtnSound()
        clearCalculator()
    }
    
    @IBAction func sumPress(button: UIButton){
        playBtnSound()
        makeOperation(Calculator.Operation.Sum)
    }
    
    @IBAction func subtractionPress(button: UIButton){
        playBtnSound()
        makeOperation(Calculator.Operation.Substraction)
    }
    
    @IBAction func multiplicationPress(button: UIButton){
        playBtnSound()
        makeOperation(Calculator.Operation.Multiplication)
    }
    
    @IBAction func dividePress(button: UIButton){
        playBtnSound()
        makeOperation(Calculator.Operation.Divisition)
    }
    
    @IBAction func dotPrees(button: UIButton){
        playBtnSound()
        wholeNumbers = false
    }
    
    @IBAction func percentagePress(button: UIButton){
        playBtnSound()
        makeOperation(Calculator.Operation.Percentage)
    }
    
    
    
}

