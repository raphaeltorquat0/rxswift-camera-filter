import Foundation
import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
    
    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                /*Access the hphotos from photo library*/
            }
        }
    }
}
