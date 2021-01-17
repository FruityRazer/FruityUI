//
//  DeviceRawDataConverter.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 07/06/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import Foundation
import FruityKit

protocol DeviceRawDataConverting {
    
    var json: String { get }
    var mode: Synapse3Handle.Mode { get }
}

struct DeviceRawDataConverter: DeviceRawDataConverting {
    
    struct DeviceRawData: Decodable, Encodable {
        let type: String
        let rows: [[String]]
        
        init(type: String = "raw", rows: [[String]]) {
            self.type = type
            self.rows = rows
        }
    }
    
    let rawData: DeviceRawData
    
    init?(json: String) {
        guard let data = json.data(using: .utf8) else {
            return nil
        }
        
        guard let decoded = try? JSONDecoder().decode(DeviceRawData.self, from: data) else {
            return nil
        }
        
        guard decoded.type == "raw" else {
            return nil
        }
        
        self.rawData = decoded
    }
    
    init(mode: Synapse3Handle.Mode) {
        switch mode {
        case .off:
            fatalError("The lights out mode can never be saved to Core Data.")
        case let .raw(colors: colors):
            self.rawData = DeviceRawData(rows: [colors.map { $0.hexValue }])
        case let .rawRows(colors: rows):
            self.rawData = DeviceRawData(rows: rows.map { $0.map { $0.hexValue }})
        }
    }
    
    init(colors: [[Color]]) {
        self.rawData = DeviceRawData(rows: colors.map { $0.map { $0.hexValue }})
    }
    
    var json: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let encoded = try? encoder.encode(rawData) else {
            preconditionFailure("`rawData` encoding should never fail!")
        }
        
        return String(data: encoded, encoding: .utf8)!
    }
    
    var mode: Synapse3Handle.Mode {
        switch rawData.rows.count {
        case 1:
            return .raw(colors: rawData.rows[0].compactMap { try? Color(hex: $0) })
        default:
            return .rawRows(colors: rawData.rows.map { $0.compactMap { try? Color(hex: $0) }})
        }
    }
}
