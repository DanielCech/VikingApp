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
    
    @State var freeText: String = ""
    
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
                
                Text(freeText)
                    .padding()
                    .background(.white.opacity(0.5))
                    .clipShape(Capsule())
                
                Button("Volný pohyb") {
                    freeTurn()
                }
                .padding()
                .background(Color(red: 0, green: 0.5, blue: 0))
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
    
    func freeTurn() {
        freeText = generateFreeTurn()
        speakText(text: freeText, playerNumber: 2)
    }
    
    func generateTurn(playerNumber: Int) -> String {
        var text = (playerNumber == 1) ? "Vlk" : "Drak"
        
        if Int.random(in: 0 ..< 7) == 0 {
            text += " stojí"
            return text
        }
        
        switch [1, 2, 3].randomElement() {
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
    
    
    func generateFreeTurn() -> String {
        var text = ""
                
        switch [1, 2, 3].randomElement() {
        case 1:
            text += "Jeden krok "
        case 2:
            text += "Dva kroky "
        case 3:
            text += "Tři kroky "
        default:
            break
        }
        
        text += ["doleva.", "dopředu.", "doprava.", "dozadu."].randomElement() ?? ""
        
        return text
    }
    
    
    func speakText(text: String, playerNumber: Int) {
        
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
