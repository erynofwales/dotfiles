" Vim syntax file
" Language:	Objective-C
" Maintainer:	Eryn Wells <eryn@erynwells.me>
" Last Change:	2013 Jan 16

" AppKit types
syn keyword objc2Boolean            YES NO
syn keyword objc2FrameworkType      NSAppleEventManagerSubscriptionID NSComparator NSDecimal NSHashEnumerator NSHashTable NSHashTableCallbacks NSHashTableOptions NSInteger NSMapEnumerator NSMapTable NSMapTableKeyCallbacks NSMapTableOptions NSMapTableValueCallbacks NSPoint NSPointArray NSPointPointer NSRange NSRangePointer NSRect NSRectArray NSRectPointer NSSize NSSizeArray NSSizePointer NSSocketNativeHandle NSStringEncoding NSSwappedDouble NSSwappedFloat NSTimeInterval NSUncaughtExceptionHandler NSUInteger NSZone
syn keyword objc2FrameworkClass     NSActionCell NSAffineTransform NSAlert NSAnimation NSArrayController NSATSTypesetter NSAttributedString NSBezierPath NSBitmapImageRep NSBox NSBrowser NSBrowserCell NSBundle NSButton NSButtonCell NSCachedImageRep NSCell NSCIImageRep NSClipView NSCoder NSCollectionView NSCollectionViewItem NSColor NSColorList NSColorPanel NSColorPicker NSColorSpace NSColorWell NSComboBox NSComboBoxCell NSControl NSController NSCursor NSCustomImageRep NSDatePicker NSDatePickerCell NSDictionaryController NSDockTile NSDocument NSDocumentController NSDraggingImageComponent NSDraggingItem NSDraggingSession NSDrawer NSEPSImageRep NSEvent NSFileWrapper NSFont NSFontCollection NSFontDescriptor NSFontManager NSFontPanel NSForm NSFormCell NSGlyphGenerator NSGlyphInfo NSGradient NSGraphicsContext NSHelpManager NSImage NSImageCell NSImageRep NSImageView NSLayoutManager NSLevelIndicator NSLevelIndicatorCell NSMatrix NSMenu NSMenuItem NSMenuItemCell NSMenuView NSMutableAttributedString NSMutableFontCollection NSMutableParagraphStyle NSNib NSNibConnector NSNibControlConnector NSNibOutletConnector NSObjectController NSOpenGLContext NSOpenGLLayer NSOpenGLPixelBuffer NSOpenGLPixelFormat NSOpenGLView NSOpenPanel NSOutlineView NSPageController NSPageLayout NSPanel NSParagraphStyle NSPasteboard NSPasteboardItem NSPathCell NSPathComponentCell NSPathControl NSPDFImageRep NSPersistentDocument NSPICTImageRep NSPopover NSPopUpButton NSPopUpButtonCell NSPredicateEditor NSPredicateEditorRowTemplate NSPrinter NSPrintInfo NSPrintOperation NSPrintPanel NSProgressIndicator NSResponder NSRuleEditor NSRulerMarker NSRulerView NSRunningApplication NSSavePanel NSScreen NSScroller NSScrollView NSSearchField NSSearchFieldCell NSSecureTextField NSSecureTextFieldCell NSSegmentedCell NSSegmentedControl NSShadow NSSharingService NSSharingServicePicker NSSlider NSSliderCell NSSound NSSpeechRecognizer NSSpeechSynthesizer NSSpellChecker NSSplitView NSStatusBar NSStatusItem NSStepper NSStepperCell NSString NSTableCellView NSTableColumn NSTableHeaderCell NSTableHeaderView NSTableRowView NSTableView NSTabView NSTabViewItem NSText NSTextAttachment NSTextAttachmentCell NSTextBlock NSTextContainer NSTextField NSTextFieldCell NSTextFinder NSTextInputContext NSTextList NSTextStorage NSTextTab NSTextTable NSTextTableBlock NSTextView NSTokenField NSTokenFieldCell NSToolbar NSToolbarItem NSToolbarItemGroup NSTouch NSTrackingArea NSTreeController NSTreeNode NSTypesetter NSURL NSUserDefaultsController NSView NSViewAnimation NSViewController NSWindow NSWindowController NSWorkspace
syn keyword objc2FrameworkClass     NSAffineTransform NSAppleEventDescriptor NSAppleEventManager NSAppleScript NSArchiver NSArray NSAssertionHandler NSAttributedString NSAutoreleasePool NSBlockOperation NSBundle NSCache NSCachedURLResponse NSCalendar NSCharacterSet NSClassDescription NSCloneCommand NSCloseCommand NSCoder NSComparisonPredicate NSCompoundPredicate NSCondition NSConditionLock NSConnection NSCountCommand NSCountedSet NSCreateCommand NSData NSDataDetector NSDate NSDateComponents NSDateFormatter NSDecimalNumber NSDecimalNumberHandler NSDeleteCommand NSDictionary NSDirectoryEnumerator NSDistantObject NSDistantObjectRequest NSDistributedLock NSDistributedNotificationCenter NSEnumerator NSError NSException NSExistsCommand NSExpression NSFileCoordinator NSFileHandle NSFileManager NSFileVersion NSFileWrapper NSFormatter NSGarbageCollector NSGetCommand NSHashTable NSHost NSHTTPCookie NSHTTPCookieStorage NSHTTPURLResponse NSIndexPath NSIndexSet NSIndexSpecifier NSInputStream NSInvocation NSInvocationOperation NSKeyedArchiver NSKeyedUnarchiver NSLinguisticTagger NSLocale NSLock NSLogicalTest NSMachBootstrapServer NSMachPort NSMapTable NSMessagePort NSMessagePortNameServer NSMetadataItem NSMetadataQuery NSMetadataQueryAttributeValueTuple NSMetadataQueryResultGroup NSMethodSignature NSMiddleSpecifier NSMoveCommand NSMutableArray NSMutableAttributedString NSMutableCharacterSet NSMutableData NSMutableDictionary NSMutableIndexSet NSMutableOrderedSet NSMutableSet NSMutableString NSMutableURLRequest NSNameSpecifier NSNetService NSNetServiceBrowser NSNotification NSNotificationCenter NSNotificationQueue NSNull NSNumber NSNumberFormatter NSObject NSOperation NSOperationQueue NSOrderedSet NSOrthography NSOutputStream NSPipe NSPointerArray NSPointerFunctions NSPort NSPortCoder NSPortMessage NSPortNameServer NSPositionalSpecifier NSPredicate NSProcessInfo NSPropertyListSerialization NSPropertySpecifier NSProtocolChecker NSProxy NSQuitCommand NSRandomSpecifier NSRangeSpecifier NSRecursiveLock NSRegularExpression NSRelativeSpecifier NSRunLoop NSScanner NSScriptClassDescription NSScriptCoercionHandler NSScriptCommand NSScriptCommandDescription NSScriptExecutionContext NSScriptObjectSpecifier NSScriptSuiteRegistry NSScriptWhoseTest NSSet NSSetCommand NSSocketPort NSSocketPortNameServer NSSortDescriptor NSSpecifierTest NSSpellServer NSStream NSString NSTask NSTextCheckingResult NSThread NSTimer NSTimeZone NSUbiquitousKeyValueStore NSUnarchiver NSUndoManager NSUniqueIDSpecifier NSURL NSURLAuthenticationChallenge NSURLCache NSURLConnection NSURLCredential
syn keyword objc2FrameworkClass     NSURLCredentialStorage NSURLDownload NSURLHandle NSURLProtectionSpace NSURLProtocol NSURLRequest NSURLResponse NSUserAppleScriptTask NSUserAutomatorTask NSUserDefaults NSUserNotification NSUserNotificationCenter NSUserScriptTask NSUserUnixTask NSUUID NSValue NSValueTransformer NSWhoseSpecifier NSXMLDocument NSXMLDTD NSXMLDTDNode NSXMLElement NSXMLNode NSXMLParser NSXPCConnection NSXPCInterface NSXPCListener NSXPCListenerEndpoint
syn keyword objc2FrameworkProtocol  NSAccessibility NSAlertDelegate NSAnimatablePropertyContainer NSAnimationDelegate NSApplicationDelegate NSBrowserDelegate NSChangeSpelling NSCollectionViewDelegate NSColorPickingCustom NSColorPickingDefault NSComboBoxCellDataSource NSComboBoxDataSource NSComboBoxDelegate NSControlTextEditingDelegate NSDatePickerCellDelegate NSDictionaryControllerKeyValuePair NSDockTilePlugIn NSDraggingDestination NSDraggingInfo NSDraggingSource NSDrawerDelegate NSEditor NSEditorRegistration NSFontPanelValidation NSGlyphStorage NSIgnoreMisspelledWords NSImageDelegate NSKeyValueBindingCreation NSLayoutManagerDelegate NSMatrixDelegate NSMenuDelegate NSMenuValidation NSNibAwaking NSOpenSavePanelDelegate NSOutlineViewDataSource NSOutlineViewDelegate NSPageControllerDelegate NSPasteboardItemDataProvider NSPasteboardReading NSPasteboardWriting NSPathCellDelegate NSPathControlDelegate NSPlaceholders NSPopoverDelegate NSPrintPanelAccessorizing NSRuleEditorDelegate NSServicesRequests NSSharingServiceDelegate NSSharingServicePickerDelegate NSSoundDelegate NSSpeechRecognizerDelegate NSSpeechSynthesizerDelegate NSSplitViewDelegate NSTableViewDataSource NSTableViewDelegate NSTabViewDelegate NSTextAttachmentCell NSTextDelegate NSTextFieldDelegate NSTextFinderBarContainer NSTextFinderClient NSTextInput NSTextInputClient NSTextLayoutOrientationProvider NSTextViewDelegate NSTokenFieldCellDelegate NSTokenFieldDelegate NSToolbarDelegate NSToolbarItemValidation NSToolTipOwner NSUserInterfaceItemIdentification NSUserInterfaceItemSearching NSUserInterfaceValidations NSValidatedUserInterfaceItem NSWindowDelegate NSWindowRestoration NSWindowScripting

" CoreVideo types
syn keyword objc2FrameworkType      CVReturn
syn keyword objc2FrameworkType      CVDisplayLinkRef
syn keyword objc2FrameworkType      CVTimeStamp CVOptionFlags
syn keyword objc2FrameworkFunction  CVDisplayLinkCreateWithActiveCGDisplays 
syn keyword objc2FrameworkFunction  CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext 
syn keyword objc2FrameworkFunction  CVDisplayLinkSetOutputCallback 
syn keyword objc2FrameworkFunction  CVDisplayLinkRelease 
syn keyword objc2FrameworkFunction  CVDisplayLinkStart 

" Core OpenGL
syn keyword objc2FrameworkType      CGLContextObj
syn match   objc2FrameworkFunction
            \ "CGL\(Choose\|Describe\|Get\|Retain\|Release\|Destroy\)PixelFormat"
syn match   objc2FrameworkFunction
            \ "CGL\(Create\|Retain\|Release\|Destroy\|Copy\|Lock\|Unlock\|GetCurrent\|SetCurrent\)Context"
syn match   objc2FrameworkFunction
            \ "CGLGet\(PixelFormat\|Context\)RetainCount"
syn keyword objc2FrameworkFunction  CGLEnable CGLDisable CGLIsEnabled CGLSetParameter CGLGetParameter

" New directives: properties and autorelease pools
syn match   objc2Directive          "@property\|@synthesize\|@dynamic\|@autoreleasepool"
syn match   objc2Property           display "^\s*@property\>\s*([^)]*)" contains=objcPropertyAttribute
syn keyword objc2PropertyAttribute  contained getter setter readwrite readonly strong weak copy assign retain nonatomic

" Automatic Reference Counting
syn keyword objc2ArcDirective       __bridge __bridge_retained __bridge_transfer __autoreleasing __strong __weak __unsafe_unretained

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_objc_syntax_inits")
  if version < 508
    let did_objc_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink objc2ArcDirective          objc2Directive
  HiLink objc2Property              objc2Directive
  HiLink objc2PropertyAttribute     objcTypeModifier
  HiLink objc2Directive		    objcDirective
  HiLink objc2Boolean               Boolean
  HiLink objc2FrameworkClass        objc2FrameworkType
  HiLink objc2FrameworkProtocol     objc2FrameworkType
  HiLink objc2FrameworkType	    Identifier
  HiLink objc2FrameworkFunction     Underlined

  delcommand HiLink
endif
