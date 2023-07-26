//
//  DetailsTopCell.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 26.07.2023.
//

import Foundation
import Kingfisher
import UIKit

struct TopCellModel: Hashable, Equatable {
    var mainImage: String?
    var userImage: String
    var carName: String
    var userName: String
}

final class DetailsTopCell: UICollectionViewCell {
    
    static let identifier = String(describing: DetailsTopCell.self)
    private var shadowLayer = CAShapeLayer()
    
    private let carImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 12
        view.layer.cornerCurve = .continuous
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
  
    private let carLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private let userAvatar: UIImageView = {
        let view = UIImageView()
        view.image = R.image.settingsArrowRight()
        view.layer.cornerRadius = 15
        view.layer.cornerCurve = .continuous
        view.layer.masksToBounds = true
        return view
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawShadows()
    }
    
    // MARK: - Public methods
    func setup(model: TopCellModel) {
        carLabel.text = model.carName
        userNameLabel.text = model.userName
        userAvatar.kf.setImage(
            with: URL(string: model.userImage),
            placeholder: nil,
            options: [
                .processor(DownsamplingImageProcessor(size: CGSize(width: 30, height: 30))),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
        
        guard let carImageURL = model.mainImage else { return }
        carImageView.kf.setImage(
            with: URL(string: carImageURL),
            placeholder: nil,
            options: [
                .processor(DownsamplingImageProcessor(size: CGSize(width: 150, height: 150))),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
        
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        addSubViews()
        setupConstraints()
        contentView.layer.cornerRadius = 12
        contentView.layer.cornerCurve = .continuous
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
        insertShadowLayerToFirstPos()
    }

    private func addSubViews() {
        contentView.addSubviews(carImageView, carLabel, userAvatar, userNameLabel)
    }
    
    // MARK: - SHADOWS
    private func drawShadows() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius)
        shadowLayer.shadowPath = shadowPath.cgPath
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 3)
        shadowLayer.shadowRadius = 3
        shadowLayer.shadowOpacity = 0.15
    }
    
    private func insertShadowLayerToFirstPos() {
        layer.insertSublayer(shadowLayer, at: 0)
    }
}

// MARK: - Constraints
extension DetailsTopCell {
    
    private func setupConstraints() {
        carImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.height.equalTo(150)
            make.width.lessThanOrEqualTo(150)
        }
        
        carLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalTo(carImageView.snp.right).inset(-16)
            make.right.equalToSuperview().inset(16)
        }
        
        userAvatar.snp.makeConstraints { make in
            make.top.equalTo(carLabel.snp.bottom).inset(-16)
            make.left.equalTo(carImageView.snp.right).inset(-16)
            make.width.height.equalTo(30)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userAvatar.snp.centerY)
            make.left.equalTo(userAvatar.snp.right).inset(-8)
            make.right.equalToSuperview().inset(16)
        }
    }
}
