unit testcom1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm1 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
    ComFlags: byte;
  ComList: LPSTR;
  CB_RS232: _DCB;
  CB_RS232_NEW: _RS232DCB;
  RS_232_Timeouts: _COMMTIMEOUTS;
  IOResult: Boolean;
  IOCount: DWORD;
  IOByte: BYTE;

implementation

{$R *.dfm}
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
   WinExec(PChar('Delotch.bat'),SW_RESTORE);
end;
procedure config_uart(const n1: short);
begin
 SetCommState(hDevice, CB_RS232) ;
 EscapeCommFunction(hDevice, CLRDTR);
end;

procedure SendData(DataSent: Byte;Index: Integer);
var IOResult: LongBool;
    Data1:Byte;
    Chanel: Byte;
    PreTime: Byte;
    CoolTime: Byte;
    CheckSum:Byte;
    Retry: Integer;
begin
 retry:=0;
 MainForm.Timer1.Enabled:=False;
  MainForm.Table1.RecNo:=Index;
  DataSent:=StrToInt('0x'+IntToStr(DataSent));
  Chanel:=MainForm.Table1.FieldByName('ADDRESS').AsInteger;
  PreTime:=MainForm.Table1.FieldByName('PREDVVREME').AsInteger;
  CoolTime:=MainForm.Table1.FieldByName('OHLAZDANE').AsInteger;
  CheckSum:=3-PreTime-CoolTime-DataSent;
  while retry<10 do
  begin

   Data1:=128+Chanel*8+2; // Set PRE-Time
   IOResult:=WriteFile(hDevice,Data1,1,IOCount,NIL);
   sleep(20);
   IOResult:=WriteFile(hDevice,PreTime,1,IOCount,NIL);
   Data1:=128+Chanel*8+5; // Set main time
    sleep(20);
   IOResult:=WriteFile(hDevice,Data1,1,IOCount,NIL);
    sleep(20);
   IOResult:=WriteFile(hDevice,DataSent,1,IOCount,NIL);
    sleep(40);
   Data1:=128+Chanel*8+3; //
   IOResult:=WriteFile(hDevice,Data1,1,IOCount,NIL);
    sleep(20);
   IOResult:=WriteFile(hDevice,CoolTime,1,IOCount,NIL);

    sleep(80);
   IOResult:=ReadFile(hDevice,IOByte,1,IOCount,NIL);
   if CheckSum=IOByte then retry:=10 else retry:= retry+1;
   IOResult:=ReadFile(hDevice,IOByte,1,IOCount,NIL);
   IOResult:=ReadFile(hDevice,IOByte,1,IOCount,NIL);
  end;
  MainForm.Timer1.Enabled:=True;
end;
end.
