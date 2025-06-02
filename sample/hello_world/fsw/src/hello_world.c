#include "hello_world.h"


/* global data */
HELLO_WORLD_Data_t HELLO_WORLD_Data;

void HELLO_WORLD_Main(void)
{
    CFE_Status_t	status;
    CFE_SB_Buffer_t	*SBBufPtr;

    /* Hello World Application Initialization */
	status = HELLO_WORLD_Init();
	if (status != CFE_SUCCESS)
	{
		HELLO_WORLD_Data.RunStatus = CFE_ES_RunStatus_APP_ERROR;
	}	

	while (CFE_ES_RunLoop(&HELLO_WORLD_Data.RunStatus) == true)
	{
		/* Pend on receipt of command packet */
		status = CFE_SB_ReceiveBuffer(&SBBufPtr, HELLO_WORLD_Data.CommandPipe, CFE_SB_PEND_FOREVER);
	
	    if (status == CFE_SUCCESS)
	    {
			HELLO_WORLD_TaskPipe(SBBufPtr);
		}	
		else
		{
			CFE_EVS_SendEvent(HELLO_WORLD_PIPE_ERR_EID, CFE_EVS_EventType_ERROR, "Hello World: SB Pipe Read Error");
		
		    HELLO_WORLD_Data.RunStatus = CFE_ES_RunStatus_APP_ERROR;
		}
	}

    CFE_ES_ExitApp(HELLO_WORLD_Data.RunStatus);
}


CFE_Status_t HELLO_WORLD_Init(void)
{
	CFE_Status_t status;

	/* zero initialization */
	memset(&HELLO_WORLD_Data, 0, sizeof(HELLO_WORLD_Data));
	
    HELLO_WORLD_Data.RunStatus = CFE_ES_RunStatus_APP_RUN;	
    
	/* Register the events */
	status = CFE_EVS_Register(NULL, 0, CFE_EVS_EventFilter_BINARY);
    if (status != CFE_SUCCESS)
	{
		CFE_ES_WriteToSysLog("Hello World: Error Registering Events");
	    return status;
	}

	/* Initialize HK Packet */
	CFE_MSG_Init(CFE_MSG_PTR(HELLO_WORLD_Data.HkTlm.TelemetryHeader), CFE_SB_ValueToMsgId(HELLO_WORLD_HK_TLM_MID),
				 sizeof(HELLO_WORLD_Data.HkTlm));

    /* Create SB Message pipe */
	status = CFE_SB_CreatePipe(&HELLO_WORLD_Data.CommandPipe, HELLO_WORLD_PIPE_DEPTH, HELLO_WORLD_PIPE_NAME);
	if (status != CFE_SUCCESS)
	{
	   CFE_EVS_SendEvent(HELLO_WORLD_PIPE_ERR_EID, CFE_EVS_EventType_ERROR, "Hello World: Error creating SB Command Pipe");
	   return status;
	}

	/* Subscribe to HK request commands */
    status = CFE_SB_Subscribe(CFE_SB_ValueToMsgId(HELLO_WORLD_SEND_HK_MID), HELLO_WORLD_Data.CommandPipe);
	if (status != CFE_SUCCESS) 
	{
	   CFE_EVS_SendEvent(HELLO_WORLD_SUB_HK_ERR_EID, CFE_EVS_EventType_ERROR, "Hello World: Error subscribing to HK Requests");
	   return status;
	}

	/* Subscibe to Ground Command Packets */
    status = CFE_SB_Subscribe(CFE_SB_ValueToMsgId(HELLO_WORLD_CMD_MID), HELLO_WORLD_Data.CommandPipe);
	if (status != CFE_SUCCESS) 
	{
	   CFE_EVS_SendEvent(HELLO_WORLD_SUB_CMD_ERR_EID, CFE_EVS_EventType_ERROR, "Hello World: Error subscribing to Ground Commands");
	   return status;
	}
	
	return status;

}

void HELLO_WORLD_TaskPipe(const CFE_SB_Buffer_t *SBBufPtr)
{
    CFE_SB_MsgId_t MsgId = CFE_SB_INVALID_MSG_ID;

    CFE_MSG_GetMsgId(&SBBufPtr->Msg, &MsgId);

    switch (CFE_SB_MsgIdToValue(MsgId))
    {
        case HELLO_WORLD_CMD_MID:
            HELLO_WORLD_ProcessGroundCommand(SBBufPtr);
            break;

        case HELLO_WORLD_SEND_HK_MID:
            HELLO_WORLD_SendHkCmd((const HELLO_WORLD_SendHkCmd_t *)SBBufPtr);
            break;

        default:
            CFE_EVS_SendEvent(HELLO_WORLD_MID_ERR_EID, CFE_EVS_EventType_ERROR,
                              "SAMPLE: invalid command packet,MID = 0x%x", (unsigned int)CFE_SB_MsgIdToValue(MsgId));
          
    }
}
CFE_Status_t HELLO_WORLD_SendHkCmd(const HELLO_WORLD_SendHkCmd_t *Msg)
{
    /*
    ** Get command execution counters...
    */
    HELLO_WORLD_Data.HkTlm.Payload.CommandErrorCounter = HELLO_WORLD_Data.ErrCounter;
    HELLO_WORLD_Data.HkTlm.Payload.CommandCounter      = HELLO_WORLD_Data.CmdCounter;

    /*
    ** Send housekeeping telemetry packet...
    */
    CFE_SB_TimeStampMsg(CFE_MSG_PTR(HELLO_WORLD_Data.HkTlm.TelemetryHeader));
    CFE_SB_TransmitMsg(CFE_MSG_PTR(HELLO_WORLD_Data.HkTlm.TelemetryHeader), true);


    return CFE_SUCCESS;
}

void HELLO_WORLD_ProcessGroundCommand(const CFE_SB_Buffer_t *SBBufPtr)
{
    CFE_MSG_FcnCode_t CommandCode = 0;

    CFE_MSG_GetFcnCode(&SBBufPtr->Msg, &CommandCode);

    /*
    ** Process SAMPLE app ground commands
    */
    switch (CommandCode)
    {

        case HELLO_WORLD_ECHO_CC:  // 🔍 새로 추가된 Command
            HELLO_WORLD_EchoCmd((const SAMPLE_EchoCmd_t *)SBBufPtr);
            break;

        /* default case already found during FC vs length test */
        default:
            CFE_EVS_SendEvent(HELLO_WORLD_CC_ERR_EID, CFE_EVS_EventType_ERROR, "Invalid ground command code: CC = %d",
                              CommandCode);
            break;
    }
}


/* Echo Command Handler */
CFE_Status_t HELLO_WORLD_EchoCmd(const SAMPLE_EchoCmd_t *Msg)
{
    // 1️⃣ 로그 출력
    CFE_EVS_SendEvent(HELLO_WORLD_INF_EID, CFE_EVS_EventType_INFORMATION,
                      "HELLO_WORLD: Echo Received -> %s", Msg->MsgContent);

    // 2️⃣ Echo 메시지 생성
    SAMPLE_EchoTlm_t EchoMsg;

    // 3️⃣ 메시지 초기화
    if (CFE_MSG_Init((CFE_MSG_Message_t *)&EchoMsg,
                     CFE_SB_ValueToMsgId(HELLO_WORLD_TLM_MID),
		     sizeof(SAMPLE_EchoTlm_t)) != CFE_SUCCESS)
    {
        // 🔍 실패 시 에러 이벤트 전송
        CFE_EVS_SendEvent(HELLO_WORLD_ECHO_ERR_EID, CFE_EVS_EventType_ERROR,
                          "HELLO_WORLD: Failed to initialize Echo message.");
        return CFE_STATUS_EXTERNAL_RESOURCE_FAIL;
    }

    // 4️⃣ 내용 복사
    strncpy(EchoMsg.MsgContent, Msg->MsgContent, sizeof(EchoMsg.MsgContent));
    
    // 5️⃣ Telemetry 전송
    if (CFE_SB_TransmitMsg((CFE_MSG_Message_t *)&EchoMsg, true) != CFE_SUCCESS)
    {
        // 🔍 실패 시 에러 이벤트 전송
        CFE_EVS_SendEvent(HELLO_WORLD_ECHO_ERR_EID, CFE_EVS_EventType_ERROR,
                          "HELLO_WORLD: Failed to send Echo telemetry.");
        return CFE_STATUS_EXTERNAL_RESOURCE_FAIL;
    }

    // 6️⃣ 로그로 전송된 메시지 확인
    CFE_EVS_SendEvent(HELLO_WORLD_INF_EID, CFE_EVS_EventType_INFORMATION,
                      "@@@@@@@HELLO_WORLD: Echo Sent -> %s %ld", EchoMsg.MsgContent, sizeof(EchoMsg.MsgContent));
    

    return CFE_SUCCESS;
}



