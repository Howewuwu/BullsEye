//
//  ViewController.swift
//  BullsEye
//
//  Created by Howe on 2022/2/22.
//

import UIKit

class ViewController: UIViewController {
    

    var currentValue:Int = 0  // 將 slider 的數值轉成 Int 後做儲存的 Instance variable.
    var targetValue: Int = 0 // 用作儲存隨機產出 1~100 數字的 target 的 Instance variable.
    var score: Int = 0 // 用作儲存 currentValue - targetValue 然後轉成正數的 Intance variable.
    var roundNumber = 0 // 用作儲存回合數的 Instance variable
    @IBOutlet weak var slider: UISlider! // 連結 Main 上的 Slider 用，數值有更動時會隨著變動，也被用做各種 slider method 的底.
    @IBOutlet weak var tagetValueLabel: UILabel! // 連結 Main 上用做顯示 target 數值用.
    @IBOutlet weak var scoreLabel: UILabel! // 連結 Main 上用做顯示 score 數值用.
    @IBOutlet weak var roundLabel: UILabel! // 連結 Main 上用做顯示 round 數值用.
    
    
    
    override func viewDidLoad() {
    super.viewDidLoad()

        //let roundValue = (slider.value.rounded())
        //currentValue = Int(roundValue)
        startRound() // 是個貫串整個 App 的 function.
        
        //let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(UIImage(named: "SliderThumb-Normal"), for: .normal) // 用作 SliderThumb normal.
        
        slider.setThumbImage(UIImage(named: "SliderThumb-Highlighted"), for: .highlighted) // 用作 SliderThumb highlighted.
     
        let inserts = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14) // 搭配 .resizableImage 使用，用數值構出要使用的區域.
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft") // 用作左邊 slider track 的圖
        let trackLeftResizeable = trackLeftImage?.resizableImage(withCapInsets: inserts) // 將用作 slider track 的圖用數值固定區域後只拉升那個區域的圖像的 method，需配合使用 UIEdgeInsets.
        slider.setMinimumTrackImage(trackLeftResizeable, for: .normal) // 將上面設定好的圖像給 slider 的 MinimumTrack.
        
        // Slider Maximum Track Image 的方法同上.
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizeable = trackRightImage?.resizableImage(withCapInsets: inserts)
        slider.setMaximumTrackImage(trackRightResizeable, for: .normal)
        
        
    }
    // 連接 Main 的 button.
    // 是用 Touch Up Inside 的 events，意為點選 button 後.
    @IBAction func showAlert() {
      
    let difference = abs(targetValue - currentValue) // 將 “目標分數” 和 “slider 滑到的分數” 相減，再藉由 abs 這個 function 將數值都轉為正數.
    var points = 100 - difference // 用 100 去剪掉上面的數值就會是得到的分數.
        
       
    score += points // 用來計算總分.
        
    
        
    let title : String // 用 if、else if 區分分數間隔 + 對應的文字
        if difference == 0 { title = "你是一陽指傳人？<額外多100>" ; points += 100 ; score += 100} // 額外加的分數 point 會再加 100 顯示在往下執行的 message 做顯示用，score 會進到 Instance variable 做總分相加.
        else if difference == 1 { title = "指差一點 <額外多50>" ; points += 50 ; score += 50}
        else if  difference < 5 { title = "指上功夫不錯"}
        else if difference < 10 { title = "加油你可以的"}
        else  { title = "差得遠了欸"}
        
        
    let message = "你的分數是 \(points)" // 顯示在 pop up 的文字內容.
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert) // 用作顯示 pop up 的 UI 物件.
        let action = UIAlertAction(title: "再來", style: .default, handler: {action in  self.startRound()}) // handler: {action in  self.startRound()} 這段用來做 “異同步”，就是在使用者點選 “再來” 這個 button 後才會執行 startRound() 這個 function.
    alert.addAction(action) // alert 需要附加一個 action 當作下面的選項 button.
    present(alert, animated: true, completion:nil ) // 用作是否要呈現 pop up.
    
  
    }
    
   
    // 連結 Main 的 button，用作重新計算.
    @IBAction func startOver() {
        let alert2 = UIAlertController(title: "回合重算", message:"你確定要重算？" , preferredStyle: .alert)
        let action2 = UIAlertAction(title: "重來", style: .default, handler: {action2 in  self.resetAll()}) // 一樣是使用“異同步”，點選後會有一個讓所有數值歸零的 function.
        let action3 = UIAlertAction(title: "沒事我就看看", style: .default, handler: nil)
        // 添加兩個 action 讓使用者選擇.
        alert2.addAction(action2)
        alert2.addAction(action3)
        present(alert2, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    // 用作 slider 滑動時會改變數值的 Value Changed events
    // 參數外部名稱省略，內部叫 slider，型態為 UISlider.
    @IBAction func sliderMoved(_ slider: UISlider) {
    let roundValue = (slider.value.rounded()) // value 為 slider Value Changed 後的值，rounded()為只取該數值的整數.
    currentValue = Int(roundValue) // 因為 Slider 的數值預設都為 float，但因為整個 App 都以整數為主所以轉為整數給 currentValue 這個 Instance value 做儲存.
   
    }
    
    // 整個 App 往下推進的 function.
    func startRound(){
        roundNumber += 1 // 回合數增加
        targetValue = Int.random(in: 1...100) // 隨機生成 1~100 的整數.
        currentValue = 50 // 將 Slider 回復成正中 50 (在 Main 有將 Slider 整條數值設為 100).
        slider.value = Float(currentValue) // 因為 Slider 預設是 float，所以將 cuttrentValue 轉成 float 丟回去.
        upDate() // 更新數值的 function
    }
    
    // 將各個 label 新的數值顯示在 Main.
    func upDate(){
        tagetValueLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(roundNumber)
    }
    
    
    // 將各個 label 數值歸零.
    func resetAll(){
        score = 0
        roundNumber = 0
        startRound()
    }
    
    
}
