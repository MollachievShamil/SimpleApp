//
//  TransparentHeader.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 26.07.2023.
//

import SnapKit
import UIKit

final class TransparentHeader: UIView {
    
    var leftButtonTappedCallback: (() -> Void)?
    
    enum LeftButtonType {
        case menu
        case crossButton
        
        func getImage() -> UIImage? {
            switch self {
            case .menu:
                return R.image.menu()?.withTintColor(.black)
            case .crossButton:
                return R.image.cross()?.withTintColor(.black)
            }
        }
    }
    
    private var blackoutView = UIView()
    private var blurEffectStyle: UIBlurEffect.Style = .light
    private var blurRadiusDriver: UIViewPropertyAnimator?
  
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    let blurView = UIVisualEffectView(effect: nil)
    
    // MARK: - init
    init(type: LeftButtonType) {
        super.init(frame: .zero)
        setupSubviews()
        backgroundColor = .backgroundColor.withAlphaComponent(0.8)
        leftButton.setImage(type.getImage(), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        reinitBlurView()
    }
    
    // MARK: - Open func
    
    func setupTitle(title: String) {
        titleLabel.text = title
    }

    func releaseBlurAnimation() {
        blurRadiusDriver?.stopAnimation(true)
    }
    
    func reinitBlurView() {
        blurRadiusDriver?.stopAnimation(true)
        blurRadiusDriver?.finishAnimation(at: .current)
        
        blurView.effect = nil
        blurRadiusDriver = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
            self.blurView.effect = UIBlurEffect(style: self.blurEffectStyle)
        })
        blurRadiusDriver?.fractionComplete = 0.2
    }
    
    // MARK: - Private func

    @objc
    private func leftButtonAction() {
        leftButtonTappedCallback?()
    }
    
    private func setupSubviews() {
        addSubviews(blurView)
        blurView.contentView.addSubview(leftButton)
        blurView.contentView.addSubview(titleLabel)
        
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        leftButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(8)
            make.left.equalToSuperview().inset(16)
            make.width.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(leftButton)
            make.height.equalTo(24)
            make.bottom.equalToSuperview().inset(8)
        }
    }
}
