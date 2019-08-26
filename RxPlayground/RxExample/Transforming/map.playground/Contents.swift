import UIKit
import RxSwift

var bag = DisposeBag()

Observable.from([1,2,3,4,5,6,7,8,9,10])
    .map({"num: \($0)"})
    .subscribe { event in
        switch event {
        case let .next(value):
            print(value)
        default:
            print("finished")
        }
        
    }.disposed(by: bag)

