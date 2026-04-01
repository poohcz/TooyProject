//
//  TeacherUseCase.swift
//  Domain
//
//  Created by 김동율 on 4/1/26.
//

import Foundation

public protocol TeacherUseCase {
    func startStream(rtmpURL: String)
    func stopStream()
    
}
