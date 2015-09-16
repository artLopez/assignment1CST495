//
//  ViewController.swift
//  assignment1
//
//  Created by Arturo Lopez on 9/13/15.
//  Copyright (c) 2015 Arturo Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var inputHistory: UILabel!
    
    
    var userMiddleTypingNum = false
    var hasDecimal = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
    
        if userMiddleTypingNum{
            if( digit == "." && display.text!.rangeOfString(".") == nil || digit != "."){
                
                inputHistory.text = inputHistory.text! + digit
            }
        }
        else {
            checkIfPi(digit)
            inputHistory.text = inputHistory.text! + " " + digit
            userMiddleTypingNum = true
        }
    }
    
    @IBAction func clearButton(sender: UIButton) {
        operandStack.removeAll()
        display.text = "0"
        userMiddleTypingNum = false
        inputHistory.text = ""
    }
    @IBAction func operate(sender: UIButton) {
        if checkDoubleOperation(sender.currentTitle!) && operandStack.count > 1{
            inputHistory.text = inputHistory.text! + " " + sender.currentTitle!
        }
        
        if userMiddleTypingNum{
            enter()
        }
        if let operation = sender.currentTitle{
            switch operation {
            case "×": performOperation{ $0 * $1}
            case "÷": performOperation{ $1 / $0}
            case "+": performOperation{ $0 + $1}
            case "−": performOperation{ $1 - $0}
            case "√" : performOperation { sqrt($0)}
            case "sin": performOperation{ sin($0) }
            case "cos": performOperation{ cos($0) }
                
            default: break
            }
        }
    }
    
    func checkIfPi(digit: String){
        if(digit ==  "π"){
            display.text = "3.14159"
        }else{
            display.text = digit
        }

    }
    
    func checkDoubleOperation(operation: String) -> Bool{
        if operation == "×" || operation == "+" ||
                        operation == "−" || operation == "÷"{
            return true
        }
        return false
    }
    
    
    func performOperation(operation: (Double,Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
  
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()

    @IBAction func enter() {
        userMiddleTypingNum = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get{
            if(display.text! == "π"){
                return M_PI
            }
            else{
                return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            }
        }
        set{
            display.text = "\(newValue)"
            userMiddleTypingNum = false
        }
    }
}

