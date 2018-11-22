import Foundation

public struct Pretty {
    
    public static func net(value: Float) -> String {
        if (value == -1) {
            return "unlimited"
        } else {
            var unit = "bytes"
            var bytes = value
            if (bytes >= 1024 * 1024 * 1024 * 1024) {
                unit = "TiB"
                bytes /= 1024 * 1024 * 1024 * 1024
            } else if (bytes >= 1024 * 1024 * 1024) {
                unit = "GiB"
                bytes /= 1024 * 1024 * 1024
            } else if (bytes >= 1024 * 1024) {
                unit = "MiB"
                bytes /= 1024 * 1024
            } else if (bytes >= 1024) {
                unit = "KiB"
                bytes /= 1024
            }
            
            return "\(roundNet(bytes)) \(unit)"
        }
    }
    
    public static func ram(value: Float) -> String {
        return roundRam(value / 1000)
    }
    
    public static func cpu(value: Float) -> String {
        if (value == -1) {
            return "unlimited"
        } else {
            var unit = ""
            var micro = value
            if (micro > 1000000 * 60 * 60) {
                micro /= 1000000 * 60 * 60
                unit = "hr"
            }
            
            if (micro > 1000000 * 60) {
                micro /= 1000000 * 60
                unit = "min"
            }
            
            if (micro > 1000000) {
                micro /= 1000000
                unit = "sec"
            }
            
            if (micro > 1000) {
                micro /= 1000
                unit = "ms"
            }
            
            return "\(roundCpu(micro)) \(unit)"
        }
    }
    
    private static func roundNet(_ value: Float) -> String {
        return String(format: "%.2f", value)
    }
    
    private static func roundRam(_ value: Float) -> String {
        return String(format: "%.2f", value)
    }
    
    private static func roundCpu(_ value: Float) -> String {
        return String(format: "%.3f", value)
    }
}
