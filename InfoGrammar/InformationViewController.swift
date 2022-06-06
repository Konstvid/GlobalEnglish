//
//  InformationViewController.swift
//  English
//
//  Created by Andrey on 13.09.2021.
//

import UIKit

class InformationViewController: UIViewController {
    
    @IBOutlet var labelTopic: UILabel!
    @IBOutlet var labelText: UILabel!
    @IBOutlet var maintextLabel: UILabel!
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var exampleLabel: UILabel!
    @IBOutlet var mainGrammar: UILabel!
    @IBOutlet var mainGrammarLabel: UILabel!
    @IBOutlet var negativeGrammarLabel: UILabel!
    @IBOutlet var negativeLabelInformation: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var questionInformation: UILabel!
    
    var info: Grammar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTopic.text = info.infoFuture
        labelText.text = info.infoText
        labelText.font = UIFont.boldSystemFont(ofSize: 18.0)
        wordLabel.text = info.wordMarker
        wordLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        exampleLabel.text = info.exampleWord
        mainGrammar.text = info.mainGrammari
        mainGrammarLabel.text = info.mainGr
        negativeGrammarLabel.text =  info.negativeGRammar
        negativeGrammarLabel.font = UIFont.boldSystemFont(ofSize: 18)
        negativeLabelInformation.text = info.negativeInfo
        questionLabel.text = info.questionInfo
        questionLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        questionInformation.text = info.questionsInfo
        mainGrammar.font = UIFont.boldSystemFont(ofSize: 18)
        maintextLabel.text = info.texttInfo
        checkTema()
        labelTopic.textColor = DataService.sharet.isWhite ? .black : .white
        labelText.textColor = DataService.sharet.isWhite ? .black : .white
        maintextLabel.textColor = DataService.sharet.isWhite ? .black : .white
        wordLabel.textColor = DataService.sharet.isWhite ? .black : .white
        exampleLabel.textColor = DataService.sharet.isWhite ? .black : .white
        mainGrammar.textColor = DataService.sharet.isWhite ? .black : .white
        mainGrammarLabel.textColor = DataService.sharet.isWhite ? .black : .white
        negativeGrammarLabel.textColor = DataService.sharet.isWhite ? .black : .white
        negativeLabelInformation.textColor = DataService.sharet.isWhite ? .black : .white
        questionLabel.textColor =  DataService.sharet.isWhite ? .black : .white
        questionInformation.textColor = DataService.sharet.isWhite ? .black : .white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func checkTema(){
        let isWhite = DataService.sharet.isWhite
        if isWhite {
            self.view.backgroundColor = .white
        }else{
            self.view.backgroundColor = .black
        }
    }
    
    @IBAction func buttonBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
