//
//  ViewController.swift
//  I'm late
//
//  Created by Shota Kohiyama on 2021/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateNowTitle: UILabel!
    @IBOutlet weak var dateNow: UILabel!
    @IBOutlet weak var binaryTitle: UILabel!
    @IBOutlet weak var binaryMonth: UILabel!
    @IBOutlet weak var binaryDay: UILabel!
    @IBOutlet weak var binaryHour: UILabel!
    @IBOutlet weak var binaryMinute: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date() // 現在の日時を取得
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMMHm", options: 0, locale: Locale(identifier: "ja_JP")) // 日時をxxxx年x月xx日xx:xxの形で出力
        let dateText = String(dateFormatter.string(from: now))
        
        class CutNumber { // 数字のみ切り出すクラス
            var firstIdx: Character
            var lastIdx: Character!
            
            init(firstIdx: Character, lastIdx: Character!) {
                self.firstIdx = firstIdx
                self.lastIdx = lastIdx
            }
            
            func cut(date: String) -> String { // 任意の数字を切り出す
                let index1 = date.firstIndex(of: firstIdx)
                let subs = date.suffix(from: index1!)
                let index2 = subs.lastIndex(of: lastIdx)
                let cutNum = date[index1!...index2!].components(separatedBy: NSCharacterSet.decimalDigits.inverted) // 数字以外を排除
                return cutNum.joined()
                
            }
            
            func cutMinute(date: String) -> String {
                let index1 = date.firstIndex(of: firstIdx)
                let index2 = date.index(after: index1!)
                return String(date[index2...])
            }
        }
        
        class CutMonth: CutNumber {
            init() {
                super.init(firstIdx: "年", lastIdx: "月")
            }
        }
        
        class CutDay: CutNumber {
            init() {
                super.init(firstIdx: "月", lastIdx: "日")
            }
        }
        
        class CutHour: CutNumber {
            init() {
                super.init(firstIdx: "日", lastIdx: ":")
            }
        }
        
        class CutMinute: CutNumber {
            init() {
                super.init(firstIdx: ":", lastIdx: nil)
            }
        }

        let month = Int(CutMonth().cut(date: dateText))
        let day = Int(CutDay().cut(date: dateText))
        let hour = Int(CutHour().cut(date: dateText))
        let minute = Int(CutMinute().cutMinute(date: dateText))
        
        func binaryConverter(decimal: Int) -> String { // 二進数に変換
            var remainderArray = [Int]()
            var binary = ""
            var x = decimal // ここでしか使わない一時的な変数なので名前は省略
            let y = 2
            
            while x >= 1 {
                let remainder = x % y
                x = Int(floor(Double(x / y)))
                remainderArray.append(remainder)
            }
            remainderArray.forEach { // 余りの配列を結合し文字列に変換
                binary = "\($0)" + binary
            }
            return binary
        }
        
        dateNowTitle.text = "現在の日時"
        dateNow.text = dateText
        binaryTitle.text = "二進数"
        binaryMonth.text = "\(binaryConverter(decimal: month!))月"
        binaryDay.text = "\(binaryConverter(decimal: day!))日"
        binaryHour.text = "\(binaryConverter(decimal: hour!))時"
        binaryMinute.text = "\(binaryConverter(decimal: minute!))分"
        // Do any additional setup after loading the view.
    }


}

