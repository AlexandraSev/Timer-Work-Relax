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
    var timer: Timer?
    var runCountJob = 26
    var runCountRelax = 11
    
    
    // MARK: - Label Time
    private lazy var labelTimer: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50, weight: .light)
        label.textColor = .black
        
        return label
    }()
    
    
    // MARK: - Button Play/Pause
    private lazy var buttonPlayOrPause: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        
        
        button.tintColor = .black
        button.clipsToBounds = false
        button.addTarget(self, action: #selector(ourButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifestyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        setupHierarchy()
        setupLayout()
        labelTimer.translatesAutoresizingMaskIntoConstraints = false
        buttonPlayOrPause.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func fireTimer() {
        
        if isStarted == true {
            if isWorkTime == true {
                
                runCountJob -= 1
                labelTimer.text = "\(runCountJob):00"
                labelTimer.textColor = .systemGreen
                buttonPlayOrPause.tintColor = .systemGreen
                if runCountJob == 0 {
                    labelTimer.textColor = .black
                    buttonPlayOrPause.tintColor = .red
                    isWorkTime = !isWorkTime
                    runCountJob = 26
                    
                }
            } else {
                runCountRelax -= 1
                labelTimer.text = "\(runCountRelax):00"
                labelTimer.textColor = .red
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
        view.addSubview(labelTimer)
        view.addSubview(buttonPlayOrPause)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
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
            buttonPlayOrPause.setImage(UIImage(named: "pause"), for: .normal) } else {  buttonPlayOrPause.setImage(UIImage(named: "play"), for: .normal)
            }
    }
    
    
}
