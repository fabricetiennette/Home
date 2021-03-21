import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {

    let apiClient: APIClient
    let disposeBag = DisposeBag()

    init(apiClient: APIClient = .init()) {
        self.apiClient = apiClient
    }

    func getDevice() {
        do {
            try apiClient.getDevicesAndUser().subscribe(onNext: { result in
                print(result)
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
                print("completed event")
            }).disposed(by: disposeBag)
        } catch {}
    }
}
