//
    // Project: CombineExample
    //  File: SearchViewModel.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    


import Combine
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .filter { !$0.isEmpty }
            .sink { term in
                print("Searching for: \(term)")
            }
            .store(in: &cancellables)
    }
}

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Search term...", text: $viewModel.searchText)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Text("Results appear in console.")
        }
    }
}
#Preview{
    SearchView()
}
