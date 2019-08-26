import UIKit
import RxSwift

var bag = DisposeBag()

let timer = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance).map({"o1: \($0)"})

timer.window(timeSpan: RxTimeInterval.seconds(3), count: 2, scheduler: MainScheduler.instance)
    .subscribe { event in
        switch event {
        case let .next(observable):
            observable.subscribe { e in
                switch e {
                case let .next(value):
                    print(value)
                default:
                    print("inner finished")
                }
            }
        default:
            print("finished")
        }
        
    }.disposed(by: bag)
