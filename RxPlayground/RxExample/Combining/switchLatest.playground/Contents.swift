import UIKit
import RxSwift

var bag = DisposeBag()

let timer1 = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance).map({"o1: \($0)"})
let timer2 = Observable<Int>.interval(RxTimeInterval.seconds(5), scheduler: MainScheduler.instance).map({"o2: \($0)"})

Observable<Int>.interval(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
    .take(2)
    .map { i -> Observable<String> in
        if i%2 == 0 {
            return timer1
        } else {
            return timer2
        }
    }
    .switchLatest()
    .debug()
    .subscribe()
    .disposed(by: bag)
