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
    let getUserProfile = PublishRelay<UserProfile>()
    let getDayCommit = PublishRelay<String>()
    let getYearCommit = PublishRelay<String>()
    let apiStatus = PublishRelay<Bool>()
    
    struct input {
        let username : String
    }
    
    struct output {
        let getUserProfile : PublishRelay<UserProfile>
        let getDayCommit : PublishRelay<String>
        let getYearCommit : PublishRelay<String>
        let apiStatus : PublishRelay<Bool>
    }
    
    func trans(_ input: input) -> output {
        
        API.getUserProfile(input.username).request()
            .subscribe { (event) in
                switch event {
                case .success(let response):
                    print(response.data)
                    guard let data = try? JSONDecoder().decode(UserProfile.self, from: response.data) else {
                        return
                    }
                    self.getUserProfile.accept(data)
                    self.apiStatus.accept(true)
                case .failure(let error):
                    print("😔 error : \(error)")
                    self.apiStatus.accept(false)
                }
            }.disposed(by: disposeBag)

        API.dayCommit(input.username).request()
            .subscribe { event in
                switch event {
                case .success(let response):
                    let data = String(data: response.data, encoding: .utf8)
                    self.getDayCommit.accept(data!)
                    self.apiStatus.accept(true)
                case .failure(let error):
                    print("😔 error : \(error)")
                    self.apiStatus.accept(false)
                }
            }.disposed(by: disposeBag)
        
        API.yearCommit(input.username).request()
            .subscribe { event in
                switch event {
                case .success(let response):
                    let data = String(data: response.data, encoding: .utf8)
                    self.getYearCommit.accept(data!)
                    self.apiStatus.accept(true)
                case .failure(let error):
                    print("😔 error : \(error)")
                    self.apiStatus.accept(false)
                }
            }.disposed(by: disposeBag)
        
        return output(getUserProfile : getUserProfile, getDayCommit: getDayCommit, getYearCommit: getYearCommit, apiStatus: apiStatus)
    }
}
