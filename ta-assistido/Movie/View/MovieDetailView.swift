//
//  MovieDetailView.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 11/10/23.
//

import SwiftUI
import AVKit

struct MovieDetailView: View {
    var movie: Movie
    @Binding var path: NavigationPath
    @State private var trailer = ""
    @State private var movieInfo: MovieInfo?
    @State private var isFavorite: Bool = false
    @State private var isPlaying: Bool = false
    @State private var offset: Double = 400
    @State private var scale: Double = 0
    @State private var cornerRadius: Double = 300
    
    
    
    var player: AVPlayer? {
        guard let url = movieInfo?.url else { return nil}
        let player = AVPlayer(url: url)
        player.play()
        return player
    }

    // .offset emburra a view x/y pontos
    var body: some View {
        
        VStack {
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    image
                    
                    if movieInfo != nil {
                        VideoPlayer(player: player)
                            .frame(width: proxy.size.width, height: 380)
//                            .offset(y: offset)
                            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                            .scaleEffect(scale)
                    }
                    
                    // vai aparecer o video em cima do poster do filme
                        //.overlay tipo um ZStack coloca uma camada em cima da view
                }
                
            }
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
        .onAppear {
            Task {
                await loadTrailer(with: movie.title)
            }
        }
//        .fullScreenCover(item: $movieInfo) { movieInfo in
//            MoviePlayer(movieInfo: movieInfo)
//        }
    }
    
    private func loadTrailer(with title: String) async {
        let itunesPath = "https://itunes.apple.com/search?media=movie&entity=movie&term=\(title)"
        guard let url = URL(string: itunesPath) else { return }
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            let itunesResult = try JSONDecoder().decode(ItunesResult.self, from: data)
            trailer = itunesResult.results.first?.previewUrl ?? ""
            
        } catch {
            print(error)
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
            
            Spacer()
            
            ZStack {
                Circle()
                    .frame(width: 34)
                    .foregroundStyle(isFavorite ? Color(.systemGray6) : Color.pink.opacity(0.3))
                    .scaleEffect(isFavorite ? 1.2 : 1.0)
                
                Image(systemName: "heart.fill")
                    .foregroundStyle(isFavorite ? .red : .white)
                    .scaleEffect(isFavorite ? 1.5: 1.0)
                    .rotationEffect(isFavorite ? .zero : .degrees(360))
                
            }
            .animation(.spring(bounce: 0.75),value: isFavorite)
            .onTapGesture {
                isFavorite.toggle()
            }
        }
    }
    
    private var playButton: some View {
        Button {
            
            movieInfo = MovieInfo(previewUrl: trailer)
            withAnimation(.spring(duration: 1.5, bounce: 0.7)) {
                isPlaying.toggle()
//                offset = 0
                scale = 1
                cornerRadius = 0
            }
            
//            withAnimation {
//                isPlaying.toggle()
//            }
            
        } label: {
            
            HStack {
                Image(systemName: trailer.isEmpty ? "xmark" : isPlaying ? "stop.fill" : "play.fill")
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(60)
                Text(trailer.isEmpty ? "Sem trailer" : "Trailer")
                    .fontWeight(.semibold)
                    .padding(.trailing)
                    .foregroundColor(.primary)
                
            }
            .padding(3)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(40)
            .overlay {
                RoundedRectangle(cornerRadius: 40)
                    .trim(from: 0,to: isPlaying ? 1.0 : 0) // esconde/ mostra o componente
                    .stroke(lineWidth: 3)
            }
        }
        .disabled(trailer.isEmpty)
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
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
        .padding(.vertical)
    }
}

// leading e trailing vs left right
// por conta dos orientais, que leem da direita para a esquerda e se colocarmos left ele apareceria a esquerda em qualquer lugar, ja o leading voce informa que esta sempre a esquerda a direita

#Preview {
    MovieDetailView(movie: Movie(title: "o", categories: "a", duration: "", rating: 1, summary: ""), path: .constant(NavigationPath()))
}
