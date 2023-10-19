//
//  MovieDetailView.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 11/10/23.
//

import SwiftUI

struct MovieDetailView: View {
    var movie: Movie
    @Binding var path: NavigationPath
    var body: some View {
        VStack {
            image
            
            VStack(alignment: .leading){
                
                title
                rating
                categories
                playButton
                categories
                
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            // esse infinity serve pra definir que a VStack tem o tamanho maximo possivel, que por padrao eh o minimo possivel, e o leading alinha a esquerda o frame
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .toolbar {
            Button("Edit") {
                path.append(NavigationType.form(movie))
            }
        }
    }
    @ViewBuilder // o que acontece eh que o ViewBuilder ocnsegue encapsular o retorno da view em outro container permitindo o retorno de dois tipos (self.mask e self.frame
    var image: some View {
        //Group {
        if let data = movie.image, let uiImage = UIImage(data: data) {
            Image(uiImage:  uiImage)
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipped()
                .mask {
                    // cria um fading na imagem de fundo, as cores nao importam ja que eh uma mascara
                    LinearGradient(stops: [.init(color: .black, location: 0.75),
                                           .init(color: .clear, location: 1)],
                                   startPoint: .top,
                                   endPoint: .bottom)
                }
        } else {
            Image(systemName: "movieclapper")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray.opacity(0.3))
                .padding(40)
                .frame(height: 400)
        }
        //}
    }
    
    private var title: some View {
        Text(movie.title)
            .font(.title)
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
    }
    private var rating: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            Text(movie.finalRating)
        }
    }
    
    private var playButton: some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: "play.fill")
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(60)
                Text("Trailer")
                    .fontWeight(.semibold)
                    .padding(.trailing)
                    .foregroundColor(.primary)
                
            }
            .padding(3)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(40)
        }
    }
    private var categories: some View {
        Text(movie.categories)
    }
    
    
    private var sinopse: some View {
        VStack(alignment: .leading) {
            Text("Sinopse")
                .padding(.top)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            ScrollView {
                Text(movie.summary)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
        .padding(.vertical)
    }
}

#Preview {
    MovieDetailView(movie: Movie(title: "o", categories: "a", duration: "", rating: 1, summary: ""), path: .constant(NavigationPath()))
}
