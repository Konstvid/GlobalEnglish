//
//  ViewController.swift
//  English
//
//  Created by Andrey on 27.07.2021.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet var mainTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var nameLabel: UILabel!
    
    var englishWord: [WordEnglish] = []
    var englishWord_: [WordEnglish] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.sharet.isWhite = UserDefaults.standard.bool(forKey: "Tema")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        searchBar.delegate = self
        searchBar.searchTextField.placeholder = "Найти"
        englishWord = Start().getArray()
        englishWord_ = englishWord
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    // For hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // For press return keyb
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        return(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkTema()
        mainTableView.reloadData()
    }

    func checkTema(){
        let isWhite = DataService.sharet.isWhite
        if isWhite {
            self.view.backgroundColor = .white
            mainTableView.backgroundColor = .white
            searchBar.searchTextField.backgroundColor = .white
            searchBar.barTintColor = .gray
            searchBar.tintColor = .black
            searchBar.searchTextField.textColor = .black
            nameLabel.textColor = .black
        }else{
            self.view.backgroundColor = .black
            mainTableView.backgroundColor = .black
            searchBar.searchTextField.backgroundColor = .white
            searchBar.barTintColor = .black
            searchBar.tintColor = .black
            searchBar.searchTextField.textColor = .black
            nameLabel.textColor = .white
        }
    }
    
    @IBAction func choiceButton(_ sender: Any) {
        let choice = StartWordsViewController()
        choice.modalPresentationStyle = .fullScreen
        self .present(choice, animated: true, completion: nil)
        
    }
    
    @IBAction func gameButton(_ sender: UIButton) {
        let setting = GameViewController()
        setting.modalPresentationStyle = .fullScreen
        self .present(setting, animated: true, completion: nil)
        
    }
    
    @IBAction func settinButtonAction(_ sender: Any) {
        let setting = SettingViewController()
        setting.modalPresentationStyle = .fullScreen
        self .present(setting, animated: true, completion: nil)
    }
    
    @IBAction func grammarButtonAction(_ sender: Any) {
        let setting = grammarViewController()
        setting.modalPresentationStyle = .fullScreen
        self .present(setting, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    //Quantity cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        englishWord.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        let isWhite = DataService.sharet.isWhite
        cell.backgroundColor = isWhite ? .white : .black
        cell.textLabel?.textColor = isWhite ? .black : .white
        // Text and picture cell
        cell.textLabel?.text = englishWord[indexPath.row].mainWord
        cell.imageView?.image = UIImage(named: englishWord[indexPath.row].imageWord)
        return cell
    }
    
    // Next cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let words = englishWord[indexPath.row].words
        let vc = WordsTableViewController()
        vc.textTopic = englishWord[indexPath.row].mainWord
        vc.words = words
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
     //Setting searchbar
    extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        englishWord = englishWord_
        searchBar.tintColor = DataService.sharet.isWhite ? .black : .white
        if searchText.isEmpty == false{
            englishWord = englishWord_ .filter({$0.mainWord.lowercased().contains(searchText.lowercased())})
        }
        mainTableView.reloadData()
    }
}
