//
//  StarViewModel.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/10.
//

import Foundation
import RxSwift
import RxRelay

class StarViewModwl : ViewModel {
    
    let disposeBag = DisposeBag()
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
        API.getUserStarred(input.username).request()
            .subscribe { event in
                switch event {
                case .success(let response):
                    print(response.data)
                    guard let data = try? JSONDecoder().decode([Starred].self, from: response.data) else {
                        self.apiStatus.accept(false)
                        return
                    }
                    self.getUserStarList.accept(data)
                    self.apiStatus.accept(true)
                case .failure(let error):
                    print("😔 error : \(error)")
                    self.apiStatus.accept(false)
                }
                
            }.disposed(by: disposeBag)
        
        API.getUserStarred(input.username).requestErrorAlert().subscribe { _ in
        }.disposed(by: disposeBag)
        
        return output(getUserStarList: getUserStarList, apiStatus: apiStatus)
    }
    
    
}
