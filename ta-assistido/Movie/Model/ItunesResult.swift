//
//  ItunesResult.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 23/10/23.
//

import Foundation

struct ItunesResult: Decodable {
    let results: [MovieInfo]
}

struct MovieInfo: Decodable,Identifiable {
    
    let previewUrl: String
    var id: String {
        previewUrl
    }
    
    var url: URL? {
        URL(string: previewUrl)
    }
}
