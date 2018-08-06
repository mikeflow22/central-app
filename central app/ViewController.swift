//
//  ViewController.swift
//  central app
//
//  Created by Michael Flowers on 7/30/18.
//  Copyright © 2018 Michael Flowers. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController , CBCentralManagerDelegate, CBPeripheralDelegate {
    
    //MARK: Properties
    var myCentral: CBCentralManager?
    var myPeri: CBPeripheral? //why not peripheral manager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myCentral = CBCentralManager(delegate: self, queue: nil)
      
    }
    
    //MARK: IBActions
    @IBAction func scanButtonPressed(_ sender: UIButton) {
        myCentral?.scanForPeripherals(withServices: nil, options: nil)
        print("button pressed")
    }
    
    //MARK: Delegate Methods
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("powered on")
        } else {
            //make an alert to tell user to turn on bluetooth
            print("not powered on")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral.name?.contains("HFQ") == true {
            print("I found it: \(peripheral.name)")
            print("Advertisement data: \(advertisementData)")
            print("Peripheral UUID: \(peripheral.identifier.uuidString)")
            print("RSSI: \(RSSI)")
//            print("Services: \(peripheral.services)")
            connect(toPeripheral: peripheral)
            myCentral?.stopScan()
            print("**************************************************************************************************")
        } else {
            print("Just a name: \(peripheral.name)")
            print("Advertisement data: \(advertisementData)")
            print("Peripheral UUID: \(peripheral.identifier.uuidString)")
            print("RSSI: \(RSSI)")
            print("**************************************************************************************************")
        }
    
    }
    
    func connect(toPeripheral: CBPeripheral) {
        myCentral?.connect(toPeripheral, options: nil)
        myPeri = toPeripheral
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected to Peripheral \(peripheral.name)")
        myPeri?.delegate = self //why set the delegate here?
//        print(peripheral.services)
//        peripheral.discoverServices(nil)
        
    }

}

