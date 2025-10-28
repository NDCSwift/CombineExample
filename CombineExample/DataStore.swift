//
    // Project: CombineExample
    //  File: DataStore.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    


import Combine
import SwiftUI

class DataStore: ObservableObject {
    @Published var itemCount: Int = 0
    
    func increment() {
        itemCount += 1
    }
}