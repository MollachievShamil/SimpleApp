//
//  MainCollectionViewCell.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 26.07.2023.
//

import Kingfisher
import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: MainCollectionViewCell.self)
    private var shadowLayer = CAShapeLayer()
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawShadows()
    }
    
    // MARK: - Public methods
    func setup(model: MainCollectionCellModel) {
        titleLabel.text = model.title
        
        imageView.kf.setImage(
            with: URL(string: model.image),
            placeholder: nil,
            options: [
                .processor(DownsamplingImageProcessor(size: CGSize(width: 200, height: 140))),
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
        contentView.addSubviews(imageView, titleLabel, rightIcon)
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
extension MainCollectionViewCell {
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(35)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(16)
        }
        
        rightIcon.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(18)
            make.centerY.equalToSuperview()
        }
    }
}
