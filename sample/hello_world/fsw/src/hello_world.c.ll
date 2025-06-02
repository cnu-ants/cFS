; ModuleID = '/home/soyeonb/cFS/apps/hello_world/fsw/src/hello_world.c'
source_filename = "/home/soyeonb/cFS/apps/hello_world/fsw/src/hello_world.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.HELLO_WORLD_Data_t = type { i8, i8, %struct.HELLO_WORLD_HkTlm_t, i32, i32 }
%struct.HELLO_WORLD_HkTlm_t = type { %struct.CFE_MSG_TelemetryHeader, %struct.HELLO_WORLD_HkTlm_Payload_t }
%struct.CFE_MSG_TelemetryHeader = type { %struct.CFE_MSG_Message, %struct.CFE_MSG_TelemetrySecondaryHeader_t, [4 x i8] }
%struct.CFE_MSG_Message = type { %struct.CCSDS_SpacePacket_t }
%struct.CCSDS_SpacePacket_t = type { %struct.CCSDS_PrimaryHeader }
%struct.CCSDS_PrimaryHeader = type { [2 x i8], [2 x i8], [2 x i8] }
%struct.CFE_MSG_TelemetrySecondaryHeader_t = type { [6 x i8] }
%struct.HELLO_WORLD_HkTlm_Payload_t = type { i8, i8, [2 x i8] }
%struct.CFE_SB_MsgId_t = type { i32 }
%struct.SAMPLE_EchoTlm_t = type { %struct.CFE_MSG_TelemetryHeader, [64 x i8] }
%struct.SAMPLE_EchoCmd_t = type { %struct.CFE_MSG_CommandHeader, [64 x i8] }
%struct.CFE_MSG_CommandHeader = type { %struct.CFE_MSG_Message, %struct.CFE_MSG_CommandSecondaryHeader_t }
%struct.CFE_MSG_CommandSecondaryHeader_t = type { i8, i8 }

@HELLO_WORLD_Data = global %struct.HELLO_WORLD_Data_t zeroinitializer, align 4, !dbg !0
@.str = private unnamed_addr constant [32 x i8] c"Hello World: SB Pipe Read Error\00", align 1, !dbg !96
@.str.1 = private unnamed_addr constant [38 x i8] c"Hello World: Error Registering Events\00", align 1, !dbg !103
@.str.2 = private unnamed_addr constant [12 x i8] c"HELLO_WORLD\00", align 1, !dbg !108
@.str.3 = private unnamed_addr constant [44 x i8] c"Hello World: Error creating SB Command Pipe\00", align 1, !dbg !113
@.str.4 = private unnamed_addr constant [46 x i8] c"Hello World: Error subscribing to HK Requests\00", align 1, !dbg !118
@.str.5 = private unnamed_addr constant [50 x i8] c"Hello World: Error subscribing to Ground Commands\00", align 1, !dbg !123
@.str.6 = private unnamed_addr constant [42 x i8] c"SAMPLE: invalid command packet,MID = 0x%x\00", align 1, !dbg !128
@.str.7 = private unnamed_addr constant [37 x i8] c"Invalid ground command code: CC = %d\00", align 1, !dbg !133
@.str.8 = private unnamed_addr constant [33 x i8] c"HELLO_WORLD: Echo Received -> %s\00", align 1, !dbg !138
@.str.9 = private unnamed_addr constant [48 x i8] c"HELLO_WORLD: Failed to initialize Echo message.\00", align 1, !dbg !143
@.str.10 = private unnamed_addr constant [44 x i8] c"HELLO_WORLD: Failed to send Echo telemetry.\00", align 1, !dbg !148
@.str.11 = private unnamed_addr constant [40 x i8] c"@@@@@@@HELLO_WORLD: Echo Sent -> %s %ld\00", align 1, !dbg !150

; Function Attrs: noinline nounwind optnone uwtable
define void @HELLO_WORLD_Main() #0 !dbg !204 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  call void @llvm.dbg.declare(metadata ptr %1, metadata !208, metadata !DIExpression()), !dbg !209
  call void @llvm.dbg.declare(metadata ptr %2, metadata !210, metadata !DIExpression()), !dbg !221
  %3 = call i32 @HELLO_WORLD_Init(), !dbg !222
  store i32 %3, ptr %1, align 4, !dbg !223
  %4 = load i32, ptr %1, align 4, !dbg !224
  %5 = icmp ne i32 %4, 0, !dbg !226
  br i1 %5, label %6, label %7, !dbg !227

6:                                                ; preds = %0
  store i32 3, ptr getelementptr inbounds (%struct.HELLO_WORLD_Data_t, ptr @HELLO_WORLD_Data, i32 0, i32 3), align 4, !dbg !228
  br label %7, !dbg !230

7:                                                ; preds = %6, %0
  br label %8, !dbg !231

8:                                                ; preds = %21, %7
  %9 = call zeroext i1 @CFE_ES_RunLoop(ptr noundef getelementptr inbounds (%struct.HELLO_WORLD_Data_t, ptr @HELLO_WORLD_Data, i32 0, i32 3)), !dbg !232
  %10 = zext i1 %9 to i32, !dbg !232
  %11 = icmp eq i32 %10, 1, !dbg !233
  br i1 %11, label %12, label %22, !dbg !231

12:                                               ; preds = %8
  %13 = load i32, ptr getelementptr inbounds (%struct.HELLO_WORLD_Data_t, ptr @HELLO_WORLD_Data, i32 0, i32 4), align 4, !dbg !234
  %14 = call i32 @CFE_SB_ReceiveBuffer(ptr noundef %2, i32 noundef %13, i32 noundef -1), !dbg !236
  store i32 %14, ptr %1, align 4, !dbg !237
  %15 = load i32, ptr %1, align 4, !dbg !238
  %16 = icmp eq i32 %15, 0, !dbg !240
  br i1 %16, label %17, label %19, !dbg !241

17:                                               ; preds = %12
  %18 = load ptr, ptr %2, align 8, !dbg !242
  call void @HELLO_WORLD_TaskPipe(ptr noundef %18), !dbg !244
  br label %21, !dbg !245

19:                                               ; preds = %12
  %20 = call i32 (i16, i16, ptr, ...) @CFE_EVS_SendEvent(i16 noundef zeroext 1, i16 noundef zeroext 3, ptr noundef @.str), !dbg !246
  store i32 3, ptr getelementptr inbounds (%struct.HELLO_WORLD_Data_t, ptr @HELLO_WORLD_Data, i32 0, i32 3), align 4, !dbg !248
  br label %21

21:                                               ; preds = %19, %17
  br label %8, !dbg !231, !llvm.loop !249

22:                                               ; preds = %8
  %23 = load i32, ptr getelementptr inbounds (%struct.HELLO_WORLD_Data_t, ptr @HELLO_WORLD_Data, i32 0, i32 3), align 4, !dbg !251
  call void @CFE_ES_ExitApp(i32 noundef %23), !dbg !252
  ret void, !dbg !253
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @HELLO_WORLD_Init() #0 !dbg !254 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca %struct.CFE_SB_MsgId_t, align 4
  %4 = alloca %struct.CFE_SB_MsgId_t, align 4
  %5 = alloca %struct.CFE_SB_MsgId_t, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !257, metadata !DIExpression()), !dbg !258
  call void @llvm.memset.p0.i64(ptr align 4 @HELLO_WORLD_Data, i8 0, i64 32, i1 false), !dbg !259
  store i32 1, ptr getelementptr inbounds (%struct.HELLO_WORLD_Data_t, ptr @HELLO_WORLD_Data, i32 0, i32 3), align 4, !dbg !260
  %6 = call i32 @CFE_EVS_Register(ptr noundef null, i16 noundef zeroext 0, i16 noundef zeroext 0), !dbg !261
  store i32 %6, ptr %2, align 4, !dbg !262
  %7 = load i32, ptr %2, align 4, !dbg !263
  %8 = icmp ne i32 %7, 0, !dbg !265
  br i1 %8, label %9, label %12, !dbg !266

9:                                                ; preds = %0
  %10 = call i32 (ptr, ...) @CFE_ES_WriteToSysLog(ptr noundef @.str.1), !dbg !267
  %11 = load i32, ptr %2, align 4, !dbg !269
  store i32 %11, ptr %1, align 4, !dbg !270
  br label %50, !dbg !270

12:                                               ; preds = %0
  %13 = call i32 @CFE_SB_ValueToMsgId(i32 noundef 6281), !dbg !271
  %14 = getelementptr inbounds %struct.CFE_SB_MsgId_t, ptr %3, i32 0, i32 0, !dbg !271
  store i32 %13, ptr %14, align 4, !dbg !271
  %15 = getelementptr inbounds %struct.CFE_SB_MsgId_t, ptr %3, i32 0, i32 0, !dbg !272
  %16 = load i32, ptr %15, align 4, !dbg !272
  %17 = call i32 @CFE_MSG_Init(ptr noundef getelementptr inbounds (%struct.HELLO_WORLD_Data_t, ptr @HELLO_WORLD_Data, i32 0, i32 2), i32 %16, i64 noundef 20), !dbg !272
  %18 = call i32 @CFE_SB_CreatePipe(ptr noundef getelementptr inbounds (%struct.HELLO_WORLD_Data_t, ptr @HELLO_WORLD_Data, i32 0, i32 4), i16 noundef zeroext 32, ptr noundef @.str.2), !dbg !273
  store i32 %18, ptr %2, align 4, !dbg !274
  %19 = load i32, ptr %2, align 4, !dbg !275
  %20 = icmp ne i32 %19, 0, !dbg !277
  br i1 %20, label %21, label %24, !dbg !278

21:                                               ; preds = %12
  %22 = call i32 (i16, i16, ptr, ...) @CFE_EVS_SendEvent(i16 noundef zeroext 1, i16 noundef zeroext 3, ptr noundef @.str.3), !dbg !279
  %23 = load i32, ptr %2, align 4, !dbg !281
  store i32 %23, ptr %1, align 4, !dbg !282
  br label %50, !dbg !282

24:                                               ; preds = %12
  %25 = call i32 @CFE_SB_ValueToMsgId(i32 noundef 2184), !dbg !283
  %26 = getelementptr inbounds %struct.CFE_SB_MsgId_t, ptr %4, i32 0, i32 0, !dbg !283
  store i32 %25, ptr %26, align 4, !dbg !283
  %27 = load i32, ptr getelementptr inbounds (%struct.HELLO_WORLD_Data_t, ptr @HELLO_WORLD_Data, i32 0, i32 4), align 4, !dbg !284
  %28 = getelementptr inbounds %struct.CFE_SB_MsgId_t, ptr %4, i32 0, i32 0, !dbg !285
  %29 = load i32, ptr %28, align 4, !dbg !285
  %30 = call i32 @CFE_SB_Subscribe(i32 %29, i32 noundef %27), !dbg !285
  store i32 %30, ptr %2, align 4, !dbg !286
  %31 = load i32, ptr %2, align 4, !dbg !287
  %32 = icmp ne i32 %31, 0, !dbg !289
  br i1 %32, label %33, label %36, !dbg !290

33:                                               ; preds = %24
  %34 = call i32 (i16, i16, ptr, ...) @CFE_EVS_SendEvent(i16 noundef zeroext 2, i16 noundef zeroext 3, ptr noundef @.str.4), !dbg !291
  %35 = load i32, ptr %2, align 4, !dbg !293
  store i32 %35, ptr %1, align 4, !dbg !294
  br label %50, !dbg !294

36:                                               ; preds = %24
  %37 = call i32 @CFE_SB_ValueToMsgId(i32 noundef 6279), !dbg !295
  %38 = getelementptr inbounds %struct.CFE_SB_MsgId_t, ptr %5, i32 0, i32 0, !dbg !295
  store i32 %37, ptr %38, align 4, !dbg !295
  %39 = load i32, ptr getelementptr inbounds (%struct.HELLO_WORLD_Data_t, ptr @HELLO_WORLD_Data, i32 0, i32 4), align 4, !dbg !296
  %40 = getelementptr inbounds %struct.CFE_SB_MsgId_t, ptr %5, i32 0, i32 0, !dbg !297
  %41 = load i32, ptr %40, align 4, !dbg !297
  %42 = call i32 @CFE_SB_Subscribe(i32 %41, i32 noundef %39), !dbg !297
  store i32 %42, ptr %2, align 4, !dbg !298
  %43 = load i32, ptr %2, align 4, !dbg !299
  %44 = icmp ne i32 %43, 0, !dbg !301
  br i1 %44, label %45, label %48, !dbg !302

45:                                               ; preds = %36
  %46 = call i32 (i16, i16, ptr, ...) @CFE_EVS_SendEvent(i16 noundef zeroext 3, i16 noundef zeroext 3, ptr noundef @.str.5), !dbg !303
  %47 = load i32, ptr %2, align 4, !dbg !305
  store i32 %47, ptr %1, align 4, !dbg !306
  br label %50, !dbg !306

48:                                               ; preds = %36
  %49 = load i32, ptr %2, align 4, !dbg !307
  store i32 %49, ptr %1, align 4, !dbg !308
  br label %50, !dbg !308

50:                                               ; preds = %48, %45, %33, %21, %9
  %51 = load i32, ptr %1, align 4, !dbg !309
  ret i32 %51, !dbg !309
}

declare zeroext i1 @CFE_ES_RunLoop(ptr noundef) #2

declare i32 @CFE_SB_ReceiveBuffer(ptr noundef, i32 noundef, i32 noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define void @HELLO_WORLD_TaskPipe(ptr noundef %0) #0 !dbg !310 {
  %2 = alloca ptr, align 8
  %3 = alloca %struct.CFE_SB_MsgId_t, align 4
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !315, metadata !DIExpression()), !dbg !316
  call void @llvm.dbg.declare(metadata ptr %3, metadata !317, metadata !DIExpression()), !dbg !323
  call void @llvm.memset.p0.i64(ptr align 4 %3, i8 0, i64 4, i1 false), !dbg !323
  %4 = load ptr, ptr %2, align 8, !dbg !324
  %5 = call i32 @CFE_MSG_GetMsgId(ptr noundef %4, ptr noundef %3), !dbg !325
  %6 = getelementptr inbounds %struct.CFE_SB_MsgId_t, ptr %3, i32 0, i32 0, !dbg !326
  %7 = load i32, ptr %6, align 4, !dbg !326
  %8 = call i32 @CFE_SB_MsgIdToValue(i32 %7), !dbg !326
  switch i32 %8, label %14 [
    i32 6279, label %9
    i32 2184, label %11
  ], !dbg !327

9:                                                ; preds = %1
  %10 = load ptr, ptr %2, align 8, !dbg !328
  call void @HELLO_WORLD_ProcessGroundCommand(ptr noundef %10), !dbg !330
  br label %19, !dbg !331

11:                                               ; preds = %1
  %12 = load ptr, ptr %2, align 8, !dbg !332
  %13 = call i32 @HELLO_WORLD_SendHkCmd(ptr noundef %12), !dbg !333
  br label %19, !dbg !334

14:                                               ; preds = %1
  %15 = getelementptr inbounds %struct.CFE_SB_MsgId_t, ptr %3, i32 0, i32 0, !dbg !335
  %16 = load i32, ptr %15, align 4, !dbg !335
  %17 = call i32 @CFE_SB_MsgIdToValue(i32 %16), !dbg !335
  %18 = call i32 (i16, i16, ptr, ...) @CFE_EVS_SendEvent(i16 noundef zeroext 4, i16 noundef zeroext 3, ptr noundef @.str.6, i32 noundef %17), !dbg !336
  br label %19, !dbg !337

19:                                               ; preds = %14, %11, %9
  ret void, !dbg !338
}

declare i32 @CFE_EVS_SendEvent(i16 noundef zeroext, i16 noundef zeroext, ptr noundef, ...) #2

declare void @CFE_ES_ExitApp(i32 noundef) #2

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #3

declare i32 @CFE_EVS_Register(ptr noundef, i16 noundef zeroext, i16 noundef zeroext) #2

declare i32 @CFE_ES_WriteToSysLog(ptr noundef, ...) #2

declare i32 @CFE_MSG_Init(ptr noundef, i32, i64 noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @CFE_SB_ValueToMsgId(i32 noundef %0) #0 !dbg !339 {
  %2 = alloca %struct.CFE_SB_MsgId_t, align 4
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  call void @llvm.dbg.declare(metadata ptr %3, metadata !343, metadata !DIExpression()), !dbg !344
  call void @llvm.dbg.declare(metadata ptr %2, metadata !345, metadata !DIExpression()), !dbg !346
  %4 = getelementptr inbounds %struct.CFE_SB_MsgId_t, ptr %2, i32 0, i32 0, !dbg !347
  %5 = load i32, ptr %3, align 4, !dbg !347
  store i32 %5, ptr %4, align 4, !dbg !347
  %6 = getelementptr inbounds %struct.CFE_SB_MsgId_t, ptr %2, i32 0, i32 0, !dbg !348
  %7 = load i32, ptr %6, align 4, !dbg !348
  ret i32 %7, !dbg !348
}

declare i32 @CFE_SB_CreatePipe(ptr noundef, i16 noundef zeroext, ptr noundef) #2

declare i32 @CFE_SB_Subscribe(i32, i32 noundef) #2

declare i32 @CFE_MSG_GetMsgId(ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @CFE_SB_MsgIdToValue(i32 %0) #0 !dbg !349 {
  %2 = alloca %struct.CFE_SB_MsgId_t, align 4
  %3 = getelementptr inbounds %struct.CFE_SB_MsgId_t, ptr %2, i32 0, i32 0
  store i32 %0, ptr %3, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !352, metadata !DIExpression()), !dbg !353
  %4 = getelementptr inbounds %struct.CFE_SB_MsgId_t, ptr %2, i32 0, i32 0, !dbg !354
  %5 = load i32, ptr %4, align 4, !dbg !354
  ret i32 %5, !dbg !355
}

; Function Attrs: noinline nounwind optnone uwtable
define void @HELLO_WORLD_ProcessGroundCommand(ptr noundef %0) #0 !dbg !356 {
  %2 = alloca ptr, align 8
  %3 = alloca i16, align 2
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !357, metadata !DIExpression()), !dbg !358
  call void @llvm.dbg.declare(metadata ptr %3, metadata !359, metadata !DIExpression()), !dbg !365
  store i16 0, ptr %3, align 2, !dbg !365
  %4 = load ptr, ptr %2, align 8, !dbg !366
  %5 = call i32 @CFE_MSG_GetFcnCode(ptr noundef %4, ptr noundef %3), !dbg !367
  %6 = load i16, ptr %3, align 2, !dbg !368
  %7 = zext i16 %6 to i32, !dbg !368
  switch i32 %7, label %11 [
    i32 0, label %8
  ], !dbg !369

8:                                                ; preds = %1
  %9 = load ptr, ptr %2, align 8, !dbg !370
  %10 = call i32 @HELLO_WORLD_EchoCmd(ptr noundef %9), !dbg !372
  br label %15, !dbg !373

11:                                               ; preds = %1
  %12 = load i16, ptr %3, align 2, !dbg !374
  %13 = zext i16 %12 to i32, !dbg !374
  %14 = call i32 (i16, i16, ptr, ...) @CFE_EVS_SendEvent(i16 noundef zeroext 7, i16 noundef zeroext 3, ptr noundef @.str.7, i32 noundef %13), !dbg !375
  br label %15, !dbg !376

15:                                               ; preds = %11, %8
  ret void, !dbg !377
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @HELLO_WORLD_SendHkCmd(ptr noundef %0) #0 !dbg !378 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !381, metadata !DIExpression()), !dbg !382
  %3 = load i8, ptr getelementptr inbounds (%struct.HELLO_WORLD_Data_t, ptr @HELLO_WORLD_Data, i32 0, i32 1), align 1, !dbg !383
  store i8 %3, ptr getelementptr inbounds (%struct.HELLO_WORLD_Data_t, ptr @HELLO_WORLD_Data, i32 0, i32 2, i32 1), align 2, !dbg !384
  %4 = load i8, ptr @HELLO_WORLD_Data, align 4, !dbg !385
  store i8 %4, ptr getelementptr inbounds (%struct.HELLO_WORLD_Data_t, ptr @HELLO_WORLD_Data, i32 0, i32 2, i32 1, i32 1), align 1, !dbg !386
  call void @CFE_SB_TimeStampMsg(ptr noundef getelementptr inbounds (%struct.HELLO_WORLD_Data_t, ptr @HELLO_WORLD_Data, i32 0, i32 2)), !dbg !387
  %5 = call i32 @CFE_SB_TransmitMsg(ptr noundef getelementptr inbounds (%struct.HELLO_WORLD_Data_t, ptr @HELLO_WORLD_Data, i32 0, i32 2), i1 noundef zeroext true), !dbg !388
  ret i32 0, !dbg !389
}

declare void @CFE_SB_TimeStampMsg(ptr noundef) #2

declare i32 @CFE_SB_TransmitMsg(ptr noundef, i1 noundef zeroext) #2

declare i32 @CFE_MSG_GetFcnCode(ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @HELLO_WORLD_EchoCmd(ptr noundef %0) #0 !dbg !390 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca %struct.SAMPLE_EchoTlm_t, align 1
  %5 = alloca %struct.CFE_SB_MsgId_t, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !393, metadata !DIExpression()), !dbg !394
  %6 = load ptr, ptr %3, align 8, !dbg !395
  %7 = getelementptr inbounds %struct.SAMPLE_EchoCmd_t, ptr %6, i32 0, i32 1, !dbg !396
  %8 = getelementptr inbounds [64 x i8], ptr %7, i64 0, i64 0, !dbg !395
  %9 = call i32 (i16, i16, ptr, ...) @CFE_EVS_SendEvent(i16 noundef zeroext 6, i16 noundef zeroext 2, ptr noundef @.str.8, ptr noundef %8), !dbg !397
  call void @llvm.dbg.declare(metadata ptr %4, metadata !398, metadata !DIExpression()), !dbg !404
  %10 = call i32 @CFE_SB_ValueToMsgId(i32 noundef 2192), !dbg !405
  %11 = getelementptr inbounds %struct.CFE_SB_MsgId_t, ptr %5, i32 0, i32 0, !dbg !405
  store i32 %10, ptr %11, align 4, !dbg !405
  %12 = getelementptr inbounds %struct.CFE_SB_MsgId_t, ptr %5, i32 0, i32 0, !dbg !407
  %13 = load i32, ptr %12, align 4, !dbg !407
  %14 = call i32 @CFE_MSG_Init(ptr noundef %4, i32 %13, i64 noundef 80), !dbg !407
  %15 = icmp ne i32 %14, 0, !dbg !408
  br i1 %15, label %16, label %18, !dbg !409

16:                                               ; preds = %1
  %17 = call i32 (i16, i16, ptr, ...) @CFE_EVS_SendEvent(i16 noundef zeroext 5, i16 noundef zeroext 3, ptr noundef @.str.9), !dbg !410
  store i32 -939524091, ptr %2, align 4, !dbg !412
  br label %33, !dbg !412

18:                                               ; preds = %1
  %19 = getelementptr inbounds %struct.SAMPLE_EchoTlm_t, ptr %4, i32 0, i32 1, !dbg !413
  %20 = getelementptr inbounds [64 x i8], ptr %19, i64 0, i64 0, !dbg !414
  %21 = load ptr, ptr %3, align 8, !dbg !415
  %22 = getelementptr inbounds %struct.SAMPLE_EchoCmd_t, ptr %21, i32 0, i32 1, !dbg !416
  %23 = getelementptr inbounds [64 x i8], ptr %22, i64 0, i64 0, !dbg !415
  %24 = call ptr @strncpy(ptr noundef %20, ptr noundef %23, i64 noundef 64) #5, !dbg !417
  %25 = call i32 @CFE_SB_TransmitMsg(ptr noundef %4, i1 noundef zeroext true), !dbg !418
  %26 = icmp ne i32 %25, 0, !dbg !420
  br i1 %26, label %27, label %29, !dbg !421

27:                                               ; preds = %18
  %28 = call i32 (i16, i16, ptr, ...) @CFE_EVS_SendEvent(i16 noundef zeroext 5, i16 noundef zeroext 3, ptr noundef @.str.10), !dbg !422
  store i32 -939524091, ptr %2, align 4, !dbg !424
  br label %33, !dbg !424

29:                                               ; preds = %18
  %30 = getelementptr inbounds %struct.SAMPLE_EchoTlm_t, ptr %4, i32 0, i32 1, !dbg !425
  %31 = getelementptr inbounds [64 x i8], ptr %30, i64 0, i64 0, !dbg !426
  %32 = call i32 (i16, i16, ptr, ...) @CFE_EVS_SendEvent(i16 noundef zeroext 6, i16 noundef zeroext 2, ptr noundef @.str.11, ptr noundef %31, i64 noundef 64), !dbg !427
  store i32 0, ptr %2, align 4, !dbg !428
  br label %33, !dbg !428

33:                                               ; preds = %29, %27, %16
  %34 = load i32, ptr %2, align 4, !dbg !429
  ret i32 %34, !dbg !429
}

; Function Attrs: nounwind
declare ptr @strncpy(ptr noundef, ptr noundef, i64 noundef) #4

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #4 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!197, !198, !199, !200, !201, !202}
!llvm.ident = !{!203}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "HELLO_WORLD_Data", scope: !2, file: !98, line: 5, type: !155, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !30, globals: !95, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "/home/soyeonb/cFS/apps/hello_world/fsw/src/hello_world.c", directory: "/home/soyeonb/cFS/build/native/default_cpu1/apps/hello_world", checksumkind: CSK_MD5, checksum: "985ec87d0e98618312d493308a44ca57")
!4 = !{!5, !20, !27}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "CFE_ES_RunStatus", file: !6, line: 109, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "cfe/modules/es/config/default_cfe_es_extern_typedefs.h", directory: "/home/soyeonb/cFS", checksumkind: CSK_MD5, checksum: "8ccd73c5185d6cb123019047e122c7c9")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19}
!9 = !DIEnumerator(name: "CFE_ES_RunStatus_UNDEFINED", value: 0)
!10 = !DIEnumerator(name: "CFE_ES_RunStatus_APP_RUN", value: 1)
!11 = !DIEnumerator(name: "CFE_ES_RunStatus_APP_EXIT", value: 2)
!12 = !DIEnumerator(name: "CFE_ES_RunStatus_APP_ERROR", value: 3)
!13 = !DIEnumerator(name: "CFE_ES_RunStatus_SYS_EXCEPTION", value: 4)
!14 = !DIEnumerator(name: "CFE_ES_RunStatus_SYS_RESTART", value: 5)
!15 = !DIEnumerator(name: "CFE_ES_RunStatus_SYS_RELOAD", value: 6)
!16 = !DIEnumerator(name: "CFE_ES_RunStatus_SYS_DELETE", value: 7)
!17 = !DIEnumerator(name: "CFE_ES_RunStatus_CORE_APP_INIT_ERROR", value: 8)
!18 = !DIEnumerator(name: "CFE_ES_RunStatus_CORE_APP_RUNTIME_ERROR", value: 9)
!19 = !DIEnumerator(name: "CFE_ES_RunStatus_MAX", value: 10)
!20 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "CFE_EVS_EventType", file: !21, line: 79, baseType: !7, size: 32, elements: !22)
!21 = !DIFile(filename: "cfe/modules/evs/config/default_cfe_evs_extern_typedefs.h", directory: "/home/soyeonb/cFS", checksumkind: CSK_MD5, checksum: "14c4fe2f60318e2a0f7bf7f9d685c6bc")
!22 = !{!23, !24, !25, !26}
!23 = !DIEnumerator(name: "CFE_EVS_EventType_DEBUG", value: 1)
!24 = !DIEnumerator(name: "CFE_EVS_EventType_INFORMATION", value: 2)
!25 = !DIEnumerator(name: "CFE_EVS_EventType_ERROR", value: 3)
!26 = !DIEnumerator(name: "CFE_EVS_EventType_CRITICAL", value: 4)
!27 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "CFE_EVS_EventFilter", file: !21, line: 112, baseType: !7, size: 32, elements: !28)
!28 = !{!29}
!29 = !DIEnumerator(name: "CFE_EVS_EventFilter_BINARY", value: 0)
!30 = !{!31, !40, !7, !83, !94}
!31 = !DIDerivedType(tag: DW_TAG_typedef, name: "CFE_Status_t", file: !32, line: 43, baseType: !33)
!32 = !DIFile(filename: "cfe/modules/core_api/fsw/inc/cfe_error.h", directory: "/home/soyeonb/cFS", checksumkind: CSK_MD5, checksum: "826cf0fb6a6e7aee47f231c1b9aae4c8")
!33 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32", file: !34, line: 81, baseType: !35)
!34 = !DIFile(filename: "osal/src/os/inc/common_types.h", directory: "/home/soyeonb/cFS", checksumkind: CSK_MD5, checksum: "703ba6d9d026d9089fc7c3200b84ef6b")
!35 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !36, line: 26, baseType: !37)
!36 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h", directory: "", checksumkind: CSK_MD5, checksum: "649b383a60bfa3eb90e85840b2b0be20")
!37 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !38, line: 41, baseType: !39)
!38 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "e1865d9fe29fe1b5ced550b7ba458f9e")
!39 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!40 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !41, size: 64)
!41 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !42)
!42 = !DIDerivedType(tag: DW_TAG_typedef, name: "HELLO_WORLD_SendHkCmd_t", file: !43, line: 48, baseType: !44)
!43 = !DIFile(filename: "apps/hello_world/fsw/src/hello_world.h", directory: "/home/soyeonb/cFS", checksumkind: CSK_MD5, checksum: "ae71237b95a954d9e0634758da8d11d6")
!44 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !43, line: 45, size: 64, elements: !45)
!45 = !{!46}
!46 = !DIDerivedType(tag: DW_TAG_member, name: "CommandHeader", scope: !44, file: !43, line: 47, baseType: !47, size: 64)
!47 = !DIDerivedType(tag: DW_TAG_typedef, name: "CFE_MSG_CommandHeader_t", file: !48, line: 107, baseType: !49)
!48 = !DIFile(filename: "cfe/modules/core_api/fsw/inc/cfe_msg_api_typedefs.h", directory: "/home/soyeonb/cFS", checksumkind: CSK_MD5, checksum: "ef3ad04e520287e8eb2571aea871718e")
!49 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "CFE_MSG_CommandHeader", file: !50, line: 102, size: 64, elements: !51)
!50 = !DIFile(filename: "cfe/modules/msg/option_inc/default_cfe_msg_hdr_pri.h", directory: "/home/soyeonb/cFS", checksumkind: CSK_MD5, checksum: "d39a3113bb2e71c2653000f43c4cb213")
!51 = !{!52, !76}
!52 = !DIDerivedType(tag: DW_TAG_member, name: "Msg", scope: !49, file: !50, line: 104, baseType: !53, size: 48)
!53 = !DIDerivedType(tag: DW_TAG_typedef, name: "CFE_MSG_Message_t", file: !48, line: 102, baseType: !54)
!54 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "CFE_MSG_Message", file: !50, line: 92, size: 48, elements: !55)
!55 = !{!56}
!56 = !DIDerivedType(tag: DW_TAG_member, name: "CCSDS", scope: !54, file: !50, line: 94, baseType: !57, size: 48)
!57 = !DIDerivedType(tag: DW_TAG_typedef, name: "CCSDS_SpacePacket_t", file: !50, line: 85, baseType: !58)
!58 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !50, line: 82, size: 48, elements: !59)
!59 = !{!60}
!60 = !DIDerivedType(tag: DW_TAG_member, name: "Pri", scope: !58, file: !50, line: 84, baseType: !61, size: 48)
!61 = !DIDerivedType(tag: DW_TAG_typedef, name: "CCSDS_PrimaryHeader_t", file: !62, line: 68, baseType: !63)
!62 = !DIFile(filename: "cfe/modules/msg/fsw/inc/ccsds_hdr.h", directory: "/home/soyeonb/cFS", checksumkind: CSK_MD5, checksum: "a79291b01688cae3bbc6b62df111eda6")
!63 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "CCSDS_PrimaryHeader", file: !62, line: 51, size: 48, elements: !64)
!64 = !{!65, !74, !75}
!65 = !DIDerivedType(tag: DW_TAG_member, name: "StreamId", scope: !63, file: !62, line: 53, baseType: !66, size: 16)
!66 = !DICompositeType(tag: DW_TAG_array_type, baseType: !67, size: 16, elements: !72)
!67 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8", file: !34, line: 83, baseType: !68)
!68 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !69, line: 24, baseType: !70)
!69 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "256fcabbefa27ca8cf5e6d37525e6e16")
!70 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !38, line: 38, baseType: !71)
!71 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!72 = !{!73}
!73 = !DISubrange(count: 2)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "Sequence", scope: !63, file: !62, line: 60, baseType: !66, size: 16, offset: 16)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "Length", scope: !63, file: !62, line: 65, baseType: !66, size: 16, offset: 32)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "Sec", scope: !49, file: !50, line: 105, baseType: !77, size: 16, offset: 48)
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "CFE_MSG_CommandSecondaryHeader_t", file: !78, line: 68, baseType: !79)
!78 = !DIFile(filename: "cfe/modules/msg/option_inc/default_cfe_msg_sechdr.h", directory: "/home/soyeonb/cFS", checksumkind: CSK_MD5, checksum: "88b4230d969f192cc7e3125b51cb65c2")
!79 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !78, line: 60, size: 16, elements: !80)
!80 = !{!81, !82}
!81 = !DIDerivedType(tag: DW_TAG_member, name: "FunctionCode", scope: !79, file: !78, line: 62, baseType: !67, size: 8)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "Checksum", scope: !79, file: !78, line: 67, baseType: !67, size: 8, offset: 8)
!83 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !84, size: 64)
!84 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !85)
!85 = !DIDerivedType(tag: DW_TAG_typedef, name: "SAMPLE_EchoCmd_t", file: !43, line: 56, baseType: !86)
!86 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !43, line: 52, size: 576, elements: !87)
!87 = !{!88, !89}
!88 = !DIDerivedType(tag: DW_TAG_member, name: "CmdHeader", scope: !86, file: !43, line: 54, baseType: !47, size: 64)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "MsgContent", scope: !86, file: !43, line: 55, baseType: !90, size: 512, offset: 64)
!90 = !DICompositeType(tag: DW_TAG_array_type, baseType: !91, size: 512, elements: !92)
!91 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!92 = !{!93}
!93 = !DISubrange(count: 64)
!94 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!95 = !{!96, !103, !108, !113, !118, !123, !128, !133, !138, !143, !148, !150, !0}
!96 = !DIGlobalVariableExpression(var: !97, expr: !DIExpression())
!97 = distinct !DIGlobalVariable(scope: null, file: !98, line: 30, type: !99, isLocal: true, isDefinition: true)
!98 = !DIFile(filename: "apps/hello_world/fsw/src/hello_world.c", directory: "/home/soyeonb/cFS", checksumkind: CSK_MD5, checksum: "985ec87d0e98618312d493308a44ca57")
!99 = !DICompositeType(tag: DW_TAG_array_type, baseType: !100, size: 256, elements: !101)
!100 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !91)
!101 = !{!102}
!102 = !DISubrange(count: 32)
!103 = !DIGlobalVariableExpression(var: !104, expr: !DIExpression())
!104 = distinct !DIGlobalVariable(scope: null, file: !98, line: 53, type: !105, isLocal: true, isDefinition: true)
!105 = !DICompositeType(tag: DW_TAG_array_type, baseType: !100, size: 304, elements: !106)
!106 = !{!107}
!107 = !DISubrange(count: 38)
!108 = !DIGlobalVariableExpression(var: !109, expr: !DIExpression())
!109 = distinct !DIGlobalVariable(scope: null, file: !98, line: 62, type: !110, isLocal: true, isDefinition: true)
!110 = !DICompositeType(tag: DW_TAG_array_type, baseType: !100, size: 96, elements: !111)
!111 = !{!112}
!112 = !DISubrange(count: 12)
!113 = !DIGlobalVariableExpression(var: !114, expr: !DIExpression())
!114 = distinct !DIGlobalVariable(scope: null, file: !98, line: 65, type: !115, isLocal: true, isDefinition: true)
!115 = !DICompositeType(tag: DW_TAG_array_type, baseType: !100, size: 352, elements: !116)
!116 = !{!117}
!117 = !DISubrange(count: 44)
!118 = !DIGlobalVariableExpression(var: !119, expr: !DIExpression())
!119 = distinct !DIGlobalVariable(scope: null, file: !98, line: 73, type: !120, isLocal: true, isDefinition: true)
!120 = !DICompositeType(tag: DW_TAG_array_type, baseType: !100, size: 368, elements: !121)
!121 = !{!122}
!122 = !DISubrange(count: 46)
!123 = !DIGlobalVariableExpression(var: !124, expr: !DIExpression())
!124 = distinct !DIGlobalVariable(scope: null, file: !98, line: 81, type: !125, isLocal: true, isDefinition: true)
!125 = !DICompositeType(tag: DW_TAG_array_type, baseType: !100, size: 400, elements: !126)
!126 = !{!127}
!127 = !DISubrange(count: 50)
!128 = !DIGlobalVariableExpression(var: !129, expr: !DIExpression())
!129 = distinct !DIGlobalVariable(scope: null, file: !98, line: 107, type: !130, isLocal: true, isDefinition: true)
!130 = !DICompositeType(tag: DW_TAG_array_type, baseType: !100, size: 336, elements: !131)
!131 = !{!132}
!132 = !DISubrange(count: 42)
!133 = !DIGlobalVariableExpression(var: !134, expr: !DIExpression())
!134 = distinct !DIGlobalVariable(scope: null, file: !98, line: 147, type: !135, isLocal: true, isDefinition: true)
!135 = !DICompositeType(tag: DW_TAG_array_type, baseType: !100, size: 296, elements: !136)
!136 = !{!137}
!137 = !DISubrange(count: 37)
!138 = !DIGlobalVariableExpression(var: !139, expr: !DIExpression())
!139 = distinct !DIGlobalVariable(scope: null, file: !98, line: 159, type: !140, isLocal: true, isDefinition: true)
!140 = !DICompositeType(tag: DW_TAG_array_type, baseType: !100, size: 264, elements: !141)
!141 = !{!142}
!142 = !DISubrange(count: 33)
!143 = !DIGlobalVariableExpression(var: !144, expr: !DIExpression())
!144 = distinct !DIGlobalVariable(scope: null, file: !98, line: 171, type: !145, isLocal: true, isDefinition: true)
!145 = !DICompositeType(tag: DW_TAG_array_type, baseType: !100, size: 384, elements: !146)
!146 = !{!147}
!147 = !DISubrange(count: 48)
!148 = !DIGlobalVariableExpression(var: !149, expr: !DIExpression())
!149 = distinct !DIGlobalVariable(scope: null, file: !98, line: 183, type: !115, isLocal: true, isDefinition: true)
!150 = !DIGlobalVariableExpression(var: !151, expr: !DIExpression())
!151 = distinct !DIGlobalVariable(scope: null, file: !98, line: 189, type: !152, isLocal: true, isDefinition: true)
!152 = !DICompositeType(tag: DW_TAG_array_type, baseType: !100, size: 320, elements: !153)
!153 = !{!154}
!154 = !DISubrange(count: 40)
!155 = !DIDerivedType(tag: DW_TAG_typedef, name: "HELLO_WORLD_Data_t", file: !43, line: 43, baseType: !156)
!156 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !43, line: 33, size: 256, elements: !157)
!157 = !{!158, !159, !160, !188, !192}
!158 = !DIDerivedType(tag: DW_TAG_member, name: "CmdCounter", scope: !156, file: !43, line: 35, baseType: !67, size: 8)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "ErrCounter", scope: !156, file: !43, line: 36, baseType: !67, size: 8, offset: 8)
!160 = !DIDerivedType(tag: DW_TAG_member, name: "HkTlm", scope: !156, file: !43, line: 38, baseType: !161, size: 160, offset: 16)
!161 = !DIDerivedType(tag: DW_TAG_typedef, name: "HELLO_WORLD_HkTlm_t", file: !43, line: 29, baseType: !162)
!162 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !43, line: 25, size: 160, elements: !163)
!163 = !{!164, !181}
!164 = !DIDerivedType(tag: DW_TAG_member, name: "TelemetryHeader", scope: !162, file: !43, line: 27, baseType: !165, size: 128)
!165 = !DIDerivedType(tag: DW_TAG_typedef, name: "CFE_MSG_TelemetryHeader_t", file: !48, line: 112, baseType: !166)
!166 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "CFE_MSG_TelemetryHeader", file: !50, line: 113, size: 128, elements: !167)
!167 = !{!168, !169, !177}
!168 = !DIDerivedType(tag: DW_TAG_member, name: "Msg", scope: !166, file: !50, line: 115, baseType: !53, size: 48)
!169 = !DIDerivedType(tag: DW_TAG_member, name: "Sec", scope: !166, file: !50, line: 116, baseType: !170, size: 48, offset: 48)
!170 = !DIDerivedType(tag: DW_TAG_typedef, name: "CFE_MSG_TelemetrySecondaryHeader_t", file: !78, line: 76, baseType: !171)
!171 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !78, line: 73, size: 48, elements: !172)
!172 = !{!173}
!173 = !DIDerivedType(tag: DW_TAG_member, name: "Time", scope: !171, file: !78, line: 75, baseType: !174, size: 48)
!174 = !DICompositeType(tag: DW_TAG_array_type, baseType: !67, size: 48, elements: !175)
!175 = !{!176}
!176 = !DISubrange(count: 6)
!177 = !DIDerivedType(tag: DW_TAG_member, name: "Spare", scope: !166, file: !50, line: 117, baseType: !178, size: 32, offset: 96)
!178 = !DICompositeType(tag: DW_TAG_array_type, baseType: !67, size: 32, elements: !179)
!179 = !{!180}
!180 = !DISubrange(count: 4)
!181 = !DIDerivedType(tag: DW_TAG_member, name: "Payload", scope: !162, file: !43, line: 28, baseType: !182, size: 32, offset: 128)
!182 = !DIDerivedType(tag: DW_TAG_typedef, name: "HELLO_WORLD_HkTlm_Payload_t", file: !43, line: 23, baseType: !183)
!183 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !43, line: 18, size: 32, elements: !184)
!184 = !{!185, !186, !187}
!185 = !DIDerivedType(tag: DW_TAG_member, name: "CommandErrorCounter", scope: !183, file: !43, line: 20, baseType: !67, size: 8)
!186 = !DIDerivedType(tag: DW_TAG_member, name: "CommandCounter", scope: !183, file: !43, line: 21, baseType: !67, size: 8, offset: 8)
!187 = !DIDerivedType(tag: DW_TAG_member, name: "spare", scope: !183, file: !43, line: 22, baseType: !66, size: 16, offset: 16)
!188 = !DIDerivedType(tag: DW_TAG_member, name: "RunStatus", scope: !156, file: !43, line: 40, baseType: !189, size: 32, offset: 192)
!189 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32", file: !34, line: 85, baseType: !190)
!190 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !69, line: 26, baseType: !191)
!191 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !38, line: 42, baseType: !7)
!192 = !DIDerivedType(tag: DW_TAG_member, name: "CommandPipe", scope: !156, file: !43, line: 42, baseType: !193, size: 32, offset: 224)
!193 = !DIDerivedType(tag: DW_TAG_typedef, name: "CFE_SB_PipeId_t", file: !194, line: 114, baseType: !195)
!194 = !DIFile(filename: "cfe/modules/sb/config/default_cfe_sb_extern_typedefs.h", directory: "/home/soyeonb/cFS", checksumkind: CSK_MD5, checksum: "7baa1cb96ee199161c00f9baabdb2b03")
!195 = !DIDerivedType(tag: DW_TAG_typedef, name: "CFE_ResourceId_t", file: !196, line: 37, baseType: !189)
!196 = !DIFile(filename: "cfe/modules/resourceid/option_inc/cfe_resourceid_simple.h", directory: "/home/soyeonb/cFS", checksumkind: CSK_MD5, checksum: "80321be5f944ef7ffb01e60b8bcb746a")
!197 = !{i32 7, !"Dwarf Version", i32 5}
!198 = !{i32 2, !"Debug Info Version", i32 3}
!199 = !{i32 1, !"wchar_size", i32 4}
!200 = !{i32 8, !"PIC Level", i32 2}
!201 = !{i32 7, !"uwtable", i32 2}
!202 = !{i32 7, !"frame-pointer", i32 2}
!203 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!204 = distinct !DISubprogram(name: "HELLO_WORLD_Main", scope: !98, file: !98, line: 7, type: !205, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !207)
!205 = !DISubroutineType(types: !206)
!206 = !{null}
!207 = !{}
!208 = !DILocalVariable(name: "status", scope: !204, file: !98, line: 9, type: !31)
!209 = !DILocation(line: 9, column: 18, scope: !204)
!210 = !DILocalVariable(name: "SBBufPtr", scope: !204, file: !98, line: 10, type: !211)
!211 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !212, size: 64)
!212 = !DIDerivedType(tag: DW_TAG_typedef, name: "CFE_SB_Buffer_t", file: !213, line: 147, baseType: !214)
!213 = !DIFile(filename: "cfe/modules/core_api/fsw/inc/cfe_sb_api_typedefs.h", directory: "/home/soyeonb/cFS", checksumkind: CSK_MD5, checksum: "abf94b5c2da5520431f9253a37f482a0")
!214 = distinct !DICompositeType(tag: DW_TAG_union_type, name: "CFE_SB_Msg", file: !213, line: 142, size: 128, elements: !215)
!215 = !{!216, !217, !219}
!216 = !DIDerivedType(tag: DW_TAG_member, name: "Msg", scope: !214, file: !213, line: 144, baseType: !53, size: 48)
!217 = !DIDerivedType(tag: DW_TAG_member, name: "LongInt", scope: !214, file: !213, line: 145, baseType: !218, size: 64)
!218 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!219 = !DIDerivedType(tag: DW_TAG_member, name: "LongDouble", scope: !214, file: !213, line: 146, baseType: !220, size: 128)
!220 = !DIBasicType(name: "long double", size: 128, encoding: DW_ATE_float)
!221 = !DILocation(line: 10, column: 22, scope: !204)
!222 = !DILocation(line: 13, column: 11, scope: !204)
!223 = !DILocation(line: 13, column: 9, scope: !204)
!224 = !DILocation(line: 14, column: 6, scope: !225)
!225 = distinct !DILexicalBlock(scope: !204, file: !98, line: 14, column: 6)
!226 = !DILocation(line: 14, column: 13, scope: !225)
!227 = !DILocation(line: 14, column: 6, scope: !204)
!228 = !DILocation(line: 16, column: 30, scope: !229)
!229 = distinct !DILexicalBlock(scope: !225, file: !98, line: 15, column: 2)
!230 = !DILocation(line: 17, column: 2, scope: !229)
!231 = !DILocation(line: 19, column: 2, scope: !204)
!232 = !DILocation(line: 19, column: 9, scope: !204)
!233 = !DILocation(line: 19, column: 53, scope: !204)
!234 = !DILocation(line: 22, column: 61, scope: !235)
!235 = distinct !DILexicalBlock(scope: !204, file: !98, line: 20, column: 2)
!236 = !DILocation(line: 22, column: 12, scope: !235)
!237 = !DILocation(line: 22, column: 10, scope: !235)
!238 = !DILocation(line: 24, column: 10, scope: !239)
!239 = distinct !DILexicalBlock(scope: !235, file: !98, line: 24, column: 10)
!240 = !DILocation(line: 24, column: 17, scope: !239)
!241 = !DILocation(line: 24, column: 10, scope: !235)
!242 = !DILocation(line: 26, column: 25, scope: !243)
!243 = distinct !DILexicalBlock(scope: !239, file: !98, line: 25, column: 6)
!244 = !DILocation(line: 26, column: 4, scope: !243)
!245 = !DILocation(line: 27, column: 3, scope: !243)
!246 = !DILocation(line: 30, column: 4, scope: !247)
!247 = distinct !DILexicalBlock(scope: !239, file: !98, line: 29, column: 3)
!248 = !DILocation(line: 32, column: 34, scope: !247)
!249 = distinct !{!249, !231, !250}
!250 = !DILocation(line: 34, column: 2, scope: !204)
!251 = !DILocation(line: 36, column: 37, scope: !204)
!252 = !DILocation(line: 36, column: 5, scope: !204)
!253 = !DILocation(line: 37, column: 1, scope: !204)
!254 = distinct !DISubprogram(name: "HELLO_WORLD_Init", scope: !98, file: !98, line: 40, type: !255, scopeLine: 41, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !207)
!255 = !DISubroutineType(types: !256)
!256 = !{!31}
!257 = !DILocalVariable(name: "status", scope: !254, file: !98, line: 42, type: !31)
!258 = !DILocation(line: 42, column: 15, scope: !254)
!259 = !DILocation(line: 45, column: 2, scope: !254)
!260 = !DILocation(line: 47, column: 32, scope: !254)
!261 = !DILocation(line: 50, column: 11, scope: !254)
!262 = !DILocation(line: 50, column: 9, scope: !254)
!263 = !DILocation(line: 51, column: 9, scope: !264)
!264 = distinct !DILexicalBlock(scope: !254, file: !98, line: 51, column: 9)
!265 = !DILocation(line: 51, column: 16, scope: !264)
!266 = !DILocation(line: 51, column: 9, scope: !254)
!267 = !DILocation(line: 53, column: 3, scope: !268)
!268 = distinct !DILexicalBlock(scope: !264, file: !98, line: 52, column: 2)
!269 = !DILocation(line: 54, column: 13, scope: !268)
!270 = !DILocation(line: 54, column: 6, scope: !268)
!271 = !DILocation(line: 58, column: 68, scope: !254)
!272 = !DILocation(line: 58, column: 2, scope: !254)
!273 = !DILocation(line: 62, column: 11, scope: !254)
!274 = !DILocation(line: 62, column: 9, scope: !254)
!275 = !DILocation(line: 63, column: 6, scope: !276)
!276 = distinct !DILexicalBlock(scope: !254, file: !98, line: 63, column: 6)
!277 = !DILocation(line: 63, column: 13, scope: !276)
!278 = !DILocation(line: 63, column: 6, scope: !254)
!279 = !DILocation(line: 65, column: 5, scope: !280)
!280 = distinct !DILexicalBlock(scope: !276, file: !98, line: 64, column: 2)
!281 = !DILocation(line: 66, column: 12, scope: !280)
!282 = !DILocation(line: 66, column: 5, scope: !280)
!283 = !DILocation(line: 70, column: 31, scope: !254)
!284 = !DILocation(line: 70, column: 94, scope: !254)
!285 = !DILocation(line: 70, column: 14, scope: !254)
!286 = !DILocation(line: 70, column: 12, scope: !254)
!287 = !DILocation(line: 71, column: 6, scope: !288)
!288 = distinct !DILexicalBlock(scope: !254, file: !98, line: 71, column: 6)
!289 = !DILocation(line: 71, column: 13, scope: !288)
!290 = !DILocation(line: 71, column: 6, scope: !254)
!291 = !DILocation(line: 73, column: 5, scope: !292)
!292 = distinct !DILexicalBlock(scope: !288, file: !98, line: 72, column: 2)
!293 = !DILocation(line: 74, column: 12, scope: !292)
!294 = !DILocation(line: 74, column: 5, scope: !292)
!295 = !DILocation(line: 78, column: 31, scope: !254)
!296 = !DILocation(line: 78, column: 90, scope: !254)
!297 = !DILocation(line: 78, column: 14, scope: !254)
!298 = !DILocation(line: 78, column: 12, scope: !254)
!299 = !DILocation(line: 79, column: 6, scope: !300)
!300 = distinct !DILexicalBlock(scope: !254, file: !98, line: 79, column: 6)
!301 = !DILocation(line: 79, column: 13, scope: !300)
!302 = !DILocation(line: 79, column: 6, scope: !254)
!303 = !DILocation(line: 81, column: 5, scope: !304)
!304 = distinct !DILexicalBlock(scope: !300, file: !98, line: 80, column: 2)
!305 = !DILocation(line: 82, column: 12, scope: !304)
!306 = !DILocation(line: 82, column: 5, scope: !304)
!307 = !DILocation(line: 85, column: 9, scope: !254)
!308 = !DILocation(line: 85, column: 2, scope: !254)
!309 = !DILocation(line: 87, column: 1, scope: !254)
!310 = distinct !DISubprogram(name: "HELLO_WORLD_TaskPipe", scope: !98, file: !98, line: 89, type: !311, scopeLine: 90, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !207)
!311 = !DISubroutineType(types: !312)
!312 = !{null, !313}
!313 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !314, size: 64)
!314 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !212)
!315 = !DILocalVariable(name: "SBBufPtr", arg: 1, scope: !310, file: !98, line: 89, type: !313)
!316 = !DILocation(line: 89, column: 50, scope: !310)
!317 = !DILocalVariable(name: "MsgId", scope: !310, file: !98, line: 91, type: !318)
!318 = !DIDerivedType(tag: DW_TAG_typedef, name: "CFE_SB_MsgId_t", file: !194, line: 107, baseType: !319)
!319 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !194, line: 104, size: 32, elements: !320)
!320 = !{!321}
!321 = !DIDerivedType(tag: DW_TAG_member, name: "Value", scope: !319, file: !194, line: 106, baseType: !322, size: 32)
!322 = !DIDerivedType(tag: DW_TAG_typedef, name: "CFE_SB_MsgId_Atom_t", file: !194, line: 91, baseType: !189)
!323 = !DILocation(line: 91, column: 20, scope: !310)
!324 = !DILocation(line: 93, column: 23, scope: !310)
!325 = !DILocation(line: 93, column: 5, scope: !310)
!326 = !DILocation(line: 95, column: 13, scope: !310)
!327 = !DILocation(line: 95, column: 5, scope: !310)
!328 = !DILocation(line: 98, column: 46, scope: !329)
!329 = distinct !DILexicalBlock(scope: !310, file: !98, line: 96, column: 5)
!330 = !DILocation(line: 98, column: 13, scope: !329)
!331 = !DILocation(line: 99, column: 13, scope: !329)
!332 = !DILocation(line: 102, column: 68, scope: !329)
!333 = !DILocation(line: 102, column: 13, scope: !329)
!334 = !DILocation(line: 103, column: 13, scope: !329)
!335 = !DILocation(line: 107, column: 90, scope: !329)
!336 = !DILocation(line: 106, column: 13, scope: !329)
!337 = !DILocation(line: 109, column: 5, scope: !329)
!338 = !DILocation(line: 110, column: 1, scope: !310)
!339 = distinct !DISubprogram(name: "CFE_SB_ValueToMsgId", scope: !340, file: !340, line: 851, type: !341, scopeLine: 852, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !207)
!340 = !DIFile(filename: "cfe/modules/core_api/fsw/inc/cfe_sb.h", directory: "/home/soyeonb/cFS", checksumkind: CSK_MD5, checksum: "f55cd2569956b2bf298d2775b9e0a669")
!341 = !DISubroutineType(types: !342)
!342 = !{!318, !322}
!343 = !DILocalVariable(name: "MsgIdValue", arg: 1, scope: !339, file: !340, line: 851, type: !322)
!344 = !DILocation(line: 851, column: 70, scope: !339)
!345 = !DILocalVariable(name: "Result", scope: !339, file: !340, line: 853, type: !318)
!346 = !DILocation(line: 853, column: 20, scope: !339)
!347 = !DILocation(line: 853, column: 29, scope: !339)
!348 = !DILocation(line: 854, column: 5, scope: !339)
!349 = distinct !DISubprogram(name: "CFE_SB_MsgIdToValue", scope: !340, file: !340, line: 822, type: !350, scopeLine: 823, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !207)
!350 = !DISubroutineType(types: !351)
!351 = !{!322, !318}
!352 = !DILocalVariable(name: "MsgId", arg: 1, scope: !349, file: !340, line: 822, type: !318)
!353 = !DILocation(line: 822, column: 70, scope: !349)
!354 = !DILocation(line: 824, column: 12, scope: !349)
!355 = !DILocation(line: 824, column: 5, scope: !349)
!356 = distinct !DISubprogram(name: "HELLO_WORLD_ProcessGroundCommand", scope: !98, file: !98, line: 129, type: !311, scopeLine: 130, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !207)
!357 = !DILocalVariable(name: "SBBufPtr", arg: 1, scope: !356, file: !98, line: 129, type: !313)
!358 = !DILocation(line: 129, column: 62, scope: !356)
!359 = !DILocalVariable(name: "CommandCode", scope: !356, file: !98, line: 131, type: !360)
!360 = !DIDerivedType(tag: DW_TAG_typedef, name: "CFE_MSG_FcnCode_t", file: !48, line: 48, baseType: !361)
!361 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16", file: !34, line: 84, baseType: !362)
!362 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !69, line: 25, baseType: !363)
!363 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !38, line: 40, baseType: !364)
!364 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!365 = !DILocation(line: 131, column: 23, scope: !356)
!366 = !DILocation(line: 133, column: 25, scope: !356)
!367 = !DILocation(line: 133, column: 5, scope: !356)
!368 = !DILocation(line: 138, column: 13, scope: !356)
!369 = !DILocation(line: 138, column: 5, scope: !356)
!370 = !DILocation(line: 142, column: 59, scope: !371)
!371 = distinct !DILexicalBlock(scope: !356, file: !98, line: 139, column: 5)
!372 = !DILocation(line: 142, column: 13, scope: !371)
!373 = !DILocation(line: 143, column: 13, scope: !371)
!374 = !DILocation(line: 148, column: 31, scope: !371)
!375 = !DILocation(line: 147, column: 13, scope: !371)
!376 = !DILocation(line: 149, column: 13, scope: !371)
!377 = !DILocation(line: 151, column: 1, scope: !356)
!378 = distinct !DISubprogram(name: "HELLO_WORLD_SendHkCmd", scope: !98, file: !98, line: 111, type: !379, scopeLine: 112, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !207)
!379 = !DISubroutineType(types: !380)
!380 = !{!31, !40}
!381 = !DILocalVariable(name: "Msg", arg: 1, scope: !378, file: !98, line: 111, type: !40)
!382 = !DILocation(line: 111, column: 67, scope: !378)
!383 = !DILocation(line: 116, column: 75, scope: !378)
!384 = !DILocation(line: 116, column: 56, scope: !378)
!385 = !DILocation(line: 117, column: 75, scope: !378)
!386 = !DILocation(line: 117, column: 56, scope: !378)
!387 = !DILocation(line: 122, column: 5, scope: !378)
!388 = !DILocation(line: 123, column: 5, scope: !378)
!389 = !DILocation(line: 126, column: 5, scope: !378)
!390 = distinct !DISubprogram(name: "HELLO_WORLD_EchoCmd", scope: !98, file: !98, line: 155, type: !391, scopeLine: 156, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !207)
!391 = !DISubroutineType(types: !392)
!392 = !{!31, !83}
!393 = !DILocalVariable(name: "Msg", arg: 1, scope: !390, file: !98, line: 155, type: !83)
!394 = !DILocation(line: 155, column: 58, scope: !390)
!395 = !DILocation(line: 159, column: 59, scope: !390)
!396 = !DILocation(line: 159, column: 64, scope: !390)
!397 = !DILocation(line: 158, column: 5, scope: !390)
!398 = !DILocalVariable(name: "EchoMsg", scope: !390, file: !98, line: 162, type: !399)
!399 = !DIDerivedType(tag: DW_TAG_typedef, name: "SAMPLE_EchoTlm_t", file: !43, line: 62, baseType: !400)
!400 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !43, line: 58, size: 640, elements: !401)
!401 = !{!402, !403}
!402 = !DIDerivedType(tag: DW_TAG_member, name: "TlmHeader", scope: !400, file: !43, line: 60, baseType: !165, size: 128)
!403 = !DIDerivedType(tag: DW_TAG_member, name: "MsgContent", scope: !400, file: !43, line: 61, baseType: !90, size: 512, offset: 128)
!404 = !DILocation(line: 162, column: 22, scope: !390)
!405 = !DILocation(line: 166, column: 22, scope: !406)
!406 = distinct !DILexicalBlock(scope: !390, file: !98, line: 165, column: 9)
!407 = !DILocation(line: 165, column: 9, scope: !406)
!408 = !DILocation(line: 167, column: 34, scope: !406)
!409 = !DILocation(line: 165, column: 9, scope: !390)
!410 = !DILocation(line: 170, column: 9, scope: !411)
!411 = distinct !DILexicalBlock(scope: !406, file: !98, line: 168, column: 5)
!412 = !DILocation(line: 172, column: 9, scope: !411)
!413 = !DILocation(line: 176, column: 21, scope: !390)
!414 = !DILocation(line: 176, column: 13, scope: !390)
!415 = !DILocation(line: 176, column: 33, scope: !390)
!416 = !DILocation(line: 176, column: 38, scope: !390)
!417 = !DILocation(line: 176, column: 5, scope: !390)
!418 = !DILocation(line: 179, column: 9, scope: !419)
!419 = distinct !DILexicalBlock(scope: !390, file: !98, line: 179, column: 9)
!420 = !DILocation(line: 179, column: 65, scope: !419)
!421 = !DILocation(line: 179, column: 9, scope: !390)
!422 = !DILocation(line: 182, column: 9, scope: !423)
!423 = distinct !DILexicalBlock(scope: !419, file: !98, line: 180, column: 5)
!424 = !DILocation(line: 184, column: 9, scope: !423)
!425 = !DILocation(line: 189, column: 74, scope: !390)
!426 = !DILocation(line: 189, column: 66, scope: !390)
!427 = !DILocation(line: 188, column: 5, scope: !390)
!428 = !DILocation(line: 192, column: 5, scope: !390)
!429 = !DILocation(line: 193, column: 1, scope: !390)
