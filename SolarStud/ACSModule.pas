///////////////////////////////////////////////////////////////////////////////
//
// COMPANY : ADVANDCED CARD SYSTEMS, LTD
//
// AUTHOR : ALCENDOR LORZANO CHAN
//
// DATE :  09 / 04 / 2001
//
// Delphi implementation of winscard.h
//
// Warning : For those using UNICODE characters. Those API's in
//           the "DECLARE" statement that end with SCARDxxxxA, you
//           must change it to SCARDxxxW. e.g SCardListReadersA() to
//           SCardListReadersW(). This is to differetiate Unicode ("W")
//           from non-Unicode API's ("A"). Look at Winscard.h for details
// Revision Trail: (Date/Author/Description)
// 1. (14 April 2003/J.I.R.Mission/Added SCardControl function, and
//           SCardControl constants)
// 2. (28 July 2003/J.I.R.Mission/Added LoadListToMenu function, and
//           APDU Command type structure)
// 3. (25 January 2004/J.I.R.Mission/Added ACR90 functions, constants,
//           and type structure)
// 4. (27 April 2004/J.I.R.Mission/Renamed file to ACSModule and added
//           ShellExecuteA function)
// 5. (08 June 2004)/J.I.R.Mission/Added IOCTL_SMARTCARD_GET_READER_INFO
//            and IOCTL_SMARTCARD_SET_CARD_TYPE constants for ACR30/38
///////////////////////////////////////////////////////////////////////////////

unit ACSModule;

interface
uses Windows,classes,StdCtrls, SysUtils, Menus;


Const SCARD_ATR_LENGTH = 33;  // ISO 7816-3 spec.
Const SCARD_S_SUCCESS = 0;

Type  LONG = LongInt;
      SCARDCONTEXT = ULONG;
      SCARDHANDLE = ULONG;
      PSCARDCONTEXT = ^SCARDCONTEXT;
      LPSCARDCONTEXT = ^SCARDCONTEXT;

      PSCARDHANDLE = ^SCARDHANDLE;
      LPSCARDHANDLE = ^SCARDHANDLE;

      LPDWORD = ^DWORD;
      LPCVOID = Pointer;
      LPBYTE = PByte;
      LPBOOL = ^Boolean;


type  SCARD_IO_REQUEST = Record
        dwProtocol :DWORD;   // Protocol identifier
        cbPciLength :DWORD;  // Protocol Control Information Length
      end;
      PSCARD_IO_REQUEST = ^SCARD_IO_REQUEST;
      LPSCARD_IO_REQUEST = ^SCARD_IO_REQUEST;
      LPCSCARD_IO_REQUEST = ^SCARD_IO_REQUEST;

      LPVOID = ^POINTER;

type  SCARD_READERSTATE = record
      szReader :LPCTSTR;
      pvUserData : LPVOID;
      dwCurrentState :DWORD;
      dwEventStates :DWORD;
      cbATR :DWORD;
      rgbATR :array[1..36] of BYTE;
end;
      LPSCARD_READERSTATE = ^SCARD_READERSTATE;

Type  TAPDUCommand = record
      CLA: Byte;
      INS: Byte;
      P1: Byte;
      P2: Byte;
      P3: Byte;
      DataIn: array [0..255] of Byte;
      DataOut: array [0..255] of Byte;
      Status: array [0..1] of Byte;
end;

Type  SCARD_I2C_TYPE = (
	    NO_PREDEFINED_CARD_PARAMETERS = 0,
	    // I2C cards from ST-Microelectronics:
	    ST14C02C,
	    ST14C04C,
	    ST14E32,
	    M14C04,
	    M14C16,
	    M14C32,
	    M14C64,
	    M14128,
	    M14256,
	    // I2C cards from GEMplus:
	    GFM2K,
	    GFM4K,
	    GFM32K,
	    // I2C cards from Atmel:
	    AT24C01A,
	    AT24C02,
	    AT24C04,
	    AT24C08,
	    AT24C16,
	    AT24C164,
	    AT24C32,
	    AT24C64,
	    AT24C128,
	    AT24C256,
	    AT24CS128,
	    AT24CS256,
	    AT24C512,
	    I2C_TYPE_ENUM_TAIL
	    // must always be the last entry in this enum!!
      );

type  SCARD_I2C_CARD_PARAMETERS  = Record
	    ucPageSize: UCHAR;										// @field | Maximal number of bytes that can be written in a successive manner, in a single device select phase.
	    ucNumberOfAddressBytes: UCHAR	;	      // @field | Number of bytes used to address the memory in the I2C card.
	    ulMemorySize: ULONG	;							    // @field | The size of the e2prom allocated in the card
end;

      PSCARD_I2C_CARD_PARAMETERS = ^SCARD_I2C_CARD_PARAMETERS;

Const stI2cCardParameterTable: array [1..26] of SCARD_I2C_CARD_PARAMETERS = (
      // ucPageSize, ucNumberOfAddressBytes, ulMemorySize
      (ucPageSize:   0; ucNumberOfAddressBytes:   0; ulMemorySize:     0),     // NO_PREDEFINED_CARD_PARAMETERS = 0, values of this entry doesn't care
      // I2C cards from ST-Microelectronics:
      (ucPageSize:   8; ucNumberOfAddressBytes:   1; ulMemorySize:   256),     // ST14C02C
      (ucPageSize:   8; ucNumberOfAddressBytes:   1; ulMemorySize:   512),     // ST14C04C
      (ucPageSize:  32; ucNumberOfAddressBytes:   2; ulMemorySize:  4096),     // ST14E32
      (ucPageSize:  16; ucNumberOfAddressBytes:   1; ulMemorySize:   512),     // M14C04
      (ucPageSize:  16; ucNumberOfAddressBytes:   1; ulMemorySize:  2048),     // M14C16
      (ucPageSize:  32; ucNumberOfAddressBytes:   2; ulMemorySize:  4096),     // M14C32
      (ucPageSize:  32; ucNumberOfAddressBytes:   2; ulMemorySize:  8192),     // M14C64
      (ucPageSize:  64; ucNumberOfAddressBytes:   2; ulMemorySize: 16384),     // M14128
      (ucPageSize:  64; ucNumberOfAddressBytes:   2; ulMemorySize: 32768),     // M14256
      // I2C cards from GEMplus:
      (ucPageSize:   8; ucNumberOfAddressBytes:   1; ulMemorySize:   256),     // GFM2K
      (ucPageSize:  16; ucNumberOfAddressBytes:   1; ulMemorySize:   512),     // GFM4K
      (ucPageSize:  32; ucNumberOfAddressBytes:   2; ulMemorySize:  4096),     // GFM32K
      // I2C cards from Atmel:
      (ucPageSize:   8; ucNumberOfAddressBytes:   1; ulMemorySize:   128),     // AT24C01A
      (ucPageSize:   8; ucNumberOfAddressBytes:   1; ulMemorySize:   256),     // AT24C02
      (ucPageSize:  16; ucNumberOfAddressBytes:   1; ulMemorySize:   512),     // AT24C04
      (ucPageSize:  16; ucNumberOfAddressBytes:   1; ulMemorySize:  1024),     // AT24C08
      (ucPageSize:  16; ucNumberOfAddressBytes:   1; ulMemorySize:  2048),     // AT24C16
      (ucPageSize:  16; ucNumberOfAddressBytes:   1; ulMemorySize:  2048),     // AT24C164
      (ucPageSize:  32; ucNumberOfAddressBytes:   2; ulMemorySize:  4096),     // AT24C32
      (ucPageSize:  32; ucNumberOfAddressBytes:   2; ulMemorySize:  8192),     // AT24C64
      (ucPageSize:  64; ucNumberOfAddressBytes:   2; ulMemorySize: 16384),     // AT24C128
      (ucPageSize:  64; ucNumberOfAddressBytes:   2; ulMemorySize: 32768),     // AT24C256
      (ucPageSize:  64; ucNumberOfAddressBytes:   2; ulMemorySize: 16384),     // AT24CS128
      (ucPageSize:  64; ucNumberOfAddressBytes:   2; ulMemorySize: 32768),     // AT24CS256
      (ucPageSize: 128; ucNumberOfAddressBytes:   2; ulMemorySize: 64536)      // AT24C512
      );

///////////////////////////////////////////////////////////////////////////////
//  Error Messages
///////////////////////////////////////////////////////////////////////////////
Const SCARD_F_INTERNAL_ERROR           = $80100001; //  An internal consistency check failed
Const SCARD_E_CANCELLED                = $80100002; //  The action was cancelled by an SCardCancel request
Const SCARD_E_INVALID_HANDLE           = $80100003; //  The supplied handle was invalid
Const SCARD_E_INVALID_PARAMETER        = $80100004; //  One or more of the supplied parameters could not be properly interpreted
Const SCARD_E_INVALID_TARGET           = $80100005; //  Registry startup information is missing or invalid
Const SCARD_E_NO_MEMORY                = $80100006; //  Not enough memory available to complete this command
Const SCARD_F_WAITED_TOO_LONG          = $80100007; //  An internal consistency timer has expired
Const SCARD_E_INSUFFICIENT_BUFFER      = $80100008; //  The data buffer to receive returned data is too small for the returned data
Const SCARD_E_UNKNOWN_READER           = $80100009; //  The specified reader name is not recognized
Const SCARD_E_TIMEOUT                  = $8010000A; //  The user-specified timeout value has expired
Const SCARD_E_SHARING_VIOLATION        = $8010000B; //  The smart card cannot be accessed because of other connections outstanding
Const SCARD_E_NO_SMARTCARD             = $8010000C; //  The operation requires a Smart Card, but no Smart Card is currently in the device
Const SCARD_E_UNKNOWN_CARD             = $8010000D; //  The specified smart card name is not recognized
Const SCARD_E_CANT_DISPOSE             = $8010000E; //  The system could not dispose of the media in the requested manner
Const SCARD_E_PROTO_MISMATCH           = $8010000F; //  The requested protocols are incompatible with the protocol currently in use with the smart card
Const SCARD_E_NOT_READY                = $80100010; //  The reader or smart card is not ready to accept commands
Const SCARD_E_INVALID_VALUE            = $80100011; //  One or more of the supplied parameters values could not be properly interpreted
Const SCARD_E_SYSTEM_CANCELLED         = $80100012; //  The action was cancelled by the system, presumably to log off or shut down
Const SCARD_F_COMM_ERROR               = $80100013; //  An internal communications error has been detected
Const SCARD_F_UNKNOWN_ERROR            = $80100014; //  An internal error has been detected, but the source is unknown
Const SCARD_E_INVALID_ATR              = $80100015; //  An ATR obtained from the registry is not a valid ATR string
Const SCARD_E_NOT_TRANSACTED           = $80100016; //  An attempt was made to end a non-existent transaction
Const SCARD_E_READER_UNAVAILABLE       = $80100017; //  The specified reader is not currently available for use
Const SCARD_P_SHUTDOWN                 = $80100018; //  PRIVATE -- Internal flag to force server termination
Const SCARD_E_PCI_TOO_SMALL            = $80100019; //  The PCI Receive buffer was too small
Const SCARD_E_READER_UNSUPPORTED       = $8010001A; //  The reader driver does not meet minimal requirements for support
Const SCARD_E_DUPLICATE_READER         = $8010001B; //  The reader driver did not produce a unique reader name
Const SCARD_E_CARD_UNSUPPORTED         = $8010001C; //  The smart card does not meet minimal requirements for support
Const SCARD_E_NO_SERVICE               = $8010001D; //  The Smart card resource manager is not running
Const SCARD_E_SERVICE_STOPPED          = $8010001E; //  The Smart card resource manager has shut down
Const SCARD_W_UNSUPPORTED_CARD         = $80100065; //  The reader cannot communicate with the smart card, due to ATR configuration conflicts
Const SCARD_W_UNRESPONSIVE_CARD        = $80100066; //  The smart card is not responding to a reset
Const SCARD_W_UNPOWERED_CARD           = $80100067; //  Power has been removed from the smart card, so that further communication is not possible
Const SCARD_W_RESET_CARD               = $80100068; //  The smart card has been reset, so any shared state information is invalid
Const SCARD_W_REMOVED_CARD             = $80100069; //  The smart card has been removed, so that further communication is not possible

///////////////////////////////////////////////////////////////////////////////
//  ACR90 Errors
///////////////////////////////////////////////////////////////////////////////
Const SCARDSYNERR_PARM1       = $81000000;         // Error in parameter 1
Const SCARDSYNERR_PARM2       = $81000001;         // Error in parameter 2
Const SCARDSYNERR_PARM3       = $81000002;         // Error in parameter 3
Const SCARDSYNERR_PARM4       = $81000003;         // Error in parameter 4
Const SCARDSYNERR_PARM5       = $81000004;         // Error in parameter 5
Const SCARDSYNERR_PARM6       = $81000005;         // Error in parameter 6
Const SCARDSYNERR_PARM7       = $81000006;         // Error in parameter 7
Const SCARDSYNERR_PARM8       = $81000007;         // Error in parameter 8
Const SCARDSYNERR_PARM9       = $81000008;         // Error in parameter 9
Const SCARDSYNERR_PARM10      = $81000009;         // Error in parameter 10
Const SCARDSYNERR_PARM11      = $8100000A;         // Error in parameter 11
Const SCARDSYNERR_PARM12      = $8100000B;         // Error in parameter 12
Const SCARDSYNERR_PARM13      = $8100000C;         // Error in parameter 13
Const SCARDSYNERR_PARM14      = $8100000D;         // Error in parameter 14
Const SCARDSYNERR_PARM15      = $8100000E;         // Error in parameter 15
Const SCARDSYNERR_PARM16      = $8100000F;         // Error in parameter 16
Const SCARDSYNERR_PARM17      = $81000010;         // Error in parameter 17
Const SCARDSYNERR_PARM18      = $81000011;         // Error in parameter 18
Const SCARDSYNERR_PARM19      = $81000012;         // Error in parameter 19
Const SCARDSYNERR_INSUFFICIENT_PRIV    = $81100000;
Const SCARDSYNERR_PW_WRONG             = $81100001;
Const SCARDSYNERR_PW_LOCKED            = $81100002;
Const SCARDSYNERR_PW_TOO_SHORT         = $81100003;  //  The lenght of the password was too short.
Const SCARDSYNERR_PW_TOO_LONG          = $81100004;  //  The length of the password was too long.
Const SCARDSYNERR_PW_NOT_LOCKED		     = $81100005;  //  The password is not locked
Const SCARDSYNERR_ITEM_NOT_FOUND       = $81200000;
Const SCARDSYNERR_ITEMS_LEFT           = $81200001;
Const SCARDSYNERR_INVALID_CFG_FILE     = $81200002;
Const SCARDSYNERR_SECTION_NOT_FOUND    = $81200003;  //  Section not found
Const SCARDSYNERR_ENTRY_NOT_FOUND      = $81200004;  //  Entry not found
Const SCARDSYNERR_NO_MORE_SECTIONS     = $81200005;  //  No more sections
Const SCARDSYNERR_ITEM_ALREADY_EXISTS  = $81200006;  //  The specified item alread exists.
Const SCARDSYNERR_ITEM_EXPIRED         = $81200007;  //  Some item (e.g. a certificate) has expired.
Const SCARDSYNERR_UNEXPECTED_RET_VALUE = $81300000;  //  Unexpected return value
Const SCARDSYNERR_COMMUNICATE          = $81300001;  //  General communication error
Const SCARDSYNERR_NOT_ENOUGH_MEMORY    = $81300002;  //  Not enough memory
Const SCARDSYNERR_BUFFER_OVERFLOW      = $81300003;  //  Buffer overflow
Const SCARDSYNERR_TIMEOUT              = $81300004;  //  A timeout has occurred
Const SCARDSYNERR_NOT_SUPPORTED        = $81300005;
Const SCARDSYNERR_ILLEGAL_ARGUMENT     = $81300006;  //  Illegal argument
Const SCARDSYNERR_READ_FIO             = $81300007;  //  File IO read error 
Const SCARDSYNERR_WRITE_FIO            = $81300008;  //  File IO write error 
Const SCARDSYNERR_INVALID_HANDLE       = $81300009;  //  Invalid handle
Const SCARDSYNERR_GENERAL_FAILURE      = $8130000A;
Const SCARDSYNERR_FILE_NOT_FOUND       = $8130000B;  //  File not found
Const SCARDSYNERR_OPEN_FILE            = $8130000C;  //  File opening failed
Const SCARDSYNERR_SEM_USED             = $8130000D;  //  The semaphore is currently use by an other process
Const SCARDSYNERR_NOP                  = $81F00001;  //  No operation done
Const SCARDSYNERR_NOK                  = $81F00002;  //  Function not executed
Const SCARDSYNERR_FWBUG                = $81F00003;  //  Internal error detected
Const SCARDSYNERR_INIT                 = $81F00004;  //  Module not initialized
Const SCARDSYNERR_FIO                  = $81F00005;  //  File IO error detected
Const SCARDSYNERR_ALLOC                = $81F00006;  //  Cannot allocate memory
Const SCARDSYNERR_SESSION_ERR          = $81F00007;  //  General error
Const SCARDSYNERR_ACCESS_ERR           = $81F00008;
Const SCARDSYNERR_OPEN_FAILURE         = $81F00009;
Const SCARDSYNERR_CARD_NOT_POWERED     = $81F0000A;  //  Card is not powered
Const SCARDSYNERR_ILLEGAL_CARDTYPE     = $81F0000B;  //  Illegal cardtype
Const SCARDSYNERR_CARD_NOT_INSERTED    = $81F0000C;  //  Card not inserted
Const SCARDSYNERR_NO_DRIVER            = $81F0000D;
Const SCARDSYNERR_OUT_OF_SERVICE       = $81F0000E;
Const SCARDSYNERR_EOF_REACHED          = $81F0000F;  //  End of file reached
Const SCARDSYNERR_ON_BLACKLIST         = $81F00010;
Const SCARDSYNERR_CONSISTENCY_CHECK    = $81F00011;
Const SCARDSYNERR_IDENTITY_MISMATCH    = $81F00012;
Const SCARDSYNERR_MULTIPLE_ERRORS      = $81F00013;
Const SCARDSYNERR_ILLEGAL_DRIVER       = $81F00014;  //  Illegal driver
Const SCARDSYNERR_ILLEGAL_FW_RELEASE   = $81F00015;
Const SCARDSYNERR_NO_CARDREADER        = $81F00016;  //  No cardreader attached
Const SCARDSYNERR_IPC_FAULT            = $81F00017;
Const SCARDSYNERR_WAIT_AND_RETRY       = $81F00018;
Const SCARDSYNERR_SCARD__E_CANCELLED                = $80100002;    //  The action was cancelled by an SCardCancel request
Const SCARDSYNERR_SCARD__E_INVALID_HANDLE           = $80100003;    //  The supplied handle was invalid
Const SCARDSYNERR_SCARD__E_INVALID_PARAMETER        = $80100004;    //  One or more of the supplied parameters could not be properly interpreted
Const SCARDSYNERR_SCARD__E_INVALID_TARGET           = $80100005;    //  Registry startup information is missing or invalid
Const SCARDSYNERR_SCARD__E_NO_MEMORY                = $80100006;    //  Not enough memory available to complete this command
Const SCARDSYNERR_SCARD__F_WAITED_TOO_LONG          = $80100007;    //  An internal consistency timer has expired
Const SCARDSYNERR_SCARD__E_INSUFFICIENT_BUFFER      = $80100008;    //  The data buffer to receive returned data is too small for the returned data
Const SCARDSYNERR_SCARD__E_UNKNOWN_READER           = $80100009;    //  The specified reader name is not recognized
Const SCARDSYNERR_SCARD__E_TIMEOUT                  = $8010000A;    //  The user-specified timeout value has expired
Const SCARDSYNERR_SCARD__E_SHARING_VIOLATION        = $8010000B;    //  The smart card cannot be accessed because of other connections outstanding
Const SCARDSYNERR_SCARD__E_NO_SMARTCARD             = $8010000C;    //  The operation requires a Smart Card, but no Smart Card is currently in the device
Const SCARDSYNERR_SCARD__E_UNKNOWN_CARD             = $8010000D;    //  The specified smart card name is not recognized
Const SCARDSYNERR_SCARD__E_CANT_DISPOSE             = $8010000E;    //  The system could not dispose of the media in the requested manner
Const SCARDSYNERR_SCARD__E_PROTO_MISMATCH           = $8010000F;    //  The requested protocols are incompatible with the protocol currently in use with the smart card
Const SCARDSYNERR_SCARD__E_NOT_READY                = $80100010;    //  The reader or smart card is not ready to accept commands
Const SCARDSYNERR_SCARD__E_INVALID_VALUE            = $80100011;    //  One or more of the supplied parameters values could not be properly interpreted
Const SCARDSYNERR_SCARD__E_SYSTEM_CANCELLED         = $80100012;    //  The action was cancelled by the system, presumably to log off or shut down
Const SCARDSYNERR_SCARD__F_COMM_ERROR               = $80100013;    //  An internal communications error has been detected
Const SCARDSYNERR_SCARD__F_UNKNOWN_ERROR            = $80100014;    //  An internal error has been detected, but the source is unknown
Const SCARDSYNERR_SCARD__E_INVALID_ATR              = $80100015;    //  An ATR obtained from the registry is not a valid ATR string
Const SCARDSYNERR_SCARD__E_NOT_TRANSACTED           = $80100016;    //  An attempt was made to end a non-existent transaction
Const SCARDSYNERR_SCARD__E_READER_UNAVAILABLE       = $80100017;    //  The specified reader is not currently available for use
Const SCARDSYNERR_SCARD__P_SHUTDOWN                 = $80100018;    //  The operation has been aborted to allow the server application to exit
Const SCARDSYNERR_SCARD__E_PCI_TOO_SMALL            = $80100019;    //  The PCI Receive buffer was too small
Const SCARDSYNERR_SCARD__E_READER_UNSUPPORTED       = $8010001A;    //  The reader driver does not meet minimal requirements for support
Const SCARDSYNERR_SCARD__E_DUPLICATE_READER         = $8010001B;    //  The reader driver did not produce a unique reader name
Const SCARDSYNERR_SCARD__E_CARD_UNSUPPORTED         = $8010001C;    //  The smart card does not meet minimal requirements for support
Const SCARDSYNERR_SCARD__E_NO_SERVICE               = $8010001D;    //  The Smart card resource manager is not running
Const SCARDSYNERR_SCARD__E_SERVICE_STOPPED          = $8010001E;    //  The Smart card resource manager has shut down
Const SCARDSYNERR_SCARD__E_UNEXPECTED               = $8010001F;    //  An unexpected card error has occurred
Const SCARDSYNERR_SCARD__E_ICC_INSTALLATION         = $80100020;    //  No Primary Provider can be found for the smart card
Const SCARDSYNERR_SCARD__E_ICC_CREATEORDER          = $80100021;    //  The requested order of object creation is not supported
Const SCARDSYNERR_SCARD__E_UNSUPPORTED_FEATURE      = $80100022;    //  This smart card does not support the requested feature
Const SCARDSYNERR_SCARD__E_DIR_NOT_FOUND            = $80100023;    //  The identified directory does not exist in the smart card
Const SCARDSYNERR_SCARD__E_FILE_NOT_FOUND           = $80100024;    //  The identified file does not exist in the smart card
Const SCARDSYNERR_SCARD__E_NO_DIR                   = $80100025;    //  The supplied path does not represent a smart card directory
Const SCARDSYNERR_SCARD__E_NO_FILE                  = $80100026;    //  The supplied path does not represent a smart card file
Const SCARDSYNERR_SCARD__E_NO_ACCESS                = $80100027;    //  Access is denied to this file
Const SCARDSYNERR_SCARD__E_WRITE_TOO_MANY           = $80100028;    //  An attempt was made to write more data than would fit in the target object
Const SCARDSYNERR_SCARD__E_BAD_SEEK                 = $80100029;    //  There was an error trying to set the smart card file object pointer
Const SCARDSYNERR_SCARD__E_INVALID_CHV              = $8010002A;    //  The supplied PIN is incorrect
Const SCARDSYNERR_SCARD__E_UNKNOWN_RES_MNG          = $8010002B;    //  An unrecognized error code was returned from a layered component
Const SCARDSYNERR_SCARD__E_NO_SUCH_CERTIFICATE      = $8010002C;    //  The requested certificate does not exist
Const SCARDSYNERR_SCARD__E_CERTIFICATE_UNAVAILABLE  = $8010002D;    //  The requested certificate could not be obtained
Const SCARDSYNERR_SCARD__E_NO_READERS_AVAILABLE     = $8010002E;    //  Cannot find a smart card reader
Const SCARDSYNERR_SCARD__E_COMM_DATA_LOST           = $8010002F;    //  A communications error with the smart card has been detected
Const SCARDSYNERR_SCARD__W_UNSUPPORTED_CARD         = $80100065;    //  The reader cannot communicate with the smart card, due to ATR configuration conflicts
Const SCARDSYNERR_SCARD__W_UNRESPONSIVE_CARD        = $80100066;    //  The smart card is not responding to a reset
Const SCARDSYNERR_SCARD__W_UNPOWERED_CARD           = $80100067;    //  Power has been removed from the smart card, so that further communication is not possible
Const SCARDSYNERR_SCARD__W_RESET_CARD               = $80100068;    //  The smart card has been reset, so any shared state information is invalid
Const SCARDSYNERR_SCARD__W_REMOVED_CARD             = $80100069;    //  The smart card has been removed, so that further communication is not possible
Const SCARDSYNERR_SCARD__W_SECURITY_VIOLATION       = $8010006A;    //  Access was denied because of a security violation
Const SCARDSYNERR_SCARD__W_WRONG_CHV                = $8010006B;    //  The card cannot be accessed because the wrong PIN was presented
Const SCARDSYNERR_SCARD__W_CHV_BLOCKED              = $8010006C;    //  The card cannot be accessed because the maximum number of PIN entry attempts has been reached
Const SCARDSYNERR_SCARD__W_EOF                      = $8010006D;    //  The end of the smart card file has been reached
Const SCARDSYNERR_SCARD__W_CANCELLED_BY_USER        = $8010006E;    //  The action was cancelled by the user

///////////////////////////////////////////////////////////////////////////////
//      SHARE MODES
///////////////////////////////////////////////////////////////////////////////
Const SCARD_SCOPE_USER     =0;  // The context is a user context, and any
                                // database operations are performed within the
                                // domain of the user.
Const SCARD_SCOPE_TERMINAL =1;  // The context is that of the current terminal,
                                // and any database operations are performed
                                // within the domain of that terminal.  (The
                                // calling application must have appropriate
                                // access permissions for any database actions.)
Const SCARD_SCOPE_SYSTEM   =2;  // The context is the system context, and any
                                // database operations are performed within the
                                // domain of the system.  (The calling
                                // application must have appropriate access
                                // permissions for any database actions.)


///////////////////////////////////////////////////////////////////////////////
// Reader States
///////////////////////////////////////////////////////////////////////////////
Const  SCARD_UNKNOWN     =0;   // This value implies the driver is unaware
                              // of the current state of the reader.
Const  SCARD_ABSENT      =1;   // This value implies there is no card in
                              // the reader.
Const  SCARD_PRESENT     =2;   // This value implies there is a card is
                              // present in the reader, but that it has
                              // not been moved into position for use.
Const  SCARD_SWALLOWED   =3;   // This value implies there is a card in the
                              // reader in position for use.  The card is
                              // not powered.
Const  SCARD_POWERED     =4;   // This value implies there is power is
                              // being provided to the card, but the
                              // Reader Driver is unaware of the mode of
                              // the card.
Const SCARD_NEGOTIABLE  =5;   // This value implies the card has been
                              // reset and is awaiting PTS negotiation.
Const SCARD_SPECIFIC    =6;   // This value implies the card has been
                              // reset and specific communication
                              // protocols have been established.

///////////////////////////////////////////////////////////////////////////////
//  Card/Reader Access Services
///////////////////////////////////////////////////////////////////////////////
Const SCARD_SHARE_EXCLUSIVE =1; // This application is not willing to share this
                                // card with other applications.
Const SCARD_SHARE_SHARED    =2; // This application is willing to share this
                                // card with other applications.
Const SCARD_SHARE_DIRECT    =3; // This application demands direct control of
                                // the reader, so it is not available to other
                                // applications.

///////////////////////////////////////////////////////////////////////////////
//  Card Disposition
///////////////////////////////////////////////////////////////////////////////
Const SCARD_LEAVE_CARD     = 0; // Don't do anything special on close
Const SCARD_RESET_CARD     = 1; // Reset the card on close
Const SCARD_UNPOWER_CARD   = 2; // Power down the card on close
Const SCARD_EJECT_CARD     = 3; // Eject the card on close

///////////////////////////////////////////////////////////////////////////////
//  Protocol Flag definitions
///////////////////////////////////////////////////////////////////////////////
Const SCARD_PROTOCOL_UNDEFINED    =$00000000;  // There is no active protocol.
Const SCARD_PROTOCOL_T0           =$00000001;  // T=0 is the active protocol.
Const SCARD_PROTOCOL_T1           =$00000002;  // T=1 is the active protocol.
Const SCARD_PROTOCOL_RAW          =$00010000;  // Raw is the active protocol.
Const SCARD_PROTOCOL_DEFAULT      =$80000000;  // Use implicit PTS.


///////////////////////////////////////////////////////////////////////////////
//  Protocol Flag definitions
///////////////////////////////////////////////////////////////////////////////
Const SCARD_STATE_UNAWARE     =$00000000;   // The application is unaware of the
                                            // current state, and would like to
                                            // know.  The use of this value
                                            // results in an immediate return
                                            // from state transition monitoring
                                            // services.  This is represented by
                                            // all bits set to zero.
Const SCARD_STATE_IGNORE      =$00000001;   // The application requested that
                                            // this reader be ignored.  No other
                                            // bits will be set.
Const SCARD_STATE_CHANGED     =$00000002;   // This implies that there is a
                                            // difference between the state
                                            // believed by the application, and
                                            // the state known by the Service
                                            // Manager.  When this bit is set,
                                            // the application may assume a
                                            // significant state change has
                                            // occurred on this reader.
Const SCARD_STATE_UNKNOWN     =$00000004;   // This implies that the given
                                            // reader name is not recognized by
                                            // the Service Manager.  If this bit
                                            // is set, then SCARD_STATE_CHANGED
                                            // and SCARD_STATE_IGNORE will also
                                            // be set.
Const SCARD_STATE_UNAVAILABLE =$00000008;   // This implies that the actual
                                            // state of this reader is not
                                            // available.  If this bit is set,
                                            // then all the following bits are
                                            // clear.
Const SCARD_STATE_EMPTY       =$00000010;   // This implies that there is not
                                            // card in the reader.  If this bit
                                            // is set, all the following bits
                                            // will be clear.
Const SCARD_STATE_PRESENT     =$00000020;   // This implies that there is a card
                                            // in the reader.
Const SCARD_STATE_ATRMATCH    =$00000040;   // This implies that there is a card
                                            // in the reader with an ATR
                                            // matching one of the target cards.
                                            // If this bit is set,
                                            // SCARD_STATE_PRESENT will also be
                                            // set.  This bit is only returned
                                            // on the SCardLocateCard() service.
Const SCARD_STATE_EXCLUSIVE   =$00000080;   // This implies that the card in the
                                            // reader is allocated for exclusive
                                            // use by another application.  If
                                            // this bit is set,
                                            // SCARD_STATE_PRESENT will also be
                                            // set.
Const SCARD_STATE_INUSE       =$00000100;   // This implies that the card in the
                                            // reader is in use by one or more
                                            // other applications, but may be
                                            // connected to in shared mode.  If
                                            // this bit is set,
                                            // SCARD_STATE_PRESENT will also be
                                            // set.
Const SCARD_STATE_MUTE       =$00000200;    // This implies that the card in the
                                            // reader is unresponsive or not
                                            // supported by the reader or
                                            // software.
Const SCARD_STATE_UNPOWERED   =$00000400;   // This implies that the card in the
                                            // reader has not been powered up.

///////////////////////////////////////////////////////////////////////////////
//  SCardControl Constants
///////////////////////////////////////////////////////////////////////////////
Const IOCTL_SMARTCARD_DIRECT            =(($31 shl 16) + (2050 shl 2));
Const IOCTL_SMARTCARD_SELECT_SLOT       =(($31 shl 16) + (2051 shl 2));
Const IOCTL_SMARTCARD_DRAW_LCDBMP       =(($31 shl 16) + (2052 shl 2));
Const IOCTL_SMARTCARD_DISPLAY_LCD       =(($31 shl 16) + (2053 shl 2));
Const IOCTL_SMARTCARD_CLR_LCD           =(($31 shl 16) + (2054 shl 2));
Const IOCTL_SMARTCARD_READ_KEYPAD       =(($31 shl 16) + (2055 shl 2));
Const IOCTL_SMARTCARD_READ_RTC          =(($31 shl 16) + (2057 shl 2));
Const IOCTL_SMARTCARD_SET_RTC           =(($31 shl 16) + (2058 shl 2));
Const IOCTL_SMARTCARD_SET_OPTION        =(($31 shl 16) + (2059 shl 2));
Const IOCTL_SMARTCARD_SET_LED           =(($31 shl 16) + (2060 shl 2));
Const IOCTL_SMARTCARD_LOAD_KEY          =(($31 shl 16) + (2062 shl 2));
Const IOCTL_SMARTCARD_READ_EEPROM       =(($31 shl 16) + (2065 shl 2));
Const IOCTL_SMARTCARD_WRITE_EEPROM      =(($31 shl 16) + (2066 shl 2));
Const IOCTL_SMARTCARD_GET_VERSION       =(($31 shl 16) + (2067 shl 2));
Const IOCTL_SMARTCARD_GET_READER_INFO		=(($31 shl 16) + (2051 shl 2));
Const IOCTL_SMARTCARD_SET_CARD_TYPE 		=(($31 shl 16) + (2060 shl 2));

///////////////////////////////////////////////////////////////////////////////
//  ACR90 Constants
///////////////////////////////////////////////////////////////////////////////
Const SCARD_I2C_CARD_PARAMETERS_SIZE	  = SizeOf(SCARD_I2C_CARD_PARAMETERS);
Const SCARDI2C_MAX_DATA_LEN			        = 65536;
Const	SCARD2W_MAX_DATA_LEN			        = 256;
Const	SCARD2W_PIN_LEN					          = 3;
Const SCARD3W_MAX_DATA_LEN			        = 1024;
Const SCARD3W_PIN_LEN					          = 2;

///////////////////////////////////////////////////////////////////////////////
//  Imported functions from Winscard.dll (WIN32 API)
///////////////////////////////////////////////////////////////////////////////
Function SCardEstablishContext(dwscope :DWORD;
                                pvReserved1: LPCVOID;
                                pvReserved2: LPCVOID;
                                phContext :LPSCARDCONTEXT):LONG; stdcall; external 'Winscard.dll';

Function SCardReleaseContext(hContext:SCARDCONTEXT):LONG; stdcall; external 'Winscard.dll';

Function SCardListReadersA(hContext : SCARDCONTEXT;
                           mszGroups:LPCSTR;
                           szReaders:LPSTR;
                           pcchReaders:LPDWORD):LONG; stdcall; external 'Winscard.dll';

//Note : ScardConnectA is for non-UNICODE characters which is only one byte.
//       For UNICODE characters it is SCardConnectW. Special processing is
//       required for UNICODE. Be careful!
Function SCardConnectA(hContext : SCARDCONTEXT;
                       szReaders:LPSTR;
                       dwShareMode : DWORD;
                       dwPreferredProtocols : DWORD;
                       phCard : LPSCARDHANDLE;
                       pdwActiveProtocols:LPDWORD):LONG; stdcall; external 'Winscard.dll';

Function SCardReconnect(hCard : SCARDHANDLE;
                        dwShareMode : DWORD;
                        dwPreferredProtocols : DWORD;
                        dwInitialization : DWORD;
                        pdwActiveProtocols:LPDWORD):LONG; stdcall; external 'Winscard.dll';

Function SCardDisconnect(hCard : SCARDHANDLE;
                         dwDisposition :DWORD):LONG; stdcall; external 'Winscard.dll';


Function SCardBeginTransaction(hCard : SCARDHANDLE):LONG; stdcall; external 'Winscard.dll';

Function SCardEndTransaction(hCard : SCARDHANDLE;
                             dwDisposition :DWORD):LONG; stdcall; external 'Winscard.dll';

Function SCardState(hCard : SCARDHANDLE;
                    pdwState :LPDWORD;
                    pdwProtocol :LPDWORD;
                    pbATR :LPBYTE;
                    pcbAtrLen :LPDWORD):LONG; stdcall; external 'Winscard.dll';

Function SCardGetStatusChangeA(hContext : SCARDHANDLE;
                    dwTimeout :DWORD;
                    rgReaderStates :LPSCARD_READERSTATE;
                    cReaders :DWORD):LONG; stdcall; external 'Winscard.dll';

Function SCardStatusA(hCard : SCARDHANDLE;
                      mszReaderNames :LPTSTR;
                      pcchReaderLen : LPDWORD;
                      pdwState :LPDWORD;
                      pdwProtocol :LPDWORD;
                      pbATR :LPBYTE;
                      pcbAtrLen :LPDWORD):LONG; stdcall; external 'Winscard.dll';

Function SCardTransmit(hCard : SCARDHANDLE;
                       pioSendPci : LPCSCARD_IO_REQUEST;
                       pbSendBuffer : LPBYTE;
                       cbSendLength : DWORD;
                       pioRecvPci : LPCSCARD_IO_REQUEST;
                       pbRecvBuffer : LPBYTE;
                       pcbRecvLength:LPDWORD):LONG; stdcall; external 'Winscard.dll';

Function SCardControl(hCard : SCARDHANDLE;
                       dwControlCode : DWORD;
                       lpInBuffer : LPBYTE;
                       nInBufferSize : DWORD;
                       lpOutBuffer : LPBYTE;
                       nOutBufferSize : DWORD;
                       lpBytesReturned : LPDWORD):LONG; stdcall; external 'Winscard.dll';

Function ShellExecuteA(handle : DWORD;
                       lpOperation : String;
                       lpTargetFile : String;
                       lpParam : String;
                       lpDirectory : String;
                       ShowMode : Integer):LONG; stdcall; external 'SHELL32.dll';

///////////////////////////////////////////////////////////////////////////////
//  ACR90 imported functions from scardsyn.dll
///////////////////////////////////////////////////////////////////////////////
Function SCardI2CInit(  ulHandleCard: SCARDHANDLE;
                        pCardParameter: PSCARD_I2C_CARD_PARAMETERS;
	                      cType: SCARD_I2C_TYPE):LONG; stdcall; external 'scardsyn.dll';

Function SCardI2CReadData ( ulHandleCard: SCARDHANDLE;
	                      pbReadBuffer: LPBYTE;
	                      ulReadBufferSize: ULONG;
	                      ulAddress: ULONG;
	                      ulBytesToRead: ULONG):LONG; stdcall; external 'scardsyn.dll';

Function SCardI2CWriteData ( ulHandleCard: SCARDHANDLE;
	                      pbWriteBuffer: LPBYTE;
	                      ulWriteBufferSize: ULONG;
	                      ulAddress: ULONG;
	                      ulBytesToWrite: ULONG):LONG; stdcall; external 'scardsyn.dll';

Function SCard2WBPReadData ( ulHandleCard: SCARDHANDLE;
	                      ulBytesToRead: ULONG;
	                      pbData: LPBYTE;
	                      ulAddress: ULONG):LONG; stdcall; external 'scardsyn.dll';

Function SCard2WBPReadProtectionMemory ( ulHandleCard: SCARDHANDLE;
	                      ulDataLen: ULONG;
	                      pbData: LPBYTE):LONG; stdcall; external 'scardsyn.dll';

Function SCard2WBPWriteData ( ulHandleCard: SCARDHANDLE;
	                      ulDataLen: ULONG;
	                      pbData: LPBYTE;
	                      ulAddress: ULONG):LONG; stdcall; external 'scardsyn.dll';

Function SCard2WBPCompareAndProtect ( ulHandleCard: SCARDHANDLE;
	                      bData: BYTE;
	                      ulAddress: ULONG):LONG; stdcall; external 'scardsyn.dll';

Function SCard2WBPPresentPIN ( ulHandleCard: SCARDHANDLE;
	                      ulPINLen: ULONG;
	                      pbPIN: LPBYTE):LONG; stdcall; external 'scardsyn.dll';

Function SCard2WBPChangePIN ( ulHandleCard: SCARDHANDLE;
	                      ulOldPINLen: ULONG;
	                      pbOldPIN: LPBYTE;
	                      ulNewPINLen: ULONG;
	                      pbNewPIN: LPBYTE):LONG; stdcall; external 'scardsyn.dll';

Function SCard2WBPIsPinPresented ( ulHandleCard: SCARDHANDLE;
	                      pfPinPresented: LPBOOL):LONG; stdcall; external 'scardsyn.dll';

Function SCard2WBPReadErrorCounter ( ulHandleCard: SCARDHANDLE;
	                      pbCounter: LPBYTE):LONG; stdcall; external 'scardsyn.dll';

Function SCard2WBPUpdateSecurityMemory ( ulHandleCard: SCARDHANDLE;
	                      bData: BYTE;
	                      ulAddress: ULONG):LONG; stdcall; external 'scardsyn.dll';

Function SCard2WBPReadSecurityMemory ( ulHandleCard: SCARDHANDLE;
	                      ulDataLen: ULONG;
	                      pbData: LPBYTE):LONG; stdcall; external 'scardsyn.dll';

Function SCard3WBPReadData ( ulHandleCard: SCARDHANDLE;
	                      ulBytesToRead: ULONG;
	                      pbReadBuffer: LPBYTE;
	                      ulAddress: ULONG):LONG; stdcall; external 'scardsyn.dll';

Function SCard3WBPVerifyProtectBit ( ulHandleCard: SCARDHANDLE;
	                      ulAddress: ULONG;
	                      pfProtected: LPBOOL):LONG; stdcall; external 'scardsyn.dll';

Function SCard3WBPWriteData ( ulHandleCard: SCARDHANDLE;
	                      ulDataLen: ULONG;
	                      pbData: LPBYTE;
	                      ulAddress: ULONG;
	                      pfProtected: Boolean):LONG; stdcall; external 'scardsyn.dll';

Function SCard3WBPCompareAndProtect ( ulHandleCard: SCARDHANDLE;
	                      bData: BYTE;
	                      ulAddress: ULONG):LONG; stdcall; external 'scardsyn.dll';

Function SCard3WBPPresentPIN ( ulHandleCard: SCARDHANDLE;
	                      ulPINLen: ULONG;
	                      pbPIN: LPBYTE):LONG; stdcall; external 'scardsyn.dll';

Function SCard3WBPChangePIN ( ulHandleCard: SCARDHANDLE;
	                      ulOldPINLen: ULONG;
	                      pbOldPIN: LPBYTE;
	                      ulNewPINLen: ULONG;
	                      pbNewPIN: LPBYTE):LONG; stdcall; external 'scardsyn.dll';

Function SCard3WBPIsPinPresented ( ulHandleCard: SCARDHANDLE;
	                      pfPinPresented: LPBOOL):LONG; stdcall; external 'scardsyn.dll';


Procedure ParseReaderList(var List : TStringList; Buffer :PChar; BuffLen : integer);
Procedure LoadListToControl(var ComboBoxControl : TComboBox; Buffer :PChar; BuffLen : integer);
Procedure LoadListToMenu(var MenuItemControl : TMenuItem; Buffer :PChar; BuffLen : integer);
Function GetScardErrMsg(ErrCode : DWORD):string;
Function GetAcr90ErrMsg(ErrCode : DWORD):string;
Function GetShareModeStrMsg(Code : DWORD):string;
Function GetReaderStateStrMsg(Code : DWORD):string;
Function GetDisposistionStrMsg(Code : DWORD):string;
Function GetProtocolStrMsg(Code : DWORD):string;
Function GetProtocolFlagStrMsg(Code : DWORD):string;


implementation

/////////////////////////////////////////////////////////////////////////////
//  Procedure   : ParseReaderList
//  Inputs      : TStringList - Resulting list of the parsed data.
//                Buffer - should contain readerlist separated by Null character.
//                        List is terminated by Null.
//                BuffLen - Length of Buffer including Null character(s).
//  Description : This function parses readerlist into into individual
//                readers. Buffer should contain the result after a
//                SCardReaderList function. TStringList must be created
//                before passing it to the routine. BuffLen should contain
                //                the number of characters contained in Buffer.
//
//                Example :  Procedure SomeProcedure();
//                           var List :TStringList;
//                           Buffer : array[0..255] of char;
//                           begin
//                               Buffer := 'ACS READER 1'#0#0; {Len is 14, include 2 null at the end}
//                               List := TStringList.Create;
//                               ParseReaderList(List,Buffer,14);
//                               ComboBoxControl.Items.Assign(List); {Assign content of List to Combobox}
//                               List.Free;
//                           end;
////////////////////////////////////////////////////////////////////////////
procedure ParseReaderList(var List : TStringList; Buffer :PChar; BuffLen : integer);
var indx : integer;
    sReader:string;
begin
     indx := 0;
     while (Buffer[indx] <> #0) do begin
       sReader := '';
       while (Buffer[indx] <> #0) do begin
       sReader := sReader + Buffer[indx];
       inc(indx);
       end; // while loop
       sReader := sReader + Buffer[indx];
       List.Add(sReader);
       inc(indx);
     end; // while loop
end;

/////////////////////////////////////////////////////////////////////////////
//  Procedure   : LoadListToControl
//  Inputs      : ComboBox - Dropdownlist box where list is loaded.
//                Buffer - should contain readerlist separated by Null character.
//                        List is terminated by Null.
//                BuffLen - Length of Buffer including Null character(s).
//  Description : This function loads the reader list in the combobox control.
//                Note : that previous entries to the control prior to the calling
//                       of this routine will clear the entries.
//                Example :  Procedure SomeProcedure();
//                           var Buffer : array[0..255] of char;
//                           begin
//                               Buffer := 'ACS READER 1'#0#0; {Len is 14, include 2 null at the end}
//                               LoadListToControl(ComboBox1,Buffer,14);
//                           end;
////////////////////////////////////////////////////////////////////////////

Procedure LoadListToControl(var ComboBoxControl : TComboBox; Buffer :PChar; BuffLen : integer);
var List : TStringList;
begin
     List := TStringList.Create;
     ParseReaderList(List,Buffer,BuffLen);
     ComboBoxControl.Clear;
     ComboBoxControl.Items.Assign(List);
     List.Free;
end;

/////////////////////////////////////////////////////////////////////////////
//  Procedure   : LoadListToMenu
//  Inputs      : MenuItem - Menu Item where list is loaded.
//                Buffer - should contain readerlist separated by Null character.
//                        List is terminated by Null.
//                BuffLen - Length of Buffer including Null character(s).
//  Description : This function loads the reader list in the menu item control.
//                Note : that previous entries to the control prior to the calling
//                       of this routine will clear the entries.
//                Example :  Procedure SomeProcedure();
//                           var Buffer : array[0..255] of char;
//                           begin
//                               Buffer := 'ACS READER 1'#0#0; {Len is 14, include 2 null at the end}
//                               LoadListToMenu(MenuItem1,Buffer,14);
//                           end;
////////////////////////////////////////////////////////////////////////////

Procedure LoadListToMenu(var MenuItemControl : TMenuItem; Buffer :PChar; BuffLen : integer);
var NewItem: TMenuItem;
    I : integer;
    List : TStringList;
begin
     List := TStringList.Create;
     ParseReaderList(List,Buffer,BuffLen);
     for  I := 0 to List.Count-1 do
     begin
       NewItem := TMenuItem.Create(NewItem);
       NewItem.Caption := List.Strings[I];
       NewItem.AutoCheck := True;
       NewItem.RadioItem := True;
       MenuItemControl.Add(NewItem);
     end;

end;


////////////////////////////////////////////////////////////////////////////
//  Function    : GetScardErrMsg
//  Inputs      : ErrCode - DWORD code.
//  Description : This function returns the string message of the
//                error code.
//
////////////////////////////////////////////////////////////////////////////
Function GetScardErrMsg(ErrCode : DWORD):string;
begin
    Case ErrCode of
      SCARD_F_INTERNAL_ERROR       : GetScardErrMsg := 'An internal consistency check failed.';
      SCARD_E_CANCELLED            : GetScardErrMsg := 'The action was cancelled by an SCardCancel request.';
      SCARD_E_INVALID_HANDLE       : GetScardErrMsg := 'The supplied handle was invalid.';
      SCARD_E_INVALID_PARAMETER    : GetScardErrMsg := 'One or more of the supplied parameters could not be properly interpreted.';
      SCARD_E_INVALID_TARGET       : GetScardErrMsg := 'Registry startup information is missing or invalid.';
      SCARD_E_NO_MEMORY            : GetScardErrMsg := 'Not enough memory available to complete this command.';
      SCARD_F_WAITED_TOO_LONG      : GetScardErrMsg := 'An internal consistency timer has expired.';
      SCARD_E_INSUFFICIENT_BUFFER  : GetScardErrMsg := 'The data buffer to receive returned data is too small for the returned data.';
      SCARD_E_UNKNOWN_READER       : GetScardErrMsg := 'The specified reader name is not recognized.';
      SCARD_E_TIMEOUT              : GetScardErrMsg := 'The user-specified timeout value has expired.';
      SCARD_E_SHARING_VIOLATION    : GetScardErrMsg := 'The smart card cannot be accessed because of other connections outstanding.';
      SCARD_E_NO_SMARTCARD         : GetScardErrMsg := 'The operation requires a Smart Card, but no Smart Card is currently in the device.';
      SCARD_E_UNKNOWN_CARD         : GetScardErrMsg := 'The specified smart card name is not recognized.';
      SCARD_E_CANT_DISPOSE         : GetScardErrMsg := 'The system could not dispose of the media in the requested manner.';
      SCARD_E_PROTO_MISMATCH       : GetScardErrMsg := 'The requested protocols are incompatible with the protocol currently in use with the smart card.';
      SCARD_E_NOT_READY            : GetScardErrMsg := 'The reader or smart card is not ready to accept commands.';
      SCARD_E_INVALID_VALUE        : GetScardErrMsg := 'One or more of the supplied parameters values could not be properly interpreted.';
      SCARD_E_SYSTEM_CANCELLED     : GetScardErrMsg := 'The action was cancelled by the system, presumably to log off or shut down.';
      SCARD_F_COMM_ERROR           : GetScardErrMsg := 'An internal communications error has been detected.';
      SCARD_F_UNKNOWN_ERROR        : GetScardErrMsg := 'An internal error has been detected, but the source is unknown.';
      SCARD_E_INVALID_ATR          : GetScardErrMsg := 'An ATR obtained from the registry is not a valid ATR string.';
      SCARD_E_NOT_TRANSACTED       : GetScardErrMsg := 'An attempt was made to end a non-existent transaction.';
      SCARD_E_READER_UNAVAILABLE   : GetScardErrMsg := 'The specified reader is not currently available for use.';
      SCARD_P_SHUTDOWN             : GetScardErrMsg := 'PRIVATE -- Internal flag to force server termination.';
      SCARD_E_PCI_TOO_SMALL        : GetScardErrMsg := 'The PCI Receive buffer was too small.';
      SCARD_E_READER_UNSUPPORTED   : GetScardErrMsg := 'The reader driver does not meet minimal requirements for support.';
      SCARD_E_DUPLICATE_READER     : GetScardErrMsg := 'The reader driver did not produce a unique reader name.';
      SCARD_E_CARD_UNSUPPORTED     : GetScardErrMsg := 'The smart card does not meet minimal requirements for support.';
      SCARD_E_NO_SERVICE           : GetScardErrMsg := 'The Smart card resource manager is not running.';
      SCARD_E_SERVICE_STOPPED      : GetScardErrMsg := 'The Smart card resource manager has shut down.';
      SCARD_W_UNSUPPORTED_CARD     : GetScardErrMsg := 'The reader cannot communicate with the smart card, due to ATR configuration conflicts.';
      SCARD_W_UNRESPONSIVE_CARD    : GetScardErrMsg := 'The smart card is not responding to a reset.';
      SCARD_W_UNPOWERED_CARD       : GetScardErrMsg := 'Power has been removed from the smart card, so that further communication is not possible.';
      SCARD_W_RESET_CARD           : GetScardErrMsg := 'The smart card has been reset, so any shared state information is invalid.';
      SCARD_W_REMOVED_CARD         : GetScardErrMsg := 'The smart card has been removed, so that further communication is not possible.';
    else
      GetScardErrMsg := 'Unknown Error: ' + Format('%d', [ErrCode]);
    end; // case statement
end;

Function GetAcr90ErrMsg(ErrCode : DWORD):string;
begin
      Case ErrCode of
      SCARDSYNERR_PARM1       : GetAcr90ErrMsg := 'Error in parameter 1.';
      SCARDSYNERR_PARM2       : GetAcr90ErrMsg := 'Error in parameter 2.';
      SCARDSYNERR_PARM3       : GetAcr90ErrMsg := 'Error in parameter 3.';
      SCARDSYNERR_PARM4       : GetAcr90ErrMsg := 'Error in parameter 4.';
      SCARDSYNERR_PARM5       : GetAcr90ErrMsg := 'Error in parameter 5.';
      SCARDSYNERR_PARM6       : GetAcr90ErrMsg := 'Error in parameter 6.';
      SCARDSYNERR_PARM7       : GetAcr90ErrMsg := 'Error in parameter 7.';
      SCARDSYNERR_PARM8       : GetAcr90ErrMsg := 'Error in parameter 8.';
      SCARDSYNERR_PARM9       : GetAcr90ErrMsg := 'Error in parameter 9.';
      SCARDSYNERR_PARM10      : GetAcr90ErrMsg := 'Error in parameter 10.';
      SCARDSYNERR_PARM11      : GetAcr90ErrMsg := 'Error in parameter 11.';
      SCARDSYNERR_PARM12      : GetAcr90ErrMsg := 'Error in parameter 12.';
      SCARDSYNERR_PARM13      : GetAcr90ErrMsg := 'Error in parameter 13.';
      SCARDSYNERR_PARM14      : GetAcr90ErrMsg := 'Error in parameter 14.';
      SCARDSYNERR_PARM15      : GetAcr90ErrMsg := 'Error in parameter 15.';
      SCARDSYNERR_PARM16      : GetAcr90ErrMsg := 'Error in parameter 16.';
      SCARDSYNERR_PARM17      : GetAcr90ErrMsg := 'Error in parameter 17.';
      SCARDSYNERR_PARM18      : GetAcr90ErrMsg := 'Error in parameter 18.';
      SCARDSYNERR_PARM19      : GetAcr90ErrMsg := 'Error in parameter 19.';
      SCARDSYNERR_INSUFFICIENT_PRIV  : GetAcr90ErrMsg := 'No current rights to execute the requested action. You may need to present a password first.';
      SCARDSYNERR_PW_WRONG           : GetAcr90ErrMsg := 'The presented password is wrong.';
      SCARDSYNERR_PW_LOCKED          : GetAcr90ErrMsg := 'The password is locked. You may need to unblock it.';
      SCARDSYNERR_PW_TOO_SHORT       : GetAcr90ErrMsg := 'The password length is too short.';
      SCARDSYNERR_PW_TOO_LONG        : GetAcr90ErrMsg := 'The password length is too long.';
      SCARDSYNERR_PW_NOT_LOCKED      : GetAcr90ErrMsg := 'The password is not locked.';
      SCARDSYNERR_ITEM_NOT_FOUND      : GetAcr90ErrMsg := 'An item, e.g. a key of a specific name, could not be found.';
      SCARDSYNERR_ITEMS_LEFT          : GetAcr90ErrMsg := 'The directory or structure is not empty and cannot be deleted.';
      SCARDSYNERR_INVALID_CFG_FILE    : GetAcr90ErrMsg := 'Invalid configuration.';
      SCARDSYNERR_SECTION_NOT_FOUND   : GetAcr90ErrMsg := 'Section is not found.';
      SCARDSYNERR_ENTRY_NOT_FOUND     : GetAcr90ErrMsg := 'Entry is not found.';
      SCARDSYNERR_NO_MORE_SECTIONS    : GetAcr90ErrMsg := 'No more available sections.';
      SCARDSYNERR_ITEM_ALREADY_EXISTS : GetAcr90ErrMsg := 'The specified item already exists.';
      SCARDSYNERR_ITEM_EXPIRED        : GetAcr90ErrMsg := 'Some item, e.g. a certificate, has expired.';
      SCARDSYNERR_UNEXPECTED_RET_VALUE  : GetAcr90ErrMsg := 'Unexpected return value.';
      SCARDSYNERR_COMMUNICATE           : GetAcr90ErrMsg := 'General communication error.';
      SCARDSYNERR_NOT_ENOUGH_MEMORY     : GetAcr90ErrMsg := 'Not enough memory.';
      SCARDSYNERR_BUFFER_OVERFLOW       : GetAcr90ErrMsg := 'Buffer overflow.';
      SCARDSYNERR_TIMEOUT               : GetAcr90ErrMsg := 'A timeout has occured.';
      SCARDSYNERR_NOT_SUPPORTED         : GetAcr90ErrMsg := 'The requested functionality is not currently supported.';
      SCARDSYNERR_ILLEGAL_ARGUMENT      : GetAcr90ErrMsg := 'Illegal argument.';
      SCARDSYNERR_READ_FIO              : GetAcr90ErrMsg := 'File IO read error.';
      SCARDSYNERR_WRITE_FIO             : GetAcr90ErrMsg := 'File IO write error.';
      SCARDSYNERR_INVALID_HANDLE        : GetAcr90ErrMsg := 'Invalid handle.';
      SCARDSYNERR_GENERAL_FAILURE       : GetAcr90ErrMsg := 'General failure occurs.';
      SCARDSYNERR_FILE_NOT_FOUND        : GetAcr90ErrMsg := 'File not found.';
      SCARDSYNERR_OPEN_FILE             : GetAcr90ErrMsg := 'Failed to open file.';
      SCARDSYNERR_SEM_USED              : GetAcr90ErrMsg := 'The semaphore is currently used by another process.';
      SCARDSYNERR_NOP                   : GetAcr90ErrMsg := 'No operation was done.';
      SCARDSYNERR_NOK                   : GetAcr90ErrMsg := 'Function was not executed.';
      SCARDSYNERR_FWBUG                 : GetAcr90ErrMsg := 'Internal error detected.';
      SCARDSYNERR_INIT                  : GetAcr90ErrMsg := 'Module was not initialized.';
      SCARDSYNERR_FIO                   : GetAcr90ErrMsg := 'File IO error detected.';
      SCARDSYNERR_ALLOC                 : GetAcr90ErrMsg := 'System cannot allocate memory.';
      SCARDSYNERR_SESSION_ERR           : GetAcr90ErrMsg := 'General error.';
      SCARDSYNERR_ACCESS_ERR            : GetAcr90ErrMsg := 'Access is not allowed.';
      SCARDSYNERR_OPEN_FAILURE          : GetAcr90ErrMsg := 'Open command failed.';
      SCARDSYNERR_CARD_NOT_POWERED      : GetAcr90ErrMsg := 'Card is not powered.';
      SCARDSYNERR_ILLEGAL_CARDTYPE      : GetAcr90ErrMsg := 'Illegal card type.';
      SCARDSYNERR_CARD_NOT_INSERTED     : GetAcr90ErrMsg := 'Card is not inserted.';
      SCARDSYNERR_NO_DRIVER             : GetAcr90ErrMsg := 'No device driver installed.';
      SCARDSYNERR_OUT_OF_SERVICE        : GetAcr90ErrMsg := 'The service is not currently available.';
      SCARDSYNERR_EOF_REACHED           : GetAcr90ErrMsg := 'End of file is reached.';
      SCARDSYNERR_ON_BLACKLIST          : GetAcr90ErrMsg := 'The ID is blacklisted, requested action is not allowed.';
      SCARDSYNERR_CONSISTENCY_CHECK     : GetAcr90ErrMsg := 'Error during consistency check.';
      SCARDSYNERR_IDENTITY_MISMATCH     : GetAcr90ErrMsg := 'The identity does not match a defined cross-check identity.';
      SCARDSYNERR_MULTIPLE_ERRORS       : GetAcr90ErrMsg := 'Multiple errors had occured.';
      SCARDSYNERR_ILLEGAL_DRIVER        : GetAcr90ErrMsg := 'Illegal driver used.';
      SCARDSYNERR_ILLEGAL_FW_RELEASE    : GetAcr90ErrMsg := 'Software does not match the firmware.';
      SCARDSYNERR_NO_CARDREADER         : GetAcr90ErrMsg := 'No card reader is detected.';
      SCARDSYNERR_IPC_FAULT             : GetAcr90ErrMsg := 'General failure of interprocess communication.';
      SCARDSYNERR_WAIT_AND_RETRY        : GetAcr90ErrMsg := 'Current service does not take calls.';
      SCARDSYNERR_SCARD__E_CANCELLED                : GetAcr90ErrMsg := 'The action was cancelled by an SCardCancel request.';
      SCARDSYNERR_SCARD__E_INVALID_HANDLE           : GetAcr90ErrMsg := 'The supplied handle was invalid.';
      SCARDSYNERR_SCARD__E_INVALID_PARAMETER        : GetAcr90ErrMsg := 'One or more of the supplied parameters could not be properly interpreted.';
      SCARDSYNERR_SCARD__E_INVALID_TARGET           : GetAcr90ErrMsg := 'Registry startup information is missing or invalid.';
      SCARDSYNERR_SCARD__E_NO_MEMORY                : GetAcr90ErrMsg := 'Not enough memory available to complete this command.';
      SCARDSYNERR_SCARD__F_WAITED_TOO_LONG          : GetAcr90ErrMsg := 'An internal consistency timer has expired.';
      SCARDSYNERR_SCARD__E_INSUFFICIENT_BUFFER      : GetAcr90ErrMsg := 'The data buffer to receive returned data is too small for the returned data.';
      SCARDSYNERR_SCARD__E_UNKNOWN_READER           : GetAcr90ErrMsg := 'The specified reader name is not recognized.';
      SCARDSYNERR_SCARD__E_TIMEOUT                  : GetAcr90ErrMsg := 'The user-specified timeout value has expired.';
      SCARDSYNERR_SCARD__E_SHARING_VIOLATION        : GetAcr90ErrMsg := 'The smart card cannot be accessed because of other outstanding connections.';
      SCARDSYNERR_SCARD__E_NO_SMARTCARD             : GetAcr90ErrMsg := 'The operation requires a Smart Card, but no Smart Card is currently in the device.';
      SCARDSYNERR_SCARD__E_UNKNOWN_CARD             : GetAcr90ErrMsg := 'The specified smart card name is not recognized.';
      SCARDSYNERR_SCARD__E_CANT_DISPOSE             : GetAcr90ErrMsg := 'The system could not dispose of the media in the requested manner.';
      SCARDSYNERR_SCARD__E_PROTO_MISMATCH           : GetAcr90ErrMsg := 'The requested protocols are incompatible with the protocol currently in use with the smart card.';
      SCARDSYNERR_SCARD__E_NOT_READY                : GetAcr90ErrMsg := 'The reader or smart card is not ready to accept commands.';
      SCARDSYNERR_SCARD__E_INVALID_VALUE            : GetAcr90ErrMsg := 'One or more of the supplied parameters values could not be properly interpreted.';
      SCARDSYNERR_SCARD__E_SYSTEM_CANCELLED         : GetAcr90ErrMsg := 'The action was cancelled by the system, presumably to log off or shut down.';
      SCARDSYNERR_SCARD__F_COMM_ERROR               : GetAcr90ErrMsg := 'An internal communications error has been detected.';
      SCARDSYNERR_SCARD__F_UNKNOWN_ERROR            : GetAcr90ErrMsg := 'An internal error has been detected, but the source is unknown.';
      SCARDSYNERR_SCARD__E_INVALID_ATR              : GetAcr90ErrMsg := 'An ATR obtained from the registry is not a valid ATR string.';
      SCARDSYNERR_SCARD__E_NOT_TRANSACTED           : GetAcr90ErrMsg := 'An attempt was made to end a non-existent transaction.';
      SCARDSYNERR_SCARD__E_READER_UNAVAILABLE       : GetAcr90ErrMsg := 'The specified reader is not currently available for use.';
      SCARDSYNERR_SCARD__P_SHUTDOWN                 : GetAcr90ErrMsg := 'The operation has been aborted to allow the server application to exit.';
      SCARDSYNERR_SCARD__E_PCI_TOO_SMALL            : GetAcr90ErrMsg := 'The PCI Receive buffer was too small.';
      SCARDSYNERR_SCARD__E_READER_UNSUPPORTED       : GetAcr90ErrMsg := 'The reader driver does not meet minimal requirements for support.';
      SCARDSYNERR_SCARD__E_DUPLICATE_READER         : GetAcr90ErrMsg := 'The reader driver did not produce a unique reader name.';
      SCARDSYNERR_SCARD__E_CARD_UNSUPPORTED         : GetAcr90ErrMsg := 'The smart card does not meet minimal requirements for support.';
      SCARDSYNERR_SCARD__E_NO_SERVICE               : GetAcr90ErrMsg := 'The Smart card resource manager is not running.';
      SCARDSYNERR_SCARD__E_SERVICE_STOPPED          : GetAcr90ErrMsg := 'The Smart card resource manager has shut down.';
      SCARDSYNERR_SCARD__E_UNEXPECTED               : GetAcr90ErrMsg := 'An unexpected card error has occurred.';
      SCARDSYNERR_SCARD__E_ICC_INSTALLATION         : GetAcr90ErrMsg := 'No Primary Provider can be found for the smart card.';
      SCARDSYNERR_SCARD__E_ICC_CREATEORDER          : GetAcr90ErrMsg := 'The requested order of object creation is not supported.';
      SCARDSYNERR_SCARD__E_UNSUPPORTED_FEATURE      : GetAcr90ErrMsg := 'This smart card does not support the requested feature.';
      SCARDSYNERR_SCARD__E_DIR_NOT_FOUND            : GetAcr90ErrMsg := 'The identified directory does not exist in the smart card.';
      SCARDSYNERR_SCARD__E_FILE_NOT_FOUND           : GetAcr90ErrMsg := 'The identified file does not exist in the smart card.';
      SCARDSYNERR_SCARD__E_NO_DIR                   : GetAcr90ErrMsg := 'The supplied path does not represent a smart card directory.';
      SCARDSYNERR_SCARD__E_NO_FILE                  : GetAcr90ErrMsg := 'The supplied path does not represent a smart card file.';
      SCARDSYNERR_SCARD__E_NO_ACCESS                : GetAcr90ErrMsg := 'Access is denied to this file.';
      SCARDSYNERR_SCARD__E_WRITE_TOO_MANY           : GetAcr90ErrMsg := 'An attempt was made to write more data than would fit in the target object.';
      SCARDSYNERR_SCARD__E_BAD_SEEK                 : GetAcr90ErrMsg := 'There was an error trying to set the smart card file object pointer.';
      SCARDSYNERR_SCARD__E_INVALID_CHV              : GetAcr90ErrMsg := 'The supplied PIN is incorrect.';
      SCARDSYNERR_SCARD__E_UNKNOWN_RES_MNG          : GetAcr90ErrMsg := 'An unrecognized error code was returned from a layered component.';
      SCARDSYNERR_SCARD__E_NO_SUCH_CERTIFICATE      : GetAcr90ErrMsg := 'The requested certificate does not exist.';
      SCARDSYNERR_SCARD__E_CERTIFICATE_UNAVAILABLE  : GetAcr90ErrMsg := 'The requested certificate could not be obtained.';
      SCARDSYNERR_SCARD__E_NO_READERS_AVAILABLE     : GetAcr90ErrMsg := 'Cannot find a smart card reader.';
      SCARDSYNERR_SCARD__E_COMM_DATA_LOST           : GetAcr90ErrMsg := 'A communications error with the smart card has been detected.';
      SCARDSYNERR_SCARD__W_UNSUPPORTED_CARD         : GetAcr90ErrMsg := 'The reader cannot communicate with the smart card, due to ATR configuration conflicts.';
      SCARDSYNERR_SCARD__W_UNRESPONSIVE_CARD        : GetAcr90ErrMsg := 'The smart card is not responding to a reset.';
      SCARDSYNERR_SCARD__W_UNPOWERED_CARD           : GetAcr90ErrMsg := 'Power has been removed from the smart card, so that further communication is not possible.';
      SCARDSYNERR_SCARD__W_RESET_CARD               : GetAcr90ErrMsg := 'The smart card has been reset, so any shared state information is invalid.';
      SCARDSYNERR_SCARD__W_REMOVED_CARD             : GetAcr90ErrMsg := 'The smart card has been removed, so that further communication is not possible.';
      SCARDSYNERR_SCARD__W_SECURITY_VIOLATION       : GetAcr90ErrMsg := 'Access was denied because of a security violation.';
      SCARDSYNERR_SCARD__W_WRONG_CHV                : GetAcr90ErrMsg := 'The card cannot be accessed because the wrong PIN was presented.';
      SCARDSYNERR_SCARD__W_CHV_BLOCKED              : GetAcr90ErrMsg := 'The card cannot be accessed because the maximum number of PIN entry attempts has been reached.';
      SCARDSYNERR_SCARD__W_EOF                      : GetAcr90ErrMsg := 'The end of the smart card file has been reached.';
      SCARDSYNERR_SCARD__W_CANCELLED_BY_USER        : GetAcr90ErrMsg := 'The action was cancelled by the user.';
      else
        GetAcr90ErrMsg := 'Unknown Error: ' + Format('%d', [ErrCode]);
      end; // case statement
end;

////////////////////////////////////////////////////////////////////////////
//   GetShareModeStrMsg - displays the meaning or gives a brief description
////////////////////////////////////////////////////////////////////////////
Function GetShareModeStrMsg(Code : DWORD):string;
begin
   case Code of
SCARD_SCOPE_USER     : GetShareModeStrMsg := 'The context is a user context, and any database operations are performed within the domain of the user.';
SCARD_SCOPE_TERMINAL : GetShareModeStrMsg := 'The context is that of the current terminal, and any database operations are performed within the domain of that terminal.  (The calling application must have appropriate access permissions for any database actions.)';
SCARD_SCOPE_SYSTEM   : GetShareModeStrMsg := 'The context is the system context, and any database operations are performed within the domain of the system.  (The calling application must have appropriate access permissions for any database actions.)';
    end; // case statement
end;


////////////////////////////////////////////////////////////////////////////
//   GetReaderStateStrMsg - displays the meaning or gives a brief description
////////////////////////////////////////////////////////////////////////////
Function GetReaderStateStrMsg(Code : DWORD):string;
begin
   case Code of
SCARD_UNKNOWN    : GetReaderStateStrMsg := 'This value implies the driver is unaware of the current state of the reader.';
SCARD_ABSENT     : GetReaderStateStrMsg := 'This value implies there is no card in the reader.';
SCARD_PRESENT    : GetReaderStateStrMsg := 'This value implies there is a card is present in the reader, but that it has not been moved into position for use.';
SCARD_SWALLOWED  : GetReaderStateStrMsg := 'This value implies there is a card in the reader in position for use.  The card is not powered.';
SCARD_POWERED    : GetReaderStateStrMsg := 'This value implies there is power is being provided to the card, but the Reader Driver is unaware of the mode of the card.';
SCARD_NEGOTIABLE : GetReaderStateStrMsg := 'This value implies the card has been reset and is awaiting PTS negotiation.';
SCARD_SPECIFIC   : GetReaderStateStrMsg := 'This value implies the card has been reset and specific communication protocols have been established.';
    end; // case statement
end;


////////////////////////////////////////////////////////////////////////////
//   GetDisposistionStrMsg - displays the meaning or gives a brief description
////////////////////////////////////////////////////////////////////////////
Function GetDisposistionStrMsg(Code : DWORD):string;
begin
   case Code of
SCARD_LEAVE_CARD     : GetDisposistionStrMsg := 'Don''t do anything special on close';
SCARD_RESET_CARD     : GetDisposistionStrMsg := 'Reset the card on close';
SCARD_UNPOWER_CARD   : GetDisposistionStrMsg := 'Power down the card on close';
SCARD_EJECT_CARD     : GetDisposistionStrMsg := 'Eject the card on close';
    end; // case statement
end;


////////////////////////////////////////////////////////////////////////////
//   GetProtocolStrMsg - displays the meaning or gives a brief description
////////////////////////////////////////////////////////////////////////////
Function GetProtocolStrMsg(Code : DWORD):string;
begin
   case Code of
SCARD_PROTOCOL_UNDEFINED    :GetProtocolStrMsg := 'There is no active protocol.';
SCARD_PROTOCOL_T0           :GetProtocolStrMsg := 'T=0 is the active protocol.';
SCARD_PROTOCOL_T1           :GetProtocolStrMsg := 'T=1 is the active protocol.';
SCARD_PROTOCOL_RAW          :GetProtocolStrMsg := 'Raw is the active protocol.';
SCARD_PROTOCOL_DEFAULT      :GetProtocolStrMsg := 'Use implicit PTS.';
    end; // case statement
end;

////////////////////////////////////////////////////////////////////////////
//   GetProtocolFlagStrMsg - displays the meaning or gives a brief description
////////////////////////////////////////////////////////////////////////////
Function GetProtocolFlagStrMsg(Code : DWORD):string;
begin
   case Code of
SCARD_STATE_UNAWARE    :GetProtocolFlagStrMsg := 'The application is unaware of the current state, and would like to know.  The use of this value results in an immediate return from state transition monitoring services.  This is represented by all bits set to zero.';
SCARD_STATE_IGNORE     :GetProtocolFlagStrMsg := 'The application requested that this reader be ignored.  No other bits will be set.';
SCARD_STATE_CHANGED    :GetProtocolFlagStrMsg := 'This implies that there is a difference between the state believed by the application, and the state known by the Service Manager.  When this bit is set, the application may assume a significant state change has occurred on this reader.';
SCARD_STATE_UNKNOWN    :GetProtocolFlagStrMsg := 'This implies that the given reader name is not recognized by the Service Manager.  If this bit is set, then SCARD_STATE_CHANGED and SCARD_STATE_IGNORE will also be set.';
SCARD_STATE_UNAVAILABLE:GetProtocolFlagStrMsg := 'This implies that the actual state of this reader is not available.  If this bit is set, then all the following bits are clear.';
SCARD_STATE_EMPTY      :GetProtocolFlagStrMsg := 'This implies that there is not card in the reader.  If this bit is set, all the following bits will be clear.';
SCARD_STATE_PRESENT    :GetProtocolFlagStrMsg := 'This implies that there is a card in the reader.';
SCARD_STATE_ATRMATCH   :GetProtocolFlagStrMsg := 'This implies that there is a card in the reader with an ATR matching one of the target cards. If this bit is set, SCARD_STATE_PRESENT will also be set.  This bit is only returned on the SCardLocateCard() service.';
SCARD_STATE_EXCLUSIVE  :GetProtocolFlagStrMsg := 'This implies that the card in the reader is allocated for exclusive use by another application.  If this bit is set, SCARD_STATE_PRESENT will also be set.';
SCARD_STATE_INUSE      :GetProtocolFlagStrMsg := 'This implies that the card in the reader is in use by one or more other applications, but may be connected to in shared mode.  If this bit is set, SCARD_STATE_PRESENT will also be set.';
SCARD_STATE_MUTE       :GetProtocolFlagStrMsg := 'This implies that the card in the reader is unresponsive or not supported by the reader or software.';
SCARD_STATE_UNPOWERED  :GetProtocolFlagStrMsg := 'This implies that the card in the reader has not been powered up.';
    end; // case statement
end;


end.







