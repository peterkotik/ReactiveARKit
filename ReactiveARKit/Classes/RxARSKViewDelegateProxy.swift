//
//  RxARSKViewDelegateProxy.swift
//  Pods
//
//  Created by jalil.kennedy on 10/12/18.
//

import Foundation
import RxSwift
import RxCocoa
import ARKit

class RxARSKViewDelegateProxy: DelegateProxy<ARSKView, ARSKViewDelegate>, ARSKViewDelegate, DelegateProxyType {
    static func registerKnownImplementations() {
        RxARSKViewDelegateProxy.register { RxARSKViewDelegateProxy(parentObject: $0) }
    }
    
    init(parentObject: ARSKView) {
        super.init(parentObject: parentObject, delegateProxy: RxARSKViewDelegateProxy.self)
    }
    
    // MARK: Delegate PublishSubjects
    var nodeForAnchor: PublishSubject<(ARSKView, ARAnchor)> = PublishSubject<(ARSKView, ARAnchor)>()
    var didAddNodeForAnchor: PublishSubject<(ARSKView, SKNode, ARAnchor)> = PublishSubject<(ARSKView, SKNode, ARAnchor)>()
    var willUpdateNodeForAnchor: PublishSubject<(ARSKView, SKNode, ARAnchor)> = PublishSubject<(ARSKView, SKNode, ARAnchor)>()
    var didUpdateNodeForAnchor: PublishSubject<(ARSKView, SKNode, ARAnchor)> = PublishSubject<(ARSKView, SKNode, ARAnchor)>()
    var didRemoveNodeForAnchor: PublishSubject<(ARSKView, SKNode, ARAnchor)> = PublishSubject<(ARSKView, SKNode, ARAnchor)>()
    
    // MARK: Custom PublishSubjects
    var willAddNodeForARObjectAnchor: PublishSubject<(ARSKView, ARObjectAnchor)> = PublishSubject<(ARSKView, ARObjectAnchor)>()
    var willAddNodeForARPlaneAnchor: PublishSubject<(ARSKView, ARPlaneAnchor)> = PublishSubject<(ARSKView, ARPlaneAnchor)>()
    var willAddNodeForARImageAnchor: PublishSubject<(ARSKView, ARImageAnchor)> = PublishSubject<(ARSKView, ARImageAnchor)>()
    var willAddNodeForARFaceAnchor: PublishSubject<(ARSKView, ARFaceAnchor)> = PublishSubject<(ARSKView, ARFaceAnchor)>()
    var didAddNodeForARObjectAnchor: PublishSubject<(ARSKView, SKNode, ARObjectAnchor)> = PublishSubject<(ARSKView, SKNode, ARObjectAnchor)>()
    var didAddNodeForARPlaneAnchor: PublishSubject<(ARSKView, SKNode, ARPlaneAnchor)> = PublishSubject<(ARSKView, SKNode, ARPlaneAnchor)>()
    var didAddNodeForARImageAnchor: PublishSubject<(ARSKView, SKNode, ARImageAnchor)> = PublishSubject<(ARSKView, SKNode, ARImageAnchor)>()
    var didAddNodeForARFaceAnchor: PublishSubject<(ARSKView, SKNode, ARFaceAnchor)> = PublishSubject<(ARSKView, SKNode, ARFaceAnchor)>()
    var willUpdateNodeForARObjectAnchor: PublishSubject<(ARSKView, SKNode, ARObjectAnchor)> = PublishSubject<(ARSKView, SKNode, ARObjectAnchor)>()
    var willUpdateNodeForARPlaneAnchor: PublishSubject<(ARSKView, SKNode, ARPlaneAnchor)> = PublishSubject<(ARSKView, SKNode, ARPlaneAnchor)>()
    var willUpdateNodeForARImageAnchor: PublishSubject<(ARSKView, SKNode, ARImageAnchor)> = PublishSubject<(ARSKView, SKNode, ARImageAnchor)>()
    var willUpdateNodeForARFaceAnchor: PublishSubject<(ARSKView, SKNode, ARFaceAnchor)> = PublishSubject<(ARSKView, SKNode, ARFaceAnchor)>()
    var didUpdateNodeForARObjectAnchor: PublishSubject<(ARSKView, SKNode, ARObjectAnchor)> = PublishSubject<(ARSKView, SKNode, ARObjectAnchor)>()
    var didUpdateNodeForARPlaneAnchor: PublishSubject<(ARSKView, SKNode, ARPlaneAnchor)> = PublishSubject<(ARSKView, SKNode, ARPlaneAnchor)>()
    var didUpdateNodeForARImageAnchor: PublishSubject<(ARSKView, SKNode, ARImageAnchor)> = PublishSubject<(ARSKView, SKNode, ARImageAnchor)>()
    var didUpdateNodeForARFaceAnchor: PublishSubject<(ARSKView, SKNode, ARFaceAnchor)> = PublishSubject<(ARSKView, SKNode, ARFaceAnchor)>()
    var didRemoveNodeForARObjectAnchor: PublishSubject<(ARSKView, SKNode, ARObjectAnchor)> = PublishSubject<(ARSKView, SKNode, ARObjectAnchor)>()
    var didRemoveNodeForARPlaneAnchor: PublishSubject<(ARSKView, SKNode, ARPlaneAnchor)> = PublishSubject<(ARSKView, SKNode, ARPlaneAnchor)>()
    var didRemoveNodeForARImageAnchor: PublishSubject<(ARSKView, SKNode, ARImageAnchor)> = PublishSubject<(ARSKView, SKNode, ARImageAnchor)>()
    var didRemoveNodeForARFaceAnchor: PublishSubject<(ARSKView, SKNode, ARFaceAnchor)> = PublishSubject<(ARSKView, SKNode, ARFaceAnchor)>()
    
    // MARK: ARSKViewDelegate
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        guard forwardToDelegate() != nil else { fatalError("Failed to forward \(#function) to RxARSKViewDelegateProxy") }
        
        switch anchor {
        case is ARObjectAnchor:
            willAddNodeForARObjectAnchor.onNext((view, ARObjectAnchor(anchor: anchor)))
        case is ARPlaneAnchor:
            willAddNodeForARPlaneAnchor.onNext((view, ARPlaneAnchor(anchor: anchor)))
        case is ARImageAnchor:
            willAddNodeForARImageAnchor.onNext((view, ARImageAnchor(anchor: anchor)))
        case is ARFaceAnchor:
            willAddNodeForARFaceAnchor.onNext((view, ARFaceAnchor(anchor: anchor)))
        default:
            print("Unidentified Anchor detected")
        }

        nodeForAnchor.onNext((view, anchor))
        
        return SKNode()
    }
    
    func view(_ view: ARSKView, didAdd node: SKNode, for anchor: ARAnchor) {
        guard let delegateForward = forwardToDelegate() else { fatalError("Failed to forward \(#function) to RxARSKViewDelegateProxy") }
        
        switch anchor {
        case is ARObjectAnchor:
            didAddNodeForARObjectAnchor.onNext((view, node, ARObjectAnchor(anchor: anchor)))
        case is ARPlaneAnchor:
            didAddNodeForARPlaneAnchor.onNext((view, node, ARPlaneAnchor(anchor: anchor)))
        case is ARImageAnchor:
            didAddNodeForARImageAnchor.onNext((view, node, ARImageAnchor(anchor: anchor)))
        case is ARFaceAnchor:
            didAddNodeForARFaceAnchor.onNext((view, node, ARFaceAnchor(anchor: anchor)))
        default:
            print("Unidentified Anchor detected")
        }
        
        didAddNodeForAnchor.onNext((view, node, anchor))
        
        delegateForward.view?(view, didAdd: node, for: anchor)
    }
    
    func view(_ view: ARSKView, willUpdate node: SKNode, for anchor: ARAnchor) {
        guard let delegateForward = forwardToDelegate() else { fatalError("Failed to forward \(#function) to RxARSKViewDelegateProxy") }
        
        switch anchor {
        case is ARObjectAnchor:
            willUpdateNodeForARObjectAnchor.onNext((view, node, ARObjectAnchor(anchor: anchor)))
        case is ARPlaneAnchor:
            willUpdateNodeForARPlaneAnchor.onNext((view, node, ARPlaneAnchor(anchor: anchor)))
        case is ARImageAnchor:
            willUpdateNodeForARImageAnchor.onNext((view, node, ARImageAnchor(anchor: anchor)))
        case is ARFaceAnchor:
            willUpdateNodeForARFaceAnchor.onNext((view, node, ARFaceAnchor(anchor: anchor)))
        default:
            print("Unidentified Anchor detected")
        }
        
        willUpdateNodeForAnchor.onNext((view, node, anchor))
        
        delegateForward.view?(view, willUpdate: node, for: anchor)
    }
    
    func view(_ view: ARSKView, didUpdate node: SKNode, for anchor: ARAnchor) {
        guard let delegateForward = forwardToDelegate() else { fatalError("Failed to forward \(#function) to RxARSKViewDelegateProxy") }
        
        switch anchor {
        case is ARObjectAnchor:
            didUpdateNodeForARObjectAnchor.onNext((view, node, ARObjectAnchor(anchor: anchor)))
        case is ARPlaneAnchor:
            didUpdateNodeForARPlaneAnchor.onNext((view, node, ARPlaneAnchor(anchor: anchor)))
        case is ARImageAnchor:
            didUpdateNodeForARImageAnchor.onNext((view, node, ARImageAnchor(anchor: anchor)))
        case is ARFaceAnchor:
            didUpdateNodeForARFaceAnchor.onNext((view, node, ARFaceAnchor(anchor: anchor)))
        default:
            print("Unidentified Anchor detected")
        }
        
        didUpdateNodeForAnchor.onNext((view, node, anchor))
        
        delegateForward.view?(view, didUpdate: node, for: anchor)
    }
    
    func view(_ view: ARSKView, didRemove node: SKNode, for anchor: ARAnchor) {
        guard let delegateForward = forwardToDelegate() else { fatalError("Failed to forward \(#function) to RxARSKViewDelegateProxy") }
        
        switch anchor {
        case is ARObjectAnchor:
            didRemoveNodeForARObjectAnchor.onNext((view, node, ARObjectAnchor(anchor: anchor)))
        case is ARPlaneAnchor:
            didRemoveNodeForARPlaneAnchor.onNext((view, node, ARPlaneAnchor(anchor: anchor)))
        case is ARImageAnchor:
            didRemoveNodeForARImageAnchor.onNext((view, node, ARImageAnchor(anchor: anchor)))
        case is ARFaceAnchor:
            didRemoveNodeForARFaceAnchor.onNext((view, node, ARFaceAnchor(anchor: anchor)))
        default:
            print("Unidentified Anchor detected")
        }
        
        didRemoveNodeForAnchor.onNext((view, node, anchor))
        
        delegateForward.view?(view, didRemove: node, for: anchor)
    }
}

extension ARSKView: HasDelegate {
}
