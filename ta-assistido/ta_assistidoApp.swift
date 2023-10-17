//
//  ta_assistidoApp.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 11/10/23.
//
import SwiftData
import SwiftUI

@main
struct ta_assistidoApp: App {
    var body: some Scene {
        WindowGroup {
            MoviesView()
        }
        .modelContainer(for: Movie.self)
    }
}
