//
//  NetworkManager.swift
//  VerandaNavigator
//
//  Created by Denis Tkachev on 17.09.2020.
//  Copyright © 2020 Denis Tkachev. All rights reserved.
//

import Moya
import Foundation

final class NetworkManager {
    let mosDataProvider = MoyaProvider<MosDataService>(plugins: [NetworkLoggerPlugin()])
    let ctyptoProvider = MoyaProvider<CryptocurrencyService>(plugins: [NetworkLoggerPlugin()])
    static let shared = NetworkManager()

    public func performMosDataNetworkRequest(with: MosDataService, completion: @escaping (MosDataCafeListModel)->()) {
        mosDataProvider.request(with) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try JSONDecoder().decode(MosDataCafeListModel.self, from: response.data)
                    completion(result)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    public func performCryptoNetworkRequest(with: CryptocurrencyService, completion: @escaping (CryptoDataModel)->()) {
        ctyptoProvider.request(with) { (result) in
            switch result {
            case .success(let response):
                do {
                    let result = try JSONDecoder().decode(CryptoDataModel.self, from: response.data)
                    completion(result)
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
