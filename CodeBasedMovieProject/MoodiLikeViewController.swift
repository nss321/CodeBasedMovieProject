//
//  MoodiLikeViewController.swift
//  CodeBasedMovieProject
//
//  Created by BAE on 1/13/25.
//

import UIKit

final class MoodiLikeViewController: UIViewController, ViewPresentableProtocol {
    
    lazy var textField = UITextField().then {
        $0.textColor = .white
        $0.borderStyle = .none
//        $0.layer.borderWidth = 1
//        $0.layer.borderColor = UIColor.red.cgColor
    }
    
    private let searchButton = UIButton(primaryAction: UIAction(handler: { _ in
        print("searchButton")
    })).then {
        $0.setTitle("검색", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
    }
    
    lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.rowHeight = UIScreen.main.bounds.height / 20
    }
    
    private let dim = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.9)
    }
    
    private let underline = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 2, height: 2)
        $0.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        textField.addUnderLine(width: 4, color: .white)
//    }
    
    func setConstraints() {
        [dim, underline, textField, searchButton, tableView].forEach { view.addSubview($0) }
        
        dim.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.leading.equalToSuperview().inset(12)
        }
        
        underline.snp.makeConstraints {
            $0.bottom.equalTo(textField.snp.bottom)
            $0.leading.trailing.equalTo(textField)
            $0.height.equalTo(2)
        }
        
//        textField.addUnderLine(width: textField.frame.size.width, color: .white)
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.top)
            $0.leading.equalTo(textField.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(12)
            $0.width.equalTo(100)
            $0.height.equalTo(textField)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchButton.snp.bottom).offset(12)
            $0.leading.bottom.trailing.equalToSuperview().inset(12)
        }
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(MoodiLikeTableViewCell.self, forCellReuseIdentifier: MoodiLikeTableViewCell.identifier)
    }
}

extension MoodiLikeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoodiLikeTableViewCell.identifier, for: indexPath) as! MoodiLikeTableViewCell
        
        cell.config(row: movieList[indexPath.row])
        return cell
    }
}


final class MoodiLikeTableViewCell: UITableViewCell, ViewPresentableProtocol {
    
    static let identifier = "MoodiLikeTableViewCell"
    
    private let rankLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textAlignment = .center
        $0.backgroundColor = .white
    }
    private let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 15)
        $0.backgroundColor = .clear
        $0.textColor = .white
    }
    private let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.backgroundColor = .clear
        $0.textColor = .white
        $0.setContentCompressionResistancePriority(.init(rawValue: 752), for: .horizontal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        backgroundView?.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        [rankLabel, titleLabel, dateLabel].forEach { contentView.addSubview($0) }
        
        contentView.backgroundColor = .clear
        rankLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.height / 20 - 8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(10)
            $0.trailing.equalTo(dateLabel.snp.leading)
            $0.centerY.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(4)
        }
        
    }
    
    func config(row: Movie){
        rankLabel.text = "\(row.rank)"
        titleLabel.text = row.title
        dateLabel.text = row.releaseDate
    }
}

//extension UITextField {
//    func addUnderLine(width: CGFloat, color: UIColor) {
//        let border = CALayer()
//        let thickness = CGFloat(2)
//        border.borderColor = color.cgColor
//        border.frame = CGRect(x: 0, y: self.frame.size.height, width: width, height: thickness)
//        border.borderWidth = thickness
//        self.layer.addSublayer(border)
//    }
//}
