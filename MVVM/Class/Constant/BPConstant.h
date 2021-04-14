//
//  BPConstant.h
//  BasicProject
//
//  Created by 404 on 2020/10/21.
//  Copyright © 2020 404. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^VoidBlock)(void);
typedef BOOL (^BoolBlock)(void);
typedef int  (^IntBlock) (void);
typedef id   (^IDBlock)  (void);

typedef void (^VoidBlock_int)(int);
typedef BOOL (^BoolBlock_int)(int);
typedef int  (^IntBlock_int) (int);
typedef id   (^IDBlock_int)  (int);

typedef void (^VoidBlock_string)(NSString *);
typedef BOOL (^BoolBlock_string)(NSString *);
typedef int  (^IntBlock_string) (NSString *);
typedef id   (^IDBlock_string)  (NSString *);

typedef void (^VoidBlock_id)(id);
typedef BOOL (^BoolBlock_id)(id);
typedef int  (^IntBlock_id) (id);
typedef id   (^IDBlock_id)  (id);
