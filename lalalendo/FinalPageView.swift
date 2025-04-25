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
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
        utterance.rate = 0.5 // velocidade da fala (0.0 a 1.0)
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack(alignment: .center, spacing: 20) {
                    Text(text)
                        .font(.title)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Text("pergunta")
                        .font(.title)
                        .foregroundColor(.black)
                    
                }
                .padding()
                .frame(width: geometry.size.width * 0.5, alignment: .center)
                .background(.clear)
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width * 0.5 )
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.red)
            .cornerRadius(16)
        }.onAppear{
            imageName = defaultImage
            settings.next = leftChoice // caso nao clique em nenhum a default eh toda pra esquerda
            settings.path.append(settings.currentPage)
        }
    }
}
