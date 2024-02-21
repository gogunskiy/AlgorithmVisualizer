//
//  ViewModel.swift
//  SwiftUITestApp
//
//  Created by vgogunsky on 21.02.2024.
//

import Foundation

struct SectionData: Identifiable {
    var id = UUID()
    var items: [ItemData]
    
    init(id: UUID = UUID(), items: [ItemData]) {
        self.id = id
        self.items = items
    }
}
    
struct ItemData: Identifiable {
    var id = UUID()
    var value: Int
    
    init(id: UUID = UUID(), value: Int) {
        self.id = id
        self.value = value
    }
}

final class VisualizerViewModel: ObservableObject {
    @Published var sections: [SectionData] = Array(0...2).map { index in
        let items =  Array(0..<10).map { ItemData(value: $0) }
        return SectionData(items: items)
    }
}
