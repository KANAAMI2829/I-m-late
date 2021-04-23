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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMMHm", options: 0, locale: Locale(identifier: "ja_JP")) // 現在の日時を取得
        let dateText = String(dateFormatter.string(from: now))
        
        func cutMonth(date: String) -> String { // x月のxのみを抽出
            let index1 = date.firstIndex(of: "年")
            let subs = date.suffix(from: index1!)
            let index2 = subs.lastIndex(of: "月")
            let monthNum = date[index1!...index2!].components(separatedBy: NSCharacterSet.decimalDigits.inverted) // 数字以外を排除
            return monthNum.joined()
        }
        let month = Int(cutMonth(date: dateText))
        
        func binaryConverter(decimal: Int) -> String { // 二進数に変換
            var x = decimal // ここでしか使わない一時的な変数なので名前は省略
            let y = 2
            var remainderArray = [Int]()
            var binary = ""
            while x >= 1 {
                let remainder = x % y
                x = Int(floor(Double(x / y)))
                remainderArray.append(remainder)
            }
            remainderArray.forEach { // 配列から文字列に変換
                binary = "\($0)" + binary
            }
            return binary
        }
        
        dateNowTitle.text = "現在の日時"
        dateNow.text = dateText
        binaryTitle.text = "二進数"
        binaryMonth.text = "\(String(binaryConverter(decimal: month!)))月"
        // Do any additional setup after loading the view.
    }


}

