//  Copyright(C):      Advanced Card Systems Ltd
//
//  File:              SLE4432_4442Dlg.pas
//
//  Description:       This sample program outlines the steps on how to
//                     program SLE4432/4442 memory cards using ACS readers
//                     in PC/SC platform.
//
//  Author:	           Jose Isagani R. Mission
//
//  Date:	           June 25, 2004
//
//  Revision Trail:   (Date/Author/Description)
//
//======================================================================
// SLE4432_4442Dlg.cpp : implementation file
//

#include "stdafx.h"
#include "SLE4432_4442.h"
#include "SLE4432_4442Dlg.h"

// ==========================================================================
// SLE4432_4442Dlg include file
#include "Winscard.h"

// SLE4432_4442Dlg GlobalVariables
	SCARDCONTEXT			hContext;
	SCARDHANDLE				hCard;
	unsigned long			dwActProtocol;
	LPCBYTE					pbSend;
	DWORD					dwSend, dwRecv, size = 64;
	LPBYTE					pbRecv;
	SCARD_IO_REQUEST		ioRequest;
	int						retCode;
    char					readerName [256];
	DWORD					SendLen,
							RecvLen,
							nBytesRet;
	CmdBytes				apdu;
	BYTE					SendBuff[262],
							RecvBuff[262];
	BOOL					connActive;
	CSLE4432_4442Dlg	    *pThis=NULL;
// ==========================================================================

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSLE4432_4442Dlg dialog

CSLE4432_4442Dlg::CSLE4432_4442Dlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSLE4432_4442Dlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSLE4432_4442Dlg)
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDI_ICON1);
}

void CSLE4432_4442Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSLE4432_4442Dlg)
	DDX_Control(pDX, IDC_BUTTON4, bChange);
	DDX_Control(pDX, IDC_BUTTON6, bWriteProt);
	DDX_Control(pDX, IDC_EDIT1, tAdd);
	DDX_Control(pDX, IDC_RADIO1, rbSLE4432);
	DDX_Control(pDX, IDC_COMBO1, cbReader);
	DDX_Control(pDX, IDC_LIST1, mMsg);
	DDX_Control(pDX, IDC_EDIT4, tData);
	DDX_Control(pDX, IDC_EDIT3, tLen);
	DDX_Control(pDX, IDC_BUTTON9, bReset);
	DDX_Control(pDX, IDC_BUTTON8, bErrCtr);
	DDX_Control(pDX, IDC_BUTTON7, bSubmit);
	DDX_Control(pDX, IDC_BUTTON5, bWrite);
	DDX_Control(pDX, IDC_BUTTON3, bRead);
	DDX_Control(pDX, IDC_BUTTON2, bConnect);
	DDX_Control(pDX, IDC_BUTTON10, bQuit);
	DDX_Control(pDX, IDC_BUTTON1, bInit);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CSLE4432_4442Dlg, CDialog)
	//{{AFX_MSG_MAP(CSLE4432_4442Dlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON1, OnInit)
	ON_BN_CLICKED(IDC_BUTTON9, OnReset)
	ON_BN_CLICKED(IDC_BUTTON10, OnQuit)
	ON_BN_CLICKED(IDC_BUTTON2, OnConnect)
	ON_BN_CLICKED(IDC_RADIO1, OnSLE4418)
	ON_CBN_EDITCHANGE(IDC_COMBO1, OnEditchangeCombo1)
	ON_BN_CLICKED(IDC_RADIO2, OnSLE4428)
	ON_BN_CLICKED(IDC_BUTTON3, OnRead)
	ON_BN_CLICKED(IDC_BUTTON4, OnReadProt)
	ON_BN_CLICKED(IDC_BUTTON5, OnWrite)
	ON_BN_CLICKED(IDC_BUTTON7, OnSubmit)
	ON_BN_CLICKED(IDC_BUTTON8, OnErrCtr)
	ON_BN_CLICKED(IDC_BUTTON6, OnWriteProt)
	ON_CBN_SELCHANGE(IDC_COMBO1, OnSelchangeCombo1)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

// ==========================================================================
// SLE4432_4442Dlg internal routines

static CString GetScardErrMsg(int code)
{
	switch(code)
	{
	// Smartcard Reader interface errors
	case SCARD_E_CANCELLED:
		return ("The action was canceled by an SCardCancel request.");
		break;
	case SCARD_E_CANT_DISPOSE:
		return ("The system could not dispose of the media in the requested manner.");
		break;
	case SCARD_E_CARD_UNSUPPORTED:
		return ("The smart card does not meet minimal requirements for support.");
		break;
	case SCARD_E_DUPLICATE_READER:
		return ("The reader driver didn't produce a unique reader name.");
		break;
	case SCARD_E_INSUFFICIENT_BUFFER:
		return ("The data buffer for returned data is too small for the returned data.");
		break;
	case SCARD_E_INVALID_ATR:
		return ("An ATR string obtained from the registry is not a valid ATR string.");
		break;
	case SCARD_E_INVALID_HANDLE:
		return ("The supplied handle was invalid.");
		break;
	case SCARD_E_INVALID_PARAMETER:
		return ("One or more of the supplied parameters could not be properly interpreted.");
		break;
	case SCARD_E_INVALID_TARGET:
		return ("Registry startup information is missing or invalid.");
		break;
	case SCARD_E_INVALID_VALUE:
		return ("One or more of the supplied parameter values could not be properly interpreted.");
		break;
	case SCARD_E_NOT_READY:
		return ("The reader or card is not ready to accept commands.");
		break;
	case SCARD_E_NOT_TRANSACTED:
		return ("An attempt was made to end a non-existent transaction.");
		break;
	case SCARD_E_NO_MEMORY:
		return ("Not enough memory available to complete this command.");
		break;
	case SCARD_E_NO_SERVICE:
		return ("The smart card resource manager is not running.");
		break;
	case SCARD_E_NO_SMARTCARD:
		return ("The operation requires a smart card, but no smart card is currently in the device.");
		break;
	case SCARD_E_PCI_TOO_SMALL:
		return ("The PCI receive buffer was too small.");
		break;
	case SCARD_E_PROTO_MISMATCH:
		return ("The requested protocols are incompatible with the protocol currently in use with the card.");
		break;
	case SCARD_E_READER_UNAVAILABLE:
		return ("The specified reader is not currently available for use.");
		break;
	case SCARD_E_READER_UNSUPPORTED:
		return ("The reader driver does not meet minimal requirements for support.");
		break;
	case SCARD_E_SERVICE_STOPPED:
		return ("The smart card resource manager has shut down.");
		break;
	case SCARD_E_SHARING_VIOLATION:
		return ("The smart card cannot be accessed because of other outstanding connections.");
		break;
	case SCARD_E_SYSTEM_CANCELLED:
		return ("The action was canceled by the system, presumably to log off or shut down.");
		break;
	case SCARD_E_TIMEOUT:
		return ("The user-specified timeout value has expired.");
		break;
	case SCARD_E_UNKNOWN_CARD:
		return ("The specified smart card name is not recognized.");
		break;
	case SCARD_E_UNKNOWN_READER:
		return ("The specified reader name is not recognized.");
		break;
	case SCARD_F_COMM_ERROR:
		return ("An internal communications error has been detected.");
		break;
	case SCARD_F_INTERNAL_ERROR:
		return ("An internal consistency check failed.");
		break;
	case SCARD_F_UNKNOWN_ERROR:
		return ("An internal error has been detected, but the source is unknown.");
		break;
	case SCARD_F_WAITED_TOO_LONG:
		return ("An internal consistency timer has expired.");
		break;
	case SCARD_W_REMOVED_CARD:
		return ("The smart card has been removed and no further communication is possible.");
		break;
	case SCARD_W_RESET_CARD:
		return ("The smart card has been reset, so any shared state information is invalid.");
		break;
	case SCARD_W_UNPOWERED_CARD:
		return ("Power has been removed from the smart card and no further communication is possible.");
		break;
	case SCARD_W_UNRESPONSIVE_CARD:
		return ("The smart card is not responding to a reset.");
		break;
	case SCARD_W_UNSUPPORTED_CARD:
		return ("The reader cannot communicate with the card due to ATR string configuration conflicts.");
		break;
	case NO_READER_INSTALLED:
		return ("The smartcard reader is not installed in your system.");
		break;
	}
	return ("Error is not documented.");
}

void ClearBuffers()
{
	int indx;
    for (indx = 0;indx<263;indx++)
    {
      SendBuff[indx] = 0x00;
      RecvBuff[indx] = 0x00;
	}
}

void ClearFields()
{

	pThis->tAdd.SetWindowText("");
	pThis->tLen.SetWindowText("");
	pThis->tData.SetWindowText("");

}

void EnableFields()
{
	pThis->tAdd.EnableWindow(TRUE);
	pThis->tAdd.SetLimitText(2);
	pThis->tLen.EnableWindow(TRUE);
	pThis->tLen.SetLimitText(2);
	pThis->tData.EnableWindow(TRUE);
}

void DisableFields()
{
	pThis->tAdd.EnableWindow(FALSE);
	pThis->tLen.EnableWindow(FALSE);
	pThis->tData.EnableWindow(FALSE);
}

void InitMenu()
{
	pThis->cbReader.ResetContent();
    pThis->mMsg.ResetContent();
	pThis->rbSLE4432.SetCheck(0);
	pThis->cbReader.EnableWindow(FALSE);
	pThis->bInit.EnableWindow(TRUE);
	pThis->bConnect.EnableWindow(FALSE);
	pThis->bErrCtr.EnableWindow(FALSE);
	pThis->bRead.EnableWindow(FALSE);
	pThis->bWrite.EnableWindow(FALSE);
	pThis->bWriteProt.EnableWindow(FALSE);
	pThis->bReset.EnableWindow(FALSE);
	pThis->bSubmit.EnableWindow(FALSE);
	pThis->bChange.EnableWindow(FALSE);
	ClearFields();
	DisableFields();
}

void DisplayOut(int errType, int retVal, CString prtText)
{
  char buffer[300];

  switch (errType){
  case 0:                          // Notifications
	  pThis->mMsg.AddString(prtText);
	  break;
  case 1:                          // Error Messages
	  pThis->mMsg.AddString(GetScardErrMsg(retVal));
	  break;
  case 2:						   // Input data
	  sprintf(buffer, "< %s", prtText);
	  pThis->mMsg.AddString(buffer);
	  break;
  case 3:                          // Output data
	  sprintf(buffer, "> %s", prtText);
	  pThis->mMsg.AddString(buffer);
	  break;
  }

}

void AddButtons()
{
	pThis->bInit.EnableWindow(FALSE);
	pThis->bConnect.EnableWindow(TRUE);
	pThis->bRead.EnableWindow(TRUE);
	pThis->bWrite.EnableWindow(TRUE);
	pThis->bWriteProt.EnableWindow(TRUE);
	pThis->bReset.EnableWindow(TRUE);
    if (pThis->rbSLE4432.GetCheck() == 1){
 		pThis->bSubmit.EnableWindow(FALSE);
    	pThis->bChange.EnableWindow(FALSE);
		pThis->bErrCtr.EnableWindow(FALSE);
	}
	else{
 		pThis->bSubmit.EnableWindow(TRUE);
    	pThis->bChange.EnableWindow(TRUE);
		pThis->bErrCtr.EnableWindow(TRUE);
	}
	
}

int SendAPDUandDisplay(int sendType, CString apduIn)
{
    char buffer[300], tmpStr[300];
	int  indx;

	ioRequest.dwProtocol = dwActProtocol;
	ioRequest.cbPciLength = sizeof(SCARD_IO_REQUEST);
	DisplayOut(2, 0, apduIn);
	retCode = SCardTransmit( hCard,
						&ioRequest,
						SendBuff,
						SendLen,
						NULL,
						RecvBuff,
						&RecvLen);
 	if (retCode != SCARD_S_SUCCESS)
	{
        DisplayOut(1, retCode, "");
        return retCode;
	}

	switch(sendType){
	case 0:						// Display SW1/SW2 value
		if (!((RecvBuff[RecvLen-2] == 0x90) && (RecvBuff[RecvLen-1] == 0x00)))
			DisplayOut(1, 0, "Return bytes are not acceptable.");
		else{
			strcpy(tmpStr, "");
			for (indx=RecvLen-2; indx<(RecvLen); indx++){
				sprintf(buffer, "%02X ", RecvBuff[indx] & 0x00FF);
				strcat(tmpStr, buffer);
			}
		}
		break;
	case 1:						// Display ATR after checking SW1/SW2
	    if (!((RecvBuff[RecvLen-2] == 0x90) && (RecvBuff[RecvLen-1] == 0x00)))
			DisplayOut(1, 0, "Return bytes are not acceptable.");
		else{
			strcpy(tmpStr, "ATR : ");
			for (indx=0; indx<(RecvLen-2); indx++){
				sprintf(buffer, "%02X ", RecvBuff[indx] & 0x00FF);
				strcat(tmpStr, buffer);
			}
			sprintf(tmpStr, "%s", tmpStr);
		}
		break;
	case 2:						// Display all data after checking SW1/SW2
	    if (!((RecvBuff[RecvLen-2] == 0x90) && (RecvBuff[RecvLen-1] == 0x00)))
			DisplayOut(1, 0, "Return bytes are not acceptable.");
		else{
			strcpy(tmpStr, "");
			for (indx=0; indx<(RecvLen); indx++){
				sprintf(buffer, "%02X ", RecvBuff[indx] & 0x00FF);
				strcat(tmpStr, buffer);
			}
		}
		break;
	}
	DisplayOut(3, 0, tmpStr);
	return retCode;

}

BOOL InputOK(int checkType)
{
	char tmpStr[257];
	int tmpLen;

	switch(checkType){
	case 0:               // for Read function
		tmpLen = pThis->tAdd.GetWindowText(tmpStr, 3);
		if  (tmpLen != 2){
			pThis->tAdd.SetFocus();
			return 0;
		}
		tmpLen = pThis->tLen.GetWindowText(tmpStr, 3);
		if  (tmpLen != 2){
			pThis->tLen.SetFocus();
			return 0;
		}
		break;
	case 1:               // for Write function
		tmpLen = pThis->tAdd.GetWindowText(tmpStr, 3);
		if  (tmpLen != 2){
			pThis->tAdd.SetFocus();
			return 0;
		}
		tmpLen = pThis->tLen.GetWindowText(tmpStr, 3);
		if  (tmpLen != 2){
			pThis->tLen.SetFocus();
			return 0;
		}
		tmpLen = pThis->tData.GetWindowText(tmpStr, 257);
		if  (tmpStr[0] == 0){
			pThis->tData.SetFocus();
			return 0;
		}
		break;
	case 2:               // for Verify function
        pThis->tAdd.Clear();
        pThis->tLen.Clear();
		tmpLen = pThis->tData.GetWindowText(tmpStr, 257);
		if  (tmpLen < 4){
			pThis->tData.SetFocus();
			return 0;
		}
		break;
	}

	return 1;

}

/////////////////////////////////////////////////////////////////////////////
// CSLE4432_4442Dlg message handlers

BOOL CSLE4432_4442Dlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	pThis = this;
	InitMenu();
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CSLE4432_4442Dlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CSLE4432_4442Dlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CSLE4432_4442Dlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CSLE4432_4442Dlg::OnInit() 
{
	int nLength = 64;
	
  // 1. Initialize SC reader
  //  1.1. Establish context
 	retCode = SCardEstablishContext (SCARD_SCOPE_USER,
								NULL,
								NULL,
								&hContext);
	if (retCode != SCARD_S_SUCCESS)
	{
        DisplayOut(1, retCode, "");
        return;
	}

  //  1.2. List PC/SC readers
	size = 256;
	retCode = SCardListReaders (hContext,
							NULL,
							readerName,
							&size);
	if (retCode != SCARD_S_SUCCESS)
	{
        DisplayOut(1, retCode, "");
        return;
	}
	if (readerName == NULL)
	{
        DisplayOut(0, retCode, "No PC/SC reader is detected in your system.");
    	return;
	}
	
	cbReader.ResetContent();
	char *p = readerName;
	while (*p)
	{
    	for (int i=0;p[i];i++);
	      i++;
	    if (*p != 0)
		{
     		cbReader.AddString(p);
		}
		p = &p[i];
	}
	cbReader.SetCurSel(0);
    DisplayOut(0, retCode, "Select Reader and Card to connect.");
    cbReader.EnableWindow(TRUE);
	rbSLE4432.SetCheck(1);
	bConnect.EnableWindow(TRUE);
	bInit.EnableWindow(FALSE);
	bReset.EnableWindow(TRUE);
	
}

void CSLE4432_4442Dlg::OnReset() 
{

	ClearFields();

    // Close SC reader
	if (connActive)
		retCode = SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
    retCode = SCardReleaseContext(hContext);
    connActive = FALSE;
	InitMenu();
	
}

void CSLE4432_4442Dlg::OnQuit() 
{

    int tmpResult = 0;

    // Close SC reader
	if (connActive)
		retCode = SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
	retCode = SCardReleaseContext(hContext);
    this->EndDialog(tmpResult);
	
}

void CSLE4432_4442Dlg::OnConnect() 
{
	int tmpInt = cbReader.GetCurSel();
	CString rName,cardType;
	char buffer[200];
	char tmpStr[128]; 

	if (connActive){
		DisplayOut(0, 0, "Connection is already active.");
		return;
	}
	cbReader.GetLBText(tmpInt, rName);

  // 1. Direct Connection
	retCode = SCardConnect(hContext,
						rName,
						SCARD_SHARE_DIRECT,
						0,
						&hCard,
						&dwActProtocol);
	if (retCode != SCARD_S_SUCCESS)
	{
        DisplayOut(1, retCode, "");
        return;
	}

    // 2. Select Card Type
	ClearBuffers();
    SendLen = 4;
    if (rbSLE4432.GetCheck() == 1){
		SendBuff[0] = 0x11;      // Card Type for SLE4432
		cardType = "SLE 4432";
	}
	else{
	    SendBuff[0] = 0x12;      // Card Type for SLE4442
		cardType = "SLE 4442";
	}
    RecvLen = 262;
    retCode = SCardControl(hCard,
                  IOCTL_SMARTCARD_SET_CARD_TYPE,
                  &SendBuff,
                  SendLen,
                  &RecvBuff,
                  RecvLen,
                  &nBytesRet);
	if (retCode != SCARD_S_SUCCESS)
	{
        DisplayOut(1, retCode, "");
        return;
	}

	sprintf(buffer, "%s is selected.", cardType);
	DisplayOut(0, 0, buffer);

    // 3. Reconnect using SCARD_SHARE_SHARED and
    //    SCARD_PROTOCOL_T0 parameters
    retCode = SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
	if (retCode != SCARD_S_SUCCESS)
	{
        DisplayOut(1, retCode, "");
        return;
	}

	retCode = SCardConnect(hContext,
						rName,
						SCARD_SHARE_SHARED,
						SCARD_PROTOCOL_T0,
						&hCard,
						&dwActProtocol);
	if (retCode != SCARD_S_SUCCESS)
	{
        DisplayOut(1, retCode, "");
		connActive = FALSE;
        return;
	}
	sprintf(buffer, "Connected to %s.", rName);
	DisplayOut(0, 0, buffer);

	// 4. Get ATR
	DisplayOut(2, 0, "Get ATR");
	ClearBuffers();
	SendBuff[0] = 0xFF;
	SendBuff[1] = 0xA4;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x01;
	SendBuff[5] = 0x06;  // SLE4432/4442 value
	SendLen = 6;
	RecvLen = 6;
    strcpy(tmpStr, "");
	for(int i=0; i<SendLen-1; i++){
		sprintf(buffer, "%02X ", SendBuff[i] & 0x00FF);
		strcat(tmpStr, buffer);
	}
	retCode = SendAPDUandDisplay(1, tmpStr);
	if (retCode != SCARD_S_SUCCESS)
        return;

	connActive = TRUE;
	AddButtons();
	EnableFields();

}

void CSLE4432_4442Dlg::OnSLE4418() 
{
	ClearFields();
	DisableFields();
	bRead.EnableWindow(FALSE);
	bWrite.EnableWindow(FALSE);
	bChange.EnableWindow(FALSE);
	bWriteProt.EnableWindow(FALSE);
	bSubmit.EnableWindow(FALSE);
	bErrCtr.EnableWindow(FALSE);
	
	if (connActive)
		retCode = SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
	connActive = FALSE;

}

void CSLE4432_4442Dlg::OnEditchangeCombo1() 
{
	ClearFields();
	DisableFields();
	bRead.EnableWindow(FALSE);
	bWrite.EnableWindow(FALSE);
	bChange.EnableWindow(FALSE);
	bWriteProt.EnableWindow(FALSE);
	bSubmit.EnableWindow(FALSE);
	bErrCtr.EnableWindow(FALSE);
	
	if (connActive)
		retCode = SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
	connActive = FALSE;

}

void CSLE4432_4442Dlg::OnSLE4428() 
{
	ClearFields();
	DisableFields();
	bRead.EnableWindow(FALSE);
	bWrite.EnableWindow(FALSE);
	bChange.EnableWindow(FALSE);
	bWriteProt.EnableWindow(FALSE);
	bSubmit.EnableWindow(FALSE);
	bErrCtr.EnableWindow(FALSE);
	
	if (connActive)
		retCode = SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
	connActive = FALSE;

}

void CSLE4432_4442Dlg::OnRead() 
{
	int tmpInt, indx;
	char buffer[256], tmpStr[256];

	// 1. Check for all input fields
	if (!InputOK(0))
		return;
   
	// 2. Read input fields and pass data to card
	tData.Clear();
	ClearBuffers();
	tmpInt = 0;
	SendBuff[0] = 0xFF;
	SendBuff[1] = 0xB0;
	SendBuff[2] = 0x00;

	tmpInt = 0;
	tAdd.GetWindowText(buffer, 3);
	sscanf(buffer, "%02X", &tmpInt);
	SendBuff[3] = tmpInt;

	tmpInt = 0;
	tLen.GetWindowText(buffer, 3);
	sscanf(buffer, "%02X", &tmpInt);
	SendBuff[4] = tmpInt;
	
	SendLen = 5;
	RecvLen = SendBuff[4]+6;
    strcpy(tmpStr, "");
	for(indx=0; indx<5; indx++){
		sprintf(buffer, "%02X ", SendBuff[indx] & 0x00FF);
		strcat(tmpStr, buffer);
	}
	retCode = SendAPDUandDisplay(2, tmpStr);
	if (retCode != SCARD_S_SUCCESS)
        return;

	// 3. Display data read from card into Data textbox
    strcpy(tmpStr, "");
	for(indx=0; indx<SendBuff[4]; indx++){
 		sprintf(buffer, "%c", RecvBuff[indx] & 0xFF);
		strcat(tmpStr, buffer);
	}
	tData.SetWindowText(tmpStr);
}

void CSLE4432_4442Dlg::OnReadProt() 
{
	int tmpInt, indx;
	char buffer[256], tmpStr[256], tmpByte[2];

	// 1. Check for all input fields
	if (!InputOK(2))
		return;
   
	// 2. Read input fields and pass data to card
	// 2. Read input fields and pass data to card
	ClearBuffers();
	tmpInt = 0;
	SendBuff[0] = 0xFF;
	SendBuff[1] = 0xD2;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x01;
	SendBuff[4] = 0x03;

	tmpInt = 0;
	tData.GetWindowText(buffer, 7);
	memcpy(tmpByte, buffer, 2);
	sscanf(tmpByte, "%02X", &SendBuff[5]);
	memcpy(tmpByte, buffer+2, 2);
	sscanf(tmpByte, "%02X", &SendBuff[6]);
	memcpy(tmpByte, buffer+4, 2);
	sscanf(tmpByte, "%02X", &SendBuff[7]);
	SendLen = 5 + SendBuff[4];
	RecvLen = 2;
    strcpy(tmpStr, "");
	for(indx=0; indx<SendLen; indx++){
		sprintf(buffer, "%02X ", SendBuff[indx] & 0x00FF);
		strcat(tmpStr, buffer);
	}
	retCode = SendAPDUandDisplay(2, tmpStr);
	if (retCode != SCARD_S_SUCCESS)
        return;

	tData.SetWindowText("");

}

void CSLE4432_4442Dlg::OnWrite() 
{
	int tmpInt, indx;
	char buffer[256], tmpStr[256];

	// 1. Check for all input fields
	if (!InputOK(1))
		return;
   
	// 2. Read input fields and pass data to card
	ClearBuffers();
	tmpInt = 0;
	SendBuff[0] = 0xFF;
	SendBuff[1] = 0xD0;
	SendBuff[2] = 0x00;

	tmpInt = 0;
	tAdd.GetWindowText(buffer, 3);
	sscanf(buffer, "%02X", &tmpInt);
	SendBuff[3] = tmpInt;

	tmpInt = 0;
	tLen.GetWindowText(buffer, 3);
	sscanf(buffer, "%02X", &tmpInt);
	SendBuff[4] = tmpInt;
	
	tData.GetWindowText(buffer, SendBuff[4]+1);
	for (indx =0;indx<SendBuff[4];indx++)
		SendBuff[indx + 5] = buffer[indx];
	SendLen = 5 + SendBuff[4];
	RecvLen = 2;
    strcpy(tmpStr, "");
	for(indx=0; indx<SendLen; indx++){
		sprintf(buffer, "%02X ", SendBuff[indx] & 0x00FF);
		strcat(tmpStr, buffer);
	}
	retCode = SendAPDUandDisplay(0, tmpStr);
	if (retCode != SCARD_S_SUCCESS)
        return;
	tData.SetWindowText("");
	
}

void CSLE4432_4442Dlg::OnSubmit() 
{

	int tmpInt, indx;
	char buffer[256], tmpStr[256], tmpByte[2];

	// 1. Check for all input fields
	if (!InputOK(2))
		return;
   
	// 2. Read input fields and pass data to card
	ClearBuffers();
	tmpInt = 0;
	SendBuff[0] = 0xFF;
	SendBuff[1] = 0x20;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x03;

	tmpInt = 0;
	tData.GetWindowText(buffer, 7);
	memcpy(tmpByte, buffer, 2);
	sscanf(tmpByte, "%02X", &SendBuff[5]);
	memcpy(tmpByte, buffer+2, 2);
	sscanf(tmpByte, "%02X", &SendBuff[6]);
	memcpy(tmpByte, buffer+4, 2);
	sscanf(tmpByte, "%02X", &SendBuff[7]);
	SendLen = 5 + SendBuff[4];
	RecvLen = 6;
    strcpy(tmpStr, "");
	for(indx=0; indx<SendLen; indx++){
		sprintf(buffer, "%02X ", SendBuff[indx] & 0x00FF);
		strcat(tmpStr, buffer);
	}
	retCode = SendAPDUandDisplay(2, tmpStr);
	if (retCode != SCARD_S_SUCCESS)
        return;

	tData.SetWindowText("");

}

void CSLE4432_4442Dlg::OnErrCtr() 
{

	int tmpInt, indx;
	char buffer[256], tmpStr[256];

	// 1. Clear all input fields
	ClearFields();
   
  // 2. Send all inputs to the card
	ClearBuffers();
	tmpInt = 0;
	SendBuff[0] = 0xFF;
	SendBuff[1] = 0xB1;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x00;

	SendLen = 5;
	RecvLen = 6;
    strcpy(tmpStr, "");
	for(indx=0; indx<SendLen; indx++){
		sprintf(buffer, "%02X ", SendBuff[indx] & 0x00FF);
		strcat(tmpStr, buffer);
	}
	retCode = SendAPDUandDisplay(2, tmpStr);
	if (retCode != SCARD_S_SUCCESS)
        return;

}

void CSLE4432_4442Dlg::OnWriteProt() 
{
	int tmpInt, indx;
	char buffer[256], tmpStr[256];

	// 1. Check for all input fields
	if (!InputOK(1))
		return;
   
	// 2. Read input fields and pass data to card
	ClearBuffers();
	tmpInt = 0;
	SendBuff[0] = 0xFF;
	SendBuff[1] = 0xD1;
	SendBuff[2] = 0x00;

	tmpInt = 0;
	tAdd.GetWindowText(buffer, 3);
	sscanf(buffer, "%02X", &tmpInt);
	SendBuff[3] = tmpInt;

	tmpInt = 0;
	tLen.GetWindowText(buffer, 3);
	sscanf(buffer, "%02X", &tmpInt);
	SendBuff[4] = tmpInt;
	
	tData.GetWindowText(buffer, SendBuff[4]+1);
	for (indx =0;indx<SendBuff[4];indx++)
		SendBuff[indx + 5] = buffer[indx];
	SendLen = 5 + SendBuff[4];
	RecvLen = 2;
    strcpy(tmpStr, "");
	for(indx=0; indx<SendLen; indx++){
		sprintf(buffer, "%02X ", SendBuff[indx] & 0x00FF);
		strcat(tmpStr, buffer);
	}
	retCode = SendAPDUandDisplay(0, tmpStr);
	if (retCode != SCARD_S_SUCCESS)
        return;

	tData.SetWindowText("");
	
}

void CSLE4432_4442Dlg::OnSelchangeCombo1() 
{
	ClearFields();
	DisableFields();
	bRead.EnableWindow(FALSE);
	bWrite.EnableWindow(FALSE);
	bChange.EnableWindow(FALSE);
	bWriteProt.EnableWindow(FALSE);
	bSubmit.EnableWindow(FALSE);
	bErrCtr.EnableWindow(FALSE);
	
	if (connActive)
		retCode = SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
	connActive = FALSE;

}
