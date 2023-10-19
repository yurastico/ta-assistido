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
            MainView()
        }
        .modelContainer(for: Movie.self)
    }
}
// TODO - N'AO DEIXAR COM QUE ALTERE SEM CLICAR NO BOTAO SALVAR
// TODO - NkAO DEIXAR CRIAR FILME VAZIL
// TODO - MUDAR NOME BOTAO
