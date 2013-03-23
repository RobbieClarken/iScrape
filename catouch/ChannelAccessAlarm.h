//
//  CAAlarm.h
//  EPICS
//
//  Created by Thomas Pelaia on 12/8/05.
//  Copyright 2005 Oak Ridge National Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef INC_alarm_H

/* defines for the choice fields */
/* ALARM SEVERITIES - NOTE: must match defs in choiceGbl.ascii GBL_ALARM_SEV */
#define NO_ALARM		0x0
#define	MINOR_ALARM		0x1
#define	MAJOR_ALARM		0x2
#define INVALID_ALARM		0x3
#define ALARM_NSEV		INVALID_ALARM+1

#endif	/* INC_alarm_H */


#ifndef NO_ALARMH_ENUM

typedef enum {
	CASevNone = NO_ALARM, 
	CASevMinor = MINOR_ALARM, 
	CASevMajor = MAJOR_ALARM, 
	CASevInvalid = INVALID_ALARM 
}CAAlarmSeverity;
#define firstCAAlarmSev epicsSevNone
#define lastCAAlarmSev epicsSevInvalid 

#endif /* NO_ALARMH_ENUM */

#ifndef INC_alarm_H

/* ALARM STATUS  -NOTE: must match defs in choiceGbl.ascii GBL_ALARM_STAT */
/* NO_ALARM = 0 as above */
#define	READ_ALARM		1
#define	WRITE_ALARM		2
/* ANALOG ALARMS */
#define	HIHI_ALARM		3
#define	HIGH_ALARM		4
#define	LOLO_ALARM		5
#define	LOW_ALARM		6
/* BINARY ALARMS */
#define	STATE_ALARM		7
#define	COS_ALARM		8
/* other alarms */
#define COMM_ALARM		9
#define	TIMEOUT_ALARM		10
#define	HW_LIMIT_ALARM		11
#define	CALC_ALARM		12
#define	SCAN_ALARM		13
#define	LINK_ALARM		14
#define	SOFT_ALARM		15
#define	BAD_SUB_ALARM		16
#define	UDF_ALARM		17
#define	DISABLE_ALARM		18
#define	SIMM_ALARM		19
#define	READ_ACCESS_ALARM	20
#define	WRITE_ACCESS_ALARM	21
#define ALARM_NSTATUS		WRITE_ACCESS_ALARM + 1

#endif	/* INC_alarm_H */


#ifndef NO_ALARMH_ENUM

typedef enum {
	CAAlarmNone = NO_ALARM,
	CAAlarmRead = READ_ALARM, 
	CAAlarmWrite = WRITE_ALARM, 
	CAAlarmHiHi = HIHI_ALARM,
	CAAlarmHigh = HIGH_ALARM,
	CAAlarmLoLo = LOLO_ALARM,
	CAAlarmLow = LOW_ALARM,
	CAAlarmState = STATE_ALARM,
	CAAlarmCos = COS_ALARM,
	CAAlarmComm = COMM_ALARM,
	CAAlarmTimeout = TIMEOUT_ALARM,
	CAAlarmHwLimit = HW_LIMIT_ALARM,
	CAAlarmCalc = CALC_ALARM,
	CAAlarmScan = SCAN_ALARM,
	CAAlarmLink = LINK_ALARM,
	CAAlarmSoft = SOFT_ALARM,
	CAAlarmBadSub = BAD_SUB_ALARM,
	CAAlarmUDF = UDF_ALARM,
	CAAlarmDisable = DISABLE_ALARM,
	CAAlarmSimm = SIMM_ALARM,
	CAAlarmReadAccess = READ_ACCESS_ALARM,
	CAAlarmWriteAccess = WRITE_ACCESS_ALARM
}CAAlarmCondition;
#define firstCAAlarmCond CASevNone
#define lastCAAlarmCond CAAlarmWriteAccess 

#endif /* No_ALARMH_ENUM*/


@interface ChannelAccessAlarm : NSObject {

}

+ (NSString *)textForSeverity:(CAAlarmSeverity)severity;
+ (NSString *)textForStatus:(CAAlarmCondition)status;

@end
