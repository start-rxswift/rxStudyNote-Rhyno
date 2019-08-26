import UIKit
import RxSwift

var bag = DisposeBag()

let timer1 = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance).map({"o1: \($0)"})
let timer2 = Observable<Int>.interval(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance).map({"o2: \($0)"})

Observable.of(timer1,timer2)
    .flatMap({$0})
    .debug()
    .subscribe()
    .disposed(by: bag)
