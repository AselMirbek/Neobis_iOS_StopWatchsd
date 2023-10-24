//
//  ViewController.swift
//  Neobis_iOS_StopWatch
//
//  Created by Asel Mirbek on 24/10/23.
//

import UIKit

class MainUiViewController: UIViewController {
   @IBOutlet weak var timerLabel: UILabel!
   @IBOutlet weak var stopButton: UIButton!
   @IBOutlet weak var pauseButton: UIButton!
   @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var segmentedCotroller: UISegmentedControl!
    @IBOutlet weak var timerPicker: UIDatePicker!
    
 

    
    @IBOutlet weak var containerView: UIView!


    
    private var timerViewController: TimerViewController!
    private var stopwatchViewController: StopWatchViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewControllers()
    }

    private func setupChildViewControllers() {
        timerViewController = TimerViewController()
        stopwatchViewController = StopWatchViewController()

        // Pass references to UI elements
        timerViewController.timerLabel = timerLabel
        timerViewController.stopButton = stopButton
        timerViewController.pauseButton = pauseButton
        timerViewController.startButton = startButton
        timerViewController.segmentedCotroller = segmentedCotroller
        timerViewController.timerPicker = timerPicker

        stopwatchViewController.timerLabel = timerLabel
        stopwatchViewController.stopButton = stopButton
        stopwatchViewController.pauseButton = pauseButton
        stopwatchViewController.startButton = startButton
        stopwatchViewController.segmentedCotroller = segmentedCotroller
        stopwatchViewController.timerPicker = timerPicker

        addChild(timerViewController)
        addChild(stopwatchViewController)

        containerView.addSubview(timerViewController.view)
        containerView.addSubview(stopwatchViewController.view)

        timerViewController.view.frame = containerView.bounds
        stopwatchViewController.view.frame = containerView.bounds

        timerViewController.didMove(toParent: self)
        stopwatchViewController.didMove(toParent: self)

        // Initially show TimerViewController
        timerViewController.view.isHidden = false
        stopwatchViewController.view.isHidden = true
    }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            timerViewController.view.isHidden = false
            stopwatchViewController.view.isHidden = true
        case 1:
            timerViewController.view.isHidden = true
            stopwatchViewController.view.isHidden = false
        default:
            break
        }
    }
}
