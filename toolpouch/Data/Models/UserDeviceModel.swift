//
//  UserDeviceModel.swift
//  toolpouch
//
//  Created by Marcin Ryzko on 28/07/2026.
//

import Foundation
import SwiftData


enum DeviceType: String, Codable {
    case iPhone
    case iPad
    case watch
    case mac
    case macbook
    case vision
    case appleTV
    case unknown
}

@Model
final class UserDeviceModel {
    @Attribute(.unique)
    var id: UUID
    
    var name: String
    var type: DeviceType
    var timestamp: Date
    
    init(
        id: UUID = UUID(),
        name: String,
        type: DeviceType,
        timestamp: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.timestamp = timestamp
    }
}
