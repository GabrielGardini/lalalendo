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
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
        utterance.rate = 0.5 // velocidade da fala (0.0 a 1.0)
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func newPageSetup ( ) {
        imageName = defaultImage
        settings.next = leftChoice // caso nao clique em nenhum a default eh toda pra esquerda
        //settings.path.append(settings.currentPage)
        //settings.choices.append(0)
    }
    
    func previousChoiceSetup( ) {
        
        guard settings.choices.count > 0 else {return}
        
        let previousChoice = settings.choices[settings.path.count - 2]
        print(previousChoice)
        switch previousChoice {
        case 1:
            imageName = mainLeftImage
            settings.next = leftChoice
            selectedButton = 1
        case 2:
            imageName = mainRightImage
            settings.next = rightChoice
            selectedButton = 2
        default:
            imageName = defaultImage
            settings.next = leftChoice
            selectedButton = nil
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack(alignment: .center, spacing: 20) {
                    Button(action: {
                        speak(text + question + leftButtonText + rightButtonText)
                    }) {
                        ZStack {
                            Image(systemName: "speaker.wave.2.fill") // ou "mic.fill", "waveform", etc
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 88/255, green: 86/255, blue: 214/255))
                        }
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                    Spacer()
                    Text(text)
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    Text(question)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    
                    HStack (spacing:20){
                        OptionButton(id: 1, title: "Opção 1", image: leftButtonImage, selectedButton: $selectedButton,
                            onSelect: {
                                imageName = mainLeftImage
                                settings.next = leftChoice
                                selectedButton = 1
                            
                                //settings.choices.append(1)
                            
                        })
                        
                        
                        OptionButton(id: 2, title: "Opção 1", image: rightButtonImage, selectedButton: $selectedButton,
                            onSelect: {
                                imageName = mainRightImage
                                settings.next = rightChoice
                                selectedButton = 2
                              //  settings.choices.append(2)
                        })
                    }
                    Spacer()
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
                .background(Color.black)
                .cornerRadius(16)
            }.onAppear{
               // imageName = defaultImage
                settings.next = leftChoice // caso nao clique em nenhum a default eh toda pra esquerda
                settings.path.append(settings.currentPage)
                
//                settings.choices.append(0)
//                let goingBack = settings.path.count < settings.choices.count
//                if goingBack {
//                    previousChoiceSetup()
//                }
//                else {
//                    newPageSetup()
//                }
                
                print(settings.path)
                print(settings.choices)
                print("==========")
                if settings.path.count == settings.choices.count + 2 {
                    newPageSetup()
                }
                else {
                    previousChoiceSetup()
                }
                print(settings.path)
                print(settings.choices)
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
                    
                    Text("texto do botao")
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
