
#ifndef HELLO_WORLD_H
#define HELLO_WORLD_H

#include "cfe.h"
#include "cfe_config.h"
#include "cfe_msg.h"


#include "hello_world_msgids.h"
#include "hello_world_fcncodes.h"
#include "hello_world_eventids.h"


#define HELLO_WORLD_PIPE_DEPTH 32 /* Depth of the Command Pipe for Application */
#define HELLO_WORLD_PIPE_NAME  "HELLO_WORLD"

typedef struct 
{
    uint8 CommandErrorCounter;
    uint8 CommandCounter;
    uint8 spare[2];
} HELLO_WORLD_HkTlm_Payload_t;

typedef struct
{
    CFE_MSG_TelemetryHeader_t  TelemetryHeader; /**< \brief Telemetry header */
    HELLO_WORLD_HkTlm_Payload_t Payload;         /**< \brief Telemetry payload */
} HELLO_WORLD_HkTlm_t;


/* Global Data */
typedef struct
{
    uint8 CmdCounter;
    uint8 ErrCounter;

    HELLO_WORLD_HkTlm_t HkTlm;

    uint32 RunStatus;

    CFE_SB_PipeId_t CommandPipe;
} HELLO_WORLD_Data_t;

typedef struct
{
    CFE_MSG_CommandHeader_t CommandHeader; /**< \brief Command header */
} HELLO_WORLD_SendHkCmd_t;


/* Echo Command 메시지 구조체 */
typedef struct 
{
    CFE_MSG_CommandHeader_t CmdHeader;    // Command Header
    char    MsgContent[64];                  // 메시지 내용
} SAMPLE_EchoCmd_t;

typedef struct 
{
    CFE_MSG_TelemetryHeader_t TlmHeader;    // Command Header
    char    MsgContent[64];                  // 메시지 내용
} SAMPLE_EchoTlm_t;



extern HELLO_WORLD_Data_t HELLO_WORLD_Data;

void		HELLO_WORLD_Main(void);
CFE_Status_t	HELLO_WORLD_Init(void);
void HELLO_WORLD_TaskPipe(const CFE_SB_Buffer_t *SBBufPtr);
CFE_Status_t HELLO_WORLD_SendHkCmd(const HELLO_WORLD_SendHkCmd_t *Msg);
void HELLO_WORLD_ProcessGroundCommand(const CFE_SB_Buffer_t *SBBufPtr);
CFE_Status_t HELLO_WORLD_EchoCmd(const SAMPLE_EchoCmd_t *Msg);


#endif /* HELLO_WORLD_H */



