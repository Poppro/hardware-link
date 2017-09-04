//
//  ViewController.swift
//  O
//
//  Created by Pop Pro on 5/18/17.
//  Copyright © 2017 Poppro. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var reload = false;
    @IBOutlet weak var web: UIWebView!
    @IBOutlet weak var CPU: UILabel!
    @IBOutlet weak var RAM: UILabel!
    @IBOutlet weak var SSD: UILabel!
    @IBOutlet weak var HDD: UILabel!
    @IBOutlet weak var IOIndicator: UISwitch!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set startup parameters
        self.IOIndicator.isOn = false;
        //load the JSON data
        fetchData()
        //start timer
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.fetchData), userInfo: nil, repeats: true)
    }

    func fetchData() {
        let urlrequest = URLRequest(url: URL(string: "http://192.168.1.150:8888/data.json")!);
        let task = URLSession.shared.dataTask(with: urlrequest) { (data,response,error) in
            if(error != nil) {
                DispatchQueue.main.async() {
                    //sets UI if PC off/dataserver down
                    self.IOIndicator.isOn = false;
                    self.CPU.text = "";
                    self.RAM.text = "";
                    self.SSD.text = "";
                    self.HDD.text = "";
                }
                return;
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
                if let dataFromJson = json["dataset"] as? [[String:AnyObject]] {
                    for dataVal in dataFromJson {
                        if let cpu = dataVal["cpu"] as? String, let ram = dataVal["ram"] as? String,
                            let hdd = dataVal["HDD"] as? String, let ssd = dataVal["SSD"] as? String {
                            DispatchQueue.main.async() {
                                //handle IO
                                self.IOIndicator.isOn = true;
                                //handle CPU
                                let cpud = Double(cpu)!;
                                let cpus = String(format: "%.2f", cpud);
                                self.CPU.text = cpus + "%";
                                //handle RAM
                                let ramd = Double(ram)!/1000;
                                let rams = String(format: "%.2f", ramd)
                                self.RAM.text = rams + "GB";
                                //handle SSD
                                let ssdd = Double(ssd)!/1000;
                                let ssds = String(format: "%.3f", ssdd);
                                self.SSD.text = ssds + "GB";
                                //handle HDD
                                let hddi = Int(hdd)!/1000;
                                let hdds = "\(hddi)";
                                self.HDD.text = hdds + "GB"
                            }
                        
                        }
                    }
                }
            }
            catch let error {
                print(error);
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //function to handle turning PC on/off with IOSlider
    @IBAction func IOP(_ sender: Any) {
        let url = NSURL(string: "http://192.168.1.135/ON");
        let urlreq = NSURLRequest(url: url! as URL);
        web.loadRequest(urlreq as URLRequest);
        reload = true;
    }
    
    
}

