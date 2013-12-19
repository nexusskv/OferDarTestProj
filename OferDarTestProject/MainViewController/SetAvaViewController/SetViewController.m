//
//  SetViewController.m
//  OferDarTestProject
//
//  Created by Admin on 11/03/2013.
//  Copyright (c) 2013 Rost. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()
@property (nonatomic, retain) NSArray *valuesArr;
@end

@implementation SetViewController

@synthesize  setAvaFlag;
@synthesize valuesArr;
@synthesize setAvaDelegate;

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
    SAFE_RELEASE(valuesArr);
    self.setAvaDelegate = nil;
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self createUI];
}



- (void) createUI
{    
    if (self.setAvaFlag == TRUE)
    {
        self.title = @"Avatars";
        NSMutableArray *avaMuArr = [[NSMutableArray alloc] init];
        
        for (int i = 1; i < 13; i++)
        {
            NSString *urlStr = nil;
            NSString *detStr = nil;
            if (i < 10)
            {
                urlStr = [NSString stringWithFormat:@"http://onoapps.com/Dev/avatars/a0%d.png",i];
            }
            else
                {
                    urlStr = [NSString stringWithFormat:@"http://onoapps.com/Dev/avatars/a%d.png",i];
                }
            
            detStr = [NSString stringWithFormat:@"Avatar %d",i];            
            NSDictionary *dataDic = [[NSDictionary alloc] initWithObjectsAndKeys:urlStr, @"url",
                                                                                 detStr, @"detail", nil];            
            [avaMuArr addObject:dataDic];
            SAFE_RELEASE(dataDic);
        }
        self.valuesArr = [NSArray arrayWithArray:avaMuArr];
        SAFE_RELEASE(avaMuArr)
    }
    else
        {
            self.title = @"Ringtones";
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"rings.plist"];
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];            
            if (fileExists == TRUE)
            {
                self.valuesArr = [[[NSArray alloc] initWithContentsOfFile:filePath] autorelease];
            }
        }
    
    UITableView *dataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, (self.view.bounds.size.height))
                                                 style:UITableViewStylePlain];
    dataTableView.delegate = self;
    dataTableView.dataSource = self;
    dataTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    dataTableView.backgroundColor = [UIColor whiteColor];
    dataTableView.scrollEnabled = YES;
    [self.view addSubview:dataTableView];
    SAFE_RELEASE(dataTableView);
}

#pragma mark - UITableView methods
-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    return [self.valuesArr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier] autorelease];
    }

    if (self.setAvaFlag != TRUE)
    {
        cell.imageView.image = nil;
        cell.textLabel.text  = [NSString stringWithFormat:@"%@ - %@", [[self.valuesArr objectAtIndex:indexPath.row] valueForKey:@"ringName"], [[self.valuesArr objectAtIndex:indexPath.row] valueForKey:@"ringDec"]];
    }
    else
        {
            [AsyncImageDownloader processImageDataWithURLString:[[self.valuesArr objectAtIndex:indexPath.row] valueForKey:@"url"]
                                                       andBlock:^(NSData *imageData)
             {
                 if (self.view.window)
                 {
                     cell.imageView.image = [UIImage imageWithData:imageData];
                 }                 
             }];
            
            cell.textLabel.text  = [[self.valuesArr objectAtIndex:indexPath.row] valueForKey:@"detail"];
        }        
    cell.selectionStyle  = UITableViewCellSelectionStyleGray;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.setAvaFlag == TRUE)
    {
        if ((self.setAvaDelegate) && ([self.setAvaDelegate respondsToSelector:@selector(setData:)]))
        {
            [self.setAvaDelegate setData:cell.imageView.image];            
        }
    }
    else
        {
            if ((self.setAvaDelegate) && ([self.setAvaDelegate respondsToSelector:@selector(setData:)]))
            {
                [self.setAvaDelegate setData:cell.textLabel.text];
            }
        }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
