//
//  MoviesView.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 16/10/23.
//

import SwiftUI

struct MoviesView: View {
    @State private var path = NavigationPath()
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder = SortDescriptor(\Movie.title)
    @State private var searchString = ""
    var body: some View {
        NavigationStack(path: $path) {
            MovieListingView(sortOrder: sortOrder,searchString: searchString)
            .navigationTitle("Filmes")
            .searchable(text: $searchString,prompt: "Digite o nome do filme")
            .navigationDestination(for: NavigationType.self) { type in
                switch type {
                case .detail(let movie):
                    MovieDetailView(movie: movie, path: $path)
                case .form(let movie):
                    MovieFormView(movie: movie,path: $path)
                }
                
            }
            .toolbar {
                Menu("Ordenacao", systemImage: "arrow.up.arrow.down") {
                    Picker("Ordenacao",selection: $sortOrder) {
                        Text("Titulo")
                            .tag(SortDescriptor(\Movie.title))
                        Text("Nota")
                            .tag(SortDescriptor(\Movie.rating))
                            
                    }
                }
                
                Button("",systemImage: "plus") {
                  
                    path = NavigationPath([NavigationType.form(nil)])
        
                }
            }
        }
    }
}

#Preview {
    MoviesView()
}
