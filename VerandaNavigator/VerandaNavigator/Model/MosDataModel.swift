//
//  MosDataModel.swift
//  VerandaNavigator
//
//  Created by Denis Tkachev on 17.09.2020.
//  Copyright © 2020 Denis Tkachev. All rights reserved.
//

struct MosDataCafeListElement: Codable, Identifiable {
    var id, number: Int?
    var cells: Cells?

    enum CodingKeys: String, CodingKey {
        case id = "global_id"
        case number = "Number"
        case cells = "Cells"
    }
}

struct Cells: Codable {
    var globalID: Int?
    var objectType: ObjectType?
    var stationaryObjectName: String?
    var admArea: AdmArea?
    var district, address: String?
    var facilityArea: Double?
    var geoData: GeoData?

    enum CodingKeys: String, CodingKey {
        case globalID = "global_id"
        case objectType = "ObjectType"
        case stationaryObjectName = "StationaryObjectName"
        case admArea = "AdmArea"
        case district = "District"
        case address = "Address"
        case facilityArea = "FacilityArea"
        case geoData
    }
}

enum AdmArea: String, Codable {
    case восточныйАдминистративныйОкруг = "Восточный административный округ"
    case западныйАдминистративныйОкруг = "Западный административный округ"
    case зеленоградскийАдминистративныйОкруг = "Зеленоградский административный округ"
    case новомосковскийАдминистративныйОкруг = "Новомосковский административный округ"
    case северныйАдминистративныйОкруг = "Северный административный округ"
    case североВосточныйАдминистративныйОкруг = "Северо-Восточный административный округ"
    case североЗападныйАдминистративныйОкруг = "Северо-Западный административный округ"
    case троицкийАдминистративныйОкруг = "Троицкий административный округ"
    case центральныйАдминистративныйОкруг = "Центральный административный округ"
    case югоВосточныйАдминистративныйОкруг = "Юго-Восточный административный округ"
    case югоЗападныйАдминистративныйОкруг = "Юго-Западный административный округ"
    case южныйАдминистративныйОкруг = "Южный административный округ"
}

struct GeoData: Codable {
    var type: TypeEnum?
    var coordinates: [Double]?
}

enum TypeEnum: String, Codable {
    case point = "Point"
}

enum ObjectType: String, Codable {
    case сезонноеКафе = "сезонное кафе"
}

typealias MosDataCafeListModel = [MosDataCafeListElement]

struct MosInfoDataModel: Codable, Identifiable {
    let id: Int?
    let identificationNumber: String?
    let categoryId: Int?
    let categoryCaption: String?
    let departmentId: Int?
    let departmentCaption: String?
    let caption: String?
    let description: String?
    let fullDescription: String?
    let keywords: String?
    let containsGeodata: Bool?
    let versionNumber: String?
    let versionDate: String?
    let itemsCount: Int?
    let columns: [Columns]?

    enum CodingKeys: String, CodingKey {

        case id = "Id"
        case identificationNumber = "IdentificationNumber"
        case categoryId = "CategoryId"
        case categoryCaption = "CategoryCaption"
        case departmentId = "DepartmentId"
        case departmentCaption = "DepartmentCaption"
        case caption = "Caption"
        case description = "Description"
        case fullDescription = "FullDescription"
        case keywords = "Keywords"
        case containsGeodata = "ContainsGeodata"
        case versionNumber = "VersionNumber"
        case versionDate = "VersionDate"
        case itemsCount = "ItemsCount"
        case columns = "Columns"
    }
}

struct Columns: Codable {
    let name: String?
    let caption: String?
    let visible: Bool?
    let type: String?
//    let subColumns: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case caption = "Caption"
        case visible = "Visible"
        case type = "Type"
//        case subColumns = "SubColumns"
    }
}
