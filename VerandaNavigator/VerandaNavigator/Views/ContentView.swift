//
//  ContentView.swift
//  VerandaNavigator
//
//  Created by Denis Tkachev on 02.09.2020.
//  Copyright © 2020 Denis Tkachev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        TabView(selection: $appState.selectedTab) {
            MapView()
                .tabItem {
                    Text("Карта")
                    Image(systemName: "map")
            }.tag(ContentView.Tab.map)
            ListView()
                .tabItem {
                    Text("Список")
                    Image(systemName: "list.dash")
            }.tag(ContentView.Tab.list)
            ModalView()
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
    var body: some View {
        NavigationView {
            VStack {
            Text("Тут будет карта")
            Button("Переключить на вторую вкладку") {
                self.appState.selectedTab = .list
                self.appState.selectRow = true
            }
            }
        }
    }
}

struct ListView: View {
    @EnvironmentObject var appState: AppState
    @State var selectedCafeId: UUID? = nil

    var cafesList = [
        Cafe(name: "Joe's Original"),
        Cafe(name: "The Real Joe's Original"),
        Cafe(name: "Original Joe's")
    ]

//    var navigationLink: NavigationLink<EmptyView, DetailView>? {
//        guard let selectedCafeId = selectedCafeId,
//            let selectedCafe = cafesList.first(where: {$0.id == selectedCafeId}) else {
//                return nil
//        }
//
//        return NavigationLink(
//            destination: DetailView(cafe: selectedCafe),
//            tag:  selectedCafeId,
//            selection: $selectedCafeId
//        ) {
//            EmptyView()
//        }
//    }

    var body: some View {
        NavigationView {
            NavigationLink(destination: DetailView(cafe: Cafe(name: "Название кафе"))) {
                return List(cafesList, rowContent: CafeRow.init)
            }
            .navigationBarTitle("Список")
            .onReceive(appState.$selectRow) { (output) in
                if output == true {
                    // как выбрать элемент списка и перейти?
                    // аналог didSelectRow
                }
            }
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
        Text("Тут будет описание")
    }
}

struct ModalView: View {
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
