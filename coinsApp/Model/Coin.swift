//
//  Coin.swift
//  coinsApp
//
//  Created by Esin Esen on 14.03.2022.
//

import UIKit

struct Datas : Decodable {
    let data : Coins
}

struct Coins : Decodable {
    let coins : [Coin]
}

struct Coin : Decodable {
    let symbol : String?
    let name : String?
    let iconUrl : String?
    let price : String?
    let change : String?
    let sparkline : [String]?
    let marketCap : String?
    let listedAt : Int?
    let volume : String?
    let rank : Int?
    
    enum CodingKeys: String, CodingKey {
        case symbol, name, iconUrl, price,  change, sparkline, marketCap, listedAt, rank
        case volume = "24hVolume"
    }
}
