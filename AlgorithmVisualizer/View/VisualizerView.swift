//
//  ContentView.swift
//  SwiftUITestApp
//
//  Created by vgogunsky on 21.02.2024.
//

import SwiftUI

struct VisualizerView: View {
    @StateObject var viewModel: VisualizerViewModel
    
    private let columns: [GridItem] = [
          GridItem(.fixed(100), spacing: 16),
          GridItem(.fixed(100), spacing: 16),
          GridItem(.fixed(100), spacing: 16)
      ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 16,
                pinnedViews: [.sectionHeaders, .sectionFooters]
            ) {
                ForEach(viewModel.sections) { section in
                    Section(header: Text("Section").font(.title)) {
                        ForEach(section.items) { item in
                            Text("\(item.value)")
                                .frame(width: 32, height: 32, alignment: .center)
                                .background(.gray)
                                .cornerRadius(16)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    VisualizerView(viewModel: VisualizerViewModel())
}
