( A few helpful aliases )

' \ alias //

only forth also oop definitions
\ FIX ME /*
\ FIX ME  * Just a comment
\ FIX ME  * for fun.
\ FIX ME  */
object subclass c-STM
\ FIX ME     STMState state;
    c-4byte obj: .STM1Sent
    c-4byte obj: .STM4Sent
    c-4byte obj: .STM136Sent
    c-4byte obj: .STM139Sent
    c-4byte obj: .STM141Sent
    c-4byte obj: .STM143Sent
    c-4byte obj: .STM181Sent
    c-4byte obj: .STM1Received
    c-4byte obj: .STM2Received
    c-4byte obj: .STM5Received
    c-4byte obj: .STM9Received
    c-4byte obj: .STM175Recieved
    c-4byte obj: .testRequested
    c-4byte obj: .testInProgress
    c-4byte obj: .selfTestRun
    c-byte obj: .NID_STMTYPE
    c-byte obj: .productId[24]

	: get-STM143Sent ( 2:this )
		--> .STM143Sent --> get
	;

	: get-STM1Received ( 2:this )
		--> .STM1Received --> get
	;

	: get-STM181Sent ( 2:this )
		--> .STM181Sent --> get
	;

	: get-productId[24] ( 2:this )
		--> .productId[24] --> get
	;

	: get-selfTestRun ( 2:this )
		--> .selfTestRun --> get
	;

	: get-testInProgress ( 2:this )
		--> .testInProgress --> get
	;

	: get-STM139Sent ( 2:this )
		--> .STM139Sent --> get
	;

	: get-testRequested ( 2:this )
		--> .testRequested --> get
	;

	: get-STM4Sent ( 2:this )
		--> .STM4Sent --> get
	;

	: get-NID_STMTYPE ( 2:this )
		--> .NID_STMTYPE --> get
	;

	: get-STM5Received ( 2:this )
		--> .STM5Received --> get
	;

	: get-STM136Sent ( 2:this )
		--> .STM136Sent --> get
	;

	: get-STM175Recieved ( 2:this )
		--> .STM175Recieved --> get
	;

	: get-STM2Received ( 2:this )
		--> .STM2Received --> get
	;

	: get-STM141Sent ( 2:this )
		--> .STM141Sent --> get
	;

	: get-STM9Received ( 2:this )
		--> .STM9Received --> get
	;

	: get-STM1Sent ( 2:this )
		--> .STM1Sent --> get
	;

end-class

