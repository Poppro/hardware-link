//
//  DataCenterController.swift
//  O
//
//  Created by Pop Pro on 7/20/17.
//  Copyright © 2017 Poppro. All rights reserved.
//

import UIKit
import Charts

class DataCenterController: UIViewController {

    @IBOutlet weak var CPUChart: LineChartView!
    @IBOutlet weak var RAMChart: LineChartView!
    @IBOutlet weak var SSDChart: PieChartView!
    @IBOutlet weak var HDDChart: PieChartView!
    
    var cpuT = [Double]()
    var ramT = [Double]()
    var SSDStorage = 0.0
    var HDDStorage = 0.0
    var firstLoad = true
    
    var colors = [UIColor(red: 0/255, green: 197/255, blue: 0/255, alpha: 1), UIColor(red: 197/255, green: 0/255, blue: 0/255, alpha: 1)]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSON()
        
        setUpCPU()
        setUpRAM()
        setUpSSD()
        setUpHDD()
        
        updateCPU()
        updateRAM()
        updateSSD()
        updateHDD()
        
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateCPU), userInfo: nil, repeats: true)
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateRAM), userInfo: nil, repeats: true)
        _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updateSSD), userInfo: nil, repeats: true)
         _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updateHDD), userInfo: nil, repeats: true)
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.fetchJSON), userInfo: nil, repeats: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //updating functions
    func updateCPU() {
        var cpuDataR: [ChartDataEntry] = []
        for i in 0..<cpuT.count {
        cpuDataR.append(ChartDataEntry(x: Double(i), y: cpuT[i]))
        }
        
        let cpuDataSet = LineChartDataSet(values: cpuDataR, label: "CPU %")
        cpuDataSet.colors = [UIColor(red: 0/255, green: 197/255, blue: 0/255, alpha: 1)]
        cpuDataSet.drawCubicEnabled = true
        cpuDataSet.drawValuesEnabled = false
        cpuDataSet.drawCirclesEnabled = false
        
        let cpuData = LineChartData(dataSet: cpuDataSet)
        CPUChart.data = cpuData;
    }
    
    func updateRAM() {
        var ramDataR: [ChartDataEntry] = []
        for i in 0..<ramT.count {
            ramDataR.append(ChartDataEntry(x: Double(i), y: ramT[i]))
        }
        
        let ramDataSet = LineChartDataSet(values: ramDataR, label: "CPU %")
        ramDataSet.colors = [UIColor(red: 0/255, green: 197/255, blue: 0/255, alpha: 1)]
        ramDataSet.drawCubicEnabled = true
        ramDataSet.drawValuesEnabled = false
        ramDataSet.drawCirclesEnabled = false
        
        let ramData = LineChartData(dataSet: ramDataSet)
        RAMChart.data = ramData;
    }
    
    func updateSSD() {
        var dataEntries: [ChartDataEntry] = []
        
        let dataEntry = ChartDataEntry(x: 1, y: SSDStorage)
        let dataEntry2 = ChartDataEntry(x: 2, y: 120-SSDStorage)
        dataEntries.append(dataEntry)
        dataEntries.append(dataEntry2)
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Storage")
        pieChartDataSet.drawValuesEnabled = false
        pieChartDataSet.colors = colors
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        SSDChart.data = pieChartData
    }
    
    func updateHDD() {
        var dataEntries: [ChartDataEntry] = []
        
        let dataEntry = ChartDataEntry(x: 1, y: HDDStorage)
        let dataEntry2 = ChartDataEntry(x: 2, y: 1000-HDDStorage)
        dataEntries.append(dataEntry)
        dataEntries.append(dataEntry2)
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Storage")
        pieChartDataSet.colors = colors
        pieChartDataSet.drawValuesEnabled = false
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        HDDChart.data = pieChartData
    }
    
    
    
    
    //setup functions
    func setUpCPU() {
        CPUChart.gridBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        CPUChart.chartDescription?.text = ""
        CPUChart.legend.enabled = false;
        CPUChart.isUserInteractionEnabled = false;
        CPUChart.drawBordersEnabled = false;
        CPUChart.drawMarkers = false
        CPUChart.leftAxis.drawGridLinesEnabled = false
        CPUChart.leftAxis.labelTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        CPUChart.rightAxis.drawLabelsEnabled = false
        CPUChart.rightAxis.drawGridLinesEnabled = false
        CPUChart.rightAxis.drawAxisLineEnabled = false
        CPUChart.xAxis.drawGridLinesEnabled = false;
        CPUChart.xAxis.drawLabelsEnabled = false
        CPUChart.xAxis.labelPosition = XAxis.LabelPosition.bottom
        CPUChart.leftAxis.axisMinimum = 0;
        //CPUChart.leftAxis.axisMaximum = 100;
        CPUChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    func setUpRAM() {
        RAMChart.gridBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        RAMChart.chartDescription?.text = ""
        RAMChart.legend.enabled = false;
        RAMChart.isUserInteractionEnabled = false;
        RAMChart.drawBordersEnabled = false;
        RAMChart.drawMarkers = false
        RAMChart.leftAxis.drawGridLinesEnabled = false
        RAMChart.leftAxis.labelTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        RAMChart.rightAxis.drawLabelsEnabled = false
        RAMChart.rightAxis.drawGridLinesEnabled = false
        RAMChart.rightAxis.drawAxisLineEnabled = false
        RAMChart.xAxis.drawGridLinesEnabled = false;
        RAMChart.xAxis.drawLabelsEnabled = false
        RAMChart.xAxis.labelPosition = XAxis.LabelPosition.bottom
        RAMChart.leftAxis.axisMinimum = 0;
        //RAMChart.leftAxis.axisMaximum = 16;
    }
    
    func setUpSSD() {
        SSDChart.holeColor = #colorLiteral(red: 0.1333139837, green: 0.1333444417, blue: 0.1333120763, alpha: 1)
        SSDChart.legend.enabled = false
        SSDChart.chartDescription?.text = ""
    }
    
    func setUpHDD() {
        HDDChart.holeColor = #colorLiteral(red: 0.1333139837, green: 0.1333444417, blue: 0.1333120763, alpha: 1)
        HDDChart.legend.enabled = false
        HDDChart.chartDescription?.text = ""
    }
    
    //JSON handler
    func fetchJSON() {
        let urlrequest = URLRequest(url: URL(string: "http://192.168.1.150:8888/data.json")!);
        let task = URLSession.shared.dataTask(with: urlrequest) { (data,response,error) in
            if(error != nil) {
                DispatchQueue.main.async() {
                }
                return;
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
                if let dataFromJson = json["dataset"] as? [[String:AnyObject]] {
                    for dataVal in dataFromJson {
                        if let cpu = dataVal["cpu"] as? String, let ram = dataVal["ram"] as? String,
                            let hdd = dataVal["HDD"] as? String, let ssd = dataVal["SSD"] as? String {
                                //handle CPU
                                let cpud = Double(cpu)!;
                                if(self.cpuT.count < 10) {
                                self.cpuT.append(cpud)
                                } else {
                                    self.cpuT.remove(at: 0)
                                }
                                //handle RAM
                                let ramd = Double(ram)!/1000;
                                if(self.ramT.count < 10) {
                                    self.ramT.append(ramd)
                                } else {
                                    self.ramT.remove(at: 0)
                                }
                                //handle SSD
                                let ssdd = Double(ssd)!/1000;
                                self.SSDStorage = ssdd
                                //handle HDD
                                let hddi = Double(hdd)!/1000;
                                self.HDDStorage = hddi
                                if(self.firstLoad == true) {
                                    self.firstLoad = false
                                    print(self.SSDStorage + self.HDDStorage)
                                    self.updateSSD()
                                    self.updateHDD()
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
}
