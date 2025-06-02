
/* Echo Command 메시지 구조체 */
typedef struct 
{
    CFE_MSG_TelemetryHeader_t TlmHeader;    // Command Header
    char    MsgContent[64];                  // 메시지 내용
} SAMPLE_EchoTlm_t;
