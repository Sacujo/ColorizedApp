//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Igor Guryan on 10.10.2024.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setColor(_ color: UIColor)
}

final class MainViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsViewController = segue.destination as? SettingsViewController else { return }
        settingsViewController.delegate = self
        settingsViewController.colorForView = view.backgroundColor
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
