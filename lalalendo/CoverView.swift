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
            HStack(spacing: 0) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height)
                    .background(Color.teal)
                    .clipped()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.brown.opacity(0.2))
            .cornerRadius(16)
        }.onAppear{
            settings.next = 1
        }
    }
}
