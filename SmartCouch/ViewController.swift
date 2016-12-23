//
//  ViewController.swift
//  SmartCouch
//
//  Created by Darcy Phillips on 2016-12-18.
//  Copyright © 2016 Darcy Phillips. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var centralManager:CBCentralManager!
    @IBOutlet weak var infoText: UITextView!
    var numberOfDevices = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoText.layer.borderWidth = 1
        infoText.layer.borderColor = UIColor.black.cgColor
        
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    //    _ = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
    //        print("................")
    //        self.centralManager.scanForPeripherals(withServices: nil, options: nil)
    //}
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        numberOfDevices += 1
        //print("centralManager didDiscoverPeripheral - CBAdvertisementDataLocalNameKey is \"\(CBAdvertisementDataLocalNameKey)\"")
       // print(advertisementData["kCBAdvDataLocalName"] as! String)
       // print(advertisementData)
        infoText.text = infoText.text + "Devices found: \(numberOfDevices)\n"
        if (peripheral.name != nil) {
            infoText.text = infoText.text + "\(peripheral.name!), UUID:"
        } else {
            infoText.text = infoText.text + "No device name, UUID:"
        }
        
        infoText.text = infoText.text + "\n\(peripheral.identifier.uuidString)"
        infoText.text = infoText.text + "\n Signal strength: \(RSSI) \n\n"
      
        
        // Retrieve the peripheral name from the advertisement data using the "kCBAdvDataLocalName" key
        if let peripheralName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            print("NEXT PERIPHERAL NAME: \(peripheralName)")
            print("NEXT PERIPHERAL UUID: \(peripheral.identifier.uuidString)")
            
            }
        }
    
    
    
    public func centralManagerDidUpdateState(_ central: CBCentralManager){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func scanButton(_ sender: Any) {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
        infoText.text = ""
        numberOfDevices = 0
    }
    
   
    
}

