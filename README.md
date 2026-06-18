# 🔗 Combine Framework Example — SwiftUI

A SwiftUI demo showing how to use Apple's Combine framework for reactive data flow — including debounced search, `@Published` state, and publisher chaining.

---

## 🤔 What this is

CombineExample demonstrates practical Combine usage in a SwiftUI todo/search app. A `SearchViewModel` uses `debounce` and `filter` operators to reactively filter a list of todos as the user types — without firing on every keystroke. `DataStore` shows how `@Published` properties and `ObservableObject` form the backbone of a Combine-driven data layer.

## ✅ Why you'd use it

- **`debounce` operator** — delays search execution until the user stops typing, reducing unnecessary work
- **`filter` and `map` operators** — chain transformations on publisher streams
- **`@Published` + `ObservableObject`** — the standard Combine-backed ViewModel pattern
- **`SearchViewModel`** — shows a real use case where Combine shines over simple `@State`
- **`DataStore`** — demonstrates a shared observable data source using Combine publishers

## 📺 Watch on YouTube

[![Watch on YouTube](https://img.shields.io/badge/YouTube-Watch%20the%20Tutorial-red?style=for-the-badge&logo=youtube)](https://youtu.be/EkDH2sUA2cI)

> This project was built for the [NoahDoesCoding YouTube channel](https://www.youtube.com/@noahdoescoding).

---

## 🚀 Getting Started

### 1. Clone the Repo
```bash
git clone https://github.com/NDCSwift/CombineExample.git
cd CombineExample
```

### 2. Open in Xcode
Double-click `CombineExample.xcodeproj`.

### 3. Set Your Development Team
TARGET → Signing & Capabilities → Team

### 4. Update the Bundle Identifier
Change `com.example.MyApp` to a unique identifier.

---

## 🛠️ Notes
- Combine is built into Apple's frameworks — no additional dependencies.
- For simpler reactive state, prefer `@Observable` (Swift 5.9+); reach for Combine when you need operator chaining.

## 📦 Requirements
- Xcode 16+
- iOS 17+

📺 [Watch the guide on YouTube](https://youtu.be/EkDH2sUA2cI)
