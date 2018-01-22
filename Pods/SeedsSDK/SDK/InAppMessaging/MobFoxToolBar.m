//
//  Copyright 2015 MobFox
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
#import "MobFoxToolBar.h"

@implementation MobFoxToolBar

@synthesize backgroundImage;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect 
{
    if (self.backgroundImage) {
        [backgroundImage drawInRect: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) ];
    } else {
        [super drawRect:rect];
    }

}

@end
