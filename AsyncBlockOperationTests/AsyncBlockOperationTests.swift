// The MIT License (MIT)
//
// Copyright (c) 2015 Suyeol Jeon (xoul.kr)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import AsyncBlockOperation
import XCTest

class AsyncBlockOperationTests: XCTestCase {

    func delay(delay: Double, _ closure: () -> Void) {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), closure)
    }

    func testAddOperationWithAsyncBlock() {
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 0
        queue.addOperation(AsyncBlockOperation { _ in })
        queue.addOperationWithAsyncBlock { _ in }
        queue.addOperationWithAsyncBlock { _ in }
        XCTAssertEqual(queue.operationCount, 3)
    }

    func testCallComplete() {
        let expectation = self.expectationWithDescription("Test")
        var flag = false

        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperationWithAsyncBlock { op in
            flag = true
            op.complete()
        }
        queue.addOperationWithAsyncBlock { op in
            XCTAssertTrue(flag)
            expectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(0.5, handler: nil)
    }

    func testNotCallComplete() {
        let expectation = self.expectationWithDescription("Test")
        var flag = false

        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperationWithAsyncBlock { op in
            // do not call op.complete()
        }
        queue.addOperationWithAsyncBlock { op in
            flag = true
        }
        self.delay(0.5) {
            XCTAssertFalse(flag)
            expectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(1, handler: nil)
    }
    
}
