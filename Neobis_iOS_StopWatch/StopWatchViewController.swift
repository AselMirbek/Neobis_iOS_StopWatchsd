//
//  StopWatchViewController.swift
//  Neobis_iOS_StopWatch
//
//  Created by Interlink on 29/10/23.
//

import UIKit

class StopWatchViewController: MainUiViewController {
   //  @IBOutlet weak var timerLabel: UILabel!
  //   @IBOutlet weak var stopButton: UIButton!
  //  @IBOutlet weak var pauseButton: UIButton!
  // @IBOutlet weak var startButton: UIButton!
  //  @IBOutlet weak var timerPicker: UIDatePicker!
    
    private var timer: Timer?
    private var isRunning = false
    private var startTime: TimeInterval = 0
    private var remainingTime: TimeInterval = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        timerPicker.countDownDuration = 60.0 // Set the initial time on the DatePicker
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        if !isRunning {
            startButton.isEnabled = false
            pauseButton.isEnabled = true
            stopButton.isEnabled = true

            if timer == nil {
                remainingTime = timerPicker.countDownDuration // Get the time from the DatePicker
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                if let timer = timer {
                    RunLoop.current.add(timer, forMode: .common)
                }
            } else {
                // Resume the timer
                timer?.fireDate = Date()
            }

            isRunning = true
            startTime = Date().timeIntervalSinceReferenceDate - startTime
        }
    }

    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if isRunning {
            startButton.isEnabled = true
            pauseButton.isEnabled = false
            stopButton.isEnabled = true

            timer?.fireDate = Date.distantFuture
        }
    }

    @IBAction func stopButtonTapped(_ sender: UIButton) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        stopButton.isEnabled = false

        if let timer = timer {
            timer.invalidate()
        }

        isRunning = false
        remainingTime = 0
        updateTime()
    }

    @objc private func updateTime() {
        let currentTime = Date().timeIntervalSinceReferenceDate - startTime

        if remainingTime > 0 {
            remainingTime -= 1
            let minutes = Int(remainingTime) / 60
            let seconds = Int(remainingTime) % 60
            timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
        } else {
            if let timer = timer {
                timer.invalidate()
            }

            isRunning = false
            timerLabel.text = "00:00"
        }
    }
}
