// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

/**
 * Copyright IBM Corporation and the Kitura project authors 2016-2020
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import PackageDescription

var dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/Kitura/LoggerAPI.git", from: "1.9.200"),
    .package(url: "https://github.com/Kitura/BlueSocket.git", from: "1.0.200"),
    .package(url: "https://github.com/Kitura/CCurl.git", from: "1.1.200"),
    .package(url: "https://github.com/Kitura/BlueSSLService.git", from: "1.0.200")
]

var kituraNetDependencies: [Target.Dependency] = [
    .byNameItem(name: "CHTTPParser"),
    .byNameItem(name: "LoggerAPI"),
    .byNameItem(name: "Socket"),
    .byNameItem(name: "CCurl"),
    .byNameItem(name: "SSLService")
]

#if os(Linux)
dependencies.append(contentsOf: [
    .package(url: "https://github.com/Kitura/CEpoll.git", from: "1.0.200"),
    .package(url: "https://github.com/Kitura/BlueSignals.git", from: "1.0.200")
    ])

kituraNetDependencies.append(contentsOf: [
    .byNameItem(name: "CEpoll"),
    .byNameItem(name: "Signals")
    ])
#endif

let package = Package(
    name: "Kitura-net",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "KituraNet",
            targets: ["KituraNet"]
        )
    ],
    dependencies: dependencies,
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "CHTTPParser"
        ),
        .target(
            name: "KituraNet",
            dependencies: kituraNetDependencies
        ),
        .testTarget(
            name: "KituraNetTests",
            dependencies: ["KituraNet"]
        )
    ]
)
