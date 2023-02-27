//
//  Desert.swift
//  fetchingdeserts
//
//  Created by Odinaka Amadi on 2/27/23.
//

import Foundation
struct DesertPage: Decodable {
    var meals: [Meals]
}

struct Meals : Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}
