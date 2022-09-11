//
//  ViewController.swift
//  Timer Work\Relax
//
//  Created by Александра  Севостьянова on 10.09.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    private lazy var isStarted = true
    private lazy var isWorkTime = true
    
    // MARK: - Label Time
    private lazy var labelTimer: UILabel = {
        let label = UILabel()
        label.text = "25:00"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50, weight: .light)
        if isWorkTime == true {
            label.textColor = .systemGreen
        } else {
            label.textColor = .red }
        return label
    }()
    
  
    // MARK: - Button Play/Pause
    private lazy var buttonPlayOrPause: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.tintColor = .systemGreen
        button.clipsToBounds = false
        button.addTarget(self, action: #selector(ourButtonPressed), for: .touchUpInside)
        return button
    }()
    
   
    //MARK: - Lifestyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        labelTimer.translatesAutoresizingMaskIntoConstraints = false
        buttonPlayOrPause.translatesAutoresizingMaskIntoConstraints = false
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
    func getRandomColor() -> UIColor{
        let red: CGFloat = CGFloat(drand48())
        let green: CGFloat = CGFloat(drand48())
        let blue: CGFloat = CGFloat(drand48())
        
        return UIColor( red: red, green: green, blue: blue, alpha: 1.0)
    }
    @objc private func ourButtonPressed() {
        
            buttonPlayOrPause.setImage(UIImage(named: "pause"), for: .normal)}
        
    }

