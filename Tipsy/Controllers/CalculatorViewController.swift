//
//  CalculatorViewController.swift
//  Tipsy
//
//  Created by Rasyid Respati Wiriaatmaja on 06/11/19.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        //Dismiss the keyboard when the user choose one of the tip values
        billTextField.endEditing(true)
        
        //Deselect all tip buttons
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        //Make the button that triggered the IBAction selected
        sender.isSelected = true
        
        //Get the current title
        let buttonTitle = sender.currentTitle!
        
        //Removing the last character (%) from the title and turn back to String
        let buttonTitleNoPercentSign = String(buttonTitle.dropLast())
        
        //Turn the String into a Double
        let buttonTitleAsNumber = Double(buttonTitleNoPercentSign)!
        
        //Divide the percent expressed out of 100 into a decimal
        tip = buttonTitleAsNumber / 100
        
        
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        //Get the stepper value using sender.value, round it down to a whole number.
        //Then set it as text in splitNumberLabel
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        
        //Set numberOfPeople props as the value of the stepper as a whole number
        numberOfPeople = Int(sender.value)
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        //Get the text the user typed in the billTextField
        let bill = billTextField.text!
        
        //if the text is not an empty String
        if bill != "" {
            
            //Turn the bill from a String e.g "123.50" to an actual String with decimal places.
            //e.g 125.50
            billTotal = Double(bill)!
            
            //Multiply the bill by the tip percentage and divide by the number of people to split the bill.
            let result = billTotal * (1 + tip) / Double(numberOfPeople)
            
            
            finalResult = String(format: "%.2f", result)
            
        }
        
        //In Main.storyboard there is a segue between CalculatorVC and ResultsVC with the identifier "goToResults"
        //This line triggers the segue to happen
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    //This method gets triggered just before the segue starts
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //If the currently triggered segue is the "goToResults" segue.
        if segue.identifier == "goToResults" {
            
            //Get hold of the instance of the destination VC and type cast it to a ResultViewController.
            let destinationVC = segue.destination as! ResultsViewController
            
            //Set the destination ResultsViewController's properties
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }
    
}

