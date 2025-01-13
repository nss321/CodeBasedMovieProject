//
//  NaverPayViewController.swift
//  CodeBasedMovieProject
//
//  Created by BAE on 1/13/25.
//

import UIKit

final class NaverPayViewController: UIViewController, ViewPresentableProtocol {
    
    var toggle = false
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .blue.withAlphaComponent(0.1)
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    private let segment = UISegmentedControl(items: ["멤버십", "현장결제", "쿠폰"]).then {
        $0.selectedSegmentIndex = 1
        $0.selectedSegmentTintColor = .darkGray
        $0.setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        $0.setTitleTextAttributes([.foregroundColor : UIColor.systemGray], for: .normal)
    }
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "npay_logo")
        $0.contentMode = .scaleAspectFit
        //        $0.layer.borderWidth = 1
        //        $0.layer.borderColor = UIColor.red.cgColor
    }
    
    private let regionButton = UIButton(primaryAction: UIAction(handler: { _ in
        print(#function)
    })).then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 8, weight: .medium, scale: .small)
        let image = UIImage(systemName: "arrowtriangle.down.fill", withConfiguration: imageConfig)?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        $0.setImage(image, for: .normal)
        
        $0.setTitle("국내", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -70)
    }
    
    private let xButton = UIButton(primaryAction: UIAction(handler: { _ in
        print(#function)
    })).then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium, scale: .small)
        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        $0.setImage(image, for: .normal)
    }
    
    private let lockImageView = UIImageView().then {
        $0.image = UIImage(named: "lock")
        $0.contentMode = .scaleAspectFit
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.red.cgColor
    }
    
    private let contentLabel = UILabel().then {
        $0.text = "한 번만 인증하고\n비밀번호 없이 결제하세요"
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 14)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.red.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setConstraints()
    }
    
    lazy var checkButton = UIButton().then {
        $0.setTitle("바로결제 사용하기", for: .normal)
        $0.setTitleColor(.label, for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.circle")?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        $0.backgroundColor = .clear
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        $0.addTarget(self, action: #selector(toggleCheckButton), for: .touchUpInside)
    }
    
    lazy var confirmButton = UIButton(primaryAction: UIAction(handler: { _ in
        print("confirmButton")
    })).then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .green
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 22
    }
    
    func setConstraints() {
        [backgroundView, segment, containerView].forEach { view.addSubview($0) }
        
        [logoImageView, regionButton, xButton, lockImageView, contentLabel, checkButton, confirmButton].forEach { containerView.addSubview($0) }
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        segment.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(32)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalToSuperview().inset(300)
        }
        
        
        logoImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(16)
            $0.width.equalTo(60)
            $0.height.equalTo(30)
        }
        
        regionButton.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing)
            $0.centerY.equalTo(logoImageView)
        }
        
        xButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(logoImageView)
        }
        
        lockImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImageView.snp.bottom).offset(28)
            $0.horizontalEdges.equalToSuperview().inset(140)
            $0.height.equalTo(120)
        }
        
        contentLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(lockImageView.snp.bottom).offset(10)
        }
        
        checkButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentLabel.snp.bottom).offset(50)
        }

        confirmButton.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.horizontalEdges.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    @objc
    func toggleCheckButton(_ sender: UIButton) {
        if toggle {
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal), for: .normal)
        }
        toggle.toggle()
    }
}
