//
//  CryptocurrencyService.swift
//  VerandaNavigator
//
//  Created by Denis Tkachev on 18.09.2020.
//  Copyright © 2020 Denis Tkachev. All rights reserved.
//

import Foundation
import Moya

enum CryptocurrencyService {
    case getRates(start: Int, limit: Int)
}

extension CryptocurrencyService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.coinlore.net/api/")!
    }

    var path: String {
        switch self {
        case .getRates:
            return "tickers"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getRates:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getRates(let start, let limit):
            return .requestParameters(parameters: ["limit": "\(limit)", "start": "\(start)"], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type" : "application/json; charset=UTF-8"]
    }
}

extension CryptocurrencyService: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .none
    }
}
