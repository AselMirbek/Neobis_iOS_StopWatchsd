//
//  TimerViewController.swift
//  Neobis_iOS_StopWatch
//
//  Created by Interlink on 29/10/23.
//



import UIKit

class TimerViewController: MainUiViewController {
 //@IBOutlet weak var timerLabel: UILabel!
// @IBOutlet weak var startButton: UIButton!
//@IBOutlet weak var pauseButton: UIButton!
//   @IBOutlet weak var stopButton: UIButton!
    
    private var timer: Timer?
    private var isRunning = false
    private var elapsedTime: TimeInterval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        timerLabel.text = "00:00:00"
        pauseButton.isEnabled = false
        stopButton.isEnabled = false
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if !isRunning {
            startButton.isEnabled = false
            pauseButton.isEnabled = true
            stopButton.isEnabled = true
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: .common)

            
            isRunning = true
        }
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if isRunning {
            startButton.isEnabled = true
            pauseButton.isEnabled = false
            stopButton.isEnabled = true
            
            timer?.invalidate()
            isRunning = false
        }
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        stopButton.isEnabled = false
        
        timer?.invalidate()
        isRunning = false
        elapsedTime = 0
        updateTime()
    }
    
    @objc private func updateTime() {
        elapsedTime += 1
        
        let hours = Int(elapsedTime) / 3600
        let minutes = (Int(elapsedTime) % 3600) / 60
        let seconds = Int(elapsedTime) % 60
        
        timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
