//
//  ViewController.swift
//  ReactiveARKit
//
//  Created by jalilk on 10/09/2018.
//  Copyright (c) 2018 jalilk. All rights reserved.
//

import UIKit
import ARKit
import RxSwift
import ReactiveARKit

class ViewController: UIViewController {
    @IBOutlet weak var sceneView: ReactiveARSKView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let scene = SKScene(fileNamed: "Scene") else { fatalError("Failed to load initial SKScene") }
        
        sceneView.presentScene(scene)
        
        #if debug
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        #endif
        
        sceneView.sessionStarted.subscribe {
            print("sessionStarted: \($0)")
        }.disposed(by: disposeBag)
        
        sceneView.didAddAnchors.subscribe {
            print("didAddAnchors: \($0)")
        }.disposed(by: disposeBag)
        
        sceneView.didUpdateAnchors.subscribe { [weak self] in
            print("didUpdateAnchors: \($0)")
            guard
                let self = self,
                let tuple = $0.element,
                let anchor = tuple.1.first
                else {
                print("Could not cast tuple to non optional tuple in didUpdateAnchors")
                return
            }

            self.sceneView.session.remove(anchor: anchor)
        }.disposed(by: disposeBag)
        
        sceneView.didRemoveAnchors.subscribe {
            print("didRemoveAnchors: \($0)")
        }.disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

