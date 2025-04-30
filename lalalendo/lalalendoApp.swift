//
//  lalalendoApp.swift
//  lalalendo
//
//  Created by Aluno 15 on 15/04/25.
//

import SwiftUI

@main
struct lalalendoApp: App {
    var settings = GlobalSettings()

    var body: some Scene {
        WindowGroup {
            LibraryView()
//            ContentView()
//                .environmentObject(settings)
        }
    }
}
