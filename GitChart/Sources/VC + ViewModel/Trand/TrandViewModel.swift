//
//  TrandViewModel.swift
//  GitChart
//
//  Created by 김대희 on 2022/03/14.
//

import UIKit
import RxSwift
import RxRelay

class TrandViewModel : ViewModel {
    
    let disposeBag = DisposeBag()
    let apiStatus = PublishRelay<Bool>()
    
    let getMounthCommit = PublishRelay<String>()
    let getYearCommit = PublishRelay<String>()
    
    let getWeekArray = PublishRelay<[Int]>()
    let getMounthArray = PublishRelay<[Int]>()
    let getYearArray = PublishRelay<[Int]>()
    
    struct input {
        let username : String
    }
    struct output {
        let apiStatus : PublishRelay<Bool>
        let getMounthCommit : PublishRelay<String>
        let getYearCommit : PublishRelay<String>
        let getWeekArray : PublishRelay<[Int]>
        let getMounthArray : PublishRelay<[Int]>
        let getYearArray : PublishRelay<[Int]>
    }
    
    func trans(_ input: input) -> output {
        
        let commitCountArray = [API.mounthCommit(input.username), API.yearCommit(input.username)]
        let commitRelayArray = [self.getMounthCommit, self.getYearCommit]
        
        API.mounthCommit(input.username).requestErrorAlert().subscribe { event in
        }.disposed(by: disposeBag)

        for count in 0..<2 {
            commitCountArray[count].request()
                .subscribe { (event) in
                    switch event {
                    case .success(let response):
                        let data = String(data: response.data, encoding: .utf8)
                        commitRelayArray[count].accept(data!)
                        self.apiStatus.accept(true)
                    case .failure(let error):
                        print("😔 error : \(error)")
                        self.apiStatus.accept(false)
                    }
                }.disposed(by: disposeBag)
        }
        
        let trandArray = [API.weekArray(input.username), API.monthArray(input.username), API.yearArray(input.username)]
        let trandRelayArray = [self.getWeekArray, self.getMounthArray, self.getYearArray]
        
        for count in 0..<3 {
            trandArray[count].request()
                .subscribe { (event) in
                    switch event {
                    case .success(let response):
                        guard let data = try? JSONDecoder().decode([Int].self, from: response.data) else
                        { return }
                        trandRelayArray[count].accept(data)
                        self.apiStatus.accept(true)
                    case .failure(let error):
                        print("😔 error : \(error)")
                        self.apiStatus.accept(false)
                    }
                }.disposed(by: disposeBag)
        }
        
        return output(apiStatus: apiStatus, getMounthCommit: getMounthCommit, getYearCommit: getYearCommit, getWeekArray: getWeekArray, getMounthArray: getMounthArray, getYearArray: getYearArray)
    }
    
}
