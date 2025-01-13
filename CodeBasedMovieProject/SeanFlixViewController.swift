//
//  ViewController.swift
//  CodeBasedMovieProject
//
//  Created by BAE on 1/13/25.
//

import UIKit
import SnapKit
import Then

final class SeanFlixViewController: UIViewController, ViewPresentableProtocol {

    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 32, weight: .heavy)
        $0.textColor = .systemRed
        $0.textAlignment = .center
        $0.text = "SEANFLIX"
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 10
        $0.distribution = .fill
    }
    
    private let placeHolders = ["이메일 주소 또는 전화번호", "비밀번호", "닉네임", "위치", "추천 코드 입력"]
    
    var textFieldArray: [UITextField] {
        var arr: [UITextField] = []
        placeHolders.forEach {
            arr.append(makeTextField(placeHolder: $0))
        }
        return arr
    }
    
    //    lazy var signupButtonAction = UIAction { _ in
    //        self.signupButtonTapped()
    //    }
    //
    //    lazy var signupButton = UIButton(frame: .zero, primaryAction: signupButtonAction).then {
    //        var config = UIButton.Configuration.plain()
    //        var attributedTitle = AttributedString("회원가입")
    //        attributedTitle.font = .systemFont(ofSize: 15, weight: .bold)
    //        attributedTitle.foregroundColor = UIColor.black
    //        config.attributedTitle = attributedTitle
    //        config.cornerStyle = .small
    //        config.background.backgroundColor = .white
    //        config.baseForegroundColor = .black
    //        $0.configuration = config
    //    }
    
    lazy var signupButton = UIButton(frame: .zero, primaryAction: UIAction(handler: { _ in
        self.signupButtonTapped()
    }))
        .then {
            var config = UIButton.Configuration.plain()
//            var attributedTitle = AttributedString("회원가입")
//            attributedTitle.font = .systemFont(ofSize: 15, weight: .bold)
//            attributedTitle.foregroundColor = UIColor.black
//            config.attributedTitle = attributedTitle
            config.title = "회원가입"
            config.baseForegroundColor = .black
            config.cornerStyle = .small
            config.background.backgroundColor = .white
            config.baseForegroundColor = .black
            $0.configuration = config
        }
    
    private let optionalLabel = UILabel().then {
        $0.text = "추가 정보 입력"
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .white
    }
    
    private let switcher = UISwitch().then {
        $0.onTintColor = .systemRed
        $0.thumbTintColor = .white
        $0.isOn = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setConstraints()
    }

    func setConstraints() {
        [titleLabel, stackView, signupButton, optionalLabel, switcher].forEach { view.addSubview($0) }
        
        textFieldArray.forEach {
            stackView.addArrangedSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(80)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
            $0.leading.right.equalToSuperview().inset(32)
        }
        
        stackView.arrangedSubviews.forEach {
            $0.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(36)
            }
        }
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(44)
        }
        
        optionalLabel.snp.makeConstraints {
            $0.top.equalTo(signupButton.snp.bottom).offset(20)
            $0.leading.equalTo(stackView.snp.leading)
        }
        
        switcher.snp.makeConstraints {
            $0.centerY.equalTo(optionalLabel)
            $0.trailing.equalTo(stackView.snp.trailing)
        }
        
    }
    
    func makeTextField(placeHolder: String) -> UITextField {
        let tf = UITextField()
        tf.attributedText = NSAttributedString(string: placeHolder, attributes: [.foregroundColor : UIColor.systemGray6])
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 4
        tf.backgroundColor = .darkGray
        tf.textAlignment = .center
        
        return tf
    }
    
    func signupButtonTapped() {
        print(#function
        )
    }
}

