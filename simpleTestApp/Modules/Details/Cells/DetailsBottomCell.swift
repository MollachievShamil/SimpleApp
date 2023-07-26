//
//  DetailsBottomCell.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 26.07.2023.
//

import Foundation
import Kingfisher
import UIKit

final class DetailsBottomCell: UICollectionViewCell {
    
    static let identifier = String(describing: DetailsBottomCell.self)
    private var shadowLayer = CAShapeLayer()
    
    private let carImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 12
        view.layer.cornerCurve = .continuous
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
  
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 8)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 8)
        return label
    }()
    
    private let likeImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "hand.thumbsup")
        view.tintColor = .black
        return view
    }()
    
    private let likeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 8)
        return label
    }()
    
    private let commentImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "hand.thumbsup")
        view.tintColor = .black
        return view
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 8)
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
    func setup(model: BottomCellModel) {
        dateLabel.text = model.date
        descriptionLabel.text = model.description
        likeLabel.text = model.numberOfLikes
        commentLabel.text = model.numberOfComments
        guard let carImageUrl = model.mainImage else { return }
        carImageView.kf.setImage(
            with: URL(string: carImageUrl),
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
        contentView.addSubviews(carImageView,
                                dateLabel,
                                descriptionLabel,
                                likeImageView,
                                likeLabel,
                                commentImageView,
                                commentLabel)
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
extension DetailsBottomCell {
    
    private func setupConstraints() {
        carImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(80)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(carImageView.snp.bottom).inset(-2)
            make.left.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).inset(0)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(25)
        }
        
        likeImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.width.height.equalTo(13)
            make.bottom.equalToSuperview().inset(6)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeImageView.snp.centerY)
            make.left.equalTo(likeImageView.snp.right).inset(-4)
        }
        
        commentImageView.snp.makeConstraints { make in
            make.left.equalTo(likeLabel.snp.right).inset(-4)
            make.width.height.equalTo(13)
            make.centerY.equalTo(likeImageView.snp.centerY)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(commentImageView.snp.centerY)
            make.left.equalTo(commentImageView.snp.right).inset(-4)
        }
    }
}
