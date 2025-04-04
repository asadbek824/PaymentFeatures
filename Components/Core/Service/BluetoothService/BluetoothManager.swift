//
//  BluetoothManager.swift
//  Core
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import Foundation
import CoreBluetooth

public class BluetoothManager: NSObject {
    // Callbacks
    public var onDiscoveredPeripherals: (([CBPeripheral]) -> Void)?
    public var onConnectionStatusChanged: ((Bool) -> Void)?
    public var onDataReceived: ((Data) -> Void)?
    
    // Properties
    private var peripheralManager: BluetoothPeripheralManager?
    private var centralManager: BluetoothCentralManager?
    private var isPeripheral: Bool
    
    public init(asPeripheral: Bool) {
        self.isPeripheral = asPeripheral
        super.init()
        setupManager()
    }
    
    private func setupManager() {
        if isPeripheral {
            peripheralManager = BluetoothPeripheralManager()
            peripheralManager?.connectionStatusCallback = { [weak self] isConnected in
                self?.onConnectionStatusChanged?(isConnected)
            }
            peripheralManager?.dataReceivedCallback = { [weak self] data in
                self?.onDataReceived?(data)
            }
        } else {
            setupCentralManager()
        }
    }
    
    private func setupCentralManager() {
        centralManager = BluetoothCentralManager()
        centralManager?.discoveryCallback = { [weak self] peripherals in
            self?.onDiscoveredPeripherals?(peripherals)
        }
        
        centralManager?.dataHandler = { [weak self] data in
            self?.onDataReceived?(data)
        }
        
        centralManager?.connectionStatusHandler = { [weak self] isConnected in
            self?.onConnectionStatusChanged?(isConnected)
        }
    }
    
    public func startScanning() {
        if !isPeripheral {
            centralManager?.startScanning()
        }
    }
    
    public func stopScanning() {
        if !isPeripheral {
            centralManager?.stopScanning()
        }
    }
    
    public func connectToPeripheral(_ peripheral: CBPeripheral) {
        if !isPeripheral {
            centralManager?.connectToPeripheral(peripheral)
        }
    }
    
    public func sendMessage(_ message: String) {
        guard let data = message.data(using: .utf8) else {
            print("Could not convert message to data")
            return
        }
        
        if isPeripheral {
            peripheralManager?.sendData(data)
        } else {
            centralManager?.sendData(data)
        }
    }
}
