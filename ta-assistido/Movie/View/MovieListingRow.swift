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
            if let data = movie.image,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50,height: 80)
                    .clipped()
                    .cornerRadius(8)
                    .shadow(radius: 4,x: 2,y: 2)
            } else {
                Image(systemName: "movie.clapper")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50,height: 80)
                    .foregroundColor(.gray.opacity(0.3))
                    .clipped()
                
            }
            Text(movie.title)
            Spacer()
            Text(movie.finalRating)
        }
    }
}

#Preview {
    MovieListingRow(movie: Movie(title: "o", categories: "a", duration: "", rating: 1, summary: ""))
}
