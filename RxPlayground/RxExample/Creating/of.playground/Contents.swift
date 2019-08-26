import UIKit
import RxSwift


var bag = DisposeBag()

Observable.of([1,2,3],[4,5,6])
    .subscribe { event in
        switch event {
        case let .next(value):
            print(value)
        default:
            print("finished")
        }
        
    }.disposed(by: bag)
