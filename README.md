AsyncBlockOperation
===================

[![Build Status](https://travis-ci.org/devxoul/AsyncBlockOperation.svg)](https://travis-ci.org/devxoul/AsyncBlockOperation)
[![CocoaPods](http://img.shields.io/cocoapods/v/AsyncBlockOperation.svg?style=flat)](https://cocoapods.org/pods/AsyncBlockOperation)

NSOperation subclass for async block.

* [x] Both compatible with Swift and Objective-C.
* [x] Light-weight. (4KB source code. Oh my god.)
* [x] Short-hand method extension `NSOperationQueue`.


At a Glance
-----------

**Swift**

```swift
import AsyncBlockOperation

let operation = AsyncBlockOperation { op in
    doSomeAsyncTaskWithCompletionBlock {
        op.complete() // complete operation
    }
}
queue.addOperation(operation)
```

**Objective-C**

```objc
#import <AsyncBlockOperation/AsyncBlockOperation.h>

AsyncBlockOperation *operation = [AsyncBlockOperation blockOperationWithBlock:^(AsyncBlockOperation *op) {
    [self doSomeAsyncTaskWithCompletionBlock:^{
        [op complete]; // complete operation
    }];
}];
[queue addOperation:operation];
```


Short-hand Method Extension
---------------------------

As `NSBlockOperation` does, `AsyncBlockOperation` supports `NSOperationQueue` extension to add async block operations quickly.

**Swift**

```swift
queue.addOperationWithAsyncBlock { op in
    op.complete()
}
```

**Objective-C**

```objc
[queue addOperationWithAsyncBlock:^(AsyncBlockOperation *op) {
    [op complete];
}];
```


Further Reading
---------------

Wanna get callback after all operations are done? Consider using [NSOperationQueue+CompletionBlock](https://github.com/devxoul/NSOperationQueue-CompletionBlock) which provides `completionHandler` for `NSOperationQueue`.

For example:

```swift
let queue = NSOperationQueue()
queue.completionHandler = {
    println("All images are loaded!")
}
queue.addOperationWithAsyncBlock { op in
    loadImage(imageURL1) { image in
        image.append(image)
        op.complete()
    }
}
queue.addOperationWithAsyncBlock { op in
    loadImage(imageURL2) { image in
        image.append(image)
        op.complete()
    }
}
```


Installation
------------

I recommend you to use [CocoaPods](https://cocoapods.org), a dependency manager for Cocoa.

**Podfile**

```ruby
pod 'AsyncBlockOperation', '~> 1.0'
```


License
-------

**AsyncBlockOperation** is under MIT license. See the LICENSE file for more info.
