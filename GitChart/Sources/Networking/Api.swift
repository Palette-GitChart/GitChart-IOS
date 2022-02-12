//
//  Api.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/12.
//

import Foundation

enum API {
    
    // Commit
    
    case dayCommit(_ name: String)
    case weekCommit(_ name: String)
    case mounthCommit(_ name: String)
    case yearCommit(_ name: String)
    
    // Commit Array
    
    case weekArray(_ name: String)
    case mounthArray(_ name: String)
    case yearArray(_ name: String)
    
    
}
