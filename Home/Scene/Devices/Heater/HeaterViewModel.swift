import Foundation

protocol HeaterViewModelDelegate: AnyObject {
    func didTapOnDeleteHeaterView()
    func didTapOnSaveHeater()
}

enum HeaterMode: String {
    case on = "ON"
    case off = "OFF"
}

class HeaterViewModel {

    weak var delegate: HeaterViewModelDelegate?

    var heaterMode: ((HeaterMode) -> Void)?
    var heaterTemperature: ((String) -> Void)?
    private var deviceID: Int?
    private var temperature = 0.0
    private var mode: HeaterMode? = .off {
        didSet {
            guard let mode = mode else { return }
            heaterMode?(mode)
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

    func setupModeAndTemperature() {
        temperature = Double(device?.temperature ?? 0)
        guard device?.mode == "ON" else {
            mode = .off
            heaterTemperature?("0 C°")
            temperature = 0.0
            return
        }
        mode = .on
        heaterTemperature?("\(temperature) C°")
    }

    func saveChanged() {
        guard let device = device, let mode = mode?.rawValue else { return }
        let devices = UserDefaultConfig.device
        let saveDevice = Device(
            deviceId: device.deviceId,
            deviceName: device.deviceName,
            intensity: nil,
            mode: mode,
            productType: device.productType,
            position: nil,
            temperature: Int(temperature)
        )
        let index = devices.firstIndex(of: device)
        var deviceList = devices.filter { $0.deviceId != deviceID }
        deviceList.insert(saveDevice, at: index ?? 0)
        UserDefaultConfig.device = deviceList
        delegate?.didTapOnSaveHeater()
    }

    func deleteDevice() {
        let devices = UserDefaultConfig.device
        let deviceList = devices.filter { $0.deviceId != deviceID }
        UserDefaultConfig.device = deviceList
        delegate?.didTapOnDeleteHeaterView()
    }

    func observeModeSwitchValue(withOnvalue: Bool) {
        guard withOnvalue else {
            heaterTemperature?("0.0 C°")
            temperature = 0.0
            mode = .off
            return
        }
        temperature = Double(device?.temperature ?? 0)
        heaterTemperature?("\(temperature) C°")
        mode = .on
    }

    func didPressPlusButton() {
        guard temperature < 28.0 else { return }
        if temperature < 7.0 {
            temperature = 6.5
        }
        if mode == .off {
            mode = .on
        }
        temperature += 0.5
        heaterTemperature?("\(temperature) C°")
    }

    func didPressMinusButton() {
        guard temperature > 7.0 else { return }
        if mode == .off {
            mode = .on
        }
        temperature -= 0.5
        heaterTemperature?("\(temperature) C°")
    }
}
