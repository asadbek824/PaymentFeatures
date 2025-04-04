//
//  PayShareViewModel.swift
//  Payment
//
//  Created by Akbarshah Jumanazarov on 4/4/25.
//

import Core
import Combine
import Foundation
import CoreBluetooth

class PayShareViewModel: ObservableObject {
    
    @Published var isScaling = false
    @Published var amount: String = ""
    @Published var discoveredPeripherals: [CBPeripheral] = []
    @Published var selectedPeripheral: CBPeripheral?
    @Published var isConnected: Bool = false
    @Published var receivedMessage: String?
    @Published var showAlert = false
    @Published var isPeripheral: Bool = true
    
    private var bluetoothManager: BluetoothManager?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $amount
            .debounce(for: .milliseconds(1000), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] newAmount in
                self?.setupBluetoothManager(for: newAmount)
            }
            .store(in: &cancellables)
        
        setupBluetoothManager(for: "")
    }
    
    private func setupBluetoothManager(for amount: String) {
        bluetoothManager?.stopScanning()
        bluetoothManager = nil
        
        isPeripheral = amount.isEmpty
        bluetoothManager = BluetoothManager(asPeripheral: isPeripheral)
        
        if isPeripheral {
            print("Initialized as Peripheral")
            discoveredPeripherals.removeAll()
            selectedPeripheral = nil
            isConnected = false
            setupPeripheralCallbacks()
        } else {
            print("Initialized as Central")
            setupCentralCallbacks()
            startScanning()
        }
    }
    
    private func setupPeripheralCallbacks() {
        bluetoothManager?.onConnectionStatusChanged = { [weak self] isConnected in
            DispatchQueue.main.async {
                self?.isConnected = isConnected
            }
        }
        
        bluetoothManager?.onDataReceived = { [weak self] data in
            if let message = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self?.receivedMessage = "Received amount: \(message)"
                    self?.showAlert = true
                }
            }
        }
    }
    
    private func setupCentralCallbacks() {
        bluetoothManager?.onDiscoveredPeripherals = { [weak self] peripherals in
            DispatchQueue.main.async {
                self?.discoveredPeripherals = peripherals
            }
        }
        
        bluetoothManager?.onConnectionStatusChanged = { [weak self] isConnected in
            DispatchQueue.main.async {
                self?.isConnected = isConnected
            }
        }
        
        bluetoothManager?.onDataReceived = { [weak self] data in
            if let message = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self?.receivedMessage = message
                    self?.showAlert = true
                }
            }
        }
    }
    
    func startScanning() {
        guard !amount.isEmpty else { return }
        bluetoothManager?.startScanning()
    }
    
    func connectToPeripheral(_ peripheral: CBPeripheral) {
        guard !amount.isEmpty else { return }
        bluetoothManager?.connectToPeripheral(peripheral)
        selectedPeripheral = peripheral
    }
    
    func sendMessage() {
        guard !amount.isEmpty else { return }
        bluetoothManager?.sendMessage(amount)
    }
}
