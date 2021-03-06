//
//  ListeningViewController.h
//  Say
//
//  Created by JiaLi on 11-7-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ListeningToolbar.h"
#import "SettingData.h"
#import "CourseParser.h"


#define VOLUMNVIEW_TAG  50001

enum {
    PLAY_LESSON_TYPE_NONE = 0,
    PLAY_LESSON = 1,
    PLAY_SENTENCE = 2,
};
typedef NSInteger PLAY_LESSON_TYPE;

typedef enum {
	PLAY_STATUS_NONE = 0,
	PLAY_STATUS_PLAYING,
	PLAY_STATUS_PAUSING,
	PLAY_STATUS_PAUSING_END
} PLAY_STATUS;
@protocol ListeningViewControllerDelegate <NSObject>

- (NSString*)getPkgTitle;
- (NSString*)getCourseTitle;

@end

@interface ListeningViewController : UIViewController {
    NSMutableArray*                 _sentencesArray;
    NSMutableArray*                 _teachersArray;
    UITableView*                    _sentencesTableView;
    ListeningToolbar*               _listeningToolbar;
    UIBarButtonItem*                _recordingItem;
    UISlider*                       progressBar;
    //UILabel* timepreces;
    //UILabel* timelast;
    UILabel*                        senCount;
    NSTimer*                        updateTimer;
    NSTimer*                        playTimer;
    NSTimer*                        pauseTimer;
    int                             nLesson;
    BOOL                            bRecording;
    NSString*                       wavefile;         // 音频文件
    NSString*                       _isbfile;
    NSString*                       resourcePath;
    AVAudioPlayer *                 player;
    
    // 循环控制
    NSTimeInterval                  loopstarttime;   // 循环开始时间
    NSTimeInterval                  loopendtime;     // 循环结束时间
    
    NSTimeInterval                  timeStart;       // 起始时间
    
    NSInteger                       nPosition;       // 滚动位置
    CGFloat                         fVolumn;
    PLAY_STATUS                     ePlayStatus;
    SettingData*                    settingData;
    NSInteger                       nCurrentReadingCount;
    BOOL                            bAlReadyPaused;
    NSInteger                       nLastScrollPos;
    BOOL                            bInit;
    BOOL                            bParseWAV;
    BOOL                            _bDownloadedXAT;
    BOOL                            _bDownloadedISB;
}

@property (nonatomic, retain) NSMutableArray* sentencesArray;
@property (nonatomic, retain) NSMutableArray* teachersArray;
@property (nonatomic, retain) IBOutlet ListeningToolbar* listeningToolbar;
@property (nonatomic, retain) IBOutlet UITableView* sentencesTableView;
@property (nonatomic, retain) IBOutlet UISlider* progressBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* recordingItem;
//@property (nonatomic, retain) IBOutlet UILabel* timepreces;
//@property (nonatomic, retain) IBOutlet UILabel* timelast;
@property (nonatomic, retain) IBOutlet UILabel* senCount;
@property (nonatomic, retain) NSTimer* updataeTimer;
@property (nonatomic, retain) NSString* wavefile;
@property (nonatomic, retain) NSString* isbfile;
@property (nonatomic, retain) AVAudioPlayer* player;

@property (nonatomic, assign) NSInteger nPositionInCourse;
@property (nonatomic, retain) CourseParser* courseParser;
@property (nonatomic, assign) id<ListeningViewControllerDelegate>delegate;
@property (nonatomic, retain) IBOutlet UIView* adView;
- (void)initMembers;
- (void)initValue;
- (void)parseWAVFile;
- (void)addWaitingView:(NSInteger)tag withText:(NSString*)text withAnimation:(BOOL)animated;
- (void)addLoadingView;
- (void)removeLoadingView;
- (void)addDownloadingView;
- (void)removeDownloadingView;
- (void)addDownloadingFailedView;
- (IBAction)onPrevious:(id)sender;
- (IBAction)onNext:(id)sender;
- (IBAction)onOther:(id)sender;
- (IBAction)onStart:(id)sender;
- (IBAction)onSetting:(id)sender;
- (IBAction)onGotoSentence:(id)sender;
- (IBAction)onChangingGotoSentence:(id)sender;
- (void)onRecording;
- (void)updateCurrentTime;
- (void)updateViewForPlayer;
- (void)updateUI;
- (void)highlightCell:(NSInteger)nPos;

- (int)getSentenceIndex:(NSTimeInterval)time;
- (void)reloadTableView;
- (void)playfromCurrentPos;
- (void)pauseintime;
- (void)setStatusPause;
- (BOOL)downloadLesson;
- (void)downloadXATByURL:(NSString*)url withTryIndex:(NSInteger)tryIndex;
- (void)downloadISBByURL:(NSString *)url withTryIndex:(NSInteger)tryIndex;
- (void)displayLesson;

@end
