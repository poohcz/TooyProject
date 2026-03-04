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
            settings: .settings(
                base: [
                    "DEVELOPMENT_TEAM": "7X4A63UK4A",
                    "CODE_SIGN_STYLE": "Automatic"
                ]
            ),
            sources: ["ToyProject/Sources/**"],
            resources: ["ToyProject/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "ToyProjectTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.ToyProjectTests",
            infoPlist: .default,
            // 💡 테스트 타겟에도 동일하게 추가해주면 편합니다.
            settings: .settings(
                base: [
                    "DEVELOPMENT_TEAM": "7X4A63UK4A",
                    "CODE_SIGN_STYLE": "Automatic"
                ]
            ),
            sources: ["ToyProject/Tests/**"],
            dependencies: [.target(name: "ToyProject")]
        ),
    ]
)
