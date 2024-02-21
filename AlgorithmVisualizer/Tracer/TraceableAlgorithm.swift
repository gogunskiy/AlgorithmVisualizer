//
//  SortAlgorithm.swift
//  SortingVisualization
//
//  Created by vgogunsky on 20.02.2024.
//

import Foundation

protocol TraceableAlgorithm {
    func sort(array: [Int], progressBlock: ([Int]) -> ())
}

struct BubbleSort: TraceableAlgorithm {
    func sort(array: [Int], progressBlock: ([Int]) -> ()) {
        var array = array
        let size = array.count
        for x in 0..<size {
           for y in 0..<size-x-1 {
              if array[y] > array[y+1] {
                 let temp = array[y]
                 array[y] = array[y+1]
                 array[y+1] = temp
              }
               
               progressBlock(array)
           }
        }
    }
}

struct InsertionSort: TraceableAlgorithm {
    func sort(array: [Int], progressBlock: ([Int]) -> ()) {
        var array = array
        guard array.count >= 2 else {
            return
        }
        // 1
        for current in 0..<(array.count - 1) {
            var lowest = current
            // 2
            for other in (current + 1)..<array.count {
                if array[lowest] > array[other] {
                    lowest = other
                }
            }
            // 3
            if lowest != current {
                array.swapAt(lowest, current)
            }
            
            progressBlock(array)
        }
    }
    
}
