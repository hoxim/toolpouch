//
//  UserDevice.swift
//  toolpouch
//
//  Created by Marcin Ryzko on 28/07/2026.
//

import Foundation

struct UserDevice: Codable {
    let id: UUID
    let name: String
    let type: DeviceType
    let timestamp: Date
}
