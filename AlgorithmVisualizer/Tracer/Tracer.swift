//
//  Tracer.swift
//  AlgorithmVisualizer
//
//  Created by vgogunsky on 21.02.2024.
//

struct Snapshot: Hashable {
    var array: [Int]
}

struct Tracer {
    let array: [Int]
        
    init(array: [Int]) {
        self.array = array
    }
    
    func createSnapshots(for algorithm: TraceableAlgorithm) -> [Int: Snapshot] {
        var snapshots = [Int: Snapshot]()
        var index = 0

        snapshots[index] = Snapshot(array: array)
        algorithm.sort(array: array) { partiallySortedArray in
            let snapshot = Snapshot(array: partiallySortedArray)
            if !snapshots.values.contains(snapshot) {
                index += 1
                snapshots[index] = snapshot
            }
        }
        
        return snapshots
    }
}
