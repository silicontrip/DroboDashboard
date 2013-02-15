#import <Cocoa/Cocoa.h>

@interface Arguments: NSObject {

	NSMutableDictionary *opt;
	NSMutableArray *arg;

}

- (id)initWithNSProcessInfoArguments:(NSArray *)a;
- (NSArray *)getArguments;
- (NSDictionary *)getOptions;

@end
