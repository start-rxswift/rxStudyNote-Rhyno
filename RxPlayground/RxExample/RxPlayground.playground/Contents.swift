import UIKit
import RxSwift
import RxCocoa

let LARGE_IMAGE_URL = "https://picsum.photos/1024/768/?random"
var bag = DisposeBag()

let url = URL(string: LARGE_IMAGE_URL)!
var resultImage = UIImageView(image: UIImage())

Observable<UIImage>.create { observable in
    DispatchQueue.global().async {
        do {
            let data = try Data(contentsOf: url)
            guard let image: UIImage = UIImage(data: data) else {
                let error = NSError(domain: "imageData Error",code: 500)
                observable.onError(error)
                return
            }
            
            observable.onNext(image)
            observable.onCompleted()
        } catch {
            observable.onError(error)
        }
    }
    return Disposables.create()
}.retry(3)
    .subscribe { [resultImage] event in
        switch event {
        case let .next(image):
            resultImage.image = image
        case let .error(e):
            e.localizedDescription
        case .completed:
            break
        }
}.disposed(by: bag)
