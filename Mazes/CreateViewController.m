    //
//  CreateViewController.m
//  iPad Mazes
//
//  Created by Andre Muis on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CreateViewController.h"

@implementation CreateViewController

@synthesize pickerView, gridView;

- (void)viewDidLoad 
{
	[super viewDidLoad];
 
	rowsArr = [[NSMutableArray alloc] init];
	for (int i = [Constants instance].rowsMin; i <= [Constants instance].rowsMax; i = i + 1)
	{
		[rowsArr addObject: [[NSNumber numberWithInt: i] stringValue]];
	}
	
	columnsArr = [[NSMutableArray alloc] init];
	for (int i = [Constants instance].columnsMin; i <= [Constants instance].columnsMax; i = i + 1)
	{
		[columnsArr addObject: [[NSNumber numberWithInt: i] stringValue]];
	}
}

- (void)viewWillAppear: (BOOL)animated
{
	[super viewWillAppear: animated];
	
	[Globals instance].mazeEdit.Rows = [Constants instance].rowsMin;
	[Globals instance].mazeEdit.Columns = [Constants instance].columnsMin;
	
	[[Globals instance].mazeEdit.locations populateWithRows: [Globals instance].mazeEdit.rows Columns: [Globals instance].mazeEdit.columns];
	
	[pickerView selectRow: 0 inComponent: 0 animated: NO];
	[pickerView selectRow: 0 inComponent: 1 animated: NO];
	
	[gridView setNeedsDisplay];
}

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)thePickerView 
{	
	return 2;
}

- (CGFloat)pickerView: (UIPickerView *)pickerView widthForComponent: (NSInteger)component
{
	float width = 0.0;
	
	if (component == 0)
		width = 100.0;
	else if (component == 1)
		width = 132.0;
	
	return width;
}

- (NSInteger)pickerView: (UIPickerView *)thePickerView numberOfRowsInComponent: (NSInteger)component 
{	
	NSInteger pickerRows = 0;
	
	if (component == 0)
		pickerRows = [rowsArr count];
	else if (component == 1)
		pickerRows = [columnsArr count];
	
	return pickerRows;
}

- (NSString *)pickerView: (UIPickerView *)thePickerView titleForRow: (NSInteger)row forComponent: (NSInteger)component 
{	
	NSString *pickerRow = 0;
	
	if (component == 0)
		pickerRow = [rowsArr objectAtIndex: row];
	else if (component == 1)
		pickerRow = [columnsArr objectAtIndex: row];
	
	return pickerRow;
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component 
{	
	[[Globals instance].mazeEdit reset];

	if (component == 0)
	{
		[Globals instance].mazeEdit.Rows = [[rowsArr objectAtIndex: row] intValue];
		[Globals instance].mazeEdit.Columns = [[columnsArr objectAtIndex: [thePickerView selectedRowInComponent: 1]] intValue];
	}
	else if (component == 1)
	{
		[Globals instance].mazeEdit.Rows = [[rowsArr objectAtIndex: [thePickerView selectedRowInComponent: 0]] intValue];
		[Globals instance].mazeEdit.Columns = [[columnsArr objectAtIndex: row] intValue];
	}
	
	[[Globals instance].mazeEdit.locations populateWithRows: [Globals instance].mazeEdit.rows Columns: [Globals instance].mazeEdit.columns];
	
	[gridView setNeedsDisplay];
}

- (IBAction)btnContinueTouchDown: (id)sender
{
	[self.navigationController popViewControllerAnimated: NO];
}

- (IBAction)btnMazesTouchDown: (id)sender
{
	[[Globals instance].mazeEdit reset];
	
	[self.navigationController popToRootViewControllerAnimated: NO];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
	
	NSLog(@"Create View Controller received a memory warning.");
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
}

@end
