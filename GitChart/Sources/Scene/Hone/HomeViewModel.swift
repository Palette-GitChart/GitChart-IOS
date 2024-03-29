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
import RxGesture
import Moya

class HomeViewModel : ViewModel  {
    
    private let bag = DisposeBag()
    
    let getUserProfile = PublishRelay<UserProfile>()
    let getUserDayCommit = PublishRelay<String>()
    let getWeekCommit = PublishRelay<String>()
    let getTrandArray = PublishRelay<[Int]>()
    let usernameStatus = PublishRelay<Bool>()
    
    
    struct input {
        let username : String
    }
    
    struct output {
        let getUserProfile : PublishRelay<UserProfile>
        let getUserDayCommit : PublishRelay<String>
        let getWeekCommit : PublishRelay<String>
        let getTrendArray: PublishRelay<[Int]>
        let usernameStatus : PublishRelay<Bool>
    }
    
    func trans(_ input: input) -> output {
        
        let username = UserDefaults.standard.string(forKey: "username")

        
        API.getUserProfile(username ?? "").request()
            .subscribe { (event) in
                
                switch event {
                case .success(let response):
                    print(response.data)
                    guard let data = try? JSONDecoder().decode(UserProfile.self, from: response.data) else {
                        return
                    }
                    self.getUserProfile.accept(data)
                    self.usernameStatus.accept(true)
                case .failure(let error):
                    print("😔 error : \(error)")
                    self.usernameStatus.accept(false)
                }
            }.disposed(by: bag)
        
        //MARK: Commit Count
        
        let commitCountArray : [API] = [.dayCommit(username ?? ""), .weekCommit(username ?? "")]
        let commitCountOutput : [PublishRelay<String>] = [getUserDayCommit, getWeekCommit]
        
        for count in 0..<2 {
            DispatchQueue.global().async {
                commitCountArray[count].request()
                    .subscribe { (event) in
                        switch event {
                        case .success(let response):
                            let data = String(data: response.data, encoding: .utf8)
                            commitCountOutput[count].accept(data!)
                            self.usernameStatus.accept(true)
                        case .failure(let error):
                            print("😔 error : \(error)")
                        }
                    }.disposed(by: self.bag)
                
            }
        }
        
        //MARK: CommitArray
        
        API.monthArray(username ?? "").request()
            .subscribe { (event) in
                switch event {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode([Int].self, from: response.data) else
                    { return }
                    self.getTrandArray.accept(data)
                    self.usernameStatus.accept(true)
                case .failure(let error):
                    print("😔 error : \(error)")
                }
            }.disposed(by: bag)

        
        API.getUserProfile(username ?? "").requestErrorAlert().subscribe { event in
        }.disposed(by: bag)

        return output(getUserProfile: getUserProfile, getUserDayCommit: getUserDayCommit, getWeekCommit: getWeekCommit, getTrendArray: getTrandArray, usernameStatus: usernameStatus)
    }
}
