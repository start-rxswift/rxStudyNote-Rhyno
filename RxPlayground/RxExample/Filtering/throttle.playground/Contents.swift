import UIKit
import RxSwift


var bag = DisposeBag()

let timer = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)

timer.throttle(RxTimeInterval.seconds(2), latest: false, scheduler: MainScheduler.instance)
    .subscribe { event in
        switch event {
        case let .next(value):
            print(value)
        default:
            print("finished")
        }
        
    }.disposed(by: bag)


timer.throttle(RxTimeInterval.seconds(2), latest: false, scheduler: MainScheduler.instance)
    .debug()
    .subscribe()
    .disposed(by: bag)
