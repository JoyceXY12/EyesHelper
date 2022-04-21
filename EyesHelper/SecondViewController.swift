//
//  SecondViewController.swift
//  EyesHelper
//
//  Created by joyce huang on 2022-04-06.
//

import UIKit
import VisionKit

class SecondViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var readAloudButton: UIButton!
    var result = " ";
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text="Hello user"; //hard-coding currently --> for official version: textView.text=result;
        textView.font = UIFont.systemFont(ofSize: 30.0)
        readAloudButton.titleLabel?.font = UIFont.systemFont(ofSize: 68.0)
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func readAloudIsPressed(_ sender: UIButton) {
        let x = Speech()
        x.startSpeech(textView.text)
    }
    
    @IBAction func changeTextSize(_ sender: UISlider) {
        print(sender.value);
        textView.font = UIFont.systemFont(ofSize: CGFloat(sender.value));
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
