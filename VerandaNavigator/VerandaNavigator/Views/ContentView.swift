//
//  ContentView.swift
//  VerandaNavigator
//
//  Created by Denis Tkachev on 02.09.2020.
//  Copyright © 2020 Denis Tkachev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedIndex: Int?
    @EnvironmentObject var appState: AppState
    var body: some View {
        TabView(selection: $appState.selectedTab) {
            MapView(selectedIndex: $selectedIndex)
                .tabItem {
                    Text("Карта")
                    Image(systemName: "map")
            }.tag(ContentView.Tab.map)
            ListView(selectedIndex: $selectedIndex)
                .tabItem {
                    Text("Список")
                    Image(systemName: "list.dash")
            }.tag(ContentView.Tab.list)
            ModalView(selectedIndex: $selectedIndex)
                .tabItem {
                    Text("Модалка")
                    Image(systemName: "plus.square")
            }.tag(ContentView.Tab.modal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MapView: View {
    @EnvironmentObject var appState: AppState
    @Binding var selectedIndex: Int?
    var body: some View {
        NavigationView {
            VStack {
                Text("Тут будет карта")
                Button("Переключить на вторую вкладку") {
                    self.appState.selectedTab = .list
                    self.appState.selectRow = true
                    self.selectedIndex = 2 //randomIndex
                }
            }
        }
    }
}

struct ListView: View {
    @Binding var selectedIndex: Int?
    @EnvironmentObject var appState: AppState
    @State var selectedCafeId: UUID? = nil

    var cafesList = [
        Cafe(name: "Joe's Original"),
        Cafe(name: "The Real Joe's Original"),
        Cafe(name: "Original Joe's")
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(0..<self.cafesList.count) { idx in
                    NavigationLink(
                        destination: DetailView(cafe: self.cafesList[idx]),
                        tag: idx,
                        selection: self.$selectedIndex) {
                            Text(self.cafesList[idx].name)
                    }
                }
            }
            .navigationBarTitle("Список")
        }
    }
}

struct CafeRow: View {
    var cafe: Cafe
    var body: some View {
        Text("Название: \(cafe.name)")
    }
}

struct Cafe: Identifiable {
    var id = UUID()
    var name: String
}

struct DetailView: View {
    let cafe: Cafe
    var body: some View {
        Text("Тут будет описание для \(cafe.name)")
    }
}

struct ModalView: View {
    @Binding var selectedIndex: Int?
    @State var showingDetail = false
    var body: some View {
        Button(action: {
            self.showingDetail.toggle()
        }) {
            Text("Показать деталку")
        }.sheet(isPresented: $showingDetail) {
            DetailView(cafe: Cafe(name: "Название кафе"))
        }
    }
}

extension ContentView {
    enum Tab: Hashable {
        case map
        case list
        case modal
    }
}
