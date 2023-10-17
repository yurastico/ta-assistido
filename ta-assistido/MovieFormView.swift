//
//  MovieFormView.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 16/10/23.
//
import SwiftData
import SwiftUI

struct MovieFormView: View {
    @Bindable var movie: Movie
    @Binding var path: NavigationPath
    var body: some View {
        Form {
            Section("Escreva o nome do filme") {
                TextField("Titulo", text: $movie.title)
            }
            Section("Nota e duracao") {
                HStack {
                    //TextField("Nota", value: $movie.rating,formatter: NumberFormatter())
                    TextField("Nota", value: $movie.rating,format: .number)
                    TextField("Duracao",text: $movie.duration)
                }
            }
            
            Section("Categorias") {
                TextField("Insira as principais categorias", text: $movie.categories)
            }
            
            Section("Sinopse") {
                TextEditor(text: $movie.summary)
                    .frame(height: 160)
            }
        }
        .navigationTitle(movie.title.isEmpty ? "Cadastro": movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("",systemImage: "house.fill") {
                path.removeLast(path.count)
                
            }
        }
        
        
    }
}

#Preview {
    do {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Movie.self, configurations: configuration)
        let movie =  Movie(title: "Matrix",image: "matrix")
        return MovieFormView(movie: movie,path: .constant(NavigationPath()))
            .modelContainer(container)
    } catch {
        fatalError("erro ao criar o preview")
    }
    
        
}

