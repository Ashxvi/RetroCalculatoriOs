//
//  ViewController.swift
//  RetroCalculator
//
//  Created by MAHHA on 17/03/2017.
//  Copyright © 2017 MAHHA. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    var btnSound : AVAudioPlayer!
    
    
    @IBOutlet weak var outputLbl: UILabel!
    
    
    var runningNumber = ""
    var leftHandVal = ""
    var rightHandVal = ""
    var result = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

         let path = Bundle.main.path(forResource: "btn", ofType: "wav")
         let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    
    }

    
    enum Operation : String{
    
    case Multiply = "*"
    case Substract = "-"
    case Add = "+"
    case Divide = "/"
    case Empty = "Empty"

    
    }
    var currentOperation = Operation.Empty

    @IBAction func numberPressed(sender : UIButton){
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    
    }

    func playSound(){
        
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    
    }
    
    func processOperation(operation: Operation){
    
        if currentOperation != Operation.Empty {
        
            
            if runningNumber != "" {
                
                rightHandVal = runningNumber
                runningNumber = ""
                
                switch currentOperation {
                case Operation.Add :
                    result = "\(Double(leftHandVal)!+Double(rightHandVal)!)"
                    break
                case Operation.Multiply :
                    result = "\(Double(leftHandVal)!*Double(rightHandVal)!)"
                    break
                case Operation.Substract :
                    result = "\(Double(leftHandVal)!-Double(rightHandVal)!)"
                    break
                case Operation.Divide :
                    result = "\(Double(leftHandVal)!/Double(rightHandVal)!)"
                    break
                default:
                    break
                }
                
                leftHandVal = result
                outputLbl.text = leftHandVal
            
            
            }
        
            currentOperation = operation
        
        }
        
        else {
        // L'utilisateur a cliqué sur une opération pour la première fois
            
            leftHandVal = runningNumber
            runningNumber = ""
            currentOperation = operation
        
        }
    
    }
    
    @IBAction func clearAll(sender: UIButton){

        runningNumber =  "0"
        leftHandVal = "0"
        rightHandVal = "0"
        result = "0"
        currentOperation = Operation.Empty
        outputLbl.text = result
        
    }
    
    @IBAction func onAddPressed(sender : UIButton){
        processOperation(operation: Operation.Add)
        
    }
    
    @IBAction func onMultiplyPressed(sender : UIButton){
        processOperation(operation: Operation.Multiply)
        
    }
    
    @IBAction func onSubstractPressed(sender : UIButton){
        processOperation(operation: Operation.Substract)
        
    }
    
    @IBAction func onDividePressed(sender : UIButton){
        processOperation(operation: Operation.Divide)
        
    }
    
    @IBAction func onEqualPressed(sender : UIButton){
        processOperation(operation: currentOperation)
        
    }
    
}

