
only forth also oop definitions


object subclass c-tst
\ OFFSET=0
    c-byte obj: .one
\ TEST 2
\ OFFSET=2
    c-2byte obj: .two
\ OFFSET=4
    c-byte obj: .three
    c-4byte obj: .four
\ OFFSET=5
    c-byte obj: .five
    c-4byte obj: .six
    c-byte obj: .LAST

	: get-last ( 2:this -- addr )
		--> .LAST drop
	;

	: get-three ( 2:this )
		--> .three --> get
	;

	: set-three ( n 2:this )
		--> .three --> set
	;
	: print-three ( 2:this )
		." three" 9 emit [char] : emit
		--> get-three . cr
	;

	: get-two ( 2:this )
		--> .two --> get
	;

	: set-two ( n 2:this )
		--> .two --> set
	;
	: print-two ( 2:this )
		." two" 9 emit [char] : emit
		--> get-two . cr
	;

	: get-five ( 2:this )
		--> .five --> get
	;

	: set-five ( n 2:this )
		--> .five --> set
	;
	: print-five ( 2:this )
		." five" 9 emit [char] : emit
		--> get-five . cr
	;

	: get-six ( 2:this )
		--> .six --> get
	;

	: set-six ( n 2:this )
		--> .six --> set
	;
	: print-six ( 2:this )
		." six" 9 emit [char] : emit
		--> get-six . cr
	;

	: get-four ( 2:this )
		--> .four --> get
	;

	: set-four ( n 2:this )
		--> .four --> set
	;
	: print-four ( 2:this )
		." four" 9 emit [char] : emit
		--> get-four . cr
	;

	: get-one ( 2:this )
		--> .one --> get
	;

	: set-one ( n 2:this )
		--> .one --> set
	;
	: print-one ( 2:this )
		." one" 9 emit [char] : emit
		--> get-one . cr
	;

	: init { 2:this }
		this drop 13 erase
		13 this --> set-length
	;

	: display { 2:this }
		this --> print-three
		this --> print-two
		this --> print-five
		this --> print-six
		this --> print-four
		this --> print-one
	;

end-class


