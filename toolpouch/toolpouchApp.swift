//
//  toolpouchApp.swift
//  toolpouch
//
//  Created by Marcin Ryzko on 28/07/2026.
//

import SwiftUI
import SwiftData

@main
struct toolpouchApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            UserDeviceModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        
        MenuBarExtra("Tool Pouch",systemImage: "shippingbox"){
            SectionGridView()
        }
        .menuBarExtraStyle(.window)
        
        WindowGroup {
            //ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
