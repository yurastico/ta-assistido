//
//  MoviewListingView.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 11/10/23.
//

import SwiftData
import SwiftUI

enum NavigationType: Hashable {
    case detail(Movie)
    case form(Movie)
    
}

struct MovieListingView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query private var movies: [Movie]
    
    init(sortOrder: SortDescriptor<Movie> = SortDescriptor(\Movie.rating)) {
        _movies = Query(sort: [sortOrder])
    }
    
    var body: some View {
        List {
            ForEach(movies) { movie in
                NavigationLink(value: NavigationType.detail(movie)) {
                    MovieListingRow(movie: movie)
                }
            }
            .onDelete(perform: deleteMovie)

        }
    }
    
    private func deleteMovie(_ indexSet: IndexSet) {
        for index in indexSet {
            let movie = movies[index]
            modelContext.delete(movie)
        }
    }
}

#Preview {
    MovieListingView()
}
