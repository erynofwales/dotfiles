" Define fold regions for interfaces, protocols, and implementations.
" 
" NOTE: keepend works here because Objective-C doesn't allow nesting @interface, @protocol, and @implementation blocks.
syn region objcInterface start="^@interface" end="^@end" keepend transparent fold
syn region objcProtocol start="^@protocol" end="^@end" keepend transparent fold
syn region objcImplementation start="^@implementation" end="^@end" keepend transparent fold

syn sync fromstart
