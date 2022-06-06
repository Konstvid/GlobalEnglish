//
//  grammarViewController.swift
//  English
//
//  Created by Andrey on 12.08.2021.
//

import UIKit

class grammarViewController: UIViewController {
    
    @IBOutlet var tableGrammar: UITableView!
    
    var infoArray: [Grammar] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableGrammar.delegate = self
        tableGrammar.dataSource = self
        tableGrammar.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "grammar")
        infoArray = Start().grammariArray
        tableGrammar.separatorStyle = .none
        checkTema()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableGrammar.reloadData()
    }
    
    func checkTema(){
        let isWhite = DataService.sharet.isWhite
        if isWhite {
            self.view.backgroundColor = .white
            tableGrammar.backgroundColor = .white
        }else{
            self.view.backgroundColor = .black
            tableGrammar.backgroundColor = .black
        }
    }
    
    @IBAction func actionButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension grammarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        infoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "grammar") as! InfoTableViewCell
        cell.selectionStyle = .none
        let info = infoArray[indexPath.row]
        cell.configCell(info: info)
        return cell
    }
    
    // Next cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let information = infoArray[indexPath.row]
        let vc = InformationViewController()
        vc.info = information
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
