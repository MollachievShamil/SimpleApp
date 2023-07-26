//
//  SettingsDefaultCell.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 26.07.2023.
//

import Foundation
import UIKit

final class SettingsDefaultCell: UICollectionViewCell {
    
    static let identifier = String(describing: SettingsDefaultCell.self)
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .black
        return view
    }()
  
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        return label
    }()
    
    private let rightIcon: UIImageView = {
        let view = UIImageView()
        view.image = R.image.settingsArrowRight()
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func setup(type: SettingsCellType) {
        imageView.image = type.getImage()
        titleLabel.text = type.getTitle()
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        addSubViews()
        setupConstraints()
        contentView.layer.cornerRadius = 12
        contentView.layer.cornerCurve = .continuous
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
    }

    private func addSubViews() {
        contentView.addSubviews(imageView, titleLabel, rightIcon)
    }
}

// MARK: - Constraints
extension SettingsDefaultCell {
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).inset(-8)
            make.centerY.equalToSuperview()
        }
        
        rightIcon.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
        }
    }
}
