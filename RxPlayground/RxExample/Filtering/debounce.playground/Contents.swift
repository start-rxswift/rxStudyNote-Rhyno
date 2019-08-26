import UIKit

import UIKit
import RxSwift


var bag = DisposeBag()

let timer = Observable<Int>.interval(RxTimeInterval.seconds(4), scheduler: MainScheduler.instance)

timer.debounce(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { event in
        switch event {
        case let .next(value):
            print(value)
        default:
            print("finished")
        }
        
    }.disposed(by: bag)

timer.debounce(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
    .debug()
    .subscribe()
    .disposed(by: bag)
