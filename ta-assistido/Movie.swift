//
//  Movie.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 11/10/23.
//

import Foundation


struct Movie: Decodable, Identifiable, Hashable {
    var id = UUID().uuidString // universally unique identifier
    
    var smallImage: String {
        "\(image)small"
    }
    var finalRating: String {
        "\(rating)/10"
    }
    
    let title: String
    let categories: String
    let duration: String
    let rating: Double
    let summary: String
    let image: String
    

    

//     pode ser passado na hora de usar o JSONDecoder() com .convertFrom snakeCase para não precisar fazer na mão, nem precisar usar o mesmo nome na propriedade.
//     è necessario fazer só com as propriedades eventualmente colocamos, mas precisamos colocar todos no case
    enum CodingKeys: String, CodingKey {
           case title
           case categories
           case duration
           case rating
           case summary 
           case image
       }
// precisa ter isso por causa do id e das computed var
    
}

