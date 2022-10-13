//
//  ContentView.swift
//  VikingApp
//
//  Created by Daniel Cech on 13.10.2022.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var firstText: String = ""
    
    @State var secondText: String = ""
    
    let synth = AVSpeechSynthesizer()
    
    var body: some View {
        ZStack {
            Image(uiImage: UIImage(named: "wallpaper")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text(firstText)
                    .padding()
                    .background(.white.opacity(0.5))
                    .clipShape(Capsule())
                
                Button("Tah vlka") {
                    firstPlayerTurn()
                }
                .padding()
                .background(Color(red: 0, green: 0, blue: 0.5))
                .clipShape(Capsule())
                
                Spacer()
                
                Text(secondText)
                    .padding()
                    .background(.white.opacity(0.5))
                    .clipShape(Capsule())
                
                Button("Tah draka") {
                    secondPlayerTurn()
                }
                .padding()
                .background(Color(red: 0, green: 0, blue: 0.5))
                .clipShape(Capsule())
                
                Spacer()
                
            }
            .padding()
        }
    }
}

private extension ContentView {
    func firstPlayerTurn() {
        firstText = generateTurn(playerNumber: 1)
        speakText(text: firstText, playerNumber: 1)
    }
    
    
    func secondPlayerTurn() {
        secondText = generateTurn(playerNumber: 2)
        speakText(text: secondText, playerNumber: 2)
    }
    
    func generateTurn(playerNumber: Int) -> String {
        var text = (playerNumber == 1) ? "Vlk" : "Drak"
        
        switch [0, 1, 2, 3].randomElement() {
        case 0:
            text += " stojí"
            return text
        case 1:
            text += ", jeden krok "
        case 2:
            text += ", dva kroky "
        case 3:
            text += ", tři kroky "
        default:
            break
        }
        
        text += ["doleva.", "dopředu.", "doprava."].randomElement() ?? "doprava."
        
        return text
    }
    
    func speakText(text: String, playerNumber: Int) {
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
//        }
//        catch let error as NSError {
//            print("Error: Could not set audio category: \(error), \(error.userInfo)")
//        }
//
//        do {
//            try AVAudioSession.sharedInstance().setActive(true)
//        }
//        catch let error as NSError {
//            print("Error: Could not setActive to true: \(error), \(error.userInfo)")
//        }
        
        let utterance = AVSpeechUtterance(string: text)
        //utterance.voice = AVSpeechSynthesisVoice(identifier: "Zuzana")  //
        
        utterance.voice = AVSpeechSynthesisVoice(language: "cs-CZ")
        utterance.pitchMultiplier = (playerNumber == 1) ? 1 : 0.5

        
        synth.speak(utterance)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
