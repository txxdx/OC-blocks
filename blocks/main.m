//
//  main.m
//  blocks
//
//  Created by huangxiaobin on 18/01/2018.
//  Copyright © 2018 huangxiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

// block declare as a property
@property (nonatomic, copy) NSString *(^getFullName)(NSString *, NSString *);

// block declare as a method parameter
- (void)greetToFirstName:(NSString *)firstName
				lastName:(NSString *)lastName
				formater:(NSString*(^)(void))greetFunc;

@end

@implementation Person

- (void)greetToFirstName:(NSString *)firstName lastName:(NSString *)lastName formater:(NSString *(^)(void))greetFunc {
	NSString *greet = greetFunc();
	NSLog(@"%@", greet);
}

@end

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		
		NSString *firstName = @"Henry";
		NSString *lastName = @"Huang";
		
		/*
		 Block As a local variable
		 returnType (^blockName)(parameterTypes) = ^[returnType](parameters) {...};
		*/
		NSString * (^getFullName)(NSString *, NSString *) = ^(NSString *firstName, NSString *lastName) {
			return [NSString stringWithFormat:@"%@ %@", firstName, lastName];
		};
		NSLog(@"[Block As Local Variable]My fullName is: %@", getFullName(firstName, lastName));
		
		// Block As a property
		Person *person = [[Person alloc] init];
		person.getFullName = ^NSString *(NSString *firstName, NSString *lastName){
			return [NSString stringWithFormat:@"%@ %@", firstName, lastName];
		};
		NSLog(@"[Block As Property]My fullName is: %@", person.getFullName(firstName, lastName));
		
		// Block As a argument to a method call
		[person greetToFirstName:firstName lastName:lastName formater:^NSString *(void) {
			return [NSString stringWithFormat:@"[Block as parameter]Hello %@ %@. Welcome to the iOS world!", firstName, lastName];
		}];
		// Another Block As a argument to a method call
		NSString *(^anotherFormater)(void) = ^NSString *(){
			return [NSString stringWithFormat:@"[Another block as paramerter]%@ %@. Welcome to the Swift world!", @"Mr", @"Huang"];
		};
		[person greetToFirstName:nil lastName:nil formater:anotherFormater];
		
		// Block As a typedef
		typedef NSString *(^GetFullNameBlock)(NSString *, NSString *);
		GetFullNameBlock getFullNameBlock = ^(NSString *firstName, NSString *lastName) {
			return [NSString stringWithFormat:@"%@ %@", firstName, lastName];
		};
		NSLog(@"[Block as typedef]My fullName is: %@", getFullNameBlock(firstName, lastName));
		
		
	}
	return 0;
}
