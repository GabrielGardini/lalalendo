//
//  BackCoverVIew.swift
//  lalalendo
//
//  Created by Sofia Villas Bôas on 24/04/25.
//

import SwiftUI

struct BackCoverView: View {
    @EnvironmentObject var settings: GlobalSettings
    var text: String
    var imageName: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Fundo inteiro com a mesma cor do background geral
                
                HStack(spacing: 0) {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width * 0.5)
                        .clipped()
                    Color.clear
                        .frame(width: geometry.size.width * 0.5)
                }
                
                Text("Você chegou ao fim da história!")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.5)
                    .position(x: geometry.size.width * 0.75, y: geometry.size.height / 2)
            }
            .onAppear{
                settings.path.append(settings.currentPage)
            }
        }.background(Color.clear)
    }
}

