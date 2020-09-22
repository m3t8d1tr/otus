//
//  ContentView.swift
//  VerandaNavigator
//
//  Created by Denis Tkachev on 02.09.2020.
//  Copyright © 2020 Denis Tkachev. All rights reserved.
//

import MapKit
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
//            ModalView(selectedIndex: $selectedIndex)
//                .tabItem {
//                    Text("Модалка")
//                    Image(systemName: "plus.square")
//            }.tag(ContentView.Tab.modal)
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
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View {
        Text("ios 14 need for Map")
    }
}

struct ListView: View {
    @Binding var selectedIndex: Int?
    @State var selectedCafeId: UUID? = nil
    @ObservedObject var mosDataViewModel = ListViewModel()
    @State var showCellPageLoadingPlaceholder: Bool = true
    @State private var selectedConfiguration = 0

    var body: some View {
        NavigationView {
            VStack() {
                Picker("Options", selection: $selectedConfiguration) {
                    ForEach(0 ..< mosDataViewModel.settings.count) { index in
                        Text(self.mosDataViewModel.settings[index])
                            .tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                Text("suggestedTopping: \(selectedConfiguration)")
                List {
                    if selectedConfiguration == 0 {
                        if mosDataViewModel.isCafePageLoading && mosDataViewModel.mosData.count == 0  {
                            ListScreen_LoadingPlaceholder()
                        }
                        ForEach(0..<self.mosDataViewModel.mosData.count, id: \.self) { idx in
                            NavigationLink(
                                destination: DetailView(cafe: self.mosDataViewModel.mosData[idx]),
                                tag: idx,
                                selection: self.$selectedIndex) {
                                    Text(self.mosDataViewModel.mosData[idx].cells?.stationaryObjectName ?? "Нет названия")
                            }.onAppear() {
                                if self.mosDataViewModel.mosData.isLast(self.mosDataViewModel.mosData[idx]) {
                                    self.mosDataViewModel.fetchListData(value: self.selectedConfiguration)
                                    if self.mosDataViewModel.mosData.count > 0 {
                                        self.showCellPageLoadingPlaceholder = true
                                    } else {
                                        self.showCellPageLoadingPlaceholder = false
                                    }
                                }
                            }
                        }
                        if showCellPageLoadingPlaceholder {
                            ListScreenFoodCellPlaceholderLoading()
                        }
                    } else if selectedConfiguration == 1 {
                        if mosDataViewModel.isCryptoPageLoading && mosDataViewModel.cryproData.data.count == 0  {
                            ListScreen_LoadingPlaceholder()
                        }
                        ForEach(0..<self.mosDataViewModel.cryproData.data.count, id: \.self) { idx in
                            NavigationLink(
                                destination: DetailDatumView(object: self.mosDataViewModel.cryproData.data[idx]),
                                tag: idx,
                                selection: self.$selectedIndex) {
                                    Text(self.mosDataViewModel.mosData[idx].cells?.stationaryObjectName ?? "Нет названия")
                            }.onAppear() {
                                if self.mosDataViewModel.mosData.isLast(self.mosDataViewModel.mosData[idx]) {
                                    self.mosDataViewModel.fetchListData(value: self.selectedConfiguration)
                                    if self.mosDataViewModel.cryproData.data.count > 0 {
                                        self.showCellPageLoadingPlaceholder = true
                                    } else {
                                        self.showCellPageLoadingPlaceholder = false
                                    }
                                }
                            }
                        }
                    }
                }.navigationBarTitle("Список")
            }

        }.onAppear() {
            self.mosDataViewModel.fetchListData(value: 2) // default
        }
    }
            func selectNewConfig(_ newValue: Int) {
                print(newValue)
                withAnimation {
    //                choosedConfiguration = newValue
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
    let cafe: MosDataCafeListElement
    var body: some View {
        Text("Тут будет описание для \(cafe.cells?.stationaryObjectName ?? "")")
    }
}

struct DetailDatumView: View {
    let object: Datum
    var body: some View {
        Text("Тут будет описание для \(object.name ?? "")")
    }
}

//struct ModalView: View {
//    @Binding var selectedIndex: Int?
//    @State var showingDetail = false
//    var body: some View {
//        Spacer()
//        //        Button(action: {
//        //            self.showingDetail.toggle()
//        //        }) {
//        //            Text("Показать деталку")
//        //        }.sheet(isPresented: $showingDetail) {
//        //         let blank = MosDataModel()
//        //            DetailView(cafe: blank)
//        //        }
//    }
//}

extension ContentView {
    enum Tab: Hashable {
        case map
        case list
        case modal
    }
}

struct ListScreen_LoadingPlaceholder: View {

    var body: some View {
        VStack(alignment: .center) {
            ActivityIndicatorView()
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
    }
}

struct ListScreenFoodCellPlaceholderLoading: View {
    var body: some View {
        VStack(alignment: .center) {
            Divider()
            ActivityIndicatorView()
        }
        .frame(height: 44)
    }
}
