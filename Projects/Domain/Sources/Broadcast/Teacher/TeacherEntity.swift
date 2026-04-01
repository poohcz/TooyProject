//
//  TeacherEntity.swift
//  Domain
//
//  Created by 김동율 on 4/1/26.
//



public struct TeacherEntity {
    public let id: String
    public let title: String
    public let rtmpURL: String
    public let streamKey: String
    
    public init(id: String, title: String, rtmpURL: String, streamKey: String) {
        self.id = id
        self.title = title
        self.rtmpURL = rtmpURL
        self.streamKey = streamKey
    }
}
