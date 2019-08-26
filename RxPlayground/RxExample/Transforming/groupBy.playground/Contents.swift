import UIKit
import RxSwift

var bag = DisposeBag()

Observable.from([1,2,3,4,5,6,7,8,9,10])
    .groupBy(keySelector: { i -> String in
        if i%2 == 0 {
            return "odd"
        } else {
            return "even"
        }
    } ).flatMap { o -> Observable<String> in
        if o.key == "odd" {
            return o.map { v in
                "odd \(v)"
            }
        } else {
                return o.map { v in
                    "even \(v)"
                }
            }
        }
    .subscribe { event in
        switch event {
        case let .next(value):
           print(value)
        default:
            print("finished")
        }
        
    }.disposed(by: bag)
