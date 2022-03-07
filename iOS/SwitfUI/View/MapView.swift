import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var latitude: String
    var longitude: String
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if (self.latitude.count>0 && self.longitude.count>0){
            
            let coordinate = CLLocationCoordinate2D(
                latitude: Double(self.latitude)!, longitude: Double(self.longitude)!)
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            uiView.setRegion(region, animated: true)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(latitude: personData[0].latitude,longitude: personData[0].longitude)
    }
}
