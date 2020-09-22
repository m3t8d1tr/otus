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

    enum APISourceSelect: Int, CaseIterable, Identifiable {
        case mosData = 0
        case crypto = 1
        case `default` = 2
        var id: Int { self.rawValue }
    }

    @Published var mosData = MosDataCafeListModel()
    @Published var cryproData = CryptoDataModel()

    //paging
    @Published private(set) var isCafePageLoading = false
    @Published private(set) var isCryptoPageLoading = false
    @Published var segmentChoioce: APISourceSelect = .default

    func fetchListData(value: Int) {
        self.segmentChoioce = APISourceSelect.init(rawValue: value) ?? .default
        fetchMosDataObject()
    }

    private func fetchMosDataObject() {
        switch segmentChoioce {
        case .default:
            self.isCafePageLoading = true
            NetworkManager.shared.performMosDataNetworkRequest(with: MosDataService.getCafeList(top: 30, skip: mosData.count)) { (result) in
                self.mosData.append(contentsOf: result)
                self.isCafePageLoading = false
            }
            NetworkManager.shared.performCryptoNetworkRequest(with: CryptocurrencyService.getRates(start: 100, limit: 50)) { (result) in
                self.cryproData.info = result.info
                self.cryproData.data = result.data
                self.isCryptoPageLoading = false
            }

        case .mosData:
            self.isCafePageLoading = true
            NetworkManager.shared.performMosDataNetworkRequest(with: MosDataService.getCafeList(top: 30, skip: mosData.count)) { (result) in
                self.mosData.append(contentsOf: result)
                self.isCafePageLoading = false
            }
        case .crypto:
            self.isCryptoPageLoading = true
            NetworkManager.shared.performCryptoNetworkRequest(with: CryptocurrencyService.getRates(start: 100, limit: 50)) { (result) in
                self.cryproData.info = result.info
                self.cryproData.data = result.data
                self.isCryptoPageLoading = false
            }
        }
    }
}


