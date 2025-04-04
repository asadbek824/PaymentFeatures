//
//  BluetoothPeripheralManager.swift
//  Core
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import Foundation
import CoreBluetooth

public class BluetoothPeripheralManager: NSObject {
    
    private let serviceUUID = BluetoothConstants.serviceUUID
    private let characteristicUUID = BluetoothConstants.characteristicUUID
    
    var peripheralManager: CBPeripheralManager!
    var transferCharacteristic: CBMutableCharacteristic?
    var dataToSend: Data?
    var sendDataIndex: Int = 0
    var connectionStatusCallback: ((Bool) -> Void)?
    var dataReceivedCallback: ((Data) -> Void)?
    
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func startAdvertising() {
        // Create the service
        let transferService = CBMutableService(type: serviceUUID, primary: true)
        
        // Create the characteristic
        let characteristic = CBMutableCharacteristic(
            type: characteristicUUID,
            properties: [.notify, .writeWithoutResponse, .write],
            value: nil,
            permissions: [.readable, .writeable]
        )
        
        // Add the characteristic to the service
        transferService.characteristics = [characteristic]
        
        // Add the service to the peripheral manager
        peripheralManager.add(transferService)
        
        // Save the characteristic for later use
        transferCharacteristic = characteristic
        
        // Start advertising
        peripheralManager.startAdvertising([
            CBAdvertisementDataServiceUUIDsKey: [serviceUUID],
            CBAdvertisementDataLocalNameKey: "DataTransferDevice"
        ])
        
        print("Started advertising")
    }
    
    func sendData(_ data: Data) {
        self.dataToSend = data
        self.sendDataIndex = 0
        
        // Start sending data if possible
        sendDataChunk()
    }
    
    private func sendDataChunk() {
        guard let dataToSend = dataToSend,
              let transferCharacteristic = transferCharacteristic else {
            return
        }
        
        // Check if we have more data to send
        if sendDataIndex >= dataToSend.count {
            print("All data sent")
            return
        }
        
        // Get the amount of data we can send
        let amountToSend = min(dataToSend.count - sendDataIndex, 20) // MTU size limitation
        
        // Create the chunk of data to send
        let chunk = dataToSend.subdata(in: sendDataIndex..<(sendDataIndex + amountToSend))
        
        // Send the chunk
        let didSend = peripheralManager.updateValue(
            chunk,
            for: transferCharacteristic,
            onSubscribedCentrals: nil
        )
        
        // If the data was sent successfully, increment the index
        if didSend {
            sendDataIndex += amountToSend
            
            // Send the next chunk
            sendDataChunk()
        }
        // If the data wasn't sent, the callback will be invoked when ready
    }
}

extension BluetoothPeripheralManager: CBPeripheralManagerDelegate {
    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOn:
            print("Peripheral manager powered on")
            startAdvertising()
        default:
            print("Invalid peripheral manager state: ", peripheral.state)
        }
    }
    
    public func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        if let error = error {
            print("Error adding service: \(error.localizedDescription)")
        } else {
            print("Service added successfully")
        }
    }
    
    public func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error {
            print("Error advertising: \(error.localizedDescription)")
        } else {
            print("Advertising started successfully")
        }
    }
    
    public func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        print("Central subscribed to characteristic")
        // Notify that we're connected when central subscribes
        connectionStatusCallback?(true)
        
        // If we have data to send, start sending it now
        if let dataToSend = dataToSend, sendDataIndex < dataToSend.count {
            sendDataChunk()
        }
    }
    
    public func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        print("Central unsubscribed from characteristic")
        // Notify that we're disconnected when central unsubscribes
        connectionStatusCallback?(false)
    }
    
    public func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
        // Continue sending data
        sendDataChunk()
    }
    
    public func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        for request in requests {
            if let value = request.value {
                // Handle the received data
                print("Received data: \(value)")
                
                // Respond to the request if needed
                if request.characteristic.properties.contains(.write) {
                    peripheral.respond(to: request, withResult: .success)
                }
                
                // Trigger the callback with received data
                dataReceivedCallback?(value)
            }
        }
    }
}
