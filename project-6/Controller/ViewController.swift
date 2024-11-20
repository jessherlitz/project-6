//
//  ViewController.swift
//  project-6
//
//  Created by Jessica Sampaio-Herlitz on 11/19/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var eurSwitch: UISwitch!
    @IBOutlet weak var gbpSwitch: UISwitch!
    @IBOutlet weak var cadSwitch: UISwitch!
    @IBOutlet weak var brlSwitch: UISwitch!
    @IBOutlet weak var convertButton: UIButton!

    private var currencyConverter = CurrencyConverter()
    private var usdAmount: Double = 0.0
    private var results: [String: Double] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        inputField.delegate = self
        inputField.keyboardType = .numberPad
        inputField.becomeFirstResponder()
        convertButton.isEnabled = false
    }

    @IBAction func switchToggled(_ sender: UISwitch) {
        updateButtonState(for: inputField?.text ?? "")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "-0123456789")
        let characterSet = CharacterSet(charactersIn: string)

        if !allowedCharacterSet.isSuperset(of: characterSet) { return false }
        if string == "-" {
            if range.location != 0 || textField.text?.contains("-") == true { return false }
        }

        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        if updatedText.count > 20 { return false }

        updateButtonState(for: updatedText)
        return true
    }

    private func updateButtonState(for text: String) {
        let hasValidText = text.hasPrefix("-") ? text.count >= 2 : text.count >= 1
        let isAnySwitchOn = eurSwitch.isOn || gbpSwitch.isOn || cadSwitch.isOn || brlSwitch.isOn
        convertButton.isEnabled = hasValidText && isAnySwitchOn
    }

    @IBAction func convertPressed(_ sender: UIButton) {
        guard let amountText = inputField.text, let amount = Double(amountText) else { return }

        usdAmount = amount
        let selectedCurrencies = getSelectedCurrencies()
        results = currencyConverter.convert(amount: amount, forCurrencies: selectedCurrencies)

        performSegue(withIdentifier: "toConversionAmount", sender: self)
    }

    private func getSelectedCurrencies() -> [String] {
        var currencies: [String] = []
        if eurSwitch.isOn { currencies.append("EUR") }
        if gbpSwitch.isOn { currencies.append("GBP") }
        if cadSwitch.isOn { currencies.append("CAD") }
        if brlSwitch.isOn { currencies.append("BRL") }
        return currencies
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toConversionAmount",
           let conversionView = segue.destination as? ConversionView {
            conversionView.conversionResults = results
            conversionView.usdAmount = usdAmount
        }
    }
}
