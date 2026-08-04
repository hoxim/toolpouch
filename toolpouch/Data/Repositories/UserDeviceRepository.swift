//
//  UserDeviceRepository.swift
//  toolpouch
//
//  Created by Marcin Ryzko on 28/07/2026.
//

import Foundation
import SwiftData

class UserDeviceRepository: UserDeviceStoring {

    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func insertDevice(_ device: UserDevice) throws {
        let deviceModel = UserDeviceModel(
            id: device.id,
            name: device.name,
            type: device.type,
            timestamp: device.timestamp
        )
        
        modelContext.insert(deviceModel)
        try modelContext.save()
    }
    
    func fetchDevice(id: UUID) throws -> UserDevice? {
        try fetchDeviceModel(id: id)?.userDevice
    }
    
    func fetchAllDevices() throws -> [UserDevice] {
        let descriptor = FetchDescriptor<UserDeviceModel>(
            sortBy: [
                SortDescriptor(\UserDeviceModel.timestamp, order: .reverse)
            ]
        )
        
        return try modelContext.fetch(descriptor).map(\.userDevice)
    }
    
    func updateDevice(_ newDevice: UserDevice) throws {
        guard let device = try fetchDeviceModel(id: newDevice.id) else {
            return
        }
        
        device.name = newDevice.name
        device.type = newDevice.type
        device.timestamp = newDevice.timestamp
        
        try modelContext.save()
    }
    
    func deleteDevice(id: UUID) throws {
        guard let device = try fetchDeviceModel(id: id) else {
            return
        }
        
        modelContext.delete(device)
        try modelContext.save()
    }
    
    private func fetchDeviceModel(id: UUID) throws -> UserDeviceModel? {
        var descriptor = FetchDescriptor<UserDeviceModel>(
            predicate: #Predicate { device in
                device.id == id
            }
        )
        
        descriptor.fetchLimit = 1
        
        return try modelContext.fetch(descriptor).first
    }
}

private extension UserDeviceModel {
    var userDevice: UserDevice {
        UserDevice(
            id: id,
            name: name,
            type: type,
            timestamp: timestamp
        )
    }
}
