import Foundation
import UIKit

class DevicesDataSource: NSObject {

    private var devices: [Device] = []
    var didSelectHandler: ((_ device: Device) -> Void)?

    func update(with devices: [Device]) {
        self.devices = devices
    }
}

extension DevicesDataSource: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard indexPath.item < devices.count else { return }
        didSelectHandler?(devices[indexPath.item])
    }
}

extension DevicesDataSource: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 3 * 10) / 2
        let height = width
        return CGSize(width: width, height: height)
    }

}

extension DevicesDataSource: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        devices.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let device = devices[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "DeviceCollectionViewCell",
            for: indexPath
        ) as! DeviceCollectionViewCell
        cell.configure(device: device)
        return cell
    }
}
