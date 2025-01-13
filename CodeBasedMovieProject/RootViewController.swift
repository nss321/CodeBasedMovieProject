//
//  RootViewController.swift
//  CodeBasedMovieProject
//
//  Created by BAE on 1/13/25.
//

import UIKit

final class RootViewController: UIViewController, ViewPresentableProtocol {
    
    
    lazy var firstButton = makeButton(title: "션플릭스", navigateTo: .seanFlix)
    lazy var secondButton = makeButton(title: "네입버페이", navigateTo: .naverPay)
    lazy var thirdButton = makeButton(title: "영화검색", navigateTo: .moodiKind)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .white
        setConstraints()
    }
    
    func setConstraints() {
        [firstButton, secondButton, thirdButton].forEach{ 
            view.addSubview($0)
        }
        
        firstButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
        
        secondButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()

        }
        
        thirdButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(1.2)
            $0.centerX.equalToSuperview()

        }
        
    }
    
    func makeButton(title: String, navigateTo: NavigateTo) -> UIButton {
        var config = UIButton.Configuration.plain()
        
        config.title = title
        
        let btn = UIButton(configuration: config, primaryAction: navigateAction(destination: navigateTo))
        
        return btn
    }
    
    func navigateAction(destination: NavigateTo) -> UIAction {
        var vc: UIViewController
        
        switch destination {
        case .seanFlix:
            vc = SeanFlixViewController()
            break
        case .naverPay:
            vc = NaverPayViewController()
            break
        case .moodiKind:
            vc = MoodiLikeViewController()
            break
        }
        
        var action = UIAction { _ in
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return action
    }
}

enum NavigateTo: Int {
    case seanFlix = 0
    case naverPay = 1
    case moodiKind = 2
}
