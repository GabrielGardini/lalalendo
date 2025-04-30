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
                HStack(spacing: 0) {
                    Color.clear
                        .frame(width: geometry.size.width * 0.5)
                    
                    ZStack {
                        Image("id1 - default")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .background(Color.yellow)
                        
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 0.7, green: 0.7, blue: 1.0))
                            Text(text)
                                .font(.system(.title, design: .rounded))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 0.60 * 0.5 * geometry.size.width ,
                               height: 0.25 * geometry.size.height)
                        .offset(x: 0.05 * 0.5 * geometry.size.width,
                                y: -0.5 * geometry.size.height + 0.18 * geometry.size.height )
                        
                    }
                    .frame(width: geometry.size.width * 0.5,
                            height: geometry.size.height)
                }
            }
        }
        .background(Color.clear)
        .onAppear {
            settings.next = 1
        }
    }
}
