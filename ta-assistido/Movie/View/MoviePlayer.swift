//
//  MoviePlayer.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 23/10/23.
//

import Foundation
import SwiftUI
import AVKit
struct MoviePlayer: View {
    let movieInfo: MovieInfo
    @Environment(\.dismiss) var dismiss
    var player: AVPlayer? {
        guard let url = movieInfo.url else { return nil }
        let player = AVPlayer(url: url)
        player.play()
        return player
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if let player {
                VideoPlayer(player: player)
                    .ignoresSafeArea()
            } else {
                Rectangle()
                    .tint(.black)
                    .ignoresSafeArea()
                    .overlay {
                        Text("Erro ao carregar video")
                            .foregroundStyle(.white)
                    }
            }
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.up.left.arrow.down.right")
                    .tint(.white)
            }
            
        }
    }
}
