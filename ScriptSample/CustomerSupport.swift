/*
 Copyright 2016 ykokw All Rights Reserved.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import UIKit
import NCMB

class CustomerSupportViewController: UIViewController {
    @IBOutlet weak var mailAddress: UITextField!
    @IBOutlet weak var messageField: UITextView!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func submit(sender: AnyObject) {
        let script = NCMBScript.init(name: "CustomerSupport.js",
                                     method:NCMBScriptRequestMethod.ExecuteWithPostMethod)
        script.execute(["mailAddress":mailAddress.text!,"message":messageField.text],
                       headers: nil,
                       queries: nil,
                       withBlock: { (result, error) in
            if error != nil {
                print("error:" + error.description)
            } else {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(result,
                        options: .MutableContainers) as! [String: String]
                    self.resultLabel.text = json["result"]
                }
                catch{
                    print("json parse error")
                }
                
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        messageField.layer.cornerRadius = 5.0
        messageField.layer.masksToBounds = false
        messageField.layer.borderWidth = 1
        messageField.layer.borderColor = UIColor.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.5).CGColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}