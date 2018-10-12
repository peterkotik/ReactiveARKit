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

    // MARK: Session start BehaviorSubject
    var didStartPublishSubject: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)

    // MARK: ARObjectAnchor PublishSubjects
    var didAddObjectAnchor: PublishSubject<ARObjectAnchor> = PublishSubject<ARObjectAnchor>()
    var didUpdateObjectAnchor: PublishSubject<ARObjectAnchor> = PublishSubject<ARObjectAnchor>()
    var didRemoveObjectAnchor: PublishSubject<ARObjectAnchor> = PublishSubject<ARObjectAnchor>()
    
    // MARK: ARPlaneAnchor PublishSubjects
    var didAddPlaneAnchor: PublishSubject<ARPlaneAnchor> = PublishSubject<ARPlaneAnchor>()
    var didUpdatePlaneAnchor: PublishSubject<ARPlaneAnchor> = PublishSubject<ARPlaneAnchor>()
    var didRemovePlaneAnchor: PublishSubject<ARPlaneAnchor> = PublishSubject<ARPlaneAnchor>()
    
    // MARK: ARImageAnchor PublishSubjects
    var didAddImageAnchor: PublishSubject<ARImageAnchor> = PublishSubject<ARImageAnchor>()
    var didUpdateImageAnchor: PublishSubject<ARImageAnchor> = PublishSubject<ARImageAnchor>()
    var didRemoveImageAnchor: PublishSubject<ARImageAnchor> = PublishSubject<ARImageAnchor>()
    
    // MARK: ARFaceAnchor PublishSubjects
    var didAddFaceAnchor: PublishSubject<ARFaceAnchor> = PublishSubject<ARFaceAnchor>()
    var didUpdateFaceAnchor: PublishSubject<ARFaceAnchor> = PublishSubject<ARFaceAnchor>()
    var didRemoveFaceAnchor: PublishSubject<ARFaceAnchor> = PublishSubject<ARFaceAnchor>()
    
    // MARK: Delegate PublishSubjects
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
        anchors.filter { $0 is ARPlaneAnchor }.map { ARPlaneAnchor(anchor: $0) }.forEach { didAddPlaneAnchor.onNext($0) }
        anchors.filter { $0 is ARImageAnchor }.map { ARImageAnchor(anchor: $0) }.forEach { didAddImageAnchor.onNext($0) }
        anchors.filter { $0 is ARFaceAnchor }.map { ARFaceAnchor(anchor: $0) }.forEach { didAddFaceAnchor.onNext($0) }
        
        didAddAnchors.onNext((session, anchors))
        
        delegateForward.session?(session, didAdd: anchors)
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let delegateForward = forwardToDelegate() else { fatalError("Failed to forward \(#function) to RxARSessionDelegateProxy") }
        
        anchors.filter { $0 is ARObjectAnchor }.map { ARObjectAnchor(anchor: $0) }.forEach { didUpdateObjectAnchor.onNext($0) }
        anchors.filter { $0 is ARPlaneAnchor }.map { ARPlaneAnchor(anchor: $0) }.forEach { didUpdatePlaneAnchor.onNext($0) }
        anchors.filter { $0 is ARImageAnchor }.map { ARImageAnchor(anchor: $0) }.forEach { didUpdateImageAnchor.onNext($0) }
        anchors.filter { $0 is ARFaceAnchor }.map { ARFaceAnchor(anchor: $0) }.forEach { didUpdateFaceAnchor.onNext($0) }
        
        didUpdateAnchors.onNext((session, anchors))
        
        delegateForward.session?(session, didUpdate: anchors)
    }
    
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        guard let delegateForward = forwardToDelegate() else { fatalError("Failed to forward \(#function) to RxARSessionDelegateProxy") }
        
        anchors.filter { $0 is ARObjectAnchor }.map { ARObjectAnchor(anchor: $0) }.forEach { didRemoveObjectAnchor.onNext($0) }
        anchors.filter { $0 is ARPlaneAnchor }.map { ARPlaneAnchor(anchor: $0) }.forEach { didRemovePlaneAnchor.onNext($0) }
        anchors.filter { $0 is ARImageAnchor }.map { ARImageAnchor(anchor: $0) }.forEach { didRemoveImageAnchor.onNext($0) }
        anchors.filter { $0 is ARFaceAnchor }.map { ARFaceAnchor(anchor: $0) }.forEach { didRemoveFaceAnchor.onNext($0) }
        
        didRemoveAnchors.onNext((session, anchors))
        
        delegateForward.session?(session, didRemove: anchors)
    }
}

extension ARSession: HasDelegate {
}
