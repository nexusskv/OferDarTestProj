//
//  MainViewController.m
//  OferDarTestProject
//
//  Created by Admin on 11/03/2013.
//  Copyright (c) 2013 Rost. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MainViewController ()

@end


@implementation MainViewController


- (id)init
{
    self = [super init];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self createUI];
}


- (void) createUI
{
    self.title = @"Main View";
    
    UIImageView  *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height)];
    bgImgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgImgView];
    SAFE_RELEASE(bgImgView);
    
    UIImageView *setAvaImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30.0f, 60.0f, 50.0f, 50.0f)];
    setAvaImgView.tag = 100;
    setAvaImgView.backgroundColor = [UIColor clearColor];
    setAvaImgView.image = [UIImage imageNamed:@"set_logo_holder"];
    [setAvaImgView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(imgTapping:)];
    [singleTap setNumberOfTapsRequired:1];
    [setAvaImgView addGestureRecognizer:singleTap];
    SAFE_RELEASE(singleTap);
    
    [self.view addSubview:setAvaImgView];
    
    
    UITextField *nameTxtFld = [[UITextField alloc] initWithFrame:CGRectMake(30.0f, setAvaImgView.frame.origin.y + 60.0f, self.view.bounds.size.width - 60.0f, 31.0f)];
    SAFE_RELEASE(setAvaImgView);
    nameTxtFld.tag                      = 10;
    nameTxtFld.placeholder              = @"Name";
    nameTxtFld.textColor                = [UIColor blackColor];
    [nameTxtFld setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    nameTxtFld.backgroundColor          = [UIColor clearColor];
    nameTxtFld.returnKeyType            = UIReturnKeyDone;
    nameTxtFld.textAlignment            = NSTextAlignmentLeft;
    nameTxtFld.clearButtonMode          = UITextFieldViewModeWhileEditing;
    nameTxtFld.borderStyle              = UITextBorderStyleRoundedRect;
    nameTxtFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nameTxtFld.keyboardType             = UIKeyboardTypeNumbersAndPunctuation;
    nameTxtFld.delegate                 = self;
    [self.view addSubview:nameTxtFld];
    
    
    UITextField *phoneTxtFld = [[UITextField alloc] initWithFrame:CGRectMake(30.0f, nameTxtFld.frame.origin.y + 50.0f, self.view.bounds.size.width - 60.0f, 31.0f)];
    SAFE_RELEASE(nameTxtFld);
    phoneTxtFld.tag                      = 20;
    phoneTxtFld.placeholder              = @"Phone Number";
    phoneTxtFld.textColor                = [UIColor blackColor];
    [phoneTxtFld setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    phoneTxtFld.backgroundColor          = [UIColor clearColor];
    phoneTxtFld.returnKeyType            = UIReturnKeyDone;
    phoneTxtFld.textAlignment            = NSTextAlignmentLeft;
    phoneTxtFld.clearButtonMode          = UITextFieldViewModeWhileEditing;
    phoneTxtFld.borderStyle              = UITextBorderStyleRoundedRect;
    phoneTxtFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    phoneTxtFld.keyboardType             = UIKeyboardTypeNumbersAndPunctuation;
    phoneTxtFld.delegate                 = self;
    [self.view addSubview:phoneTxtFld];
    
    
    UITextField *ringTonTxtFld = [[UITextField alloc] initWithFrame:CGRectMake(30.0f, phoneTxtFld.frame.origin.y + 50.0f, self.view.bounds.size.width - 60.0f, 31.0f)];
    SAFE_RELEASE(phoneTxtFld);
    ringTonTxtFld.tag                      = 30;
    ringTonTxtFld.placeholder              = @"Choose Ringtone";
    ringTonTxtFld.textColor                = [UIColor blackColor];
    [ringTonTxtFld setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    ringTonTxtFld.backgroundColor          = [UIColor clearColor];
    ringTonTxtFld.textAlignment            = NSTextAlignmentLeft;
    ringTonTxtFld.borderStyle              = UITextBorderStyleRoundedRect;
    ringTonTxtFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    ringTonTxtFld.delegate                 = self;
    [self.view addSubview:ringTonTxtFld];
    
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setFrame:CGRectMake(50.0f, ringTonTxtFld.frame.origin.y + 60.0f, self.view.bounds.size.width - 100.0f, 40.0f)];
    SAFE_RELEASE(ringTonTxtFld);
    [shareBtn setBackgroundColor:[UIColor whiteColor]];
    [shareBtn setTitle:@"Share By Mail" forState:UIControlStateNormal];
    [shareBtn setTitle:@"Share By Mail" forState:UIControlStateHighlighted];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [shareBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    shareBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [shareBtn addTarget:self action:@selector(sendEmailnSelector) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.layer.borderWidth    = 1.5f;
    shareBtn.layer.borderColor    = [UIColor grayColor].CGColor;
    shareBtn.layer.cornerRadius   = 8.0f;
    shareBtn.clipsToBounds        = YES;
    shareBtn.exclusiveTouch = YES;
    [self.view addSubview:shareBtn];
}

- (void) imgTapping:(UITapGestureRecognizer *)sender
{    
    SetViewController *setViewContr = [[SetViewController alloc] init];
    setViewContr.setAvaFlag = TRUE;
    setViewContr.setAvaDelegate = self;
    [self.navigationController pushViewController:setViewContr animated:YES];
    SAFE_RELEASE(setViewContr);
}

- (void) setData:(id)objValue
{
    if ([objValue isKindOfClass:[UIImage class]])
    {
        UIImage *aImg = (UIImage *)objValue;
        UIImageView *setAvaImgView = (UIImageView *)[self.view viewWithTag:100];
        setAvaImgView.image = aImg;
    }
    else
        {
            NSString *ringStr = (NSString *)objValue;
            UITextField *ringTxtFld = (UITextField *)[self.view viewWithTag:30];
            ringTxtFld.text = ringStr;
        }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 30)
    {        
        SetViewController *setViewContr = [[SetViewController alloc] init];
        setViewContr.setAvaFlag = FALSE;
        setViewContr.setAvaDelegate = self;
        [self.navigationController pushViewController:setViewContr animated:YES];
        SAFE_RELEASE(setViewContr);
        return NO;
    }
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 10)
    {
        [textField resignFirstResponder];
    }
    
    if (textField.tag == 20)
    {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void) sendEmailnSelector
{	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		if ([mailClass canSendMail])
		{
            NSString *nameStr = nil;
            NSString *numbStr = nil;
            NSString *ringStr = nil;
            
			MFMailComposeViewController *mailSender = [[MFMailComposeViewController alloc] init];
            [mailSender setToRecipients:[NSArray arrayWithObject:@"welcome@onoapps.com"]];
			mailSender.mailComposeDelegate = self;
			[mailSender setSubject:@"Share Contact"];

            UIImageView *avaImgView = (UIImageView *)[self.view viewWithTag:100];
			NSData *imageData = UIImagePNGRepresentation(avaImgView.image);            
            
            [mailSender addAttachmentData:imageData mimeType:@"image/png" fileName:@"ava"];
            UITextField *nameTxtFld = (UITextField *)[self.view viewWithTag:10];
            UITextField *numbTxtFld = (UITextField *)[self.view viewWithTag:20];
            UITextField *ringTxtFld = (UITextField *)[self.view viewWithTag:30];
            if (![self isCheckEmpty:nameTxtFld.text])
            {
                nameStr = nameTxtFld.text;
            }
            else
                {
                    nameStr = @"";
                }
            
            if (![self isCheckEmpty:numbTxtFld.text])
            {
                numbStr = numbTxtFld.text;
            }
            else
                {
                    numbStr = @"";
                }
            
            if (![self isCheckEmpty:ringTxtFld.text])
            {
                ringStr = ringTxtFld.text;
            }
            else
                {
                    ringStr = @"";
                }
            
            NSString *msgStr = [NSString stringWithFormat:@"Name: %@ \n Phone: %@ \n Ringtone: %@ \n\n", nameStr, numbStr, ringStr];
            
			[mailSender setMessageBody:msgStr isHTML:NO];
			
			[self OPEN_MAIL_SENDER];
			SAFE_RELEASE(mailSender);
		}
		else
			[self launchMailAppOnDevice];
	}
	else
    {
        [self launchMailAppOnDevice];
    }
}

- (void) launchMailAppOnDevice
{
    NSString *recipients = @"mailto:?cc=&subject=";    
	NSString *body = @"&body=";
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	NSString *alertMessage;
	switch (result)
	{
		case MFMailComposeResultCancelled:
			alertMessage = @"Email composition cancelled";
			break;
		case MFMailComposeResultSaved:
			alertMessage = @"Your e-mail has been saved successfully";
			
			break;
		case MFMailComposeResultSent:
			alertMessage = @"Your email has been sent successfully";
			
			break;
		case MFMailComposeResultFailed:
			alertMessage = @"Failed to send email";
			
			break;
		default:
			alertMessage = @"Email Not Sent";
			
			break;
	}
	
    [[[[UIAlertView alloc] initWithTitle:@"Send mail result." message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
	
	[self CLOSE_MAIL_SENDER];
}

- (BOOL)isCheckEmpty:(NSString *)checkStr
{
    BOOL resultFlag = TRUE;
    if ((checkStr != nil) && (checkStr.length > 0))
    {
        resultFlag = FALSE;
    }
    return resultFlag;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
