//
//  settingViewController.swift
//  English
//
//  Created by Andrey on 13.08.2021.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var labelTema: UILabel!
    @IBOutlet var switchTema: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchTema.isOn = !DataService.sharet.isWhite
        changeTema()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }

    func changeTema() {
        if switchTema .isOn {
            self.view.backgroundColor = .black
            labelTema.textColor = .white
            labelTema.text = "Темная тема"
            DataService.sharet.isWhite = false
            UserDefaults.standard.set(false, forKey: "Tema")
        } else {
            self.view.backgroundColor = .white
            labelTema.textColor = .black
            labelTema.text = "Светлая тема"
            UserDefaults.standard.set(true, forKey: "Tema")
            DataService.sharet.isWhite = true
        }
    }

    @IBAction func switchAction(_ sender: UISwitch) {
     changeTema()
    }
    
    @IBAction func buttonSetting(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
