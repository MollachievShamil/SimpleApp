//
//  LaunchScreenViewController.swift
//  simpleTestApp
//
//  Created by Шамиль Моллачиев on 25.07.2023.
//

import Lottie
import SnapKit
import UIKit

class LaunchScreenViewController: UIViewController {
    
    private var timer: Timer?
    
    private var animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.animation = LottieAnimation.named("carAnimation")
        view.contentMode = .scaleAspectFill
        view.loopMode = .loop
        view.animationSpeed = 1.5
        view.play()
        return view
    }()
    
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.progress = 0
        view.layer.cornerRadius = 4
        view.layer.cornerCurve = .continuous
        view.layer.masksToBounds = true
        view.progressTintColor = hexColor(hex: "6AC8C8")
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        debugPrint("launch screen deinited")
    }
    
    // MARK: - SetupView
    private func setupView() {
        addSubviews()
        setupConstraints()
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        view.addSubviews(progressView, animationView)
    }
    
    private func setupConstraints() {
        progressView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(8)
            make.top.equalTo(animationView.snp.bottom).inset(-30)
        }
        
        animationView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
    
    // MARK: - Timer
    func startTimer() {
        guard timer == nil else {
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.05,
                                     target: self,
                                     selector: #selector(pageSetup),
                                     userInfo: nil, repeats: true)
    }
    
    @objc
    private func pageSetup() {
        let progress = progressView.progress + 0.01
        progressView.setProgress(progress, animated: true)
      
        if progressView.progress >= 1 {
            AppCoordinator.shared.launchScreenAnimationEnded()
        }
    }
    
}
