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
        let didCommitTap : Driver<Bool>
    }
    
    struct output {
        let getUserProfile : PublishRelay<UserProfile>
        let getUserDayCommit : PublishRelay<String>
        let getWeekCommit : PublishRelay<String>
        let getYearCommit : PublishRelay<String>
        let getYearArray : PublishRelay<[Int]>
        let usernameStatus : PublishRelay<Bool>
    }
    
    func trans(_ input: input) -> output {
        
        
        let getUserProfile = PublishRelay<UserProfile>()
        let getUserDayCommit = PublishRelay<String>()
        let getWeekCommit = PublishRelay<String>()
        let getYearCommit = PublishRelay<String>()
        let getYearArray = PublishRelay<[Int]>()
        let usernameStatus = PublishRelay<Bool>()
        
        API.getUserProfile("kimdaehee0824").request()
            .subscribe { (event) in
                switch event {
                case .success(let response):
                    print(response.data)
                    guard let data = try? JSONDecoder().decode(UserProfile.self, from: response.data) else {
                        return
                    }
                    getUserProfile.accept(data)
                    usernameStatus.accept(true)
                case .failure(let error):
                    print(error)
                    usernameStatus.accept(true)
                }
                
            }
        
        
        
        
        
        return output(getUserProfile: getUserProfile, getUserDayCommit: getUserDayCommit, getWeekCommit: getWeekCommit, getYearCommit: getYearCommit, getYearArray: getYearArray, usernameStatus: usernameStatus)
    }
    
    
}
