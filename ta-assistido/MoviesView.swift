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
    
    var body: some View {
        NavigationStack(path: $path) {
            MovieListingView(sortOrder: sortOrder)
            .navigationTitle("Filmes")
            
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
                    let movie = Movie()
                    modelContext.insert(movie)
                    path = NavigationPath([NavigationType.form(movie)])
        
                }
            }
        }
    }
}

#Preview {
    MoviesView()
}
