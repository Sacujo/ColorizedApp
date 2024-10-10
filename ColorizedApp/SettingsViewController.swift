//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Igor Guryan on 15.09.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var colorizedView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    //MARK: - Public properties
    weak var delegate: SettingsViewControllerDelegate?
    var colorForView: UIColor!
    
    //MARK: - View LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        [redTextField, greenTextField, blueTextField].forEach{ $0?.delegate = self }
        
        setup(for: redSlider, greenSlider, blueSlider)
        setup(for: redValueLabel, greenValueLabel, blueValueLabel)
        setup(for: redTextField, greenTextField, blueTextField)
        
        
        navigationItem.hidesBackButton = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    //MARK: - IBActions
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setup(for: redValueLabel)
            setup(for: redTextField)
        case greenSlider:
            setup(for: greenValueLabel)
            setup(for: greenTextField)
        default:
            setup(for: blueValueLabel)
            setup(for: blueTextField)
        }
        setViewColor()
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        delegate?.setColor(colorizedView.backgroundColor ?? .brown)
        dismiss(animated: true)
    }
    
}

//MARK: - Private Methods
private extension SettingsViewController {
    
    func setViewColor() {
        colorizedView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    func setup(for sliders: UISlider...) {
        let cicolor = CIColor(color: colorForView)
        sliders.forEach {  slider in
            switch slider {
            case redSlider:
                slider.value = Float(cicolor.red)
            case greenSlider:
                slider.value = Float(cicolor.green)
            default:
                slider.value = Float(cicolor.blue)
            }
        }
        setViewColor()
    }
    
    
    func setup(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                label.text = string(from: redSlider)
            case greenValueLabel:
                label.text = string(from: greenSlider)
            default:
                label.text = string(from: blueSlider)
            }
        }
    }
    
    func setup(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField:
                textField.text = string(from: redSlider)
            case greenTextField:
                textField.text = string(from: greenSlider)
            default:
                textField.text = string(from: blueSlider)
            }
        }
    }
    
    
    func setupView() {
        colorizedView.layer.cornerRadius = view.frame.width / 15
        setViewColor()
    }
    
    func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    func showAllert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) {_ in
            textField?.text = "0.00"
            textField?.becomeFirstResponder()
        })
        present(alert, animated: true)
    }
    
}

//MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: textField, action: #selector(resignFirstResponder))
        let emptySpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([emptySpace,doneButton], animated: true)
        textField.inputAccessoryView = toolbar
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            showAllert(title: "Oops!", message: "Value can not be empty")
            return
        }
        guard let value = Float(text.replacingOccurrences(of: ",", with: ".")), (0...1).contains(value) else {
            showAllert(title: "Oops!", message: "Value must be between 0 and 1", textField: textField)
            return
        }
        
        switch textField {
        case redTextField:
            setup(for: redValueLabel)
            redSlider.setValue(value, animated: true)
        case greenTextField:
            setup(for: greenValueLabel)
            greenSlider.setValue(value, animated: true)
        default:
            setup(for: blueValueLabel)
            blueSlider.setValue(value, animated: true)
        }
        
        setViewColor()
    }
}

