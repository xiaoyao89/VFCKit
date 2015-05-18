//
//  VFCApplicationInformationViewController.m
//  VFCKit
//

#import "VFCApplicationInformationViewController.h"
#import "VFCUser.h"
#import "UIColor+VFCAdditions.h"

#pragma mark - _VFCTableViewCell

@interface _VFCTableViewCell : UITableViewCell
@end

@implementation _VFCTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.detailTextLabel.textColor = [UIColor venturaFoodsBlueColor];
        self.preservesSuperviewLayoutMargins = NO;
        self.layoutMargins = UIEdgeInsetsZero;
        self.separatorInset = UIEdgeInsetsZero;
    }
    return self;
}

@end

#pragma mark - VFCApplicationInformationViewController

#pragma mark - Private Interface

@interface VFCApplicationInformationViewController() <UITextFieldDelegate>
@end

#pragma mark - Public Implementation

static NSString *VFCApplicationCellIdentifier = @"VFCApplicationCell";
static NSString *VFCApplicationTextFieldCellIdentifier = @"VFCApplicationTextFieldCell";

@implementation VFCApplicationInformationViewController

#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    self.title = infoDict[@"CFBundleName"];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                              target:self
                                                                              action:@selector(dismiss)];
    self.navigationItem.rightBarButtonItem = doneItem;
    
    [[self tableView] registerClass:[_VFCTableViewCell class] forCellReuseIdentifier:VFCApplicationCellIdentifier];
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:VFCApplicationTextFieldCellIdentifier];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.allowsSelection = NO;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if ([indexPath row] == 6) {
        cell = [tableView dequeueReusableCellWithIdentifier:VFCApplicationTextFieldCellIdentifier forIndexPath:indexPath];
        cell.preservesSuperviewLayoutMargins = NO;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsZero;
        cell.textLabel.text = @"User Email";
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
        textField.textAlignment = NSTextAlignmentRight;
        textField.placeholder = @"Tap to enter email";
        textField.delegate = self;
        textField.textColor = [UIColor venturaFoodsBlueColor];
        cell.accessoryView = textField;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:VFCApplicationCellIdentifier forIndexPath:indexPath];
        NSString *text = nil;
        NSString *detailText = nil;
        NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
        UIDevice *device = [UIDevice currentDevice];
        
        switch ([indexPath row]) {
            case 0: {
                text = NSLocalizedString(@"Application Version", @"kApplicationVersion");
                detailText = [infoDict objectForKey:@"CFBundleShortVersionString"];
                break;
            }
            case 1: {
                text = NSLocalizedString(@"Application Build Number", @"kApplicationBuildNumber");
                detailText = [infoDict objectForKey:@"CFBundleVersion"];
                break;
            }
            case 2: {
                text = NSLocalizedString(@"iOS Version", @"kiOSVersion");
                detailText = device.systemVersion;
                break;
            }
            case 3: {
                text = NSLocalizedString(@"Device Model", @"kDeviceModel");
                detailText = device.localizedModel;
                break;
            }
            case 4: {
                text = NSLocalizedString(@"Device Name", @"kDeviceName");
                detailText = device.name;
                break;
            }
            case 5: {
                text = NSLocalizedString(@"Vendor Identifier", @"kVendorIdentifier");
                detailText = device.identifierForVendor.UUIDString;
                break;
            }
            default:
                break;
        }
        cell.textLabel.text = text;
        cell.detailTextLabel.text = detailText;
    }
    
    return cell;
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [VFCUser user].email = textField.text;
}

#pragma mark Private

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
