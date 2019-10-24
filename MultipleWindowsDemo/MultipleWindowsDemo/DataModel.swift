//
//  Model.swift
//  MultiWindowTest
//
//  Created by Kévin MAAREK on 24/10/2019.
//  Copyright © 2019 Kévin MAAREK. All rights reserved.
//

import Foundation

public struct Restaurant {
    let id: String
    let name: String
    let adress: String
    let intro: String
    let rating: Int
}

public struct DataManager {
    public static let data: [Restaurant] = [
        Restaurant(id: "0", name: "Via degli Scipioni", adress: "45, 00192 Roma RM, Italia", intro: "If you like pizza, you'll like us!", rating: 4),
        Restaurant(id: "1", name: "L'As du Fallafel", adress: "32-34 Rue des Rosiers, 75004 Paris", intro: "We've got the best falafel in the world.", rating: 5),
        Restaurant(id: "2", name: "Blossom", adress: "187 9th Avenuem, New York, NY", intro: "We do some great green stuff...", rating: 3),
        Restaurant(id: "3", name: "Beers Burgers Desserts", adress: "2411 W Sahara Ave, Las Vegas, NV", intro: "The best burger in Vegas!", rating: 4),
        Restaurant(id: "4", name: "Menya Kissou", adress: "1-11-3 Tōyō, Kōtō-ku, Tokyo 135-0016", intro: "The most amazing Ramen you'll ever taste.", rating: 5)
    ]

    public static func getItemById(id: String) -> Restaurant{
        var restaurant: Restaurant!
        for item in data {
            if item.id == id {
                restaurant = item
            }
        }
        return restaurant
    }
}
