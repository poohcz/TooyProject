import ProjectDescription

let project = Project(
    name: "ToyProject",
    targets: [
        .target(
            name: "ToyProject",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.ToyProject",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            buildableFolders: [
                "ToyProject/Sources",
                "ToyProject/Resources",
            ],
            dependencies: []
        ),
        .target(
            name: "ToyProjectTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.ToyProjectTests",
            infoPlist: .default,
            buildableFolders: [
                "ToyProject/Tests"
            ],
            dependencies: [.target(name: "ToyProject")]
        ),
    ]
)
