unit testcom3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  Ttestform = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Timer1: TTimer;
    Edit1: TEdit;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label5: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type _RS232DCB = packed record // dcb
     DCBlength: DWORD;           // sizeof(DCB)
     BaudRate: DWORD;            // current baud rate
     fBinary: DWORD;          // binary mode, no EOF check
     fParity: DWORD;          // enable parity checking
     fOutxCtsFlow: DWORD;      // CTS output flow control
     fOutxDsrFlow: DWORD;      // DSR output flow control
     fDtrControl: DWORD;       // DTR flow control type
     fDsrSensitivity: DWORD;   // DSR sensitivity

     fTXContinueOnXoff: DWORD; // XOFF continues Tx
     fOutX: DWORD;            // XON/XOFF out flow control
     fInX: DWORD;             // XON/XOFF in flow control
     fErrorChar: DWORD;       // enable error replacement
     fNull: DWORD;            // enable null stripping
     fRtsControl: DWORD;       // RTS flow control
     fAbortOnError: DWORD;     // abort reads/writes on error
     fDummy2: DWORD;          // reserved
     wReserved: WORD;            // not currently used

     XonLim: WORD;               // transmit XON threshold
     XoffLim: WORD;              // transmit XOFF threshold
     ByteSize: BYTE;             // number of bits/byte, 4-8
     Parity: BYTE;               // 0-4=no,odd,even,mark,space
     StopBits: BYTE;             // 0,1,2 = 1, 1.5, 2
     XonChar: char;              // Tx and Rx XON character
     XoffChar: char;             // Tx and Rx XOFF character
     ErrorChar: char;            // error replacement character

     EofChar: char;              // end of input character
     EvtChar: char;              // received event character
     wReserved1: WORD;           // reserved; do not use
end;
var
   hDevice : HWND;
  testform: Ttestform;
    ComFlags: byte;
  ComList: LPSTR;
  CB_RS232: _DCB;
  CB_RS232_NEW: _RS232DCB;
  RS_232_Timeouts: _COMMTIMEOUTS;
  IOResult: Boolean;
  IOCount: DWORD;
  IOByte: BYTE;
  Chanel: Byte;
  MainTime: Integer;
  PreTime:Integer;
  CoolTime: Integer;
const

  UART_BASEADDR=$3E8; //  the base address of the UART
  UART_BAUDRATE=9600; //   the divisor value (e.g. 12 for 9600 baud)
  UART_LCRVAL=$1b;    // the value to be written to the LCR (e.g. 0x1b for 8N1)
  UART_FCRVAL=$07;    // the value to be written to the FCR. Bit 0, 1 and 2 set,
                  // bits 6 & 7 according to wished trigger level (see above)


implementation

{$R *.dfm}
procedure config_uart(const n1: short);
begin
 SetCommState(hDevice, CB_RS232) ;
 EscapeCommFunction(hDevice, CLRDTR);
 EscapeCommFunction(hDevice, SETRTS		);
end;
procedure init_uart(const n1: short);

begin

    hDevice := CreateFile(
        'COM2',                 // pointer to name of the file
        GENERIC_READ or GENERIC_WRITE,       // access (read-write) mode
        FILE_SHARE_READ or FILE_SHARE_WRITE, // share mode
        NIL,                               // pointer to security attributes
        OPEN_EXISTING,                      // how to create
        0,                                  // file attributes
        0);                              // handle to file with attributes to copy
    if (hDevice = INVALID_HANDLE_VALUE) then    // did we succeed?
    begin
        Application.MessageBox('Програмата няма достъп до серийния порт!', 'error', MB_OK);
        Application.Terminate;
        // possibly call GetLastError() to get a hint what failed
        // and terminate (it is useless to continue if we can’t connect to Direct I/O)
    end;

    // some more processing...

    CB_RS232.DCBlength:= SizeOf (CB_RS232);           // sizeof(DCB)
    CB_RS232.BaudRate:=9600;            // current baud rate
    CB_RS232.Flags:= $31 ;//$31;
    CB_RS232.wReserved:=0;            // not currently used
    CB_RS232.XonLim:=1;               // transmit XON threshold
    CB_RS232.XoffLim:=1;              // transmit XOFF threshold
    CB_RS232.ByteSize:=8;             // number of bits/byte, 4-8
    CB_RS232.Parity:=0;               // 0-4=no,odd,even,mark,space
    CB_RS232.StopBits:=1;             // 0,1,2 = 1, 1.5, 2
    CB_RS232.XonChar:='x';              // Tx and Rx XON character
    CB_RS232.XoffChar:='X';             // Tx and Rx XOFF character
    CB_RS232.ErrorChar:='E';            // error replacement character

    CB_RS232.EofChar:='T';              // end of input character
    CB_RS232.EvtChar:='R';              // received event character
    CB_RS232.wReserved1:=0;           // reserved; do not use

    RS_232_Timeouts.ReadIntervalTimeout:=100;
    RS_232_Timeouts.ReadIntervalTimeout:=100;
    RS_232_Timeouts.ReadTotalTimeoutMultiplier:=100;
    config_uart(1);
    SetCommTimeouts(hDevice,RS_232_Timeouts);

end;
procedure mode_set();
var
  Macro: string;
  Cmd: array[0..255] of Char;
begin
  // Macro := 'mode com2: baud=9600 data=8 parity=n to=on';
   Macro := 'set_com2.bat';
   StrPCopy (Cmd, Macro);
   WinExec(Cmd, SW_RESTORE);
 
end;


procedure SendData(DataSent: Byte;Index: Integer);
var IOResult: LongBool;
    Data1:Byte;
   // Chanel: Byte;
    //PreTime: Byte;
    //CoolTime: Byte;
    CheckSum:Byte;
    CheckSum1:Byte;
    Retry: Integer;
    LineText: String;
begin
 retry:=0;
 testForm.Timer1.Enabled:=False;
  DataSent:=StrToInt('0x'+IntToStr(DataSent));
  if not testform.CheckBox2.Checked then    Chanel:=StrToInt(testform.Edit1.text);
  //PreTime:=3;
 // CoolTime:=7;
 cHECKsUM1:=0;
 testform.Edit1.Text:=IntToStr(Chanel);
  CheckSum:=PreTime+CoolTime-DataSent-5;
  CheckSum:=CheckSum mod 128 ;
  testform.Label1.Caption:=IntToStr(preTime);
  testform.Label2.Caption:=IntToHex(DataSent,2);
  testform.Label3.Caption:=IntToStr(CoolTime);
  while retry<10 do
  begin

   Data1:=128+Chanel*8+2; // Set PRE-Time
   IOResult:=WriteFile(hDevice,Data1,1,IOCount,NIL);
   sleep(1);
   IOResult:=WriteFile(hDevice,PreTime,1,IOCount,NIL);
   Data1:=128+Chanel*8+5; // Set main time
   sleep(1);
   IOResult:=WriteFile(hDevice,Data1,1,IOCount,NIL);
   sleep(1);
   IOResult:=WriteFile(hDevice,DataSent,1,IOCount,NIL);
   sleep(1);
   Data1:=128+Chanel*8+3; //
   IOResult:=WriteFile(hDevice,Data1,1,IOCount,NIL);
   sleep(1);
   IOResult:=WriteFile(hDevice,CoolTime,1,IOCount,NIL);
   sleep(5);
   IOResult:=ReadFile(hDevice,IOByte,1,IOCount,NIL);
   Application.ProcessMessages;
  // cHECKsUM:=7;
   IOResult:=WriteFile(hDevice,CheckSum,1,IOCount,NIL);
      sleep(5);
  // IOResult:=ReadFile(hDevice,IOByte,1,IOCount,NIL);
   LineText:='Sent>'+IntToHex(CheckSum,2)+' Received>'+IntToHex(IOByte,2);
   if IOCount>0 then    testform.Memo1.font.Color:=clNavy else   testform.Memo1.font.Color:=clRed;
   testform.Memo1.Lines.Add(LineText);
   if TestForm.Memo1.Lines.Count>20 then  TestForm.Memo1.Lines.Delete(1);
   if CheckSum=IOByte then retry:=10 else retry:= retry+1;
   IOResult:=ReadFile(hDevice,IOByte,1,IOCount,NIL);
   IOResult:=ReadFile(hDevice,IOByte,1,IOCount,NIL);
  end;
  testForm.Timer1.Enabled:=True;
end;
procedure Ttestform.Timer1Timer(Sender: TObject);
begin
if CheckBox1.Checked then
 begin
  MainTime:=MainTime+1;
  if MainTime>30 then begin
   MainTime:=1;PreTime:=PreTime+1;end;
  if PreTime>30 then begin
   PreTime:=1;CoolTime:=CoolTime+1;end;
  if CoolTime>10 then CoolTime:=0;
 end
else
 begin
  TryStrToInt(Edit3.Text,MainTime);
  TryStrToInt(Edit2.Text,PreTime);
  TryStrToInt(Edit4.Text,CoolTime);
 end;
 if CheckBox2.Checked then
 begin
 Chanel:=Chanel+1; if Chanel>15 then Chanel:=0;
 end;
 SendData(MainTime,1);


end;

procedure Ttestform.Button1Click(Sender: TObject);
begin
if memo1.Lines.Count<10 then
begin
Chanel:=StrToInt(Edit1.Text);
mode_set;
sleep(2000);
init_uart(1);
config_uart(1);
end;
PreTime:=1;
CoolTime:=1;
testform.Timer1.Enabled:=True;

end;

procedure Ttestform.Button2Click(Sender: TObject);
begin
   testform.Timer1.Enabled:=False;
   MainTime:=0;
end;

end.


