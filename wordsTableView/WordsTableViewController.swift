//
//  WordsTableViewController.swift
//  English
//
//  Created by Andrey on 27.07.2021.
//

import UIKit

class WordsTableViewController: UIViewController {

    @IBOutlet var topicLabel: UILabel!
    @IBOutlet var wordTableView: UITableView!
    
    var words: [Translate] = []
    var textTopic = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.sharet.isWhite = UserDefaults.standard.bool(forKey: "Tema")
        wordTableView.delegate = self
        wordTableView.dataSource = self
        topicLabel.text = textTopic
        topicLabel.textColor = DataService.sharet.isWhite ? .black : .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkTema()
        wordTableView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    //Dark Window
    func checkTema(){
        let isWhite = DataService.sharet.isWhite
        if isWhite {
            self.view.backgroundColor = .white
            wordTableView.backgroundColor = .white
        }else{
            self.view.backgroundColor = .black
            wordTableView.backgroundColor = .black
        }
    }
    
    @IBAction func wordButtonAction(_ sender: UIButton) {
        let favorites = DataService.sharet.favorites
        DataService.saveTasks(data: favorites)
        self.dismiss(animated: true, completion: nil)
    }
}

extension WordsTableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.selectionStyle = .none
        let word = words [indexPath.row]
        let isWhite = DataService.sharet.isWhite
        
        cell.backgroundColor = isWhite ? .white : .black
        cell.textLabel?.font = .systemFont(ofSize: 20)
        cell.textLabel?.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        //Color label
        cell.detailTextLabel?.textColor = isWhite ? .black : .yellow
        cell.textLabel?.text = word.wordEnd
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.font = .italicSystemFont(ofSize: 19)
        cell.detailTextLabel?.text = "\(word.translatesWord) \n\(word.proiznoshenie)"
        return cell
    }
 
    func favoriteProperty(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "Добавить в Избранное") { [self] (action, view, complition) in
            DataService.sharet.favorites.append(words [indexPath.row])
            self.wordTableView.reloadRows(at: [indexPath], with: .fade)
            topicLabel.text = "\(words[indexPath.row].wordEnd) \nДобавлено в Избранное"
        }
        
        action.backgroundColor = .blue
        return action
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = favoriteProperty(at: indexPath)
        return UISwipeActionsConfiguration(actions: [favorite])
    }
}
