//
//  MainMenuBarView.swift
//  toolpouch
//
//  Created by Marcin Ryzko on 29/07/2026.
//

import SwiftUI

public struct SectionGridView: View {
    public init() {}
    
    let columns = Array(
        repeating: GridItem(.flexible()),
        count: 3
    )
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(sections) { section in
                        NavigationLink(value: section) {
                            MenuSectionButton(
                                title: section.title,
                                image: section.image,
                                description: section.description
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Tools")
            .navigationDestination(for: MenuSectionItem.self) { section in
                ToolsGridView(section: section)
            }
        }
        .frame(width: 320, height: 380)
    }
    
    
    
    var sections: [MenuSectionItem] = [
        
        MenuSectionItem(
            title: "Network",
            description: "IP, DNS, Ping, HTTP...",
            image: "network"
        ),
        
        MenuSectionItem(
            title: "Security",
            description: "SSH, Keys, Hashes...",
            image: "lock.shield"
        ),
        
        MenuSectionItem(
            title: "Passwords",
            description: "Password generator",
            image: "key.fill"
        ),
        
        MenuSectionItem(
            title: "Clipboard",
            description: "Snippets & Notes",
            image: "clipboard"
        ),
        
        MenuSectionItem(
            title: "Design",
            description: "Colors & UI",
            image: "paintpalette"
        ),
        
        MenuSectionItem(
            title: "Images",
            description: "Resize & Convert",
            image: "photo.on.rectangle"
        ),
        
        MenuSectionItem(
            title: "Text",
            description: "JSON, Base64...",
            image: "textformat"
        ),
        
        MenuSectionItem(
            title: "Sync",
            description: "Shared Files",
            image: "icloud"
        ),
        
        MenuSectionItem(
            title: "Tools",
            description: "Timer & Monitor",
            image: "wrench.and.screwdriver"
        )
    ]
        
    
}
