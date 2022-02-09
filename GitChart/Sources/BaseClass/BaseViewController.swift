//
//  BaseViewController.swift
//  GitChart
//
//  Created by 김대희 on 2022/02/03.
//

import UIKit

import RxSwift
import RxCocoa
import RxRelay

import Then
import SnapKit

class BaseViewController: UIViewController {
    
    // 자주 사용하는 프로퍼티를 넣어줘도 되요
    // MARK: - Property
    var disposeBag = DisposeBag()
    private(set) var didSetupConstraints = false
    
    // MARK: - Initializing
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLayoutSubviews() {
        self.setLayout()
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .appColor(.backgroundColor)
        self.configureUI()
        self.setupConstraints()
        self.initialize()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    func initialize() {
        
    }
    
    func configureUI() {
        
    }
    
    func setupConstraints() {
        // Override point
    }
    func setLayout() {
        
    }
    
}
