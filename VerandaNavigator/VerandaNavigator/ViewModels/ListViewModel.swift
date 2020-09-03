//
//  ListViewModel.swift
//  VerandaNavigator
//
//  Created by Denis Tkachev on 02.09.2020.
//  Copyright © 2020 Denis Tkachev. All rights reserved.
//

import SwiftUI

class ListViewModel: ObservableObject {
    @Published private(set) var countries: [Field] = []
}

struct Field {
    let name: String
}


