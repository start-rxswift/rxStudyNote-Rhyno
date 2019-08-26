//
//  ViewController.swift
//  RxImageExample
//
//  Created by 조수환 on 2019/08/26.
//  Copyright © 2019 조수환. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let LARGE_IMAGE_URL = "https://picsum.photos/1024/768/?random"
    
    var bag = DisposeBag()

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func load(_ sender: UIButton) {
        loadImage()
    }
    
    func loadImage() {
        let url = URL(string: LARGE_IMAGE_URL)!
        
        Observable<UIImage?>.create { observable in
            
                let random = drand48()
                if random > 0.5 {
                        DispatchQueue.global().async {
                            do {
                                let data = try Data(contentsOf: url)
                                let image: UIImage? = UIImage(data: data)
                                
                                observable.onNext(image)
                                observable.onCompleted()
                            } catch {
                                observable.onError(error)
                            }
                        }

                    }
                else {
                    let error = NSError(domain: "randomFailError", code: 500)
                    observable.onError(error)
                }
                return Disposables.create()
            }.retry(3)
            .subscribe {event in
                switch event {
                case let .next(image):
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                case let .error(e):
                    print(e.localizedDescription)
                    self.imageView.image = nil
                case .completed:
                    break
                }
            }.disposed(by: bag)

    }
}

