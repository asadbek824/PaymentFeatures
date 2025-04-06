import Foundation

public enum ConnectionStatus {
    case notConnected
    case searching
    case connecting(to: String)
    case connected(to: String)
    case failed(error: String)
    case stopped
    
    public var description: String {
        switch self {
        case .notConnected:
            return "Not Connected"
        case .searching:
            return "Searching for peers..."
        case .connecting(let name):
            return "Connecting to \(name)..."
        case .connected(let name):
            return "Connected to \(name)"
        case .failed(let error):
            return "Failed: \(error)"
        case .stopped:
            return "Stopped"
        }
    }
}