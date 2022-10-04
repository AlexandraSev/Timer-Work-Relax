//
//  ViewController.swift
//  Timer Work\Relax
//
//  Created by Александра  Севостьянова on 10.09.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    private lazy var isStarted = false
    private lazy var isWorkTime = true
    
    // MARK: - Timer
    private lazy var circularProgressBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var timer: Timer?
    var runCountJob = 26
    var runCountRelax = 11
    var shapeLayer = CAShapeLayer()
    var backShapeLayer = CAShapeLayer()
    
    // MARK: - Label Time
    private lazy var labelTimer: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50, weight: .light)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   // MARK: - Button Play/Pause
    private lazy var buttonPlayOrPause: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.tintColor = .black
        button.clipsToBounds = false
        button.addTarget(self, action: #selector(ourButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifestyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        setupHierarchy()
        setupLayout()
        backProgressBar()
        animationProgressBar()
        
        }
    
    @objc func fireTimer() {
        
        if isStarted == true {
            if isWorkTime == true {
                basicAnimation()
                
                runCountJob -= 1
                labelTimer.text = "\(runCountJob):00"
                labelTimer.textColor = .systemGreen
                buttonPlayOrPause.tintColor = .systemGreen
                shapeLayer.strokeColor = UIColor.systemGreen.cgColor
                if runCountJob == 0 {
                    
                    labelTimer.textColor = .black
                    buttonPlayOrPause.tintColor = .black
                    isWorkTime = !isWorkTime
                   runCountJob = 26
                    
                }
            } else {
                basicAnimation()
                runCountRelax -= 1
                labelTimer.text = "\(runCountRelax):00"
                labelTimer.textColor = .red
                buttonPlayOrPause.tintColor = .red
                shapeLayer.strokeColor = UIColor.red.cgColor
                if runCountRelax == 0 {
                    
                    labelTimer.textColor = .black
                    buttonPlayOrPause.tintColor = .black
                    isWorkTime = !isWorkTime
                  runCountRelax = 11
                }
            }
        }
    }
    // MARK: - Setup
    private func setupHierarchy() {
        view.addSubview(circularProgressBarView)
        circularProgressBarView.addSubview(labelTimer)
        circularProgressBarView.addSubview(buttonPlayOrPause)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            circularProgressBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 175),
            circularProgressBarView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
            circularProgressBarView.heightAnchor.constraint(equalToConstant: 350),
            circularProgressBarView.widthAnchor.constraint(equalToConstant: 350),
            
            labelTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTimer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70),
            
            buttonPlayOrPause.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonPlayOrPause.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10),
            buttonPlayOrPause.heightAnchor.constraint(equalToConstant: 50),
            buttonPlayOrPause.widthAnchor.constraint(equalToConstant: 50),
            

        ])
    }
    
    // MARK: - Actions
    
    @objc private func ourButtonPressed() {
        isStarted = !isStarted
        if isStarted == true {
            resumeAnimation()
            buttonPlayOrPause.setImage(UIImage(named: "pause"), for: .normal) } else {
                pauseAnimation()
                buttonPlayOrPause.setImage(UIImage(named: "play"), for: .normal)
                fireTimer()
            }
    }


// MARK: - Animated progressBar
    private func backProgressBar() {
        
        let center = CGPoint(x: circularProgressBarView.frame.width / 2, y: circularProgressBarView.frame.height / 2)
        let finish = (-CGFloat.pi / 2)
        let start = 2 * CGFloat.pi + finish
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 138,
                                        startAngle: start,
                                        endAngle: finish,
                                        clockwise: false)
        
        backShapeLayer.path = circularPath.cgPath
        backShapeLayer.fillColor = UIColor.clear.cgColor
        backShapeLayer.lineWidth = 5.0
        backShapeLayer.strokeEnd = 1
        backShapeLayer.lineCap = CAShapeLayerLineCap.round
        backShapeLayer.strokeColor = UIColor.systemGray5.cgColor
        circularProgressBarView.layer.addSublayer(backShapeLayer)
    }

    private func animationProgressBar() {
        
        let center = CGPoint(x: circularProgressBarView.frame.width / 2, y: circularProgressBarView.frame.height / 2)
        let end = (-CGFloat.pi / 2)
        let start = 2 * CGFloat.pi + end
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 138,
                                        startAngle: start,
                                        endAngle: end,
                                        clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 4
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        circularProgressBarView.layer.addSublayer(shapeLayer)
    }

    private func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.duration = isWorkTime ? CFTimeInterval(26) : CFTimeInterval(11)
        basicAnimation.toValue = 0.0
        basicAnimation.speed = 1.0
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    private func pauseAnimation(){
        let pausedTime = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
        shapeLayer.speed = 0.0
        shapeLayer.timeOffset = pausedTime
    }
    
    private func resumeAnimation(){
        let pausedTime = shapeLayer.timeOffset
        shapeLayer.speed = 1.0
        shapeLayer.timeOffset = 0.0
        shapeLayer.beginTime = 0.0
        let timeSincePause = shapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        shapeLayer.beginTime = timeSincePause
    }
}
