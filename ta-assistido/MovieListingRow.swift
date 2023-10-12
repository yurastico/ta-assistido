//
//  MovieListingRow.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 11/10/23.
//

import SwiftUI

struct MovieListingRow: View {
    let movie: Movie
    
    
    var body: some View {
        HStack(spacing: 12) {
            Image(movie.smallImage)
                .resizable()
                .scaledToFill()
                .frame(width: 50,height: 80)
                .clipped()
                .cornerRadius(8)
                .shadow(radius: 4,x: 2,y: 2)
            Text(movie.title)
            Spacer()
        }
    }
}

#Preview {
    MovieListingRow(movie: Movie(title: "o", categories: "a", duration: "", rating: 1, summary: "", image: ""))
}
