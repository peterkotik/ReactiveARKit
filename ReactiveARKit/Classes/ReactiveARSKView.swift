
import Foundation
import ARKit
import RxSwift
import RxCocoa

public class ReactiveARSKView: ARSKView, ARSKViewDelegate, ARSessionDelegate {
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.session.delegate = self
        self.delegate = self
        
        let _ = RxARSessionDelegateProxy.proxy(for: self.session)
        let _ = RxARSKViewDelegateProxy.proxy(for: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.session.delegate = self
        self.delegate = self
        
        let _ = RxARSessionDelegateProxy.proxy(for: self.session)
        let _ = RxARSKViewDelegateProxy.proxy(for: self)
    }
    
    // MARK: ARSessionDelegate
    
    /**
    Returns a single value Observable that sends a single event when the first frame of the current ARSession
    is sent to the delegate. If you wish to subscribe to additional frame update events, use didUpdateFrame
     */
    public var sessionStarted: Observable<Bool> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didStartPublishSubject.asObservable()
    }
    
    /**
     Observable sequence that sends an event when an ARObjectAnchor is added to the ARSession
     */
    public var didAddARObjectAnchor: Observable<ARObjectAnchor> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didAddObjectAnchor.asObservable()
    }
    
    /**
     Observable sequence that sends an event when an ARPlaneAnchor is added to the ARSession
     */
    public var didAddARPlaneAnchor: Observable<ARPlaneAnchor> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didAddPlaneAnchor.asObservable()
    }
    
    /**
     Observable sequence that sends an event when an ARImageAnchor is added to the ARSession
     */
    public var didAddARImageAnchor: Observable<ARImageAnchor> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didAddImageAnchor.asObservable()
    }
    
    /**
     Observable sequence that sends an event when an ARFaceAnchor is added to the ARSession
     */
    public var didAddFaceAnchor: Observable<ARFaceAnchor> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didAddFaceAnchor.asObservable()
    }
    
    /**
     Observable sequence that sends an event when an ARObjectAnchor is updated in the ARSession
     */
    public var didUpdateARObjectAnchor: Observable<ARObjectAnchor> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didUpdateObjectAnchor.asObservable()
    }
    
    /**
     Observable sequence that sends an event when an ARPlaneAnchor is updated in the ARSession
     */
    public var didUpdatePlaneAnchor: Observable<ARPlaneAnchor> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didUpdatePlaneAnchor.asObservable()
    }
    
    /**
     Observable sequence that sends an event when an ARImageAnchor is updated in the ARSession
     */
    public var didUpdateARImageAnchor: Observable<ARImageAnchor> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didUpdateImageAnchor.asObservable()
    }
    
    /**
     Observable sequence that sends an event when an ARFaceAnchor is updated in the ARSession
     */
    public var didUpdateFaceAnchor: Observable<ARFaceAnchor> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didUpdateFaceAnchor.asObservable()
    }
    
    /**
     Observable sequence that sends an event when an ARObjectAnchor is removed from the ARSession
     */
    public var didRemoveObjectAnchor: Observable<ARObjectAnchor> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didRemoveObjectAnchor.asObservable()
    }
    
    /**
     Observable sequence that sends an event when an ARPlaneAnchor is removed from the ARSession
     */
    public var didRemovePlaneAnchor: Observable<ARPlaneAnchor> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didRemovePlaneAnchor.asObservable()
    }
    
    /**
     Observable sequence that sends an event when an ARImageAnchor is removed from the ARSession
     */
    public var didRemoveARImageAnchor: Observable<ARImageAnchor> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didUpdateImageAnchor.asObservable()
    }
    
    /**
     Observable sequence that sends an event when an ARFaceAnchor is removed from the ARSession
     */
    public var didRemoveARFaceAnchor: Observable<ARFaceAnchor> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didRemoveFaceAnchor.asObservable()
    }
    
    // MARK: Computed properties for delegate observables
    
    /**
     Observable sequence for session(_:didUpdate:)
     */
    public var didUpdateFrame: Observable<(ARSession, ARFrame)> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didUpdateFrame.asObservable()
    }

    /**
     Observable sequence for session(_:didUpdate:)
     */
    public var didAddAnchors: Observable<(ARSession, [ARAnchor])> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didAddAnchors.asObservable()
    }
    
    /**
     Observable sequence for session(_:didUpdate:)
     */
    public var didUpdateAnchors: Observable<(ARSession, [ARAnchor])> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didUpdateAnchors.asObservable()
    }
    
    /**
     Observable sequence for session(_:didRemove:)
     */
    public var didRemoveAnchors: Observable<(ARSession, [ARAnchor])> {
        let proxy = RxARSessionDelegateProxy.proxy(for: self.session)
        return proxy.didRemoveAnchors.asObservable()
    }
    
    // MARK: ARSKViewDelegate
    
    /**
     Observable that emits an event when an SKNode for an ARObjectAnchor is about to be added
     to the ARSession
     */
    public var willAddNodeForARObjectAnchor: Observable<(ARSKView, ARObjectAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.willAddNodeForARObjectAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARPlaneAnchor is about to be added
     to the ARSession
     */
    public var willAddNodeForARPlaneAnchor: Observable<(ARSKView, ARPlaneAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.willAddNodeForARPlaneAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARImageAnchor is about to be added
     to the ARSession
     */
    public var willAddNodeForARImageAnchor: Observable<(ARSKView, ARImageAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.willAddNodeForARImageAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARFaceAnchor is about to be added
     to the ARSession
     */
    public var willAddNodeForARFaceAnchor: Observable<(ARSKView, ARFaceAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.willAddNodeForARFaceAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARObjectAnchor has been added to the ARSession
    */
    public var didAddNodeForARObjectAnchor: Observable<(ARSKView, SKNode, ARObjectAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.didAddNodeForARObjectAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARPlaneAnchor has been added to the ARSession
     */
    public var didAddNodeForARPlaneAnchor: Observable<(ARSKView, SKNode, ARPlaneAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.didAddNodeForARPlaneAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARImageAnchor has been added to the ARSession
     */
    public var didAddNodeForARImageAnchor: Observable<(ARSKView, SKNode, ARImageAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.didAddNodeForARImageAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARFaceAnchor has been added to the ARSession
     */
    public var didAddNodeForARFaceAnchor: Observable<(ARSKView, SKNode, ARFaceAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.didAddNodeForARFaceAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARObjectAnchor is about to be updated in the ARSession
     */
    public var willUpdateNodeForARObjectAnchor: Observable<(ARSKView, SKNode, ARObjectAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.willUpdateNodeForARObjectAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARPlaneAnchor is about to be updated in the ARSession
     */
    public var willUpdateNodeForARPlaneAnchor: Observable<(ARSKView, SKNode, ARPlaneAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.willUpdateNodeForARPlaneAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARImageAnchor is about to be updated in the ARSession
     */
    public var willUpdateNodeForARImageAnchor: Observable<(ARSKView, SKNode, ARImageAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.willUpdateNodeForARImageAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARFaceAnchor is about to be updated in the ARSession
     */
    public var willUpdateNodeForARFaceAnchor: Observable<(ARSKView, SKNode, ARFaceAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.willUpdateNodeForARFaceAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARObjectAnchor has been updated in the ARSession
     */
    public var didUpdateNodeForARObjectAnchor: Observable<(ARSKView, SKNode, ARObjectAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.didUpdateNodeForARObjectAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARPlaneAnchor has been updated in the ARSession
     */
    public var didUpdateNodeForARPlaneAnchor: Observable<(ARSKView, SKNode, ARPlaneAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.didUpdateNodeForARPlaneAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARImageAnchor has been updated in the ARSession
     */
    public var didUpdateNodeForARImageAnchor: Observable<(ARSKView, SKNode, ARImageAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.didUpdateNodeForARImageAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARFaceAnchor has been updated in the ARSession
     */
    public var didUpdateNodeForARFaceAnchor: Observable<(ARSKView, SKNode, ARFaceAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.didUpdateNodeForARFaceAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARObjectAnchor has been removed from the ARSession
     */
    public var didRemoveNodeForARObjectAnchor: Observable<(ARSKView, SKNode, ARObjectAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.didRemoveNodeForARObjectAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARPlaneAnchor has been removed from the ARSession
     */
    public var didRemoveNodeForARPlaneAnchor: Observable<(ARSKView, SKNode, ARPlaneAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.didRemoveNodeForARPlaneAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARImageAnchor has been removed from the ARSession
     */
    public var didRemoveNodeForARImageAnchor: Observable<(ARSKView, SKNode, ARImageAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.didRemoveNodeForARImageAnchor.asObservable()
    }
    
    /**
     Observable that emits an event when an SKNode for an ARFaceAnchor has been removed from the ARSession
     */
    public var didRemoveNodeForARFaceAnchor: Observable<(ARSKView, SKNode, ARFaceAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.didRemoveNodeForARFaceAnchor.asObservable()
    }
    
    // MARK: Computed properties for delegate
    /**
    Observable sequence for view(_:nodeFor:)
     */
    public var nodeForAnchor: Observable<(ARSKView, ARAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.nodeForAnchor.asObservable()
    }
    
    /**
     Observable sequence for view(_:didAdd:for:)
     */
    public var didAddNodeForAnchor: Observable<(ARSKView, SKNode, ARAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.didAddNodeForAnchor.asObservable()
    }
    
    /**
    Observable sequence for view(:willUpdate:for)
     */
    public var willUpdateNodeForAnchor: Observable<(ARSKView, SKNode, ARAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.willUpdateNodeForAnchor.asObservable()
    }
    
    /**
     Observable sequence for view(:didUpdate:for)
     */
    public var didUpdateNodeForAnchor: Observable<(ARSKView, SKNode, ARAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.didUpdateNodeForAnchor.asObservable()
    }
    
    /**
     Observable sequence for view(:didRemove:for)
     */
    public var didRemoveNodeForAnchor: Observable<(ARSKView, SKNode, ARAnchor)> {
        let proxy = RxARSKViewDelegateProxy.proxy(for: self)
        return proxy.didRemoveNodeForAnchor.asObservable()
    }
}
