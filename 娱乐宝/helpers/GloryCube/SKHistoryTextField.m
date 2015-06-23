//
//  SKHistoryTextField.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKHistoryTextField.h"
#import "SKUtil.h"

@interface SKHistoryTextField () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, assign) BOOL isFocus;
@property (nonatomic, assign) CGRect fromFrame;
@property (nonatomic, assign) CGRect toFrame;
@property (nonatomic, copy) NSString *inputString;
@property (nonatomic, retain) UITableView *searchTable;
@property (nonatomic, retain) NSMutableArray *searchArray;
@property (nonatomic, assign) BOOL isKeyboardNotifyEvent; // 是否是否是由键盘监听产生的事件
@property (nonatomic, retain) UITapGestureRecognizer *tapRecognizer;

@end

@implementation SKHistoryTextField
{}
#pragma mark -
#pragma mark Super Methods

+ (NSString *)stringByTrimmingWhitespaceAndNewlineWithString:(NSString *)string {
    NSCharacterSet *whitespace = [NSCharacterSet  whitespaceAndNewlineCharacterSet];
    NSString *result = [string stringByTrimmingCharactersInSet:whitespace];
    return result;
}

+ (NSString *)stringByReplacingAllWhiteSpacesWithString:(NSString *)string {
    NSArray *array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *result = [array componentsJoinedByString:@""];
    return result;
}

- (void)dealloc {
    // TODO: Release code
    [_textField release];
    [_inputString release];
    [_searchTable release];
    [_searchArray release];
    [_tapRecognizer release];
    [_cancelInteractionViews release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self _initData];
    }
    return self;
}

- (void)layoutSubviews {
    [self _initView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -
#pragma mark Public Methods
- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)addHistoryListWithInfo:(NSString *)info {
    NSArray *historyArray = (NSArray *)[SKUtil objectFromSavedInfoWithKey:_historyTextFieldIdentifier];
    
    for (NSString *s in historyArray) {
        if ([s isEqualToString:info]) {
            return;
        }
    }
    
    NSMutableArray *mutableHisArray = [NSMutableArray arrayWithArray:historyArray];
    [mutableHisArray addObject:info];
    [SKUtil saveToSavedInfoWithObject:mutableHisArray andKey:_historyTextFieldIdentifier];
}

- (void)setLeftView:(UIView *)leftView {
    _leftView = leftView;
    
    CGFloat width = _leftViewWidth;
    if ([SKUtil floatValueOfCurrentDeviceVersion] < 6.0) {
        width = width - 15; // 15像素，是一个根据实际显示效果预估的差值
    } else {
        width = width - 15 + 8; // iOS6与以下版本的偏移相差8像素
    }
    
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, self.bounds.size.height)] autorelease];
    [view setBackgroundColor:[UIColor clearColor]];
    
    //    CGPoint center = leftView.center;
    //    center.y = view.center.y;
    //    leftView.center = center;
    
    leftView.center = view.center;
    [view addSubview:leftView];
    
    [_textField setLeftView:view];
    [_textField setLeftViewMode:(UITextFieldViewModeAlways)];
}

#pragma mark -
#pragma mark Delegate Methods
#pragma mark UITextField Code
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [_movingView addGestureRecognizer:_tapRecognizer];
    
    self.isFocus = YES;
//    [self _keyboardWillShow:nil]; // 用于处理弹出键盘之后，切换文本框没有发生移位的情况，所以需要在这里触发
    
    if (_isKeyboardNotifyEvent) { // 只有当收到键盘出现的事件时，才在切换输入框焦点的时候进行移位操作
        [UIView beginAnimations:@"textFieldShouldEndEditing" context:nil];
        [UIView setAnimationDuration:0.25f];
        [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
        [_movingView setFrame:_toFrame];
        [UIView commitAnimations];
    }
    
    // 显示历史信息
    CGRect frame = [_movingView convertRect:self.bounds fromView:self];//self.frame;
    frame.origin.y += self.bounds.size.height;
    frame.size.height = _historyListHeight;
    [_searchTable setFrame:frame];
    
    NSArray *historyArray = (NSArray *)[SKUtil objectFromSavedInfoWithKey:_historyTextFieldIdentifier];
    NSString *existText = [textField text];
    
    if (existText == nil || [existText isEqualToString:@""]) {
        if ([historyArray count] != 0) {
            [_movingView addSubview:_searchTable];
            [_searchTable reloadData];
            
//            [_movingView addGestureRecognizer:_tapRecognizer];
        }
    }
    
//    existText = [self.class stringByReplacingAllWhiteSpacesWithString:existText];
    NSInteger length = existText.length;
    if (existText != nil && ![existText isEqualToString:@""]) {
        
        self.inputString = existText;
        
        [_searchArray removeAllObjects];
        for (int i = 0; i < [historyArray count]; i++) {
            NSString *text = [historyArray objectAtIndex:i];
            NSInteger textLength = [text length];
            NSString *tempText = @"";
            
            if (length <= textLength) {
                tempText = [text substringToIndex:length];
            }
            
            if ([tempText isEqualToString:existText]) {
                [_searchArray addObject:text];
            }
        }
        
        if (_searchArray.count > 0) {
            [_movingView addSubview:_searchTable];
            [_searchTable reloadData];
            
//            [_movingView addGestureRecognizer:_tapRecognizer];
        }
    }
    
    if ([_delegate respondsToSelector:@selector(historyTextFieldShouldBeginEditing:)]) {
        return [_delegate historyTextFieldShouldBeginEditing:self];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [_movingView removeGestureRecognizer:_tapRecognizer];
    
    self.isFocus = NO;
    [_searchTable removeFromSuperview];
    
//    [_movingView removeGestureRecognizer:_tapRecognizer];
    
    if ([_delegate respondsToSelector:@selector(historyTextFieldDidEndEditing:)]) {
        [_delegate historyTextFieldDidEndEditing:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
//    if ([string length] == 0 && range.length > 0) {
//        SKLog(@"删除操作");
//    } else {
//        SKLog(@"string: %@, %@", string, textField.text);
//    }
    
    [_searchArray removeAllObjects];
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *array = [newString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *result = [array componentsJoinedByString:@""]; // result不会返回nil，An NSString object that is the result of interposing separator between the elements of the array. If the array has no elements, returns an NSString object representing an empty string.
    
    if ([result isEqualToString:@""]) {
        [_movingView addSubview:_searchTable];
        
//        [_movingView addGestureRecognizer:_tapRecognizer];
    }
    
    self.inputString = result;
    
    NSArray *historyArray = (NSArray *)[SKUtil objectFromSavedInfoWithKey:_historyTextFieldIdentifier];
    
//    SKLog(@"historyArray: %@", historyArray);
    
    NSInteger length = [result length];
    for (int i = 0; i < [historyArray count]; i++) {
        NSString *text = [historyArray objectAtIndex:i];
        NSInteger textLength = [text length];
        NSString *tempText = @"";
        
        if (length <= textLength) {
            tempText = [text substringToIndex:length];
        }
        
        if ([tempText isEqualToString:result]) {
            [_searchArray addObject:text];
        }
    }
    
    if ([_searchArray count] == 0) {
        [_searchTable removeFromSuperview];
        
//        [_movingView removeGestureRecognizer:_tapRecognizer];
    } else if ([_searchArray count] > 0) {
        [_movingView addSubview:_searchTable];
        
//        [_movingView addGestureRecognizer:_tapRecognizer];
    }
    
    [_searchTable reloadData];
    
    if ([_delegate respondsToSelector:@selector(historyTextField:shouldChangeCharactersInRange:replacementString:)]) {
        return [_delegate historyTextField:self shouldChangeCharactersInRange:range replacementString:string];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
//    CGRect frame = [_movingView convertRect:self.bounds fromView:self];//self.frame;
//    frame.origin.y += self.bounds.size.height;
//    frame.size.height = 30 * 4;
//    [_searchTable setFrame:frame];
    
    NSArray *historyArray = (NSArray *)[SKUtil objectFromSavedInfoWithKey:_historyTextFieldIdentifier];
    if ([historyArray count] != 0) {
        [_movingView addSubview:_searchTable];
        self.inputString = @"";
        [_searchTable reloadData];
        
//        [_movingView addGestureRecognizer:_tapRecognizer];
    }
    
    if ([_delegate respondsToSelector:@selector(historyTextFieldShouldClear:)]) {
        return [_delegate historyTextFieldShouldClear:self];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // 测试保存历史信息
//    [self addHistoryListWithInfo:textField.text];
    
    [_textField resignFirstResponder];
    
    if ([_delegate respondsToSelector:@selector(historyTextFieldShouldReturn:)]) {
        return [_delegate historyTextFieldShouldReturn:self];
    }
    
    return YES;
}

#pragma mark UITableView Code
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([_inputString isEqualToString:@""]) {
        NSArray *historyArray = (NSArray *)[SKUtil objectFromSavedInfoWithKey:_historyTextFieldIdentifier];
        return [historyArray count];
    } else {
        return [_searchArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    [cell setSelectionStyle:(UITableViewCellSelectionStyleGray)];
    [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
    
    UIButton *delete = [UIButton buttonWithType:(UIButtonTypeCustom)];
    UIImage *deleteImage = [UIImage imageNamed:@"sk_text_filed_delete"];
//    [delete setBackgroundImage:deleteImage forState:(UIControlStateNormal)];
    [delete setImage:deleteImage forState:UIControlStateNormal]; // prevent a button's background image from stretching
    [delete setFrame:CGRectMake(self.bounds.size.width - 50, 0, 50, 30)];
    [delete setTag:indexPath.row];
    [delete addTarget:self action:@selector(_actionForClickCellDeleteButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.contentView addSubview:delete];
    
    if ([_inputString isEqualToString:@""]) {
        NSArray *historyArray = (NSArray *)[SKUtil objectFromSavedInfoWithKey:_historyTextFieldIdentifier];
        
        switch (_orderStyle) {
            case SKHistoryTextFieldOrderStyleASC:
                cell.textLabel.text = [historyArray objectAtIndex:indexPath.row];
                break;
            case SKHistoryTextFieldOrderStyleDESC:
                cell.textLabel.text = [historyArray objectAtIndex:(historyArray.count - 1 - indexPath.row)];
                break;
            default:
                break;
        }
        
    } else {
        
        switch (_orderStyle) {
            case SKHistoryTextFieldOrderStyleASC:
                cell.textLabel.text = [_searchArray objectAtIndex:indexPath.row];
                break;
            case SKHistoryTextFieldOrderStyleDESC:
                cell.textLabel.text = [_searchArray objectAtIndex:(_searchArray.count - 1 - indexPath.row)];
                break;
            default:
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellText = @"";
    if ([_inputString isEqualToString:@""]) {
        NSArray *historyArray = (NSArray *)[SKUtil objectFromSavedInfoWithKey:_historyTextFieldIdentifier];
        
        switch (_orderStyle) {
            case SKHistoryTextFieldOrderStyleASC:
                cellText = [historyArray objectAtIndex:indexPath.row];
                break;
            case SKHistoryTextFieldOrderStyleDESC:
                cellText = [historyArray objectAtIndex:(historyArray.count - 1 - indexPath.row)];
                break;
            default:
                break;
        }
        
        [_textField setText:cellText];
    } else {
        
        switch (_orderStyle) {
            case SKHistoryTextFieldOrderStyleASC:
                cellText = [_searchArray objectAtIndex:indexPath.row];
                break;
            case SKHistoryTextFieldOrderStyleDESC:
                cellText = [_searchArray objectAtIndex:(_searchArray.count - 1 - indexPath.row)];
                break;
            default:
                break;
        }
        
        [_textField setText:cellText];
    }
    
    [_searchTable removeFromSuperview];
    
//    [_movingView removeGestureRecognizer:_tapRecognizer];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _historyListTitleHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [v setBackgroundColor:[UIColor grayColor]];
    [SKUtil borderWithView:v masksToBounds:YES];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - 5, _historyListTitleHeight)] autorelease];
    [label setText:_historyListTitle];
    [label setFont:[UIFont boldSystemFontOfSize:13]];
    [label setTextColor:[UIColor whiteColor]];
    [label setTextAlignment:(NSTextAlignmentRight)];
    [label setBackgroundColor:[UIColor clearColor]];
    [v addSubview:label];
    
    UIButton *delete = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    [delete setFrame:CGRectMake(5, 2, 40, _historyListTitleHeight - 2 * 2)];
    [delete setTitle:@"清除" forState:(UIControlStateNormal)];
    [delete.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [delete setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [delete addTarget:self action:@selector(_actionForClickHeaderDeleteButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [delete setTintColor:[UIColor lightGrayColor]]; // UIButton按下后改变默认那个蓝色的效果
    [v addSubview:delete];
    
    return v;
}

#pragma mark UIAlertView Code
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10) {
        if (buttonIndex == 0) { // 删除全部历史数据
            NSArray *historyArray = (NSArray *)[SKUtil objectFromSavedInfoWithKey:_historyTextFieldIdentifier];
            NSMutableArray *mutableHisArray = [NSMutableArray arrayWithArray:historyArray];
            [mutableHisArray removeAllObjects];
            [SKUtil saveToSavedInfoWithObject:mutableHisArray andKey:_historyTextFieldIdentifier];
            
            [_searchTable removeFromSuperview];
            
//            [_movingView removeGestureRecognizer:_tapRecognizer];
        }
    }
    
    if (alertView.tag == 11) {
        if (buttonIndex == 0) {
            UIButton *button = (UIButton *)[alertView additionalValueForKey:@"button"];
            
            NSArray *historyArray = (NSArray *)[SKUtil objectFromSavedInfoWithKey:_historyTextFieldIdentifier];
            NSMutableArray *mutableHisArray = [NSMutableArray arrayWithArray:historyArray];
            
            NSInteger deleteIndex = 0;
            switch (_orderStyle) {
                case SKHistoryTextFieldOrderStyleASC:
                    deleteIndex = button.tag;
                    break;
                case SKHistoryTextFieldOrderStyleDESC:
                    deleteIndex = historyArray.count - 1 - button.tag;
                    break;
                default:
                    break;
            }
            
            [mutableHisArray removeObjectAtIndex:deleteIndex];
            [SKUtil saveToSavedInfoWithObject:mutableHisArray andKey:_historyTextFieldIdentifier];
            [_searchTable reloadData];
            
            if ([mutableHisArray count] == 0) {
                [_searchTable removeFromSuperview];
                
//                [_movingView removeGestureRecognizer:_tapRecognizer];
            }
            
            // 附带动画效果的删除行操作
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
//            [_searchTable beginUpdates];
//            [_searchTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
//            [_searchTable endUpdates];
        }
    }
    
    if (alertView.tag == 12) {
        if (buttonIndex == 0) {
            UIButton *button = (UIButton *)[alertView additionalValueForKey:@"button"];
            
            NSInteger deleteIndex = 0;
            switch (_orderStyle) {
                case SKHistoryTextFieldOrderStyleASC:
                    deleteIndex = button.tag;
                    break;
                case SKHistoryTextFieldOrderStyleDESC:
                    deleteIndex = _searchArray.count - 1 - button.tag;
                    break;
                default:
                    break;
            }
            
            NSString *info = [_searchArray objectAtIndex:deleteIndex];
            [_searchArray removeObjectAtIndex:deleteIndex];
            
            // 在searchArray中删除的信息，需要也在保存的信息中进行删除
            NSArray *historyArray = (NSArray *)[SKUtil objectFromSavedInfoWithKey:_historyTextFieldIdentifier];
            NSMutableArray *mutableHisArray = [NSMutableArray arrayWithArray:historyArray];
            
            for (int i = 0; i < [mutableHisArray count]; i++) {
                NSString *s = [mutableHisArray objectAtIndex:i];
                if ([s isEqualToString:info]) {
                    [mutableHisArray removeObjectAtIndex:i];
                }
            }
            
            [SKUtil saveToSavedInfoWithObject:mutableHisArray andKey:_historyTextFieldIdentifier];
            
            [_searchTable reloadData];
            
            if ([_searchArray count] == 0) {
                [_searchTable removeFromSuperview];
                
//                [_movingView removeGestureRecognizer:_tapRecognizer];
            }
        }
    }
}

#pragma mark UIGestureRecognizer Code
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:_searchTable]) {
        return NO;
    }
    
    if ([touch.view isDescendantOfView:_textField]) {
        return NO;
    }
    
    NSMutableArray *tmpArray = [[_cancelInteractionViews copy] autorelease];
    for (UIView *v in tmpArray) {
        if ([touch.view isDescendantOfView:v]) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark -
#pragma mark Private Methods
- (void)_initData {
	// TODO: init data code
    self.textField = [[[UITextField alloc] initWithFrame:self.bounds] autorelease];
    [_textField setBorderStyle:(UITextBorderStyleRoundedRect)];
    [_textField setSecureTextEntry:NO];
    [_textField setClearButtonMode:(UITextFieldViewModeWhileEditing)];
    [_textField setAutocapitalizationType:(UITextAutocapitalizationTypeNone)];
    [_textField setDelegate:self];
    [_textField setReturnKeyType:(UIReturnKeyDefault)];
    [_textField setContentVerticalAlignment:(UIControlContentVerticalAlignmentCenter)];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    self.inputString = [NSMutableString stringWithCapacity:0];
    
    self.searchTable = [[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain] autorelease];
    _searchTable.rowHeight = 30;
    _searchTable.dataSource = self;
    _searchTable.delegate = self;
    [SKUtil borderWithView:_searchTable masksToBounds:YES];
//    [_searchTable setEditing:YES];
    
    self.searchArray = [NSMutableArray arrayWithCapacity:0];
    self.historyListTitle = @"历史信息";
    self.historyListTitleHeight = 25.0f;
    self.historyTextFieldIdentifier = @"ILoveSKHistoryTextField";
    self.historyListHeight = 120;
    self.orderStyle = SKHistoryTextFieldOrderStyleASC;
    self.tapRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_actionForTapRecognizer:)] autorelease];
    [_tapRecognizer setDelegate:self];
    
//    NSMutableArray *hisArray = [NSMutableArray arrayWithArray:@[
//                                @"090771",
//                                @"714995",
//                                @"091234",
//                                @"090890"
//                                ]];
//    [SKUtil saveToSavedInfoWithObject:hisArray andKey:_historyTextFieldIdentifier];
    
    self.leftViewWidth = 40.0f;
}

- (void)_initView {
	// TODO: init view code
    [self addSubview:_textField];
    self.fromFrame = _movingView.frame;
    self.toFrame = CGRectMake(_movingView.frame.origin.x, _movingView.frame.origin.y - fabsf(_offset), _movingView.frame.size.width, _movingView.frame.size.height);
}

- (void)_keyboardWillShow:(NSNotification *)notification {
    
    self.isKeyboardNotifyEvent = YES;
    
    if (_isFocus) {
        [UIView beginAnimations:@"textFieldShouldBeginEditing" context:nil];
        [UIView setAnimationDuration:0.25f];
        [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
        [_movingView setFrame:_toFrame];
        [UIView commitAnimations];
    }
}

- (void)_keyboardWillHide:(NSNotification *)notification {
    
    self.isKeyboardNotifyEvent = NO;
    
    if (_isFocus) {
        [UIView beginAnimations:@"textFieldShouldEndEditing" context:nil];
        [UIView setAnimationDuration:0.25f];
        [UIView setAnimationCurve:(UIViewAnimationCurveLinear)];
        [_movingView setFrame:_fromFrame];
        [UIView commitAnimations];
    }
}

- (void)_actionForClickHeaderDeleteButton:(UIButton *)button {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您确定要清除全部历史记录吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert setTag:10];
    [alert show];
    [alert release];
}

- (void)_actionForClickCellDeleteButton:(UIButton *)button {
    if ([_inputString isEqualToString:@""]) {
        NSArray *historyArray = (NSArray *)[SKUtil objectFromSavedInfoWithKey:_historyTextFieldIdentifier];
        
        NSString *text = @"";
        switch (_orderStyle) {
            case SKHistoryTextFieldOrderStyleASC:
                text = [historyArray objectAtIndex:button.tag];
                break;
            case SKHistoryTextFieldOrderStyleDESC:
                text = [historyArray objectAtIndex:(historyArray.count - 1 - button.tag)];
                break;
            default:
                break;
        }
        
        NSString *msg = [NSString stringWithFormat:@"您确定要清除【%@】吗？", text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert setTag:11];
        [alert setAdditionalValue:button forKey:@"button"];
        [alert show];
        [alert release];
    } else {
        
        NSString *text = @"";
        switch (_orderStyle) {
            case SKHistoryTextFieldOrderStyleASC:
                text = [_searchArray objectAtIndex:button.tag];
                break;
            case SKHistoryTextFieldOrderStyleDESC:
                text = [_searchArray objectAtIndex:(_searchArray.count - 1 - button.tag)];
                break;
            default:
                break;
        }
        
        NSString *msg = [NSString stringWithFormat:@"您确定要清除【%@】吗？", text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert setTag:12];
        [alert setAdditionalValue:button forKey:@"button"];
        [alert show];
        [alert release];
    }
}

- (void)_actionForTapRecognizer:(UITapGestureRecognizer *)tap {
    [_textField resignFirstResponder];
}

@end
