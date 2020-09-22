//
//  CryptoDataModel.swift
//  VerandaNavigator
//
//  Created by Denis Tkachev on 18.09.2020.
//  Copyright © 2020 Denis Tkachev. All rights reserved.
//

import Foundation

// MARK: - CryptoDataModel
struct CryptoDataModel: Codable {
    var data: [Datum] = []
    var info: Info?
}

// MARK: - Datum
struct Datum: Codable {
    var id, symbol, name, nameid: String?
    var rank: Int?
    var priceUsd, percentChange24H, percentChange1H, percentChange7D: String?
    var priceBtc, marketCapUsd: String?
    var volume24, volume24A: Double?
    var csupply, tsupply: String?
    var msupply: String?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, nameid, rank
        case priceUsd = "price_usd"
        case percentChange24H = "percent_change_24h"
        case percentChange1H = "percent_change_1h"
        case percentChange7D = "percent_change_7d"
        case priceBtc = "price_btc"
        case marketCapUsd = "market_cap_usd"
        case volume24
        case volume24A = "volume24a"
        case csupply, tsupply, msupply
    }
}

// MARK: - Info
struct Info: Codable {
    var coinsNum, time: Int?

    enum CodingKeys: String, CodingKey {
        case coinsNum = "coins_num"
        case time
    }
}
