import Foundation
import RxSwift
import RxCocoa

class APIClient {
    
    lazy var requestObservable = APIRequest(config: .default)

    func getDevicesAndUser() throws -> Observable<Response> {
        var request = URLRequest(url: URL(string:"http://storage42.com/modulotest/data.json")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return requestObservable.callAPI(request: request)
    }
}
