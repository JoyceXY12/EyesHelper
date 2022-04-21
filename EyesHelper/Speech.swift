//
//  Speech.swift
//  EyesHelper
//
//  Created by joyce huang on 2022-04-13.
//

/*
import Foundation
import AVKit

class Speech{
    let speechSynthesizer = AVSpeechSynthesizer()
    func startSpeech(_ text: String){
        if let language = NSLinguisticTagger.dominantLanguage(for: text){
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: language)
            speechSynthesizer.speak(utterance)
        }
    }
}
 */


import Foundation
import AVKit

class Speech {
    let speechSynthesizer = AVSpeechSynthesizer()
    
    func startSpeech(_ text: String){
        if let language = NSLinguisticTagger.dominantLanguage(for: text){
            
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: language)
            speechSynthesizer.speak(utterance)
        }
    }
    
    
    
}

