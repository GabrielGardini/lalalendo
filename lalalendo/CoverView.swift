//
//  CoverView.swift
//  lalalendo
//
//  Created by Sofia Villas Bôas on 24/04/25.
//

import SwiftUI

struct CoverView: View {
    @EnvironmentObject var settings: GlobalSettings
    var text: String
    var imageName: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Fundo inteiro com a mesma cor do background geral
                
                HStack(spacing: 0) {
                    Color.clear
                        .frame(width: geometry.size.width * 0.5)
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width * 0.5)
                        .clipped()
                                
                }.background(Color.clear)
            }.background(Color.clear)
        }.onAppear{
        settings.next = 1;
        }.background(Color.clear);
    }
}
