//
//  StarViewModel.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/10.
//

import Foundation
import RxSwift
import RxRelay
import SPIndicator

class StarViewModel : ViewModel {
    
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
        
        let username = UserDefaults.standard.string(forKey: "username")
        
        API.getUserStarred(username ?? "").request()
            .subscribe { event in
                switch event {
                case .success(let response):
                    print(response.data)
                    guard let data = try? JSONDecoder().decode([Starred].self, from: response.data) else {
                        self.apiStatus.accept(false)
                        return
                    }
                    SPIndicator.present(title: "Requst 성공!", message: "30개의 Star 정보를 가져옴", preset: .done, from: .top)
                    self.getUserStarList.accept(data)
                    self.apiStatus.accept(true)
                case .failure(let error):
                    print("😔 error : \(error)")
                    self.apiStatus.accept(false)
                }
                
            }.disposed(by: disposeBag)
        
        API.getUserStarred(username ?? "").requestErrorAlert().subscribe { _ in
        }.disposed(by: disposeBag)
        
        return output(getUserStarList: getUserStarList, apiStatus: apiStatus)
    }
    
}
