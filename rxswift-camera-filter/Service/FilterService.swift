import Foundation
import UIKit
import CoreImage
import RxSwift

class FiltersService {
    private var context: CIContext
    init () {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage) { filteredImage in
                observer.onNext(filteredImage)
            }
            return Disposables.create()
        }
    }
    
    private func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        guard let filter = CIFilter(name: "CICMYKHalftone") else {
            fatalError("Cannot get filter")
        }
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        guard let sourceImage = CIImage(image: inputImage) else {
            fatalError("Cannot Apply filter")
        }
        filter.setValue(sourceImage, forKey: kCIInputImageKey)
        guard let cgImage = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) else {
            fatalError("Cannot create an cg image from filter")
        }
        let processedImage = UIImage(cgImage: cgImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
        completion(processedImage)
        
    }
}
