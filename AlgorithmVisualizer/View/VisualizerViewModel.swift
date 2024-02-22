//
//  ViewModel.swift
//  SwiftUITestApp
//
//  Created by vgogunsky on 21.02.2024.
//

import Foundation

struct SectionData: Identifiable {
    var id = UUID()
    
    var index: Int
    var title: String
    var description: String
    var items: [ItemData]
    
    init(index: Int, title: String, description: String, items: [ItemData]) {
        self.index = index
        self.title = title
        self.description = description
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
    @Published var sections: [SectionData] = []
    @Published var items: [Int] = [3, 2, 4, 5, 1, 11, 45, 34, 32, 23, 16, 19, 20]
    
    let algorithms: [TraceableAlgorithm]
    
    var algorithmViewModels: [AlgorithmViewModel] = []
    
    init(algorithms: [TraceableAlgorithm]) {
        self.algorithms = algorithms
    }
    
    func loadData() {
        buildData()
        buildSections()
    }
    
    func buildSections() {
        sections = algorithmViewModels.enumerated().map ({ (index, viewModel) in
            let items = viewModel.items.map { value in
                ItemData(value: value)
            }
            
            let description = "Step: \(viewModel.currentIndex + 1) from \(viewModel.data.count)"
            return SectionData(index: index, title: viewModel.title, description: description, items: items)
        })
    }
    
    func increaseStep(at index: Int) {
        algorithmViewModels[index].increaseStep()
        buildSections()
    }
    
    func decreaseStep(at index: Int) {
        algorithmViewModels[index].decreaseStep()
        buildSections()
    }
    
    private func buildData() {
        let tracer = Tracer(array: items)
        self.algorithmViewModels = algorithms.map {
            let data = tracer.createSnapshots(for: $0)
            return AlgorithmViewModel(title: $0.title, data: data)
        }
    }
    
}

final class AlgorithmViewModel {
    let title: String
    let data: [Int: Snapshot]
    var currentIndex: Int = 0
    
    var items: [Int] {
        data[currentIndex]?.array ?? []
    }
    
    init(title: String, data: [Int : Snapshot]) {
        self.title = title
        self.data = data
    }
    
    func increaseStep() {
        if currentIndex < data.count - 1 {
            currentIndex += 1
        }
    }
    
    func decreaseStep() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
}
