//
//  BluetoothCentralManager.swift
//  Core
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import Foundation
import CoreBluetooth

public class BluetoothCentralManager: NSObject {
    
    private let serviceUUID = BluetoothConstants.serviceUUID
    private let characteristicUUID = BluetoothConstants.characteristicUUID
    
    var centralManager: CBCentralManager!
    var discoveredPeripherals: [CBPeripheral] = []  // Array to store discovered peripherals
    var connectedPeripheral: CBPeripheral?
    var transferCharacteristic: CBCharacteristic?
    var receivedData = Data()
    var connectionStatusHandler: ((Bool) -> Void)?
    var dataHandler: ((Data) -> Void)?
    var discoveryCallback: (([CBPeripheral]) -> Void)?  // Callback for peripheral discovery updates
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScanning() {
        // Clear previous discoveries when starting a new scan
        discoveredPeripherals.removeAll()
        
        centralManager.scanForPeripherals(withServices: [serviceUUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        print("Started scanning")
    }
    
    func stopScanning() {
        centralManager.stopScan()
        print("Stopped scanning")
    }
    
    // Connect to a specific peripheral from the discovered list
    func connectToPeripheral(_ peripheral: CBPeripheral) {
        centralManager.connect(peripheral, options: nil)
    }
    
    func sendData(_ data: Data) {
        guard let connectedPeripheral = connectedPeripheral,
              let transferCharacteristic = transferCharacteristic else {
            print("No peripheral or characteristic available")
            return
        }
        
        // Write the data to the peripheral
        connectedPeripheral.writeValue(data, for: transferCharacteristic, type: .withResponse)
    }
}

extension BluetoothCentralManager: CBCentralManagerDelegate {
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch central.state {
    case .poweredOn:
        print("Central manager powered on")
        startScanning()
    default:
        print("Invalid central manager state: ", central.state)
    }
}

    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
    // Check if this peripheral is already in our list
    if !discoveredPeripherals.contains(where: { $0.identifier == peripheral.identifier }) {
        // Add peripheral to the list
        discoveredPeripherals.append(peripheral)
        print("Discovered: \(peripheral.name ?? "unnamed device") RSSI: \(RSSI)")
        
        // Call the discovery callback with the updated list
        discoveryCallback?(discoveredPeripherals)
    }
}

    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    print("Connected to: \(peripheral.name ?? "unnamed device")")
    
    // Store the connected peripheral
    connectedPeripheral = peripheral
    
    // Stop scanning
    stopScanning()
    
    // Set peripheral delegate
    peripheral.delegate = self
    
    // Discover services
    peripheral.discoverServices([serviceUUID])
    
    connectionStatusHandler?(true)
}

    public func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
    print("Failed to connect to peripheral: \(error?.localizedDescription ?? "unknown error")")
}

    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
    print("Disconnected from peripheral: \(error?.localizedDescription ?? "no error")")
    
    // Clear the connected peripheral reference
    if connectedPeripheral?.identifier == peripheral.identifier {
        connectedPeripheral = nil
        transferCharacteristic = nil
    }
    
    connectionStatusHandler?(false)
}
}

extension BluetoothCentralManager: CBPeripheralDelegate {
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
    if let error = error {
        print("Error discovering services: \(error.localizedDescription)")
        return
    }
    
    // Discover the characteristics for each service
    if let services = peripheral.services {
        for service in services {
            peripheral.discoverCharacteristics([characteristicUUID], for: service)
        }
    }
}

    public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
    if let error = error {
        print("Error discovering characteristics: \(error.localizedDescription)")
        return
    }
    
    // Look for the transfer characteristic
    if let characteristics = service.characteristics {
        for characteristic in characteristics {
            if characteristic.uuid == characteristicUUID {
                // Save reference to the characteristic
                transferCharacteristic = characteristic
                
                // Subscribe to notifications
                peripheral.setNotifyValue(true, for: characteristic)
                
                print("Discovered characteristic: \(characteristic)")
            }
        }
    }
}

    public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
    if let error = error {
        print("Error receiving update: \(error.localizedDescription)")
        return
    }
    
    guard let data = characteristic.value else {
        return
    }
    
    // Append the data
    receivedData.append(data)
    
    // Process the data if needed
    let receivedString = String(data: data, encoding: .utf8) ?? "Invalid data"
    print("Received: \(receivedString)")
    
    // Call data handler if set
    dataHandler?(data)
}

    public func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
    if let error = error {
        print("Error writing value: \(error.localizedDescription)")
    } else {
        print("Value written successfully")
    }
}
}
