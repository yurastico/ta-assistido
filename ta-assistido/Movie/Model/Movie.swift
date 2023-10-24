//
//  Movie.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 11/10/23.
//
import Foundation
import SwiftData

@Model
class Movie {
    
    var title: String
    var categories: String
    var duration: String
    var rating: Double?
    var summary: String
    var image: Data?
    
   
    var finalRating: String {
        "\(rating ?? 0)/10"
    }
    
    init(title: String = "", categories: String = "", duration: String = "", rating: Double? = nil, summary: String = "", image: Data? = nil) {
        self.title = title
        self.categories = categories
        self.duration = duration
        self.rating = rating
        self.summary = summary
        self.image = image
    }
    
}

