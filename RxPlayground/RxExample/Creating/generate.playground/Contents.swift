import UIKit
import RxSwift


var bag = DisposeBag()


Observable.generate(initialState: 0,
                    condition: { $0 < 10},
                    iterate: { $0+1 })
    .subscribe { event in
        switch event {
        case let .next(value):
            print(value)
        default:
            print("finished")
        }
        
    }.disposed(by: bag)
