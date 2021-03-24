import Foundation

protocol LightViewModelDelegate: AnyObject {
    func didTapOnDeleteLightView()
    func didTapOnSaveLight()
}

enum LightMode: String {
    case on = "ON"
    case off = "OFF"
}

class LightViewModel {

    weak var delegate: LightViewModelDelegate?

    var lightIntensity: ((String) -> Void)?
    var lightMode: ((LightMode) -> Void)?
    private var intensity = 10
    private var deviceID: Int?
    private var mode: LightMode? = .on {
        didSet {
            guard let mode = mode else { return }
            lightMode?(mode)
        }
    }

    init(deviceID: Int?) {
        self.deviceID = deviceID
    }

    var device: Device? {
        let saveDevices = UserDefaultConfig.device
        let selectedDevice = saveDevices.filter { $0.deviceId == deviceID }.first
        return selectedDevice!
    }

    func setupLightAndIntensity() {
        intensity = device?.intensity ?? 0
        if device?.mode == "ON" && device?.intensity != 0 {
            mode = .on
            lightIntensity?("\(intensity)")
        } else {
            mode = .off
            lightIntensity?("\(intensity)")
        }
    }

    func observeLightIntensity(with value: Int) {
        if value == 0 {
            mode = .off
        } else {
            mode = .on
        }
        lightIntensity?("\(value)")
        intensity = value
    }

    func saveChanged() {
        guard let device = device, let mode = mode?.rawValue else { return }
        let devices = UserDefaultConfig.device
        let saveDevice = Device(
            deviceId: device.deviceId,
            deviceName: device.deviceName,
            intensity: intensity,
            mode: mode,
            productType: device.productType,
            position: nil,
            temperature: nil
        )
        let index = devices.firstIndex(of: device)
        var deviceList = devices.filter { $0.deviceId != deviceID }
        deviceList.insert(saveDevice, at: index ?? 0)
        UserDefaultConfig.device = deviceList
        delegate?.didTapOnSaveLight()
    }

    func deleteDevice() {
        let devices = UserDefaultConfig.device
        let deviceList = devices.filter { $0.deviceId != deviceID }
        UserDefaultConfig.device = deviceList
        delegate?.didTapOnDeleteLightView()
    }

    func observceSwithValueChanged(valueMode: Bool){
        guard valueMode else {
            lightIntensity?("0")
            mode = .off
            intensity = 0
            return
        }
        lightIntensity?("50")
        mode = .on
        intensity = 50
    }
}
