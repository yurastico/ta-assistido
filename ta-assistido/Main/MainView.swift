//
//  MainView.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 18/10/23.
//

import SwiftUI

struct MainView: View {
    @AppStorage(AppStorageKeys.color) private var color = 0
    var body: some View {
        TabView {
            MoviesView()
                .tabItem {
                    Label("Filmes",systemImage: "movieclapper.fill")
                }
            MapView()
                .tabItem { Label("Mapa",systemImage: "map.fill") }
            SettingsView()
                .tabItem { Label("Ajustes",systemImage: "gearshape") }
        }
        .accentColor(ColorHelper.colorFor(index: color))
    }
}

#Preview {
    MainView()
}
