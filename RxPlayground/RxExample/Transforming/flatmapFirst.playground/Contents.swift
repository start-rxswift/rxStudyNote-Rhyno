import UIKit
import RxSwift

var bag = DisposeBag()

let timer1 = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance).map({"o1: \($0)"}).take(3)
let timer2 = Observable<Int>.interval(RxTimeInterval.seconds(5), scheduler: MainScheduler.instance).map({"o2: \($0)"})

Observable<Int>.interval(RxTimeInterval.seconds(4), scheduler: MainScheduler.instance)
    .take(2)
    .map { i -> Observable<String> in
        if i%2 == 0 {
            return timer1
        } else {
            return timer2
        }
    }
    .flatMapFirst({$0})
    .debug()
    .subscribe()
    .disposed(by: bag)
