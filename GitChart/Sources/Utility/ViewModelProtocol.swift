//
//  ViewModelProtocol.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/28.
//

import Foundation

protocol ViewModel {
    associatedtype input
    associatedtype output
    
    func transform(_ input: input) -> output
}
