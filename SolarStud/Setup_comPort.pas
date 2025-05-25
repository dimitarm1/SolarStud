{$APPTYPE CONSOLE}

uses Windows,
     SysUtils;

var c           : char;
    hComm       : THandle;
    ComPortName : PChar;
    EventMask   : DWord;
    dcb         : TDCB;

procedure ModemSendBlock(var Block; BlockSize : word);
var numread : DWord;
begin;
 WriteFile ( hComm, Block, BlockSize, numread, nil );
end;

function ModemGetChar : char;
var c       : char;
    numread : DWord;
begin;
 ReadFile ( hComm, c, sizeof(c), numread, nil );
 if (numread = 0) then ModemGetChar := #0 else ModemGetChar := c;
end;

var s : string;
    done : boolean;
   
begin
ComPortName := StrAlloc(Length('COM2')+1);
StrPCopy(ComPortName,'COM2');

hComm := CreateFile (ComPortName,GENERIC_READ or GENERIC_WRITE,0, nil,
                     OPEN_EXISTING,0,0);
StrDispose(ComPortName);

SetupComm ( hComm, 32768, 32768 );
GetCommState( hComm, dcb );
SetCommMask( hComm, EV_RXCHAR );
dcb.BaudRate := 19200;
SetCommState( hComm, dcb );

s := 'AT&V'#13;
ModemSendBlock(s[1],length(s));

while (not done) do
      begin;
      WaitCommEvent ( hComm, EventMask, nil );
      c := ModemGetChar;
      write(c);
      end;

CloseHandle(hComm);
hComm := 0;
end.


Example C++ code

#include "Windows.H"

DWORD __stdcall listenThread (LPVOID pVoid)
{
    HANDLE hCom4 = (HANDLE) pVoid;
    SetCommMask (hCom4, EV_RXCHAR);

    char buf [1024];
    DWORD dwBytesReaded, event;

    COMSTAT stat;
    OVERLAPPED overlap;
    memset (&overlap, 0, sizeof (overlap));

    HANDLE hConsole = GetStdHandle (STD_OUTPUT_HANDLE);

    while (1)
    {
        WaitCommEvent (hCom4, &event, NULL);
        ClearCommError (hCom4, &event, &stat);

        ReadFile (hCom4, buf, min (1023, stat. cbInQue),
            &dwBytesReaded, &overlap);
        GetOverlappedResult (hCom4, &overlap, &dwBytesReaded, FALSE);

        WriteConsole (hConsole, buf, dwBytesReaded, &dwBytesReaded, NULL);
    }
    return 0;
} // listenThread

int main (int argc, char **argv)
{
    if (argc < 2) return 1;
    OVERLAPPED overlap;
    memset (&overlap, 0, sizeof (overlap));

    HANDLE hCom4  = CreateFile (argv [1],
        GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING,
        FILE_ATTRIBUTE_NORMAL | FILE_FLAG_OVERLAPPED, NULL);

    SetupComm (hCom4, 4096, 4096);
    SetCommMask (hCom4, EV_RXCHAR);

    EscapeCommFunction (hCom4, SETDTR);

    DWORD dwThreadID, dwBytesWritten, dwEventsRead;

    HANDLE hThread = CreateThread
        (NULL, 0, listenThread, hCom4, 0, &dwThreadID);

    INPUT_RECORD message;
    char symbol, process = 1, buf [5];

    HANDLE hConsole = GetStdHandle (STD_INPUT_HANDLE);

    while (ReadConsoleInput (hConsole, &message, 1, &dwEventsRead) &&
           process)
    {
        if ((message. EventType == KEY_EVENT) &&
            (message. Event. KeyEvent. bKeyDown))
        {
            symbol = message. Event. KeyEvent. uChar. AsciiChar;
            if (message. Event. KeyEvent. dwControlKeyState &
               (LEFT_ALT_PRESSED | RIGHT_ALT_PRESSED))
            {
                switch (symbol)
                {
                    case 'x': process = 0; *buf = 0; break;
                    // ... allow to dispatch more Alt+? ....
                    default: continue;
                }
                symbol = 0;
            }

            if (symbol)
            {
                buf [0] = symbol;
                buf [1] = 0;
            }

            if (*buf)
            {
                dwEventsRead = WriteFile (hCom4, buf,
                    lstrlen (buf), &dwBytesWritten, &overlap);
                WaitForSingleObject (overlap. hEvent, 1000);
                GetOverlappedResult (hCom4, &overlap, &dwBytesWritten,
FALSE);
                *buf = 0;
            }
        }
    }

    TerminateThread (hThread, 1);
    CloseHandle (hThread);
    CloseHandle (hCom4);
    return 0;
} // main

