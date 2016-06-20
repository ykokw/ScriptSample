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

class GettingStartedViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBAction func executeScript(sender: AnyObject) {
        
        let script = NCMBScript.init(name: "testScript_GET.js", method:NCMBScriptRequestMethod.ExecuteWithGetMethod)
        script.execute(nil, headers: nil, queries: ["name":name.text!], withBlock: { (result, error) in
            if error != nil {
                print("error:%s", error)
            } else {
                self.resultLabel.text = String(data: result, encoding: NSUTF8StringEncoding)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}