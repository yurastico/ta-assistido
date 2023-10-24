//
//  SettingsView.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 18/10/23.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(AppStorageKeys.color) private var color = 0
    @AppStorage(AppStorageKeys.autoplay) private var autoplay = false
    @AppStorage(AppStorageKeys.category) private var category = ""
   
    var body: some View {
        Form {
            Section("Esquema de cores") {
                Picker("Qual sua cor favorita?", selection: $color) {
                    Text("Azul")
                        .tag(0)
                    Text("Laranja")
                        .tag(1)
                    Text("Roxo")
                        .tag(2)
                    
                }
                .pickerStyle(.segmented)
            }
            
            Section("Autoplay") {
                HStack {
                    Image(systemName: "play.circle.fill")
                    Toggle("Tocar automaticamente", isOn: $autoplay)
                        .tint(ColorHelper.colorFor(index: color))
                }
            }
            
            Section("Categoria") {
                TextField("Entre com sua categoria favorita",text: $category)
                
            }
            
        }
        .navigationTitle("Ajustes")
    }
}

#Preview {
    SettingsView()
}
