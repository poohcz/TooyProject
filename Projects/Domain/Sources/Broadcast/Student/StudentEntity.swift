//
//  StudentEntity.swift
//  Domain
//
//  Created by 김동율 on 4/1/26.
//



public struct StudentEntity {
    public let id: String
    public let title: String
    public let hlsURL: String
    public let viewerCount: Int
    
    public init(id: String, title: String, hlsURL: String, viewerCount: Int) {
        self.id = id
        self.title = title
        self.hlsURL = hlsURL
        self.viewerCount = viewerCount
    }
}
