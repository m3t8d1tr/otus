//
//  ListViewModel.swift
//  VerandaNavigator
//
//  Created by Denis Tkachev on 02.09.2020.
//  Copyright © 2020 Denis Tkachev. All rights reserved.
//

import SwiftUI

final class ListViewModel: ObservableObject {

    var settings = ["Список кафе", "Курс крипто валют"]

    enum APISourceSelect: String, CaseIterable, Identifiable {
        case mosData = "Кафе"
        case crypto = "Валюты"
        var id: String { self.rawValue }
    }

    @Published var mosData = MosDataCafeListModel()
    //paging
    @Published private(set) var isCafePageLoading = false
    @Published var segmentChoioce: APISourceSelect = .mosData


    func fetchMosDataObject() {
        switch segmentChoioce {
        case .mosData:
            self.isCafePageLoading = true
            NetworkManager.shared.performMosDataNetworkRequest(with: MosDataService.getCafeList(top: 30, skip: mosData.count)) { (result) in
                self.mosData.append(contentsOf: result)
                self.isCafePageLoading = false
            }
        case .crypto:
            NetworkManager.shared.performCryptoNetworkRequest(with: CryptocurrencyService.getRates(start: 100, limit: 50)) { (result) in
                print(result.data?.count)
            }
        }

    }
}


