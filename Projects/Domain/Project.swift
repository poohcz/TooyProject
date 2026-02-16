import ProjectDescription

let project = Project(
    name: "Domain",
    targets: [
        .target(
            name: "Domain",
            destinations: .iOS,
            product: .framework,
            bundleId: "dev.dan12.Domain",
            sources: ["Sources/**"]
        )
    ]
)




