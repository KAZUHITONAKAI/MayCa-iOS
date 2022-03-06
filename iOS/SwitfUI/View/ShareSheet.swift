import SwiftUI

/*
struct TestPage: View {
    @State private var rect: CGRect = .zero
    @State private var uiImage: UIImage? = nil
    @State private var showShareSheet = false

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "sun.haze")
                    .font(.title)
                    .foregroundColor(.white)
                Text("Hello, World!")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
            .background(RectangleGetter(rect: $rect))
            .onAppear() {
                
            }
            
            Button(action: {
                self.uiImage = UIApplication.shared.windows[0].rootViewController?.view!.getImage(rect: self.rect)
                self.showShareSheet.toggle()
            }) {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(Color.white)
                    .mask(Circle())
            }.sheet(isPresented: self.$showShareSheet) {
                ShareSheet(photo: self.uiImage!)
            }.padding()
        }
    }
}

struct TestPage_Previews: PreviewProvider {
    static var previews: some View {
        TestPage()
    }
}

struct RectangleGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        GeometryReader { geometry in
            self.createView(proxy: geometry)
        }
    }
    
    func createView(proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = proxy.frame(in: .global)
        }
        return Rectangle().fill(Color.clear)
    }
}

extension UIView {
    func getImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
*/
import LinkPresentation

struct ShareSheet: UIViewControllerRepresentable {
    let photo: UIImage
          
    func makeUIViewController(context: Context) -> UIActivityViewController {
        //let text = "🐥"
        let text = ""//"マイデータの共有"
        let itemSource = ShareActivityItemSource(shareText: text, shareImage: photo)
        
        itemSource.linkMetaData.title = "MayCa QRコードの共有"
        
        //let activityItems: [Any] = [photo, text, itemSource]
        let activityItems: [Any] = [photo, itemSource]
        //let activityItems: [Any] = [/*text*/itemSource, text, photo]

        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil)
        
        return controller
    }
      
    func updateUIViewController(_ vc: UIActivityViewController, context: Context) {
    }
}

class ShareActivityItemSource: NSObject, UIActivityItemSource {
    
    var shareText: String
    var shareImage: UIImage
    var linkMetaData = LPLinkMetadata()
    
    init(shareText: String, shareImage: UIImage) {
        self.shareText = shareText
        self.shareImage = shareImage
        //linkMetaData.title = shareText
        super.init()
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return UIImage(named: "AppIcon") as Any
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return nil
        //return linkMetaData.url
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        //return linkMetaData
        return linkMetaData
    }
}

struct ShareMayCaSheet: UIViewControllerRepresentable {
    let url: String
    var linkMetaData = LPLinkMetadata()

    func makeUIViewController(context: Context) -> UIActivityViewController {
        linkMetaData.title = "MayCaアプリの共有"
        linkMetaData.iconProvider = NSItemProvider(contentsOf: URL(string: "MayCa"))

        let itemSource = ShareMayCaActivityItemSource(linkMetaData: linkMetaData)
        
        let activityItems: [Any] = [itemSource, url]
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil)
        
        return controller
    }
      
    func updateUIViewController(_ vc: UIActivityViewController, context: Context) {
    }
}

class ShareMayCaActivityItemSource: NSObject, UIActivityItemSource {
    
    var linkMetaData: LPLinkMetadata
    
    init(linkMetaData: LPLinkMetadata) {
        self.linkMetaData = linkMetaData
        super.init()
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return UIImage(named: "AppIcon") as Any
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return nil
        //return linkMetaData.url
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        return linkMetaData
    }

}

/*
class ShareActivityLazyLoadItemSource: NSObject, UIActivityItemSource {
    private let linkMetadata: LPLinkMetadata

    init(_ url: URL) {
        linkMetadata = LPLinkMetadata()
        super.init()
        // 完全な情報が取得できるまでプレビューに表示しておく仮の情報を入れておく
        linkMetadata.title = "placeholder title"
        linkMetadata.originalURL = url
        linkMetadata.iconProvider = NSItemProvider(contentsOf: placeholderImageURL)
        // URL から metadata を取得する (非同期処理)
        metadataProvider.startFetchingMetadata(for: originalURL) { [linkMetadata] metadata, error in
            // 非同期で実行されるブロック
            // `linkMetadata` に足りなかった情報を入れてプレビューを完成させる
            linkMetadata.title = metadata?.title
            linkMetadata.url = metadata?.url
            linkMetadata.originalURL = metadata?.originalURL
            linkMetadata.iconProvider = metadata?.iconProvider
            linkMetadata.imageProvider = metadata?.imageProvider
        }
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        return linkMetadata
    }
}
*/
