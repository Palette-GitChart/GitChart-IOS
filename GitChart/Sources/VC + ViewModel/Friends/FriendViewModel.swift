//
//  FriendViewModel.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/13.
//

import Foundation
import RxSwift
import RxRelay


class FriendViewModel : ViewModel {
    let getUserStarList = PublishRelay<[Starred]>()
    let apiStatus = PublishRelay<Bool>()
    
    struct input {
        let username : String
    }
    
    struct output {
        let getUserStarList : PublishRelay<[Starred]>
        let apiStatus : PublishRelay<Bool>
    }
    
    func trans(_ input: input) -> output {
        return output(getUserStarList: getUserStarList, apiStatus: apiStatus)
    }
}
