//
//  ViewController.swift
//  stopwatch
//
//  Created by Nakata chisato on 2020/07/03.
//  Copyright © 2020 Ajima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerMinute: UILabel!
    @IBOutlet weak var timerSecond: UILabel!
    
    @IBOutlet weak var stockTimesTable: UITableView!
    
    weak var timer: Timer!
    var startTime = Date()
    var stockTimes:[TimeInterval] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ラベルと画面全体の背景色設定
        self.view.backgroundColor = #colorLiteral(red: 0.2128436267, green: 0.646464169, blue: 0.6198984981, alpha: 1)
        timerMinute.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        timerSecond.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer?.invalidate()
    }
    
    
    
    @IBAction func startTimer(_ sender: Any) {
        // timerが起動中なら一旦破棄する
        if timer != nil{
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(self.timerCounter),
            userInfo: nil,
            repeats: true)
        
        startTime = Date()
    }
    
    @IBAction func stopTimer(_ sender: Any) {
        //Stopしたら配列に止めた時間（TimeIntrerval）を追加してリセットする
        if timer != nil{
            stockTimes.append(Date().timeIntervalSince(startTime))
            print(stockTimes.last!)
            stockTimesTable?.reloadData()
            timer.invalidate()
            
            timerMinute.text = "00"
            timerSecond.text = "00"
        }
    }
    
    @objc func timerCounter() {
        // タイマー開始からのインターバル時間
        let currentTime = Date().timeIntervalSince(startTime)
        // fmod() 余りを計算
        let minute = (Int)(fmod((currentTime/60), 60))
        // currentTime/60 の余り
        let second = (Int)(fmod(currentTime, 60))
        
        // %02d： ２桁表示、0で埋める
        let sMinute = String(format:"%02d", minute)
        let sSecond = String(format:"%02d", second)
        
        timerMinute.text = sMinute
        timerSecond.text = sSecond
        
    }
    
}



extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let currentTime = stockTimes[indexPath.row]
        
        // fmod() 余りを計算
        let minute = (Int)(fmod((currentTime/60), 60))
        // currentTime/60 の余り
        let second = (Int)(fmod(currentTime, 60))
        
        // %02d： ２桁表示、0で埋める
        let sMinute = String(format:"%02d", minute)
        let sSecond = String(format:"%02d", second)
        
        cell.textLabel!.text = "\(sMinute) \(sSecond)"
        cell.textLabel?.textAlignment = .center
        
        return cell
        
    }
    
}


