//
//  SimplePageView.swift
//  lalalendo
//
//  Created by Sofia Villas Bôas on 24/04/25.
//

import SwiftUI
import AVFoundation

struct SimplePageView: View {
    @EnvironmentObject var settings: GlobalSettings
    var text: String
    var defaultImage: String //essa vai ser a imagem default, a das escolhas muda no botao
    var rightChoice: Int
    var leftChoice: Int
    var question: String
    
    var rightButtonImage: String
    var rightButtonText: String
    var leftButtonImage: String
    var leftButtonText: String
    var mainRightImage: String
    var mainLeftImage: String
    
    @State private var imageName: String = ""
    @State private var selectedButton: Int? = nil
    
    // Atualização Marlon
    private let synthesizer = AVSpeechSynthesizer()
    
    func speak(_ text: [String]) { 
            if synthesizer.isSpeaking {
                synthesizer.stopSpeaking(at: .immediate)
            } else {
                for t in text {
                    let utterance = AVSpeechUtterance(string: t)
                    utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
                    utterance.rate = 0.5 // velocidade da fala (0.0 a 1.0)\
                    utterance.postUtteranceDelay = 0.7
                    
                    synthesizer.speak(utterance)
                }
            }
        }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                ZStack(alignment: .topLeading){
                    VStack(alignment: .center, spacing: 20) {
                        Spacer()
                        Text(text)
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true) //impedir as reticencias!!!
                            .frame(alignment: .center)
                            .padding(.top, 40)
                            
                        Spacer()
                        Text(question)
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true) //impedir as reticencias!!!
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.horizontal, 50)
                            .padding(.bottom, 20)
                        
                        HStack (spacing:50) {
                            OptionButton(id: 1, title: leftButtonText, image: leftButtonImage, selectedButton: $selectedButton, onSelect: {
                                imageName = mainLeftImage
                                settings.next = leftChoice
                                selectedButton = 1
                            })
                            
                            OptionButton(id: 2, title: rightButtonText, image: rightButtonImage, selectedButton: $selectedButton,
                                         onSelect: {
                                imageName = mainRightImage
                                settings.next = rightChoice
                                selectedButton = 2
                            })
                        }.padding(.bottom, 30)
                    }
                    .padding()
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height, alignment: .center)
                    .background(.white)
                    
                    Button(action: {
                        speak([text, question, leftButtonText, rightButtonText])
                    }) {
                        Image(systemName: "speaker.wave.2.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color(red: 88/255, green: 86/255, blue: 214/255))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width * 0.5)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background((Color.black.opacity(0.25)))
            .cornerRadius(16)
        }.onAppear{
            selectedButton = 1
            imageName = defaultImage
            settings.next = leftChoice // caso nao clique em nenhum a default eh toda pra esquerda
            settings.path.append(settings.currentPage)
        }.onDisappear() {
            if synthesizer.isSpeaking {
                synthesizer.stopSpeaking(at: .immediate)
            }
        }
    }
}

struct OptionButton: View {
    @EnvironmentObject var settings: GlobalSettings
    let id: Int
    var title: String
    var image: String
    @Binding var selectedButton: Int?
    var onSelect: () -> Void
    
    struct RoundedCornerShape: Shape {
        var radius: CGFloat
        var corners: UIRectCorner
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            return Path(path.cgPath)
        }
    }
    
    var body: some View {
        Button(action: {
            onSelect()
        }) {
            VStack(alignment: .center, spacing:0) {
                Image(image)
                    .resizable()
                    .frame(width: 130, height: 130)
                    .background(Color.black.opacity(0.2))
                    .clipShape(
                        RoundedCornerShape(radius: 8, corners: [.topLeft, .topRight])
                    )
                ZStack {
                    Rectangle()
                        .fill(Color(red: 220/255, green: 231/255, blue: 249/255))
                        .frame(width: 130, height: 30)
                    
                    Text(title)
                        .foregroundColor(.black)
                }.clipShape(
                    RoundedCornerShape(radius: 8, corners: [.bottomLeft, .bottomRight])
                )
            }.overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(selectedButton == id ? Color.purple : Color.clear, lineWidth: 4)
            )
        }
    }
}
