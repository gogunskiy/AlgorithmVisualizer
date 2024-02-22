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
                    let header = SectionHeaderView(title: section.title, 
                                                   description: section.description) {
                        viewModel.increaseStep(at: section.index)
                    } decreaseAction: {
                        viewModel.decreaseStep(at: section.index)
                    }

                    Section(header: header) {
                        ForEach(section.items) { item in
                            Text("\(item.value)")
                                .frame(width: 32, height: 32, alignment: .center)
                                .background(.gray)
                                .cornerRadius(16)
                        }
                    }
                }
            }
        }.onAppear {
            viewModel.loadData()
        }
    }
}

#Preview {
    VisualizerView(viewModel: VisualizerViewModel(algorithms: [BubbleSort(), InsertionSort()]))
}

struct SectionHeaderView: View {
    let title: String
    let description: String
    let increaseAction: () -> Void
    let decreaseAction: () -> Void

    var body: some View {
        VStack {
            Text(title).font(.title)
            HStack {
                Button {
                    decreaseAction()
                } label: {
                    Text("Previous")
                }
                Spacer()
                Text(description)
                Spacer()
                Button {
                    increaseAction()
                } label: {
                    Text("Next")
                }
            }
        }.padding()
    }
}
