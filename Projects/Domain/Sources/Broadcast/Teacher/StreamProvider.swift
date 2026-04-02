//
//  StreamProvider.swift
//  Domain
//
//  Created by 김동율 on 4/1/26.
//



import Foundation

public protocol StreamProvider {
    func attach(to view: Any)
}
