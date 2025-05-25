// get the latest windows.inc from
// http://www.ionicwind.com/forums/index.php/topic,633.msg21983.html#msg21983
#include "windows.inc"
#include "stdio.inc"
 
sub main()
{
	dstring buf[32];
	DWORD ErrorCode;
	BOOL success;
 
	// open the first COM port
	string *PortName = "COM3";
	HANDLE hPort = CreateFile(PortName, GENERIC_READ|GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, 0);
 
	if (hPort == INVALID_HANDLE_VALUE)
	{
		// failed, but why?
		return ShowError("Failed to open %s: \n", PortName, 0);
	}
 
	// change port settings
	DCB dcb;
	dcb.DCBlength = sizeof(dcb);
	// baud=b
	// parity=p
	// data=d
	// stop=s
	// to={on|off}
	// xon={on|off}
	// odsr={on|off}
	// octs={on|off}
	// dtr={on|off|hs}
	// rts={on|off|hs|tg}
	// idsr={on|off}
	success = BuildCommDCB("baud=1200 parity=N data=8 stop=1", &dcb);
 
	// check for error
	if (!success)
	{
		return ShowError("BuildCommDCB failed: ", NULL, hPort);
	}
 
	// apply new transmission settings
	success = SetCommState(hPort, &dcb);
 
	// check for error
	if (!success)
	{
		ShowError("Failed to configure %s: \n", PortName, 0);
		ShowComConfigDialog(hPort, PortName, 0);
	}
 
	// configure time-out parameters
	COMMTIMEOUTS ct;
	ct.ReadIntervalTimeout         = 3000; // total time for reading data (3s)
	ct.ReadTotalTimeoutMultiplier  =  100; // maximum time for receiving a byte (100ms)
	ct.ReadTotalTimeoutConstant    =    1;
	ct.WriteTotalTimeoutMultiplier =  100; // maximum time for sending a byte
	ct.WriteTotalTimeoutConstant   =    1;
 
	success = SetCommTimeouts(hPort, &ct);
 
	// check for error
	if (!success)
	{
		return ShowError("Failed to set new timeouts on %s: \n", PortName, hPort);
	}
 
	// write data to port
	string *pData = "cq dx";
 
	DWORD BytesWriten;
	DWORD BytesToWrite = strlen(pData);
 
	success = WriteFile(hPort, pData, BytesToWrite, &BytesWriten, 0);
 
	// check for error
	if (!success)
	{
		return ShowError("Failed to write data to %s: \n", PortName, hPort);
	}
 
	// read response
	DWORD BytesRead;
	DWORD BytesToRead = 31; // size of <buf> is 32; reserve one byte for NULL
	string *ReadBuffer = &buf;
 
	success = ReadFile(hPort, ReadBuffer, BytesToRead, &BytesRead, 0);
 
	// check for error
	if (!success)
	{
		return ShowError("Failed to read data from %s: \n", PortName, hPort);
	}
 
	// received BytesRead bytes
	// If received data is a string, show it:
	*ReadBuffer[BytesRead] = 0; // cut all after received data
	MessageBox(0, *ReadBuffer, "Received data");
 
	// close the port and quit
	CloseHandle(hPort);
}
 
 
sub ShowError(string *format, string *arg1, HANDLE hPort),int
{
	string buf;
 
	DWORD ErrorCode = GetLastError();
 
	if (hPort)
		CloseHandle(hPort);
 
	int i = sprintf(buf, format, arg1);
 
	FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
		0, ErrorCode, 0, &buf + i, 256 - i, 0);
 
	return MessageBox(0, buf, "Error");
}
 
 
// instead calling BuildCommDCB and SetCommState (or when SetCommState fails),
// use this function to open a dialog with configuration
// hPort    - opened COM1
// PortName - "COM1"
// hwndParent - zero, or handle to your window
sub ShowComConfigDialog(HANDLE hPort, string *PortName, HWND hwndParent)
{
	COMMCONFIG cc;
 
	DWORD cch = sizeof(cc);
	if (!GetCommConfig(hPort, &cc, &cch))
	{
		ShowError("Failed to read device configuration:", 0, 0);
	}
	else
	{
		if (CommConfigDialog(PortName, hwndParent, &cc))
		{
			SetCommConfig(hPort, &cc, sizeof(cc));
		}
	}
}

« Last Edit: August 04, 2008, 01:48:26 PM by sapero » 