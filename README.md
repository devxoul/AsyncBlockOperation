AsyncBlockOperation
===================

[![CocoaPods](http://img.shields.io/cocoapods/v/AsyncBlockOperation.svg?style=flat)](https://cocoapods.org/pods/AsyncBlockOperation)

NSOperation subclass for support async block.


At a Glance
-----------

**Swift**

```swift
import AsyncBlockOperation

let queue = NSOperationQueue()

/// Method 1. Using `AsyncBlockOperation` object
let operation = AsyncBlockOperation { op in
    op.complete() // call this method when async task finished
}
queue.addOperation(operation)

/// Method 2. Using `NSOperationQueue` method
queue.addOperationWithAsyncBlock { op in
    op.complete()
}
```

**Objective-C**

```objc
#import <AsyncBlockOperation/AsyncBlockOperation.h>

NSOperationQueue *queue = [[NSOperationQueue alloc] init];

// Method 1. Using `AsyncBlockOperation` object
AsyncBlockOperation *operation = [AsyncBlockOperation blockOperationWithBlock:^(AsyncBlockOperation *op) {
    [op complete]; // call this method when async task finished
}];
[queue addOperation:operation];

// Method 2. Using `NSOperationQueue` method
[queue addOperationWithAsyncBlock:^(AsyncBlockOperation *op) {
    [op complete];
}];
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
