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
    
    let disposeBag = DisposeBag()
    let getUserFriendsList = PublishRelay<[Friends]>()
    let apiStatus = PublishRelay<Bool>()
    
    struct input {
        let username : String
    }
    
    struct output {
        let getUserFriendsList : PublishRelay<[Friends]>
        let apiStatus : PublishRelay<Bool>
    }
    
    func trans(_ input: input) -> output {
        API.getUserFollowing(input.username).request()
            .subscribe { event in
                switch event {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode([Friends].self, from: response.data) else {
                        self.apiStatus.accept(false)
                        return
                    }
                    self.getUserFriendsList.accept(data)
                    self.apiStatus.accept(true)

                case .failure(let error):
                    print("😔 error : \(error)")
                    self.apiStatus.accept(false)

                }
                
            }.disposed(by: disposeBag)
        return output(getUserFriendsList: getUserFriendsList, apiStatus: apiStatus)
    }
}
