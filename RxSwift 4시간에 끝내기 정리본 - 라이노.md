# RxSwift 4시간에 끝내기
ReactiveX.io

* observable stream을 통한 비동기 프로그래밍 API
	* 이거면 50%다.
* Introduction
	* 동기 vs 비동기
	* Introduction만 읽으면 마스터할 수 있다.
	* 하지만 어느 세월에 다 읽겠는가? 
* Docs
	* Observable - 핵심
	* Operators - 더 잘 쓸수 있다.
	* Single - 몰라도 괜찮다.
	* Subject - 뭔가를 만들 수 있다.
	* Scheduler - 다른 데 적용을 할 수 있다.
* Languages
	* Rx를 한번 배우면 다른 언어에서도 동일하게 적용할 수 있다.
* Resources
	* Tutorial - 수많은 자료들( Rx 전반에 대한)
*  Community
	* Github

- - - -
* RxSwift 왜쓰는가? -  비동기적으로 데이터를 처리하는 코드를 더 간결하게 쓰기 위해서. 굳이 다 쓰겠다면 안 써도 됨.
	* 단순한 코드라면 오히려 Rx 가져다 쓰는 게 더 복잡할 수 있다.
	* PromiseKit,,Bolts같은 것 써도 되는데 왜  Rx여야 하는가? -> Operator의 존재!( Bolts 는 현재 1년 정도 업데이트가 되지 않은 상태라 쓰기 좀 그렇다)
	
* Observable 
	* 값을 내보내는 주체
	* 원하는 Observable을 구독하면 원하는 값이 날아온다.
	* 구독할 때 원하는 처리를 클로저 형태로 넘긴다.
	* observable이 completed 나 error를 내보내게 되면 자동으로  dispose된다.
* Observable 구독 중단하기
	* observable 은 구독하면 disposable을 반환한다.
	* 해당 disposable에 대해 dispose() 메소드를 실행시켜주면 중단시킬 수 있다.
	* 일일이 구독해제 시켜주기가 번거로울 땐 DisposeBag에 담아놓으면  DisposeBag이 해제될 때 자동으로 해제된다.
	* disposable
	* DisposeBag은 dispose 할 수 있는 메소드를 따로 제공하지 않기 때문에 disposeBag에 대한 참조를 없애고 새로 만드는 방법으로 dispose해야한다.
	

* Operator
	* just : 값을 제공해주면 제공해준 값을 그대로 방출한다. 방출 후 자동으로 dispose된다.
	* from :  array를 인자로 받아 해당 array 의 원소를 하나하나 떼서 이벤트로 내보낸다.
	* map : 이벤트를 받아서 해당 이벤트의 내용을 바꿔치기 해서 내보낸다. (Event<T> -> Event<U>)
	* filter : 이벤트와 클로저를 받아서 해당 이벤트 내용을 주어진 클로저에 넣어  참일 경우에만 계속 흘려보낸다.  
> Stream : 연산자들의 연속. Rx는 Observable  Stream(즉 Observable에 여러 연산을 연속적으로 적용한다)으로 연속적인 비동기 데이터를 처리한다.    

* Operator의 종류 -> 필요할 때 와서 찾으면 된다.
	* 생성
	* 변환
	* 필터링
	* 결합
	* 오류처리
	* Observable  유틸리티
	* 조건과 불린 연산자
	* 수학과 집계 연산자
	* 역압 연산자
	* 연결
	* Observable 변환
* 저 많은 연산자를 어떻게 이해할 것인가? -> marble로 이해한다![RxMarbles](https://rxmarbles.com)
	* Rxswift에 대해서는 설명이 없는 경우가 많다 -> RxJava가 충실히 되어 있는 경우가 많다. -> 다만 RxSwift와 대응되지 않는 경우도 많으니 감안하고 봐야한다.
* 나온 연산자
	* From
	* Map
	* Filter
	* Single(first)
	* flatMap -> 데이터를 넣으면 스트림이 나온다.
	* concat
	* zip
	* merge
* subscribe -> 구독을 한 뒤  disposable을 반환
	* subscribe() - 아무 처리도 안함  
	* subscribe(on: ) - 이벤트를  enum형태로 받아 처리 -> 정석
	* subscribe(pnNext: onError: onCompleted: onDisposed:) -> 필요한 것만 골라서 적용할 때, onDisposed를 적용할 때
*  scheduler
	* 스레드 비슷한 것
	* observeOn으로 그 다음 줄 부터 해당  scheduler로 실행 문맥이 바뀜
	* subscribeOn - subscribe되는 순간부터 지정한 Scheduler 로 돌리겠다 -> 어디에 써도 상관은 없다.
	* 중요한 Scheduler
		*  MainScheduler
		* ConcurrentDispatchQueueScheduler
* sideEffect 가능성
	*  subscribe 시
	* do -> 흐름 중간에 side-effect가 있는 행동을 할 때

* 바인딩


* Subject : 데이터를 외부에서 넣어줄 수 있는 Observable
	* AsyncSubject
		* subscribe시 아무것도 받을 수 없다.
		* subject가 끝날 때의 가장 마지막 이벤트를 구독자 모두가 받게 된다.
	* BehaviorSubject
		* default 값을 가짐
		* subscribe 하면 현재 값을 방출해 줌
		* 이후 값이 변경될 때 마다 이벤트를 보내줌
	* PublisherSubject
		*  subscribe시에는 아무것도 안 넘어온다.
		* 구독해 놓으면 이후 값 발생을 모두 받아볼 수 있다.
	* ReplaySubject
		* 첫 subscribe 시에는 아무것도 받을 수 없다
		* 이후 값의 변경은 모두 받아볼 수 있다.
		* 두번째 이후의 구독이 발생하면 구독 시점에서 그때까지 발생했던 모든 이벤트가 순서대로 들어온다.
* Driver -  매번 mainScheduler로 바꾸기 귀찮아서 만든 거.   