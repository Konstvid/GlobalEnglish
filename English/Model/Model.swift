//
//  Model.swift
//  English
//
//  Created by Andrey on 27.07.2021.
//

import UIKit
import AVFoundation

struct WordEnglish: Codable{
    var imageWord: String = "anatomy"
    var mainWord: String
    var words: [Translate]
}

struct Translate: Codable {
    var proiznoshenie: String
    var wordEnd: String
    var translatesWord: String
}



struct  Question {
    var question: String
    var answer: String
}


struct Grammar: Codable {
    var infoFuture: String
    var imageGrammar: String = "anatomy"
    var infoText: String
    var texttInfo: String
    var wordMarker: String
    var exampleWord: String
    var mainGrammari: String
    var mainGr: String
    var negativeGRammar: String
    var negativeInfo: String
    var questionInfo: String
    var questionsInfo: String
}

enum Sound: String {
    case win = "gamewin"
    case falseGame = "gamefalse"
}

struct PlayGame {
    
   private static var player : AVAudioPlayer?
    
        static func labelAnime(label: UILabel) {
            label.transform = CGAffineTransform.init(scaleX: 0.3, y: 0.3)
            UIView.animate(withDuration: 1.5, animations: { () -> Void in
                label.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            })
        }

        static func playSound(sound: Sound) {
            let path = Bundle.main.path(forResource: sound.rawValue, ofType: "mp3")!
            let url = URL(fileURLWithPath: path)
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                print(error.localizedDescription)
            }
        }
    
    
    
}
