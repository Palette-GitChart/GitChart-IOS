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
        return output(apiStatus: apiStatus, getMounthCommit: getMounthCommit, getYearCommit: getYearCommit, getWeekArray: getWeekArray, getMounthArray: getMounthArray, getYearArray: getYearArray)
    }
    
}
