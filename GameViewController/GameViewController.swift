//
//  GameViewController.swift
//  English
//
//  Created by Andrey on 22.08.2021.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var notQuestionLabel: UILabel!
    @IBOutlet var okQuestionLabel: UILabel!
    @IBOutlet var textAnswerText: UITextField!
    @IBOutlet var checkButtonOu: UIButton!
    @IBOutlet var nextButtonOu: UIButton!
    @IBOutlet var oneAnswer: UIButton!
    @IBOutlet var twoAnswer: UIButton!
    @IBOutlet var threeAnswer: UIButton!
    @IBOutlet var fourAnswer: UIButton!
    
    var questions: [Question] = []
    var element: Question!
    var answerForButton: [String] = []
    var questionNumber: Int = 0
    var trueAnswer = false
    var countQuestions = 0
    var trueAnswerCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textAnswerText.delegate = self
        questions = Start().questions.shuffled()
        element = questions.first
        questionLabel.text = "Как переводится \n \(element.question)"
        okQuestionLabel.text = ""
        notQuestionLabel.text = ""
        questionLabel.textColor = DataService.sharet.isWhite ? .black : .white
        settingForButton(button: oneAnswer, color: .orange)
        
        textAnswerText.attributedPlaceholder  = NSAttributedString(string: "Правильное слово", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        textAnswerText.layer.borderWidth = 3
        textAnswerText.layer.borderColor = UIColor.red.cgColor
        textAnswerText.layer.cornerRadius = textAnswerText.frame.height/2
        textAnswerText.layer.masksToBounds = true
        textAnswerText.tintColor = .black
        textAnswerText.textColor = .black
        
        settingForButton(button: twoAnswer, color: .red)
        settingForButton(button: threeAnswer, color: .gray)
        settingForButton(button: fourAnswer, color: .blue)
        settingForButton(button: nextButtonOu, color: .systemPink)
        settingForButton(button: checkButtonOu, color: .blue)
        fullButton()
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
        textAnswerText.resignFirstResponder()
        return(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkTema()
    }

    func settingForButton(button:UIButton, color: UIColor) {
        button.backgroundColor = color
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
    }
    
    func checkTema(){
        let isWhite = DataService.sharet.isWhite
        if isWhite {
            self.view.backgroundColor = .white
            self.textAnswerText.backgroundColor = .white
            self.textAnswerText.layer.borderColor = UIColor.lightGray.cgColor
        }else{
            self.view.backgroundColor = .black
            self.view.backgroundColor = .black
            self.textAnswerText.backgroundColor = .white
        }
    }
 
    func checkAnswer() {
        trueAnswer = true
        if textAnswerText.text?.lowercased() == element.answer.lowercased(){
            okQuestionLabel.text = "Верно"
            notQuestionLabel.text = ""
            trueAnswerCount += 1
        }else{
            okQuestionLabel.text = "Правильный ответ \n  \(element.answer)"
            notQuestionLabel.text = "Не верно"
        }
    }
    
    func checkAnswerForButton(button: UIButton) {
        trueAnswer = true
        if button.currentTitle?.lowercased() == element.answer.lowercased(){
            okQuestionLabel.text = "Верно"
            PlayGame.labelAnime(label: okQuestionLabel)
            notQuestionLabel.text = ""
            trueAnswerCount += 1
            PlayGame.playSound(sound: Sound.win)
        }else{
            okQuestionLabel.text = "Правильный ответ \n  \(element.answer)"
            notQuestionLabel.text = "Не верно"
            PlayGame.labelAnime(label: notQuestionLabel)
            PlayGame.playSound(sound: Sound.falseGame)
        }
    }
    
    func goToNextQuestion(){
        questionNumber += 1
        countQuestions += 1
        if questionNumber == questions.count {
            questionNumber = 0
            questions = questions.shuffled()
        }
        element = questions[questionNumber]
        questionLabel.text = "Как переводится \n \(element.question)"
        okQuestionLabel.text = ""
        notQuestionLabel.text = ""
        textAnswerText.text = nil
        trueAnswer = false
        fullButton()
    }
    
    func fullMassiv(){
        answerForButton = []
        answerForButton.append(element.answer) // Добавление правильного ответа
        let questions_ = questions.shuffled()
        for item in questions_{
            if !answerForButton.contains(item.answer) {
                answerForButton.append(item.answer)
                if answerForButton.count == 4 {
                    return
                }
            }
        }
    }
    
    func fullButton(){
        fullMassiv()
       answerForButton = answerForButton.shuffled()
        oneAnswer.setTitle(answerForButton[0], for: .normal)
        twoAnswer.setTitle(answerForButton[1], for: .normal)
        threeAnswer.setTitle(answerForButton[2], for: .normal)
        fourAnswer.setTitle(answerForButton[3], for: .normal)
    }
    
    @IBAction func buttonBackAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkQuestionActionButton(_ sender: UIButton) {
        checkAnswer()
    }
    
    @IBAction func nextButtonQuestion(_ sender: UIButton) {
        if trueAnswer == true{ goToNextQuestion() }
    }
    
    @IBAction func oneAnswerTap(_ sender: UIButton) {
        checkAnswerForButton(button: sender)
    }
    
    @IBAction func twoAnswerTap(_ sender: UIButton) {
        checkAnswerForButton(button: sender)
    }
    
    @IBAction func threeAnswerTap(_ sender: UIButton) {
        checkAnswerForButton(button: sender)
    }
    
    @IBAction func fourAnswerTap(_ sender: UIButton) {
        checkAnswerForButton(button: sender)
    }
}
