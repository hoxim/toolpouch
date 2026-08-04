//
//  UserDeviceStoring.swift
//  toolpouch
//
//  Created by Marcin Ryzko on 28/07/2026.
//

import Foundation

protocol UserDeviceStoring {
    func insertDevice(_ device: UserDevice) throws
    func fetchDevice(id: UUID) throws -> UserDevice?
    func fetchAllDevices() throws -> [UserDevice]
    func updateDevice(_ newDevice: UserDevice) throws
    func deleteDevice(id: UUID) throws
}
