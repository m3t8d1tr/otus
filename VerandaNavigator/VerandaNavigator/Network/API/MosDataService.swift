//
//  MosDataService.swift
//  VerandaNavigator
//
//  Created by Denis Tkachev on 17.09.2020.
//  Copyright © 2020 Denis Tkachev. All rights reserved.
//

import Foundation
import Moya

enum MosDataService {
    case infoDataSet
    case getCafeList(top: Int, skip: Int)
    case getCafeByGEO(coordinates: String)
}

extension MosDataService: TargetType {
    var baseURL: URL {
        return URL(string: "https://apidata.mos.ru/v1/")!
    }

    var path: String {
        switch self {
        case .infoDataSet:
            return "datasets/\(Config.shared.dataSet)/"
        case .getCafeList:
            return "datasets/\(Config.shared.dataSet)/rows/"
        case .getCafeByGEO:
            return "datasets/\(Config.shared.dataSet)/features/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .infoDataSet, .getCafeList, .getCafeByGEO:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .infoDataSet:
            return .requestParameters(parameters: ["api_key" : Config.shared.apiKey], encoding: URLEncoding.default)

        case .getCafeList(let top, let skip):
            return .requestParameters(parameters: ["api_key" : Config.shared.apiKey, "$top": "\(top)", "$skip": "\(skip)"], encoding: URLEncoding.default)

        case .getCafeByGEO(let coordinates):
            return .requestParameters(parameters: ["api_key" : Config.shared.apiKey, "bbox" : coordinates], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type" : "application/json; charset=UTF-8"]
    }
}

extension MosDataService: AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .none
    }
}

