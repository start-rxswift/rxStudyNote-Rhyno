import UIKit
import RxSwift

var bag = DisposeBag()

var observableSwitch:Bool = false

let observable = Observable<Int>.deferred {
    observableSwitch.toggle()
    
    if observableSwitch {
        return Observable.from([1,2,3])
    } else {
        return Observable.from([4,5,6])
    }
}

observable.subscribe { event in
    switch event {
    case let .next(value):
        print(value)
    default:
        print("finished")
    }
    
    }.disposed(by: bag)

observable.subscribe { event in
    switch event {
    case let .next(value):
        print(value)
    default:
        print("finished")
    }
    
    }.disposed(by: bag)
