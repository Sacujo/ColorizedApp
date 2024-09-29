//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Igor Guryan on 15.09.2024.
//

import UIKit

class ColorizerViewController: UIViewController {

    @IBOutlet weak var colorizedView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet	 weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    var redColorValue: CGFloat = 0
    var greenColorValue: CGFloat = 0
    var blueColorValue: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        colorizedView.layer.cornerRadius = view.frame.width / 15
        colorizedView.backgroundColor = UIColor(red: redColorValue, green: greenColorValue, blue: blueColorValue, alpha: 1)
    }

    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redValueLabel.text = String(format: "%.2f", redSlider.value)
            redColorValue = CGFloat(redSlider.value)
        case greenSlider:
            greenValueLabel.text = String(format: "%.2f", greenSlider.value)
            greenColorValue = CGFloat(greenSlider.value)
        default:
            blueValueLabel.text = String(format: "%.2f", blueSlider.value)
            blueColorValue = CGFloat(blueSlider.value)
        }
        
        colorizedView.backgroundColor = UIColor(red: redColorValue, green: greenColorValue, blue: blueColorValue, alpha: 1)
    }
    
}

