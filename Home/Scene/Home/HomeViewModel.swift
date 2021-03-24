import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelDelegate: AnyObject {
    func didTapOnHeater(deviceID: Int?)
    func didTapOnLight(deviceID: Int?)
    func didTapOnRollerShutter(deviceID: Int?)
    func didTapOnProfile(user: User)
}

class HomeViewModel {

    weak var delegate: HomeViewModelDelegate?

    var devicesHandler: ((_ devices: [Device]) -> Void)?
    var errorHandler: (() -> Void)?
    private var devices: [Device] = []
    private var user: User?
    private var unFilteredDevices: [Device] = []
    private let homeService: HomeService
    private let disposeBag = DisposeBag()

    init(homeService: HomeService = .init()) {
        self.homeService = homeService
    }

    func getDevice() {
        do {
            try homeService.getDevicesAndUser()
                .subscribe(onNext: { [weak self] result in
                    self?.setDeviceAndUser(with: result)
                }, onError: { error in
                    self.errorHandler?()
                }).disposed(by: disposeBag)
        } catch {}
    }

    func filteredDevices(producTypeName: String) {
        switch producTypeName {
        case L1s.all:
            devices = unFilteredDevices
        case L1s.shutter:
            devices = unFilteredDevices.filter({ $0.productType == "RollerShutter" })
        case L1s.light:
            devices = unFilteredDevices.filter({ $0.productType == "Light" })
        case L1s.heater:
            devices = unFilteredDevices.filter({ $0.productType == "Heater" })
        default:
            devices = unFilteredDevices.filter({ $0.productType == producTypeName })
        }
        devicesHandler?(devices)
    }

    func getSelectedDevice(selectedDevice: Device) {
        switch selectedDevice.productType {
        case "Heater":
            delegate?.didTapOnHeater(deviceID: selectedDevice.deviceId)
        case "Light":
            delegate?.didTapOnLight(deviceID: selectedDevice.deviceId)
        case "RollerShutter":
            delegate?.didTapOnRollerShutter(deviceID: selectedDevice.deviceId)
        default: break
        }
    }

    func showUser() {
        guard let user = user else { return }
        delegate?.didTapOnProfile(user: user)
    }

    private func setDeviceAndUser(with result: Response) {
        user = result.user
        if UserDefaultConfig.device == [] {
            UserDefaultConfig.device = result.devices
        }
        if UserDefaultConfig.device.count != unFilteredDevices.count {
            devicesHandler?(UserDefaultConfig.device)
        }
        unFilteredDevices = UserDefaultConfig.device
    }
}
