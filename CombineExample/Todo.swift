//
    // Project: CombineExample
    //  File: Todo.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    


import UIKit

// A simple Codable model we’ll decode from JSON
struct Todo: Codable {
    let id: Int
    let title: String
}

final class ViewController: UIViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        startFlow() // kick it off
    }

    // MARK: - Old-school nested callbacks (fetch → decode → save → refresh)

    private func startFlow() {
        setLoading(true)

        fetchData { [weak self] data, fetchError in
            guard let self = self else { return }

            if let fetchError = fetchError {
                self.handleError(fetchError, step: "Fetch")
                self.setLoading(false)
                return
            }

            guard let data = data else {
                self.handleError(NSError(domain: "App", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"]), step: "Fetch")
                self.setLoading(false)
                return
            }

            self.decodeTodo(from: data) { todo, decodeError in
                if let decodeError = decodeError {
                    self.handleError(decodeError, step: "Decode")
                    self.setLoading(false)
                    return
                }

                guard let todo = todo else {
                    self.handleError(NSError(domain: "App", code: -2, userInfo: [NSLocalizedDescriptionKey: "No model"]), step: "Decode")
                    self.setLoading(false)
                    return
                }

                self.save(todo: todo) { success, saveError in
                    if let saveError = saveError {
                        self.handleError(saveError, step: "Save")
                        self.setLoading(false)
                        return
                    }

                    guard success else {
                        self.handleError(NSError(domain: "App", code: -3, userInfo: [NSLocalizedDescriptionKey: "Save failed"]), step: "Save")
                        self.setLoading(false)
                        return
                    }

                    self.refreshUI(with: todo) {
                        // done!
                        self.setLoading(false)
                    }
                }
            }
        }
    }

    // MARK: - Steps

    /// Step 1: Fetch raw data (URLSession-style)
    private func fetchData(completion: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            // Call back on main only to mimic old UI-centric code
            DispatchQueue.main.async {
                completion(data, error)
            }
        }.resume()
    }

    /// Step 2: Decode JSON into model
    private func decodeTodo(from data: Data, completion: @escaping (Todo?, Error?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let todo = try JSONDecoder().decode(Todo.self, from: data)
                DispatchQueue.main.async { completion(todo, nil) }
            } catch {
                DispatchQueue.main.async { completion(nil, error) }
            }
        }
    }

    /// Step 3: Save the model (pretend persistence)
    private func save(todo: Todo, completion: @escaping (Bool, Error?) -> Void) {
        // Simulate a write (e.g., Core Data / file / UserDefaults)
        DispatchQueue.global(qos: .utility).async {
            // Pretend this takes time…
            sleep(1)
            let success = true // or false if something went wrong
            DispatchQueue.main.async {
                completion(success, success ? nil : NSError(domain: "App", code: -4, userInfo: [NSLocalizedDescriptionKey: "Failed to save"]))
            }
        }
    }

    /// Step 4: Refresh the UI (table reload, label update, etc.)
    private func refreshUI(with todo: Todo, completion: @escaping () -> Void) {
        // Always touch UI on main
        DispatchQueue.main.async {
            // e.g., self.titleLabel.text = todo.title
            print("Refreshing UI with: \(todo.title)")
            completion()
        }
    }

    // MARK: - Helpers

    private func setLoading(_ loading: Bool) {
        // e.g., show/hide spinner
        print(loading ? "Loading…" : "Done")
    }

    private func handleError(_ error: Error, step: String) {
        // e.g., show an alert
        print("❌ \(step) error:", error.localizedDescription)
    }
}
