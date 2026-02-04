// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "HSKFlashcards",
    platforms: [.iOS(.v15)],
    products: [
        .executable(name: "HSKFlashcards", targets: ["HSKFlashcards"]),
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "HSKFlashcards",
            dependencies: [],
            swiftSettings: [.define("DEBUG")]
        ),
    ]
)
