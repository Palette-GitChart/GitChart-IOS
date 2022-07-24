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
    
    let getMonthCommit = PublishRelay<String>()
    let getYearCommit = PublishRelay<String>()
    
    let getWeekArray = PublishRelay<[Int]>()
    let getMounthArray = PublishRelay<[Int]>()
    let getYearArray = PublishRelay<[Int]>()
    
    struct input {
        let username : String
    }
    struct output {
        let apiStatus : PublishRelay<Bool>
        let getMonthCommit : PublishRelay<String>
        let getYearCommit : PublishRelay<String>
        let getWeekArray : PublishRelay<[Int]>
        let getMounthArray : PublishRelay<[Int]>
        let getYearArray : PublishRelay<[Int]>
    }
    
    func trans(_ input: input) -> output {
        
        let username = UserDefaults.standard.string(forKey: "username")
        
        let commitCountArray = [API.mounthCommit(username ?? ""), API.yearCommit(username ?? "")]
        let commitRelayArray = [self.getMonthCommit, self.getYearCommit]
        
        API.mounthCommit(username ?? "").requestErrorAlert().subscribe { event in
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
        
        let trandArray = [API.weekArray(username ?? ""), API.monthArray(username ?? ""), API.yearArray(username ?? "")]
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
        
        return output(apiStatus: apiStatus, getMonthCommit: getMonthCommit, getYearCommit: getYearCommit, getWeekArray: getWeekArray, getMounthArray: getMounthArray, getYearArray: getYearArray)
    }
    
}
