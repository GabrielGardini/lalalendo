//
//  LibraryView.swift
//  lalalendo
//
//  Created by Aluno 40 on 30/04/25.
//

import SwiftUI

struct LibraryView: View {
    let imagens = ["capa livro frente", "capa livro frente", "capa livro frente", "capa livro frente", "capa livro frente"] // Array de nomes das imagens.
    @State private var currentIndex: Int = 0
    
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
                            .foregroundColor(Color(UIColor.secondaryLabel))
                            .padding(.top, 90)
                            .padding(.leading, 40)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                            .frame(height: 1)
                            .background(Color.gray.opacity(0.5))
                            .padding(.horizontal, 40)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 40) {
                                ForEach(imagens.indices, id: \.self) { index in
                                    NavigationLink(destination: ContentView()) {
                                        Image(imagens[index])
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 300)
                                            .cornerRadius(15)
                                            .shadow(radius: 5)
                                            .buttonStyle(PlainButtonStyle()) // Para evitar a animação padrão do botão
                                    }
                                }
                            }
                        }.padding(.leading, 40)
                            .padding(.top)
                        
                        
                        Text("Meus livros")
                            .font(.system(size: 60))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                            .padding(.leading, 40)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                            .frame(height: 1)
                            .background(Color.gray.opacity(0.5))
                            .padding(.horizontal, 40)
                        
                        
                    }.navigationBarTitleDisplayMode(.inline)
                    .navigationBarHidden(true)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

//
//struct LoginView: View {
//    @State private var currentIndex: Int = 0 // Índice da imagem atual.
//    let imagens = ["capa livro frente", "capa livro frente", "capa livro frente", "capa livro frente", "capa livro frente"] // Array de nomes das imagens.
//
//    var body: some View {
//        NavigationView{
//            ZStack(alignment: .topLeading) {
//                Image("fundo home")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//
//                VStack {
//                    Text("Biblioteca")
//                        .font(.system(size: 60))
//                        .fontWeight(.semibold)
//                        .foregroundColor(Color(UIColor.secondaryLabel))
//                        .padding(.top, 90)
//                        .padding(.leading, 40)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//
//                    Divider()
//                        .frame(height: 1)
//                        .background(Color.gray.opacity(0.5))
//                        .padding(.horizontal, 40)
//
//                    // ScrollView para a lista de livros
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 40) {
//                            ForEach(imagens.indices, id: \.self) { index in
//                                NavigationLink(destination: ContentView()) {
//                                    Image(imagens[index])
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(height: 300)
//                                        .cornerRadius(15)
//                                        .shadow(radius: 5)
//                                }
//                                .buttonStyle(PlainButtonStyle()) // Para evitar a animação padrão do botão
//                            }
//                        }
//                    }
//
//                    Text("Meus livros")
//                        .font(.system(size: 60))
//                        .fontWeight(.semibold)
//                        .foregroundColor(Color(UIColor.secondaryLabel))
//                        .padding(.leading, 40)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//
//                    Divider()
//                        .frame(height: 1)
//                        .background(Color.gray.opacity(0.5))
//                        .padding(.horizontal, 40)
//                    
//                    // ScrollView para a lista de livros
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 40) {
//                            ForEach(imagens.indices, id: \.self) { index in
//                                NavigationLink(destination: ContentView()) {
//                                    Image(imagens[index])
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(height: 300)
//                                        .cornerRadius(15)
//                                        .shadow(radius: 5) // Sombra para melhorar a aparência do livro
//                                }
//                                .buttonStyle(PlainButtonStyle()) // Para evitar a animação padrão do botão
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}

