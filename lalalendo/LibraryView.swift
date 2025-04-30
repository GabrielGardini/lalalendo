//
//  LibraryView.swift
//  lalalendo
//
//  Created by Aluno 40 on 30/04/25.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("fundo home")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Text("Biblioteca")
                    .font(.system(size: 60))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(UIColor.secondaryLabel))
                    .padding(.top, 50)
                    
                Divider()
                
                // outros elementos aqui...
            }
        }
    }
}
