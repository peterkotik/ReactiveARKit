# ReactiveARKit

ReactiveARKit is an RxSwift framework that provides a custom ARSKView that emits it's events as Observable sequences. ReactiveARKit removes the need to implement ARSKViewDelegate and ARSessionDelegate methods as those delegate methods are emitted as events. You should not set the ARSKViewDelegate or ARSessionDelegate of a ReactiveARSKView. If you need to use your own delegate objects, you should use a regular ARSKView instead.

<!---[![CI Status](https://img.shields.io/travis/jalilk/ReactiveARKit.svg?style=flat)](https://travis-ci.org/jalilk/ReactiveARKit)
[![Version](https://img.shields.io/cocoapods/v/ReactiveARKit.svg?style=flat)](https://cocoapods.org/pods/ReactiveARKit)
[![License](https://img.shields.io/cocoapods/l/ReactiveARKit.svg?style=flat)](https://cocoapods.org/pods/ReactiveARKit)
[![Platform](https://img.shields.io/cocoapods/p/ReactiveARKit.svg?style=flat)](https://cocoapods.org/pods/ReactiveARKit)--->

## Requirements
* Xcode 10.0
* Swift 4.2

## Installation

ReactiveARKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ReactiveARKit'
```

## Usage
ReactiveARKit allows you to listen to ARSKView events as Observable sequences. So code like this:
```
@IBOutlet weak var sceneView: ARSKView!

override func viewDidLoad() {
    super.viewDidLoad()
    sceneView.delegate = delegateObject
    sceneView.session.delegate = sessionDelegateObject
    
    let configuration = ARWorldTrackingConfiguration()
    // ...configuration setup
    sceneView.session.run(configuration)
}

// MARK: ARSessionDelegate methods
func session(_ session: ARSession, didUpdate frame: ARFrame) {
  // Do something with latest frame
}
```
Becomes this
```
@IBOutlet weak var sceneView: ReactiveARSKView!

let disposeBag = DisposeBag()

override func viewDidLoad() {
    super.viewDidLoad()
    // Do not set the delegates for ReactiveARSKView
    
    let configuration = ARWorldTrackingConfiguration()
    // ...configuration setup
    sceneView.session.run(configuration)
    
    setupObservers()
}

// MARK: ReactiveARSKView Observables
func setupObservers() {
  sceneView.didUpdateFrame.subscribe {
      // Do something with latest frame
  }.disposed(by: disposeBag)
}
```

ReactiveARKit provides an Observable for every ARSessionDelegate and ARSKViewDelegate method as well as some convinience Observables.

## Observing the start of a session
```
sceneView.sessionStarted.subscribe {
    // Do something when ARSession starts
}.disposed(by: disposeBag)

```
`sessionStarted` is a one off Observable sequence that emits a true event when the first frame of the `ARSession` is sent to the delegate. So you can use this to react to the start of an `ARSession`

## Observing specific ARAnchor events

In addition to providing observable sequences for ARSessionDelegate and ARSKViewDelegate methods, ReactiveARKit also allows you to listen to `didAdd`, `willAdd`, `didUpdate` and `didRemove` events for specific `ARAnchor` sublcasses.

```
sceneView.didAddARObjectAnchor.subscribe {
    // Do something with added ARObjectAnchor
}.disposed(by: disposeBag)

sceneView.willAddARObjectAnchor.subscribe {
    // Do something with ARObjectAnchor that is about to be added to the ARSession
}.disposed(by: disposeBag)

sceneView.didUpdateARObjectAnchor.subscribe {
    // Do something with ARObjectAnchor that has just been updated by the ARSession
}.disposed(by: disposeBag)

sceneView.didRemoveARObjectAnchor.subscribe {
    // Do something when ARObjectAnchor is removed from the ARSession
}.disposed(by: disposeBag)
```

ReactiveARKit provides these types of Observable sequences for `ARImageAnchor`, `ARPlaneAnchor` and `ARFaceAnchor` as well.

```
sceneView.didAddARPlaneAnchor.subscribe {
    // Do something with ARPlaneAnchor
}.disposed(by: disposeBag)

// willAddARPlaneAnchor, didUpdateARPlaneAnchor, didRemoveARPlaneAnchor
```

```
sceneView.didAddARImageAnchor.subscribe {
    // Do something with ARImageAnchor
}.disposed(by: disposeBag)

// willAddARImageAnchor, didUpdateARImageAnchor, didRemoveARImageAnchor
```

```
sceneView.didAddARFaceAnchor.subscribe {
    // Do something with ARFaceAnchor
}.disposed(by: disposeBag)

// willAddARFaceAnchor, didUpdateARFaceAnchor, didRemoveARFaceAnchor
```

## Author

Jalil Kennedy

## License

ReactiveARKit is available under the MIT license. See the LICENSE file for more info.
