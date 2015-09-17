struct STM {
    STMState state;

    Boolean STM1Sent;
    Boolean STM4Sent;
    Boolean STM136Sent;
    Boolean STM139Sent;
    Boolean STM141Sent;
    Boolean STM143Sent;
    Boolean STM181Sent;

    Boolean STM1Received;
    Boolean STM2Received;
    Boolean STM5Received;
    Boolean STM9Received;
    Boolean STM175Recieved;

    Boolean testRequested;
    Boolean testInProgress;
    Boolean selfTestRun;

    uint8_t NID_STMTYPE;

    char productId[24];   // STM-4 X_TEXT
};
