import Foundation

class ScannerViewModel: ObservableObject {
    
    /// Defines how often we are going to try looking for a new QR-code in the camera feed.
    let scanInterval: Double = 1.0
    
    @Published var isShowing: Bool = true
    @Published var torchIsOn: Bool = false
    @Published var lastQrCode: String = "QRコード"
    @Published var isFound: Bool = false
    
    
    func onFoundQrCode(_ code: String) {
        self.lastQrCode = code
        isShowing = false
        isFound = true
    }   
}
