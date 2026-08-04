//
//  ToolButton.swift
//  toolpouch
//
//  Created by Marcin Ryzko on 29/07/2026.
//

import SwiftUI

struct MenuSectionButton: View {
    let title: String
    let image: String
    let description: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: image)
                .font(.title2)
            
            Text(title)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .contentShape(Rectangle())
        .glassEffect(
            in: RoundedRectangle(cornerRadius: 8)
        )
    }
}

#Preview {
    MenuSectionButton(title: "Network", image: "wifi.circle", description: "some description")
}
