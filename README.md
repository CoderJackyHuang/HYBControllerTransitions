

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/CoderJackyHuang/HYBControllerTransitions/blob/master/logo.png" style="text-align: center; margin: 0 auto;">

#Summary

A helpful and very useful library for controller custom transition.

This is an open source library for developers to use custom transition,   
including push, pop, present and dismiss. In the library, now has supported  
many kind of animations that we can see in many apps. The best thing for this  
library is, that developers only need to call an API, without others, to support  
custom transition. For more information, just see the document in detail  
or just download the demo project to have a look.

#Buble Effect Transition

A custom modal transition that presents and dismiss a controller with an expanding bubble effect.


![image](https://github.com/CoderJackyHuang/HYBControllerTransitions/blob/master/bubble.gif)


It's easy to use, just in the presenting controller callback event to add custom transition, like below:

```
- (void)onPresent {
  HYBBubbleFromBottomController *vc = [[HYBBubbleFromBottomController alloc] init];
  vc.modalPresentationStyle = UIModalPresentationCustom;
  
  // Remember to own it strongly
  // Because delegate is weak reference, and it will be released after out of the function body.
  self.bubbleTransition = [[HYBBubbleTransition alloc] initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
    // You need to cast type to the real subclass type.
    HYBBubbleTransition *bubble = (HYBBubbleTransition *)transition;
   
    // If you want to use Spring animation, set to YES.
    // Default is NO.
//    bubble.animatedWithSpring = YES;
    bubble.bubbleColor = presented.view.backgroundColor;
    
    // 由于一个控制器有导航，一个没有，导致会有64的误差，所以要记得处理这种情况
    CGPoint center = [self.view viewWithTag:1010].center;
    center.y += 64;
    
    bubble.bubbleStartPoint = center;
  } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {
    // Do nothing and it is ok here.
    // If you really want to do something, here you can set the mode.
    // But inside the super class, it is set to be automally.
    // So you do this has no meaning.
    transition.transitionMode = kHYBTransitionDismiss;
  }];
  vc.transitioningDelegate = self.bubbleTransition;
  
  [self presentViewController:vc animated:YES completion:NULL];
}
```

For example, AController has an event onPresent, when it is clicked, it will be invoked.   
Now, AController need to present BController, just use the code like above. In BController,  
you don't need to do anything. It is easy?

#Modal Effect Transition

![image](https://github.com/CoderJackyHuang/HYBControllerTransitions/blob/master/modal.gif)

#Move Push/Pop Transition

![image](https://github.com/CoderJackyHuang/HYBControllerTransitions/blob/master/move.gif)

#Note

Later will add document!

#MIT LICENSE

Copyright (c) 2016 CoderJackyHuang. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
