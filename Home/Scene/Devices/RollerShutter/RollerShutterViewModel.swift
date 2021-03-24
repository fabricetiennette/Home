import Foundation

protocol RollerShutterViewModelDelegate: AnyObject {
    func didTapOnDeleteRollerShutterView()
}

class RollerShutterViewModel {

    weak var delegate: RollerShutterViewModelDelegate?

    private var deviceID: Int?

    init(deviceID: Int?) {
        self.deviceID = deviceID
    }

    var device: Device? {
        let saveDevices = UserDefaultConfig.device
        let selectedDevice = saveDevices.filter { $0.deviceId == deviceID }.first
        return selectedDevice!
    }

    func saveChanged(with position: String?) {
        guard let position = position, let device = device else { return }
        let devices = UserDefaultConfig.device
        let saveDevice = Device(
            deviceId: device.deviceId,
            deviceName: device.deviceName,
            intensity: nil,
            mode: nil,
            productType: device.productType,
            position: Int(position),
            temperature: nil
        )
        let index = devices.firstIndex(of: device)
        var deviceList = devices.filter { $0.deviceId != deviceID }
        deviceList.insert(saveDevice, at: index ?? 0)
        UserDefaultConfig.device = deviceList
    }

    func deleteDevice() {
        let devices = UserDefaultConfig.device
        let deviceList = devices.filter { $0.deviceId != deviceID }
        UserDefaultConfig.device = deviceList
        delegate?.didTapOnDeleteRollerShutterView()
    }
}
