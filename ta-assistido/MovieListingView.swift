//
//  MoviewListingView.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 11/10/23.
//

import SwiftUI

struct MovieListingView: View {
    private var movies: [Movie] {
        // funciona passar movies.json no forRessource e nil no withExtension
        //Singleton
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else {
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let movies = try decoder.decode([Movie].self, from: data)
            return movies
        } catch {
            print(error)
        }
        return []
    }
    var body: some View {
        NavigationStack {
            List(movies) { movie in
                // gostaria de usar o ForEach aqui dentro, mas o professor falou que ele cria a lista inteira de uma vez, não é performático :o
//                NavigationLink {
//                    MovieDetailView(movie: movie)
//                } label: {
//                    MovieListingRow(movie: movie)
//                }
                // esse navigation link comentado cria uma tela sem clicar, pessimo pra performance
                
                NavigationLink(value: movie) {
                    MovieListingRow(movie: movie)
                }
               
                
            }
            .navigationTitle("Filmes")
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movie: movie)
            }
        }
    }
}

#Preview {
    MovieListingView()
}
