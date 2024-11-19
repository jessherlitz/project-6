//
//  ViewController.swift
//  project-6
//
//  Created by Jessica Sampaio-Herlitz on 11/19/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var eurSwitch: UISwitch!
    @IBOutlet weak var gbpSwitch: UISwitch!
    @IBOutlet weak var cadSwitch: UISwitch!
    @IBOutlet weak var brlSwitch: UISwitch!
    
    var amountText: String = ""
    var results: [String: Double] = [:]
    
    let conversionRates: [String: Double] = [
        "EUR": 0.94,
        "GBP": 0.79,
        "CAD": 1.40,
        "BRL": 5.77
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputField.delegate = self
        inputField.keyboardType = .numberPad
    }

    func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {

        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
        let characterSet = CharacterSet(charactersIn: string)

        if !allowedCharacterSet.isSuperset(of: characterSet) {
            return false
        }

        return true
    }
    

    @IBAction func convertPressed(_ sender: UIButton) {
        guard let amountText = inputField.text,
        let amount = Double(amountText) else {
//              resultLabel.text = "Invalid input amount"
            print("invalid")
            return
        }


        if eurSwitch.isOn {
            results["EUR"] = amount * conversionRates["EUR"]!
        }
        
        if gbpSwitch.isOn {
            results["GBP"] = amount * conversionRates["GBP"]!
        }
        
        if cadSwitch.isOn {
            results["CAD"] = amount * conversionRates["CAD"]!
        }
        
        if brlSwitch.isOn {
            results["BRL"] = amount * conversionRates["BRL"]!
        }
        
       if results.isEmpty {
//           resultLabel.text = "No currencies selected"
           print("nothing was selected")
       } else {
           let formattedResults = results.map { "\($0.key): \($0.value)" }.joined(separator: "\n")
//           resultLabel.text = formattedResults
           print(formattedResults)
       }
        
        self.performSegue(withIdentifier: "toConversionAmount", sender: self)
        
        print("here")
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "toConversionAmount" {
             let conversionNavigation = segue.destination as! ConversionView
             conversionNavigation.eurLabelField = String(results["EUR"]!)
             conversionNavigation.cadLabelField = String(results["CAD"]!)
         }
     }
}

