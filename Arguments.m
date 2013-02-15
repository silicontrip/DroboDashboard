#import "Arguments.h"

@implementation Arguments

- (id)init
{
	[super init];

	opt = [[NSMutableDictionary alloc] init];
	arg = [[NSMutableArray alloc] init];
}

/* long arguments must begin with a --
** short arguments can be combined.
** NOTE any non argument following an argument is assumed an option of that argument. 
** this could lead to potential issues with the remaining argument array.
** either the proceeding argument must have an option, or the non argument must come before the option
*/

- (id)initWithNSProcessInfoArguments:(NSArray *)a
{
	[self init];
	NSMutableArray *args = [NSMutableArray arrayWithCapacity:[a count]];
	NSString *oldArg = nil;
	bool endOfArguments = false;

	for (NSString *argument in a) 
	{
		if (oldArg) {
			if ([oldArg compare:@"--"]) 
				endOfArguments = true;
				
			if (endOfArguments) {
				//add to arguments array
				[arg addObject:oldArg];
			} else if ([oldArg hasPrefix:@"--"]) {
				if ([argument hasPrefix:@"-"]) {
					// add old arg to dict as true bool	
					[opt setObject:[NSNumber numberWithBool:YES] forKey:oldArg];
				} else {
					// add old arg to dict as string
					[opt setObject:argument forKey:oldArg];
					// need to skip parsing this option
					argument = nil;
				}
			} else if ([oldArg hasPrefix:@"-"]) {
				if ([argument hasPrefix:@"-"]) {
					// add each letter of old arg to dict as true bool	
					for (NSString *letter in [oldArg componentsSeparatedByString:@""]) {
						[opt setObject:[NSNumber numberWithBool:YES] forKey:letter];
					}
				} else {
					// add each letter excluding last letter of old arg to dict as true bool	
                                        for (NSString *letter in [[oldArg substringToIndex:[oldArg length]-1] componentsSeparatedByString:@""])
					{
                                                [opt setObject:[NSNumber numberWithBool:YES] forKey:letter];
                                        }

					// add last letter of old arg to dict as string
					[opt setObject:argument forKey:[oldArg substringFromIndex:[oldArg length]-1]];
				}
			}  else {
				// add to argument array
				[arg addObject:oldArg];
			}
		}

		oldArg = argument;
	}


}
- (NSArray *)getArguments { return arg; }
- (NSDictionary *)getOptions { return opt; }

@end
