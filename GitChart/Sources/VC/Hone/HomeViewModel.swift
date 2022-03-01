//
//  HomeViewModel.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/25.
//

import Foundation
import RxRelay
import RxSwift
import RxCocoa
import Moya

class HomeViewModel : ViewModel  {
    
    private let bag = DisposeBag()
    
    struct input {
        let didCommitTap : Driver<String>
    }
    
    struct output {
        let getUserProfile : PublishRelay<UserProfile>
        let getUserDayCommit : PublishRelay<String>
        let getWeekCommit : PublishRelay<String>
        let getYearCommit : PublishRelay<String>
        let getYearArray : PublishRelay<[Int]>
    }
    
    func transform(_ input: input) -> output {
        return output()
    }
    
    
}
