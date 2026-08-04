//
//  ToolItem.swift
//  toolpouch
//
//  Created by Marcin Ryzko on 29/07/2026.
//

import Foundation

struct MenuSectionItem: Identifiable, Hashable {
    let id: UUID = UUID()
    let title: String
    let description: String
    let image: String
}
