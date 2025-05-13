//
//  LibraryView.swift
//  lalalendo
//
//  Created by Aluno 40 on 30/04/25.
//

import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

struct LibraryView: View {
    let imagens = ["capa livro frente", "capa-rainbow", "capa-floresta", "capa-mermaid", "capa-dragons", "capa-fadas"] // Array de nomes das imagens.
    @State private var currentIndex: Int = 0
    let columns = [GridItem(.flexible(minimum: 300, maximum: 350)), GridItem(.flexible(minimum: 300, maximum: 350)), GridItem(.flexible(minimum: 300, maximum: 350))]
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .topLeading) {
                Image("fundo home")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Text("Biblioteca")
                            .font(.system(size: 60))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hex: 0x525252, opacity: 1))
                            .padding(.top, 90)
                            .padding(.leading, 40)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                            .frame(height: 1)
                            .background(Color.gray.opacity(0.5))
                            .padding(.horizontal, 40)
                        
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(imagens.indices, id: \.self) { index in
                                    NavigationLink(destination: ContentView()) {
                                        Image(imagens[index])
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 300)
                                            .shadow(radius: 5)
                                    }
                                }
                            }.padding(.top, 20)
                        
//
//                        Text("Meus livros")
//                            .font(.system(size: 60))
//                            .fontWeight(.semibold)
//                            .foregroundColor(Color(hex: 0x525252, opacity: 1))
//                            .padding(.leading, 40)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//
//                        Divider()
//                            .frame(height: 1)
//                            .background(Color.gray.opacity(0.5))
//                            .padding(.horizontal, 40)
//
                        
                    }.navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
 
