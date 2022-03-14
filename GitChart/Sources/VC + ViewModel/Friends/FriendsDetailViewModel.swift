//
//  FriendsDetailViewModel.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/14.
//

import Foundation
import RxSwift
import RxRelay

class FriendsDetailViewModel : ViewModel {

    let disposeBag = DisposeBag()
    let apiStatus = PublishRelay<Bool>()
    
    struct input {
        let username : String
    }
    
    struct output {
        let apiStatus : PublishRelay<Bool>
    }
    
    func trans(_ input: input) -> output {
        return output(apiStatus: apiStatus)
    }

}
