//
//  FinalPageView.swift
//  lalalendo
//
//  Created by Sofia Villas Bôas on 24/04/25.
//

import SwiftUI
import AVFoundation

struct FinalPageView: View {
    @EnvironmentObject var settings: GlobalSettings
    var text: String
    var defaultImage: String //essa vai ser a imagem default, a das escolhas muda no botao
    var leftChoice: Int
    
    @State private var imageName: String = ""
    
    private let synthesizer = AVSpeechSynthesizer()
    
    func speak(_ text: String) {
            if synthesizer.isSpeaking {
                synthesizer.stopSpeaking(at: .immediate)
            } else {
                let utterance = AVSpeechUtterance(string: text)
                utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
                utterance.rate = 0.5 // velocidade da fala (0.0 a 1.0)\
                utterance.postUtteranceDelay = 0.7
                
                synthesizer.speak(utterance)
            }
        }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                ZStack(alignment: .topLeading){
                    VStack(alignment: .center, spacing: 20){
                        Text(text)
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height, alignment: .center)
                    
                    Button(action: {
                        speak(text)
                    }) {
                        Image(systemName: "speaker.wave.2.fill") // ou "mic.fill", "waveform", etc
                            .font(.largeTitle)
                            .foregroundColor(Color(red: 88/255, green: 86/255, blue: 214/255))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
                .padding()
                .frame(width: geometry.size.width * 0.5, height: geometry.size.height, alignment: .center)
                .background(.white)
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width * 0.5 )
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background((Color.black.opacity(0.25)))
            .cornerRadius(16)
            
            
        }.onAppear{
            imageName = defaultImage
            settings.next = leftChoice // caso nao clique em nenhum a default eh toda pra esquerda
            settings.path.append(settings.currentPage)
        }
    }
}
