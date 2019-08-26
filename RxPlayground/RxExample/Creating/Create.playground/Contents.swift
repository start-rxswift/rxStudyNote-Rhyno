import UIKit
import RxSwift


var bag = DisposeBag()

// 타입 추론이 불가능해서 명시적으로 써줘야 한다.
Observable<Int>.create { observable in
    
    observable.onNext(0)
    observable.onNext(1)
    observable.onNext(2)
    observable.onCompleted()
    
    return Disposables.create()
    
    }.subscribe { event in
        switch event {
        case let .next(value):
            print(value)
        default:
            print("finished")
        }
        
}.disposed(by: bag)
