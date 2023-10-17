//
//  Movie.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 11/10/23.
//

import SwiftData

@Model
class Movie {
    
    var title: String
    var categories: String
    var duration: String
    var rating: Double?
    var summary: String
    var image: String
    
    var smallImage: String {
        "\(image)small"
    }
    var finalRating: String {
        "\(rating ?? 0)/10"
    }
    
    init(title: String = "", categories: String = "", duration: String = "", rating: Double? = nil, summary: String = "", image: String = "question") {
        self.title = title
        self.categories = categories
        self.duration = duration
        self.rating = rating
        self.summary = summary
        self.image = image
    }
    
}

