// SLE4432_4442Dlg.h : header file
//

typedef struct _CmdBytes{
    BYTE
        bCla,   // The instruction class
        bIns,   // The instruction code 
        bP1,    // Parameter to the instruction
        bP2,    // Parameter to the instruction
        bP3;    // Size of I/O Transfer
	char
		bDataIn [256],		// Data in
		bDataOut [256];		// Data out
	char
		Status [2];			// (SW1/SW2)
} CmdBytes;


// SLE4432_4442Dlg-defined errors
#define INVALID_SW1SW2 -450
#define	NO_READER_INSTALLED	-451
#define IOCTL_SMARTCARD_SET_CARD_TYPE		SCARD_CTL_CODE(2060)

#if !defined(AFX_SLE4432_4442DLG_H__63FAC2E6_0593_44F0_99C8_043B53E812B8__INCLUDED_)
#define AFX_SLE4432_4442DLG_H__63FAC2E6_0593_44F0_99C8_043B53E812B8__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CSLE4432_4442Dlg dialog

class CSLE4432_4442Dlg : public CDialog
{
// Construction
public:
	CSLE4432_4442Dlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CSLE4432_4442Dlg)
	enum { IDD = IDD_SLE4432_4442_DIALOG };
	CButton	bChange;
	CButton	bWriteProt;
	CEdit	tAdd;
	CButton	rbSLE4432;
	CComboBox	cbReader;
	CListBox	mMsg;
	CEdit	tData;
	CEdit	tLen;
	CButton	bReset;
	CButton	bErrCtr;
	CButton	bSubmit;
	CButton	bWrite;
	CButton	bRead;
	CButton	bConnect;
	CButton	bQuit;
	CButton	bInit;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSLE4432_4442Dlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CSLE4432_4442Dlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnInit();
	afx_msg void OnReset();
	afx_msg void OnQuit();
	afx_msg void OnConnect();
	afx_msg void OnSLE4418();
	afx_msg void OnEditchangeCombo1();
	afx_msg void OnSLE4428();
	afx_msg void OnRead();
	afx_msg void OnReadProt();
	afx_msg void OnWrite();
	afx_msg void OnSubmit();
	afx_msg void OnErrCtr();
	afx_msg void OnWriteProt();
	afx_msg void OnSelchangeCombo1();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SLE4432_4442DLG_H__63FAC2E6_0593_44F0_99C8_043B53E812B8__INCLUDED_)
