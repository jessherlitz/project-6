//
//  ConversionView.swift
//  project-6
//
//  Created by Jessica Sampaio-Herlitz on 11/19/24.
//

import UIKit

class ConversionView: UIViewController {

    var conversionResults: [String: Double] = [:]
    var usdAmount: Double = 0.0

    @IBOutlet weak var conversionStackView: UIStackView!
    @IBOutlet weak var usdLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        usdLabel.text = "Amount in USD: \(String(format: "%.2f", usdAmount))"
        displayConversions()
        addBackButton()
    }

    private func displayConversions() {
        for (currency, amount) in conversionResults {
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.distribution = .fill
            horizontalStack.alignment = .center
            horizontalStack.spacing = 8

            let currencyLabel = UILabel()
            currencyLabel.text = currency
            currencyLabel.font = UIFont.boldSystemFont(ofSize: 16)
            currencyLabel.textColor = .black
            currencyLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            
            let amountLabel = UILabel()
            amountLabel.text = String(format: "%.2f", amount)
            amountLabel.font = UIFont.boldSystemFont(ofSize: 16)
            amountLabel.textColor = .black
            amountLabel.textAlignment = .right
            amountLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

            horizontalStack.addArrangedSubview(currencyLabel)
            horizontalStack.addArrangedSubview(amountLabel)
            conversionStackView.addArrangedSubview(horizontalStack)

            horizontalStack.translatesAutoresizingMaskIntoConstraints = false
            horizontalStack.widthAnchor.constraint(equalTo: conversionStackView.widthAnchor, multiplier: 0.8).isActive = true
        }
    }

    private func addBackButton() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        backButton.setTitleColor(.white, for: .normal)
        backButton.backgroundColor = .systemGray
        backButton.layer.cornerRadius = 8
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        conversionStackView.addArrangedSubview(backButton)

        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalTo: conversionStackView.widthAnchor).isActive = true
    }

    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
