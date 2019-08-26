import UIKit
import RxSwift

var bag = DisposeBag()

let timer1 = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance).map({"o1: \($0)"})

timer1.buffer(timeSpan: RxTimeInterval.seconds(3), count: 2, scheduler: MainScheduler.instance)
    .subscribe { event in
    switch event {
    case let .next(value):
        print(value)
    default:
        print("finished")
    }
    
    }.disposed(by: bag)
