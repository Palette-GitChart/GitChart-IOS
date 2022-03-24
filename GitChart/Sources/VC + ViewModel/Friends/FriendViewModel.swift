//
//  FriendViewModel.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/13.
//

import Foundation
import RxSwift
import RxRelay
import SPIndicator


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
        
        let username = UserDefaults.standard.string(forKey: "username")
        
        API.getUserFollowing(username ?? "").request()
            .subscribe { event in
                switch event {
                case .success(let response):
                    guard let data = try? JSONDecoder().decode([Friends].self, from: response.data) else {
                        self.apiStatus.accept(false)
                        return
                    }
                    SPIndicator.present(title: "Requst 성공!", message: "\(data.count)명 데이터를 가져옴", preset: .done, from: .top)
                    self.getUserFriendsList.accept(data)
                    self.apiStatus.accept(true)

                case .failure(let error):
                    print("😔 error : \(error)")
                    self.apiStatus.accept(false)

                }
                
            }.disposed(by: disposeBag)
        
        API.getUserFollowing(username ?? "").requestErrorAlert().subscribe { event in
        }.disposed(by: disposeBag)

        return output(getUserFriendsList: getUserFriendsList, apiStatus: apiStatus)
    }
}
