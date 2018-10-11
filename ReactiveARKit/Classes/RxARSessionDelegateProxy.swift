//
//  RxARSessionDelegateProxy.swift
//  Pods-ReactiveARKit_Example
//
//  Created by jalil.kennedy on 10/11/18.
//

import Foundation
import RxSwift
import RxCocoa
import ARKit

class RxARSessionDelegateProxy: DelegateProxy<ARSession, ARSessionDelegate>, ARSessionDelegate, DelegateProxyType {
    static func registerKnownImplementations() {
        RxARSessionDelegateProxy.register { RxARSessionDelegateProxy(parentObject: $0) }
    }
    
    init(parentObject: ARSession) {
        super.init(parentObject: parentObject, delegateProxy: RxARSessionDelegateProxy.self)
    }

    var didStartPublishSubject: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    var didAddObjectAnchor: PublishSubject<ARObjectAnchor> = PublishSubject<ARObjectAnchor>()
    var didUpdateObjectAnchor: PublishSubject<ARObjectAnchor> = PublishSubject<ARObjectAnchor>()
    var didRemoveObjectAnchor: PublishSubject<ARObjectAnchor> = PublishSubject<ARObjectAnchor>()
    
    // MARK: Delegate subjects
    var didUpdateFrame: PublishSubject<(ARSession, ARFrame)> = PublishSubject<(ARSession, ARFrame)>()
    var didAddAnchors: PublishSubject<(ARSession, [ARAnchor])> = PublishSubject<(ARSession, [ARAnchor])>()
    var didUpdateAnchors: PublishSubject<(ARSession, [ARAnchor])> = PublishSubject<(ARSession, [ARAnchor])>()
    var didRemoveAnchors: PublishSubject<(ARSession, [ARAnchor])> = PublishSubject<(ARSession, [ARAnchor])>()
    
    
    // MARK: ARSessionDelegate
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        guard let delegateForward = forwardToDelegate() else { fatalError("Failed to forward \(#function) to RxARSessionDelegateProxy") }
        
        // One time did start publish subject
        didStartPublishSubject.onNext(true)
        didStartPublishSubject.onCompleted()
        
        didUpdateFrame.onNext((session, frame))
        delegateForward.session?(session, didUpdate: frame)
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard let delegateForward = forwardToDelegate() else { fatalError("Failed to forward \(#function) to RxARSessionDelegateProxy") }
        
        anchors.filter { $0 is ARObjectAnchor }.map { ARObjectAnchor(anchor: $0) }.forEach { didAddObjectAnchor.onNext($0) }
        
        didAddAnchors.onNext((session, anchors))
        
        delegateForward.session?(session, didAdd: anchors)
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let delegateForward = forwardToDelegate() else { fatalError("Failed to forward \(#function) to RxARSessionDelegateProxy") }
        
        anchors.filter { $0 is ARObjectAnchor }.map { ARObjectAnchor(anchor: $0) }.forEach { didUpdateObjectAnchor.onNext($0) }
        
        didUpdateAnchors.onNext((session, anchors))
        
        delegateForward.session?(session, didUpdate: anchors)
    }
    
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        guard let delegateForward = forwardToDelegate() else { fatalError("Failed to forward \(#function) to RxARSessionDelegateProxy") }
        
        anchors.filter { $0 is ARObjectAnchor }.map { ARObjectAnchor(anchor: $0) }.forEach { didRemoveObjectAnchor.onNext($0) }
        
        didRemoveAnchors.onNext((session, anchors))
        
        delegateForward.session?(session, didRemove: anchors)
    }
}

extension ARSession: HasDelegate {
}
