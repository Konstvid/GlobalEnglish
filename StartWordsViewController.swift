//
//  StartWordsViewController.swift
//  English
//
//  Created by Andrey on 08.08.2021.
//

import UIKit

class StartWordsViewController: UIViewController {

    @IBOutlet var startWords: UITableView!
    @IBOutlet var topicLabel: UILabel!
    
    var words: [Translate] = []
    var textTopic = "Избранное"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.sharet.isWhite = UserDefaults.standard.bool(forKey: "Tema")
        startWords.delegate = self
        startWords.dataSource = self
        topicLabel.text = textTopic
        topicLabel.textColor = DataService.sharet.isWhite ? .black : .white
        words = DataService.sharet.favorites
        if let taskArray = DataService.loadTasks(){
            words = taskArray
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkTema()
        startWords.reloadData()
    }
    
    func checkTema(){
        let isWhite = DataService.sharet.isWhite
        if isWhite {
            self.view.backgroundColor = .white
            startWords.backgroundColor = .white
        }else{
            self.view.backgroundColor = .black
            startWords.backgroundColor = .black
        }
    }
    
    @IBAction func wordsButtonBack(_ sender: UIButton) {
        DataService.saveTasks(data: self.words)
        DataService.sharet.favorites = words
        self.dismiss(animated: true, completion: nil)
    }
    }

extension StartWordsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.selectionStyle = .none
        let word = words [indexPath.row]
        let isWhite = DataService.sharet.isWhite
    
        cell.backgroundColor = isWhite ? .white : .black
        cell.textLabel?.textColor = isWhite ? .black :.white
        cell.detailTextLabel?.textColor = isWhite ? .black :.yellow
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        cell.textLabel?.text = word.wordEnd
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.font = .italicSystemFont(ofSize: 19)
        cell.detailTextLabel?.text = "\(word.translatesWord) \n\(word.proiznoshenie)"
        
        return cell
}
    
    //Swipe left
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deliteProperty(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    //Swipe right
     func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deliteProperty(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
 
    func deliteProperty(indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Удалить") { (action, view, completion) in
            self.words.remove(at: indexPath.row)
            self.startWords.reloadData()
        }
        action.backgroundColor = .red 
        return action
    }
}
