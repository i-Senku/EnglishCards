//
//  Helper.swift
//  englishcard
//
//  Created by Ercan on 21.05.2020.
//  Copyright © 2020 Ercan. All rights reserved.
//

import Foundation
import AVFoundation

var synthesizer = AVSpeechSynthesizer()

func readText(content : String){
    
    let speechUtterance = AVSpeechUtterance(string: content)
    speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-EN")
    speechUtterance.rate = 0.4
    synthesizer.speak(speechUtterance)
    
}

