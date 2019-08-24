# RxSwift 5주차 - 기본 연산자 톺아보기

* 사전 개념 :  Observable, Subscribe, Dispose



* 연산자란 : Observable을 다루는 메소드. 대부분 결과 값으로 Observable을 반환하기 때문에 원하는 만큼 연쇄적으로 적용할 수 있다.

---

* 연산자의 종류  

  1. 생성 연산자(Creating Operator) : 새로운 Observable을 만들어 반환합니다.
  2. 여과 연산자(Filtering Operator) : 조건에 맞는 원소만 골라 내보내는 Observable을 만들어냅니다.
  3. 변환 연산자(Transforming Operator) : Observable의 원소들을 가공하여 다른 형태로 내보내는 Observable을 만들어냅니다. 
  4. 합성 연산자(Combining Observable) : 두 개 이상의 Observable을 합쳐 하나의 Observable로 만들어냅니다.
  5. 그 외 :  에러 처리 연산자, 유틸리티 연산자, 조건 연산자, 수학 연산자 등...

  > 자세한 연산자 목록은  http://reactivex.io의 연산자 항목을 참조하면 됩니다.  
  >
  > **주의!** 공식 사이트에 있는 모든 연산자가 RxSwift에 구현되어 있는 것은 아닙니다. 또한 RxSwift에 대한 설명은 거의 작성되어 있지 않습니다. 공식 사이트를 참조하여 관련 함수 이름을 알아낸 다음, [RxSwift 공식 저장소의 Observable 폴더](https://github.com/ReactiveX/RxSwift/tree/master/RxSwift/Observables) 를 들어가 관련 파일(대부분은 이름이 같은데, 다를 수도 있습니다.)에 적혀있는 설명을 참조하는 것이 가장 정확합니다. 또, 공식 홈페이지에는 기재되어 있지 않아도 구현되어 있는 연산자들이 존재하므로 정말로 필요하다면 반드시 체크해보셔야 합니다.

  ---

  

  ![연산자 계층도](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/연산자 계층도.png)

  

---

* 연산자 상세 -> 일부만 알아보겠습니다.

  1. 생성 연산자

     1. from() : 배열을 인자로 받아 해당 원소를 하나씩 이벤트로 내보내는 Observable을 만든다. 

     2. of() : 1개 이상의 인자를 받아 해당 인자를 하나씩 이벤트로 내보내는 Observable을 만든다. 

        ![from](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/from.png) 

     3. create : 이벤트를 일일이 지정해서 만들어준다.  

        ![create](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/create.png)

     4. deferred: 팩토리 클로저를 인자로 받아, 구독시마다 외부 조건에 따라 다른 Observable을 반환하도록 한다. 즉, 실제 받아볼 Observable은 구독 시점에서야 비로소 결정된다.

        ![deferred](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/deferred.png)

  2. 여과 연산자

     1. filter() : 조건식 클로저를 인자로 넘겨, 해당 조건식을 만족하는 이벤트만 넘긴다.

        ![filter](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/filter.png)

     2. debounce() : 이벤트가 발생하고 일정 시간 내에 다른 이벤트가 발생하지 않아야만 해당 이벤트를 넘긴다.

        ![debounce](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/debounce.png)

     3. throttle() : 특정 시간동안 발생한 이벤트 중 가장 최근 이벤트만 넘긴다.

        ![throttle](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/throttle.png)

     4. take() : 첫 n개의 이벤트만 넘긴다. 

        ![take](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/take.png)

     5. skip() : 첫 n개의 이벤트를 무시한다.

        ![skip](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/skip.png)

  3. 변환 연산자

     1. Map() : T->U 형태의 변환 클로저를 받아 Observable이 방출하는 값의 타입을 바꿔준다. (Observable<T> -> Observable<U>)

        ![Map](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/Map.png)

     2.  flatmap : map과 비슷하지만, 변환 클로져의 형태가 T->Observable<U>라는 점에서 차이가 있다.  이 중간 Observable은 하나의 Observable로 합쳐지게 된다.(Observable<T> -> Observable<U>, 혹은 Observable<Observable<T>> -> Observable<U>)

        1. flatmapLatest() : Observable 이 합쳐지는 단계에서, 이전 Observable 발행이 끝나지 않았는데 새로운 Observable이 들어오면 현재 Observable을 멈추고 새로 들어온 Observable을 발행한다.
        2. flatmapFirst() : Observable이 합쳐질 때, 이전 Observable 발행이 끝나지 않았는데 새로운 Observable 이 들어오면 새로 들어온 Observable은 무시된다. 이전 Observable이 종료해야만 새로운 Observable을 받아들일 수 있다.

        ![flatMap](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/flatMap.png)

     3. GroupBy() : 키 셀렉터 클로저를 인자로 받아, [키:Observable] 형태로 반환한다. 같은 키를 반환하는 원소는 같은 Observable로 보내진다. 종료 이벤트는 동시에 받게 된다.

         ![GroupBy](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/GroupBy.png)

     4. Buffer() : 지정한 시간 동안 나온 값들을 배열에 담아 내보낸다. (Observable<T> -> Observable<[T]>)![Buffer](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/Buffer.png)

        

     5. Window() : Buffer와 비슷하나, 배열대신 Observable 로 내보낸다.![window](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/window.png)

  4. 합성 연산자

     1. merge() : Observable을 내부 순서를 유지한 채로 합친다.

        ![merge](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/merge.png)

     2. CombineLatest() : Observable 이 방출한 가장 최근 값을 resultSelector 클로져를 이용하 하나의 값으로 만들어 낸다.

        ![CombineLatest](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/CombineLatest.png)

     3. startWith(): Observable 앞에 초기값을 추가한다.

        ![startWith](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/startWith.png)

     4.  zip() : Observable이 방출하는 값들을 튜플로 묶어서 내보낸다. 튜플로 묶을 수 없는 값들은 버려진다.

        ![zip](/Users/ChoSooHwan/Library/CloudStorage/iCloudDrive/Desktop/zip.png)

     5. SwitchLatest() : Observable을 내보내는 Observable에서 적용가능한 연산자로, 새로운 Observable 이 방출될 때 마다, 기존 Observable을 구독 해제하고 새로운 Observable을 구독하는 Observable 을 만든다.

        >  flatmapLatest = map + switchLatest이다.