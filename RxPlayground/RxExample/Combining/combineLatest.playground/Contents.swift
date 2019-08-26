import UIKit
import RxSwift

var bag = DisposeBag()

let timer1 = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance).map({"o1: \($0)"})
let timer2 = Observable<Int>.interval(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance).map({"o2: \($0)"})

Observable.combineLatest(timer1,timer2){ v1, v2 in
        v1+" "+v2
    }
    .subscribe { event in
        switch event {
        case let .next(value):
            print(value)
        default:
            print("finished")
        }
        
    }.disposed(by: bag)

