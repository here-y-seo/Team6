//
//  ReversedGeocoding.swift
//  SMSH-Summer
//
//  Created by Doy Kim on 2022/10/30.
//


import Foundation

// MARK: - ReversedGeocoding
struct ReversedGeocoding: Codable {
    var status: Status
    var results: [Result]
}

// MARK: - Result
struct Result: Codable {
    var name: String
    var code: Code
    var region: Region
    var land: Land
}

// MARK: - Code
struct Code: Codable {
    var id: String
    var type: String
    var mappingId: String
}

// MARK: - Land
struct Land: Codable {
    var type: String
    var number1: String
    var number2: String
    var addition0, addition1, addition2, addition3, addition4: Addition
    var name: String
    var coords: Coords
}

// MARK: - Addition
struct Addition: Codable {
    var type: String
    var value: String
}

// MARK: - Coords
struct Coords: Codable {
    var center: Center
}

// MARK: - Center
struct Center: Codable {
    var crs: String
    var x: Float
    var y: Float
}

// MARK: - Region
struct Region: Codable {
    var area0: Area
    var area1: Area1
    var area2, area3, area4: Area
}

// MARK: - Area
struct Area: Codable {
    var name: String
    var coords: Coords
}

// MARK: - Area1
struct Area1: Codable {
    var name: String
    var coords: Coords
    var alias: String
}

// MARK: - Status
struct Status: Codable {
    var code: Int
    var name: String
    var message: String
}
