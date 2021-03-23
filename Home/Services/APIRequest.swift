import Foundation
import RxSwift
import RxCocoa

public class APIRequest {

    private lazy var jsonDecoder = JSONDecoder()
    private var urlSession: URLSession

    public init(config: URLSessionConfiguration) {
        urlSession = URLSession(configuration: .default)
    }

    public func callAPI<Item: Decodable>(request: URLRequest) -> Observable<Item> {
        return Observable.create { observer in

            let task = self.urlSession.dataTask(with: request) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {

                    do {

                        let data = data ?? Data()
                        if (200...399).contains(httpResponse.statusCode) {
                            let objs = try self.jsonDecoder.decode(Item.self, from: data)
                            observer.onNext(objs)
                        } else {
                            observer.onError(error!)
                        }
                    } catch {
                        observer.onError(error)
                    }
                }
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
