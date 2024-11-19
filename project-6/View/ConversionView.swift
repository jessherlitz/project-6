//
//  ConversionView.swift
//  project-6
//
//  Created by Jessica Sampaio-Herlitz on 11/19/24.
//

import Foundation

import UIKit

class ConversionView: UIViewController {
    var cadLabelField : String = ""
    var eurLabelField : String = ""
    
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var brlLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cadLabel.text = cadLabelField
        eurLabel.text = eurLabelField
    }
    
}
