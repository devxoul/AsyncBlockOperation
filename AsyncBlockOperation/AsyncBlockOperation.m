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

#import "AsyncBlockOperation.h"

#pragma mark - AsyncBlockOperation

@implementation AsyncBlockOperation

- (nonnull instancetype)initWithBlock:(nonnull AsyncBlock)block {
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}

+ (nonnull instancetype)blockOperationWithBlock:(nonnull AsyncBlock)block {
    AsyncBlockOperation *operation = [[AsyncBlockOperation alloc] initWithBlock:block];
    return operation;
}

- (void)start {
    [self willChangeValueForKey:@"isExecuting"];
    self.isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];

    if (self.block) {
        self.block(self);
    } else {
        [self complete];
    }
}

- (void)complete {
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    self.isExecuting = NO;
    self.isFinished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end


#pragma mark - NSOperationQueue+AsyncBlockOperation

@implementation NSOperationQueue (AsyncBlockOperation)

- (void)addOperationWithAsyncBlock:(nonnull AsyncBlock)block {
    AsyncBlockOperation *operation = [AsyncBlockOperation blockOperationWithBlock:block];
    [self addOperation:operation];
}

@end
