//  Copyright(C):      Advanced Card Systems Ltd
//
//  File:              AT88SC1608.pas
//
//  Description:       This sample program outlines the steps on how to
//                     program SLE4432/4442 memory cards using ACS readers
//                     in PC/SC platform.
//
//  Author:	           Jose Isagani R. Mission
//
//  Date:	             June 18, 2004
//
//  Revision Trail:   (Date/Author/Description)
//
//======================================================================
unit SLE4432_4442;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACSModule, StdCtrls, ExtCtrls, ComCtrls;

Const MAX_BUFFER_LEN    = 256;
Const INVALID_SW1SW2    = -450;

type
  TSLE4432_4442Main = class(TForm)
    Label1: TLabel;
    mMsg: TRichEdit;
    bReset: TButton;
    bQuit: TButton;
    gbFunction: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    tLen: TEdit;
    tData: TEdit;
    bRead: TButton;
    bWrite: TButton;
    tAdd: TEdit;
    bWriteProt: TButton;
    bSubmit: TButton;
    bReadCtr: TButton;
    bChange: TButton;
    Button1: TButton;
    Timer3: TTimer;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Edit2: TEdit;
    Label7: TLabel;
    Edit3: TEdit;
    Label8: TLabel;
    Edit4: TEdit;
    Label9: TLabel;
    Edit5: TEdit;
    Label10: TLabel;
    Edit6: TEdit;
    procedure bInitClick(Sender: TObject);
    procedure bResetClick(Sender: TObject);
    procedure cbReaderClick(Sender: TObject);
    procedure bQuitClick(Sender: TObject);
    procedure tLenKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tLenKeyPress(Sender: TObject; var Key: Char);
    procedure tRandKeyPress(Sender: TObject; var Key: Char);
    procedure bConnectClick(Sender: TObject);
    procedure tAddKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tAddKeyPress(Sender: TObject; var Key: Char);
    procedure bReadClick(Sender: TObject);
    procedure bWriteClick(Sender: TObject);
    procedure tLenExit(Sender: TObject);
    procedure tRPValKeyPress(Sender: TObject; var Key: Char);
    procedure bSubmitClick(Sender: TObject);
    procedure bWriteProtClick(Sender: TObject);
    procedure bReadCtrClick(Sender: TObject);
    procedure bChangeClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SLE4432_4442Main: TSLE4432_4442Main;
  hContext    : SCARDCONTEXT;
  hCard       : SCARDCONTEXT;
  ioRequest   : SCARD_IO_REQUEST;
  retCode     : Integer;
  dwActProtocol, BufferLen    : DWORD;
  SendBuff, RecvBuff          : array [0..262] of Byte;
  SendLen, RecvLen, nBytesRet : DWORD;
  Buffer      : array [0..MAX_BUFFER_LEN] of char;
  ConnActive  : Boolean;
   dwState:DWORD;
 bATR: Byte;
 TimerTime: Integer;
 dwState1:DWORD;
 bATR1: Byte;
 cBAtrLen1: DWORD;
 dwActProtocol1: DWORD;
 cBAtrLen: DWORD;

procedure ClearBuffers();
procedure InitMenu();
procedure AddButtons();
procedure ClearFields();
procedure GetATR();
procedure displayOut(errType: Integer; retVal: Integer; PrintText: String);
function SendAPDUandDisplay(SendType: integer; ApduIn: string): integer;
function CallCardControl(): integer;
function InputOK(checkType: integer): boolean;
function TrimInput(InString: String): String;

implementation

{$R *.dfm}
uses StrUtils;
procedure ClearBuffers();
var indx: integer;
begin

  for indx := 0 to 262 do
    begin
      SendBuff[indx] := $00;
      RecvBuff[indx] := $00;
    end;

end;

procedure InitMenu();
begin

//  SLE4432_4442Main.cbReader.Clear;
  SLE4432_4442Main.mMsg.Clear;
//  SLE4432_4442Main.cbReader.Enabled := False;
//  SLE4432_4442Main.bInit.Enabled := True;
//  SLE4432_4442Main.rgCardType.Enabled := False;
  SLE4432_4442Main.gbFunction.Enabled := False;
//  SLE4432_4442Main.bConnect.Enabled := False;

end;

procedure AddButtons();
begin

//  SLE4432_4442Main.rgCardType.Enabled := True;
//  SLE4432_4442Main.rgCardType.ItemIndex := 0;
//  SLE4432_4442Main.cbReader.Enabled := True;
//  SLE4432_4442Main.bInit.Enabled := False;
//  SLE4432_4442Main.bConnect.Enabled := True;
  SLE4432_4442Main.bReset.Enabled := True;

end;

procedure ClearFields();
begin

  SLE4432_4442Main.tAdd.Text := '';
  SLE4432_4442Main.tLen.Text := '';
  SLE4432_4442Main.tData.Text := '';
  SLE4432_4442Main.tData.MaxLength := 0;

end;

procedure GetATR();
var tmpStr: string;
    indx: integer;
begin

  DisplayOut(2, 0, 'Get ATR');
  ClearBuffers();
  SendLen := 6;
  RecvLen := 6;
  SendBuff[0] := $FF;
  SendBuff[1] := $A4;
  SendBuff[2] := $00;
  SendBuff[3] := $00;
  SendBuff[4] := $01;
  SendBuff[5] := $06;  // SLE4432/4442 value
  tmpStr := '';
  for indx := 0 to SendLen-1 do
    tmpStr := tmpStr + Format('%.02X ',[SendBuff[indx]]);
  retCode := SendAPDUandDisplay(1, tmpStr);
  if retCode <> SCARD_S_SUCCESS then
    Exit;

end;

procedure displayOut(errType: Integer; retVal: Integer; PrintText: String);
begin

  case errType of
    0: SLE4432_4442Main.mMsg.SelAttributes.Color := clTeal;   // Notifications
    1: begin                                                  // Error Messages
         SLE4432_4442Main.mMsg.SelAttributes.Color := clRed;
         PrintText := GetScardErrMsg(retVal);
       end;
    2: begin
         SLE4432_4442Main.mMsg.SelAttributes.Color := clBlack;
         PrintText := '< ' + PrintText;                      // Input data
       end;
    3: begin
         SLE4432_4442Main.mMsg.SelAttributes.Color := clBlack;
         PrintText := '> ' + PrintText;                      // Output data
       end;
  end;
  SLE4432_4442Main.mMsg.Lines.Add(PrintText);
  SLE4432_4442Main.mMsg.SelAttributes.Color := clBlack;
  SLE4432_4442Main.mMsg.SetFocus;

end;

function SendAPDUandDisplay(SendType: integer; ApduIn: string): integer;
var tmpStr: string;
    indx: integer;
begin

  ioRequest.dwProtocol := dwActProtocol;
  ioRequest.cbPciLength := sizeof(SCARD_IO_REQUEST);
  DisplayOut(2, 0, ApduIn);
  retCode := SCardTransmit(hCard,
                           @ioRequest,
                           @SendBuff,
                           SendLen,
                           Nil,
                           @RecvBuff,
                           @RecvLen);
  if retCode <> SCARD_S_SUCCESS then
    begin
      DisplayOut(1, retCode, '');
      SendAPDUandDisplay := retCode;
      Exit;
    end
  else
    begin
      case SendType of
      0: begin      // Display SW1/SW2 value
         for indx := (RecvLen-2) to (RecvLen-1) do
           tmpStr := tmpStr + Format('%.02X ', [(RecvBuff[indx])]);
         if (Trim(tmpStr) <> '90 00') then
           DisplayOut(1, 0, 'Return bytes are not acceptable.');
         end;
      1: begin      // Display ATR after checking SW1/SW2
         for indx := (RecvLen-2) to (RecvLen-1) do
           tmpStr := tmpStr + Format('%.02X ', [(RecvBuff[indx])]);
         if (Trim(tmpStr) <> '90 00') then
           DisplayOut(1, 0, 'Return bytes are not acceptable.')
         else
           begin
             tmpStr := 'ATR :';
             for indx := 0 to (RecvLen-3) do
               tmpStr := tmpStr + Format('%.2X ', [(RecvBuff[Indx])]);
           end;
         end;
      2: begin      // Display all data after checking SW1/SW2
         for indx := (RecvLen-2) to (RecvLen-1) do
           tmpStr := tmpStr + Format('%.02X ', [(RecvBuff[indx])]);
         if (Trim(tmpStr) <> '90 00') then
           DisplayOut(1, 0, 'Return bytes are not acceptable.')
         else
           begin
             tmpStr := '';
             for indx := 0 to (RecvLen-1) do
               tmpStr := tmpStr + Format('%.2X ', [(RecvBuff[Indx])]);
           end;
         end;

      end;
      DisplayOut(3, 0, Trim(tmpStr));
    end;
  SendAPDUandDisplay := retCode;

end;

function CallCardControl(): integer;
begin

  RecvLen := 262;
  retCode := SCardControl(hCard,
                  IOCTL_SMARTCARD_SET_CARD_TYPE,
                  @SendBuff,
                  SendLen,
                  @RecvBuff,
                  RecvLen,
                  @nBytesRet);
  if retCode <> SCARD_S_SUCCESS then
      DisplayOut(1, retCode, '');
  CallCardControl := retCode;

end;

function InputOK(checkType: integer): boolean;
var tmpStr: String;
    indx: integer;
begin

  InputOK := False;
  case checkType of
    0: begin              // for Read function
         if (SLE4432_4442Main.tAdd.Text = '') then begin
           SLE4432_4442Main.tAdd.SetFocus;
           Exit;
         end;
         if (SLE4432_4442Main.tLen.Text = '') then begin
           SLE4432_4442Main.tLen.SetFocus;
           Exit;
         end;
       end;
    1: begin              // for Write function
         if (SLE4432_4442Main.tAdd.Text = '')  then begin
           SLE4432_4442Main.tAdd.SetFocus;
           Exit;
         end;
         if (SLE4432_4442Main.tLen.Text = '') then begin
           SLE4432_4442Main.tLen.SetFocus;
           Exit;
         end;
         if (SLE4432_4442Main.tData.Text = '') then begin
           SLE4432_4442Main.tData.SetFocus;
           Exit;
         end;
       end;
    2: begin              // for Verify function
         SLE4432_4442Main.tAdd.Text := '';
         SLE4432_4442Main.tLen.Text := '';
         if (SLE4432_4442Main.tData.Text = '') then begin
           SLE4432_4442Main.tData.SetFocus;
           Exit;
         end;
         SLE4432_4442Main.tData.Text := UpperCase(SLE4432_4442Main.tData.Text);
         tmpStr := TrimInput(SLE4432_4442Main.tData.Text);
         if (Length(tmpStr) <> 6) then begin
           SLE4432_4442Main.tData.SelectAll;
           SLE4432_4442Main.tData.SetFocus;
           Exit;
         end;
         for indx := 1 to 6 do
           if not (tmpStr[indx] in ['A'..'F']) then
             if not (tmpStr[indx] in ['0'..'9']) then  begin
               SLE4432_4442Main.tData.SelectAll;
               SLE4432_4442Main.tData.SetFocus;
               Exit;
             end;
       end;
    3: begin              // for Write Protect of SLE 4432/4442
         if (SLE4432_4442Main.tAdd.Text = '')  then begin
           SLE4432_4442Main.tAdd.SetFocus;
           Exit;
         end;
         if (StrToInt('$' + copy(SLE4432_4442Main.tAdd.Text,1,2)) > 31) then begin
           SLE4432_4442Main.tAdd.SetFocus;
           Exit;
         end;
         if (SLE4432_4442Main.tLen.Text = '') then begin
           SLE4432_4442Main.tLen.SetFocus;
           Exit;
         end;
         if (SLE4432_4442Main.tData.Text = '') then begin
           SLE4432_4442Main.tData.SetFocus;
           Exit;
         end;
       end;
  end;

  InputOK := True;

end;

function TrimInput(InString: String): String;
var tmpStr: String;
    indx: integer;
begin
  tmpStr := '';
  for indx := 1 to length(InString) do
    if (InString[indx] <> chr(32)) then
      tmpStr := tmpStr + InString[indx];
  TrimInput := tmpStr;

end;

procedure TSLE4432_4442Main.bInitClick(Sender: TObject);
begin

  // 1. Establish context and obtain hContext handle
  retCode := SCardEstablishContext(SCARD_SCOPE_USER,
                                   nil,
                                   nil,
                                   @hContext);
  if retCode <> SCARD_S_SUCCESS then
    begin
      DisplayOut(1, retCode, '');
      Exit;
    end ;

  // 2. List PC/SC card readers installed in the system
  BufferLen := MAX_BUFFER_LEN;
  retCode := SCardListReadersA(hContext,
                               nil,
                               @Buffer,
                               @BufferLen);
  if retCode <> SCARD_S_SUCCESS then
    begin
      DisplayOut(1, retCode, '');
      Exit;
    end
  else
    DisplayOut(0, 0, 'Select reader and card type, and connect.');

//  SLE4432_4442Main.cbReader.Clear;
//  LoadListToControl(SLE4432_4442Main.cbReader,@buffer,bufferLen);
 // SLE4432_4442Main.cbReader.ItemIndex := 0;
//  AddButtons();

end;

procedure TSLE4432_4442Main.bResetClick(Sender: TObject);
begin

  ClearFields();
//  rgCardType.ItemIndex := -1;
  if ConnActive then
    begin
      retCode := SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
      ConnActive := False;
    end;

  retCode := SCardReleaseContext(hCard);
  InitMenu();

end;

procedure TSLE4432_4442Main.cbReaderClick(Sender: TObject);
begin

  ClearFields();
  gbFunction.Enabled := False;
  if ConnActive then
    begin
      retCode := SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
      ConnActive := False;
    end;

end;

procedure TSLE4432_4442Main.bQuitClick(Sender: TObject);
begin

  if ConnActive then
    begin
      retCode := SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
      ConnActive := False;
    end;
  retCode := SCardReleaseContext(hCard);
  Application.Terminate;

end;

procedure TSLE4432_4442Main.tLenKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Length(tLen.Text) > 1 then
         tData.SetFocus;

end;

procedure TSLE4432_4442Main.tLenKeyPress(Sender: TObject; var Key: Char);
begin

  if Key in ['a'..'z'] then Dec(Key,32);
  if Not(Key in ['0'..'9']) then
    if not(Key in ['A'..'F'])  then
      if Key <> chr(8) then
        Key := #0;

end;

procedure TSLE4432_4442Main.tRandKeyPress(Sender: TObject; var Key: Char);
begin

  if Key in ['a'..'z'] then Dec(Key,32);
  if Not(Key in ['0'..'9']) then
    if not(Key in ['A'..'F'])  then
      if Key <> chr(8) then
        if Key <> chr(32) then
          Key := #0;

end;

procedure TSLE4432_4442Main.bConnectClick(Sender: TObject);

 
begin
if hCard<>0 then
 begin
  retCode:=SCardState(hCard,@dwState1,@dwActProtocol1,@bATR1,@cBAtrLen1);
  if dwState1=6 {ConnActive} then
  begin
    DisplayOut(0, 0, '!Connection is already active.');
    Exit;
  end
  else
   begin
    displayOut(0,0,IntToStr(retCode)+'state='+IntToStr(dwState1)+' protocol='+IntToStr(dwActProtocol1)+IntToStr(bATR1));

   end;
 end;
  // 1. Direct Connection
  retCode := SCardConnectA(hContext,
                           PChar('ACS ACR38U 0'),
                           SCARD_SHARE_DIRECT,
                           0,
                           @hCard,
                           @dwActProtocol);
  if retCode <> SCARD_S_SUCCESS then
    begin
      DisplayOut(1, retCode, '');
      ConnActive := False;
      Exit;
    end;

  // 2. Select Card Type
  ClearBuffers();
  SendLen := 4;
  SendBuff[0] := $12;     // Card Type for SLE4442
  retCode := CallCardControl();
  if retCode <> SCARD_S_SUCCESS then
    Exit;

  // 3. Reconnect using SCARD_SHARE_SHARED and
  //    SCARD_PROTOCOL_T0 parameters
  retCode := SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
  if retCode <> SCARD_S_SUCCESS then
    begin
      DisplayOut(1, retCode, '');
      ConnActive := False;
      Exit;
    end;
  retCode := SCardConnectA(hContext,
                           PChar('ACS ACR38U 0'),
                           SCARD_SHARE_SHARED,
                           SCARD_PROTOCOL_T0 or SCARD_PROTOCOL_T1,
                           @hCard,
                           @dwActProtocol);
  if retCode <> SCARD_S_SUCCESS then
    begin
      DisplayOut(1, retCode, '');
      ConnActive := False;
      Exit;
    end
  else
    DisplayOut(0, 0, 'Successful connection to ' + 'ACR');
  ConnActive := True;

  // Get ATR
  GetATR();

  ClearFields();
  gbFunction.Enabled := True;

end;

procedure TSLE4432_4442Main.tAddKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Length(tAdd.Text) > 1 then
         tLen.SetFocus;

end;

procedure TSLE4432_4442Main.tAddKeyPress(Sender: TObject; var Key: Char);
begin

  if Key in ['a'..'z'] then Dec(Key,32);
  if Not(Key in ['0'..'9']) then
    if not(Key in ['A'..'F'])  then
      if Key <> chr(8) then
        Key := #0;

end;

procedure TSLE4432_4442Main.bReadClick(Sender: TObject);
var tmpStr: string;
    indx: integer;
begin

  // 1. Check all input fields
  if not InputOK(0) then
    Exit;

  // 2. Send all inputs to the card
  ClearBuffers();
  SendBuff[0] := $FF;
  SendBuff[1] := $B0;
  SendBuff[2] := $00;
  SendBuff[3] := (StrToInt('$' + copy(tAdd.Text,1,2)));
  SendBuff[4] := (StrToInt('$' + copy(tLen.Text,1,2)));
  SendLen := 5;
  RecvLen := SendBuff[4] + 6;
  tmpStr := '';
  for indx := 0 to SendLen-1 do
    tmpStr := tmpStr + Format('%.02X ',[SendBuff[indx]]);
  retCode := SendAPDUandDisplay(2, tmpStr);
  if retCode <> SCARD_S_SUCCESS then
    Exit;

  // 3. Display data read from card into Data textbox
  tmpStr := '';
  for indx := 0 to SendBuff[4]-1 do
    tmpStr := tmpStr + chr(RecvBuff[indx]);
  tData.Text := tmpStr;

end;

procedure TSLE4432_4442Main.bWriteClick(Sender: TObject);
var tmpStr: string;
    indx: integer;
begin

  // 1. Check all input fields
  if not InputOK(1) then
    Exit;

  // 2. Send all inputs to the card
  tmpStr := tData.Text;
  ClearBuffers();
  SendBuff[0] := $FF;
  SendBuff[1] := $D0;
  SendBuff[2] := $00;
  SendBuff[3] := (StrToInt('$' + copy(tAdd.Text,1,2)));
  SendBuff[4] := (StrToInt('$' + copy(tLen.Text,1,2)));
  for indx := 0 to SendBuff[4]-1 do
    SendBuff[indx+5] := ord(tmpStr[indx+1]);
  SendLen := 5 + SendBuff[4];
  RecvLen := 2;
  tmpStr := '';
  for indx := 0 to SendLen-1 do
    tmpStr := tmpStr + Format('%.02X ',[SendBuff[indx]]);
  retCode := SendAPDUandDisplay(2, tmpStr);
  if retCode <> SCARD_S_SUCCESS then
    Exit;

  tData.Clear;

end;

procedure TSLE4432_4442Main.tLenExit(Sender: TObject);
begin

  if tLen.Text <> '' then begin
    tData.Clear;
    tData.MaxLength := StrToInt('$' + copy(tLen.Text,1,2));
  end;

end;

procedure TSLE4432_4442Main.tRPValKeyPress(Sender: TObject; var Key: Char);
begin

  if Key in ['a'..'f'] then Dec(Key,32);
  if Not(Key in ['0'..'9']) then
    if not(Key in ['A'..'F'])  then
      if Key <> chr(8) then
        Key := #0;

end;

procedure TSLE4432_4442Main.bSubmitClick(Sender: TObject);
var tmpStr: string;
    indx: integer;
begin

  // 1. Check all input fields
  if not InputOK(2) then
    Exit;

  // 2. Send all inputs to the card
  ClearBuffers();
  tmpStr := TrimInput(tData.Text);
  SendBuff[0] := $FF;
  SendBuff[1] := $20;
  SendBuff[2] := $00;
  SendBuff[3] := $00;
  SendBuff[4] := $03;
  for indx := 0 to 2 do
    SendBuff[indx+5] := (StrToInt('$' + copy(tmpStr,(indx*2)+1,2)));
  SendLen := 5 + SendBuff[4];
  RecvLen := 6;
  tmpStr := '';
  for indx := 0 to SendLen-1 do
    tmpStr := tmpStr + Format('%.02X ',[SendBuff[indx]]);
  retCode := SendAPDUandDisplay(2, tmpStr);
  if retCode <> SCARD_S_SUCCESS then
    Exit;

  tData.Clear;

end;

procedure TSLE4432_4442Main.bWriteProtClick(Sender: TObject);
var tmpStr: string;
    indx: integer;
begin

  // 1. Check all input fields
  if not InputOK(3) then
    Exit;

  // 2. Send all inputs to the card
  tmpStr := tData.Text;
  ClearBuffers();
  SendBuff[0] := $FF;
  SendBuff[1] := $D1;
  SendBuff[2] := $00;
  SendBuff[3] := (StrToInt('$' + copy(tAdd.Text,1,2)));
  SendBuff[4] := (StrToInt('$' + copy(tLen.Text,1,2)));
  for indx := 0 to SendBuff[4]-1 do
    SendBuff[indx+5] := ord(tmpStr[indx+1]);
  SendLen := 5 + SendBuff[4];
  RecvLen := 2;
  tmpStr := '';
  for indx := 0 to SendLen-1 do
    tmpStr := tmpStr + Format('%.02X ',[SendBuff[indx]]);
  retCode := SendAPDUandDisplay(2, tmpStr);
  if retCode <> SCARD_S_SUCCESS then
    Exit;

  tData.Clear;

end;

procedure TSLE4432_4442Main.bReadCtrClick(Sender: TObject);
var tmpStr: string;
    indx: integer;
begin
  // 1. Clear all input fields
  ClearFields();

  // 2. Send all inputs to the card
  ClearBuffers();
  SendBuff[0] := $FF;
  SendBuff[1] := $B1;
  SendBuff[2] := $00;
  SendBuff[3] := $00;
  SendBuff[4] := $00;
  SendLen := 5;
  RecvLen := 6;
  tmpStr := '';
  for indx := 0 to SendLen-1 do
    tmpStr := tmpStr + Format('%.02X ',[SendBuff[indx]]);
  retCode := SendAPDUandDisplay(2, tmpStr);
  if retCode <> SCARD_S_SUCCESS then
    Exit;

end;

procedure TSLE4432_4442Main.bChangeClick(Sender: TObject);
var tmpStr: string;
    indx: integer;
begin

  // 1. Check all input fields
  if not InputOK(2) then
    Exit;

  // 2. Send all inputs to the card
  ClearBuffers();
  tmpStr := TrimInput(tData.Text);
  SendBuff[0] := $FF;
  SendBuff[1] := $D2;
  SendBuff[2] := $00;
  SendBuff[3] := $01;
  SendBuff[4] := $03;
  for indx := 0 to 2 do
    SendBuff[indx+5] := (StrToInt('$' + copy(tmpStr,(indx*2)+1,2)));
  SendLen := 5 + SendBuff[4];
  RecvLen := 2;
  tmpStr := '';
  for indx := 0 to SendLen-1 do
    tmpStr := tmpStr + Format('%.02X ',[SendBuff[indx]]);
  retCode := SendAPDUandDisplay(2, tmpStr);
  if retCode <> SCARD_S_SUCCESS then
    Exit;

  tData.Clear;

end;

procedure TSLE4432_4442Main.Button1Click(Sender: TObject);
var
 dwState:DWORD;
 bATR: Byte;
 cBAtrLen: DWORD;

begin

retCode:=0;
retCode:=SCardState(hCard,@dwState,@dwActProtocol,@bATR,@cBAtrLen);
 displayOut(0,0,IntToStr(retCode)+'state='+IntToStr(dwState)+' protocol='+IntToStr(dwActProtocol)+IntToStr(bATR));
 //displayOut(0,0,GetReaderStateStrMsg(dwState));

end;

procedure TSLE4432_4442Main.FormCreate(Sender: TObject);
begin
hCard:=0;
TimerTime:=0;
end;

procedure TSLE4432_4442Main.Timer3Timer(Sender: TObject);
var
 dwState:DWORD;
 bATR: Byte;
 cBAtrLen: DWORD;
begin
If (TimerTime>4) and (Label1.Color = clRed) then TimerTime:=0;
TimerTime:= TimerTime+1;
If TimerTime=2 then
 begin
     retCode := SCardEstablishContext(SCARD_SCOPE_USER,
                                   nil,
                                   nil,
                                   @hContext);
  if retCode <> SCARD_S_SUCCESS then
    begin
      DisplayOut(1, retCode, 'Con1');
      TimerTime:=0;
      Exit;
    end ;
 // 2. List PC/SC card readers installed in the system
  BufferLen := MAX_BUFFER_LEN;
  retCode := SCardListReadersA(hContext,
                               nil,
                               @Buffer,
                               @BufferLen);
  if retCode <> SCARD_S_SUCCESS then
    begin
      DisplayOut(1, retCode, ' List1');
      Exit;
    end;
//  SLE4432_4442Main.cbReader.Clear;
//  LoadListToControl(SLE4432_4442Main.cbReader,@buffer,bufferLen);
//  SLE4432_4442Main.cbReader.ItemIndex := 0;
     // 1. Direct Connection
  retCode := SCardConnectA(hContext,
                           PChar('ACS ACR38U 0'),
                           SCARD_SHARE_DIRECT,
                           0,
                           @hCard,
                           @dwActProtocol);
  if retCode <> SCARD_S_SUCCESS then
    begin
      DisplayOut(1, retCode, ' Con2');
      ConnActive := False;
      Exit;
    end;

  // 2. Select Card Type
  ClearBuffers();
  SendLen := 4;
  SendBuff[0] := $12;     // Card Type for SLE4442
  retCode := CallCardControl();
  if retCode <> SCARD_S_SUCCESS then
    Exit;

  // 3. Reconnect using SCARD_SHARE_SHARED and
  //    SCARD_PROTOCOL_T0 parameters
  retCode := SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
  if retCode <> SCARD_S_SUCCESS then
    begin
      DisplayOut(1, retCode, 'Con3');
      ConnActive := False;
      Exit;
    end;
  retCode := SCardConnectA(hContext,
                           PChar('ACS ACR38U 0'),
                           SCARD_SHARE_SHARED,
                           SCARD_PROTOCOL_T0 or SCARD_PROTOCOL_T1,
                           @hCard,
                           @dwActProtocol);
  if retCode <> SCARD_S_SUCCESS then
    begin
    //  DisplayOut(1, retCode, '');
      ConnActive := False;
      Exit;
    end
  else
  ConnActive := True;
      //****************


 end;
 if hCard<>0 then
 begin
 // retCode:=SCardState(hCard,@dwState1,@dwActProtocol1,@bATR1,@cBAtrLen1);
 retCode:=SCardState(hCard,@dwState,@dwActProtocol1,@bATR1,@cBAtrLen1);
  if dwState=6 {ConnActive} then
  begin
    Label1.Caption:='Има Карта!';
    Label1.Color:=clGreen;
    Exit;
  end
  else
   begin
    Label1.Caption:='Няма Карта!';
    Label1.Color:=clRed;

   end;
 end;

end;

procedure TSLE4432_4442Main.Button2Click(Sender: TObject);
begin
Timer1.Enabled:=False;
Timer1.Enabled:=True;
TimerTime:=1;
end;

procedure TSLE4432_4442Main.Button3Click(Sender: TObject);
var
  Result: String;
  Buff: Real;
begin
tData.Text:=LeftStr(Edit1.Text,16);
tAdd.Text:='80';
tLen.Text:='0f';
bWriteClick(Sender); // Запис на име на студиото на адрес 80-8f

tData.Text:=LeftStr(Edit2.Text,3);
tAdd.Text:='f9';
tLen.Text:='01'; // Запис на номер на студиото
bWriteClick(Sender);

tData.Text:=LeftStr(Edit3.Text,32);
tAdd.Text:='90';
tLen.Text:='1f'; // Запис на име на клиента
bWriteClick(Sender);

Buff:=  (StrToCurr(Edit4.Text));
FmtStr(Result,'%4.2f',[Buff]);
tData.Text:= AnsiReplaceStr(Result,'.','');
tAdd.Text:='b0';
tLen.Text:='03'; // Запис на баланс
bWriteClick(Sender);

tData.Text:=LeftStr(Edit5.Text,6);
tAdd.Text:='fa';
tLen.Text:='03'; // Запис на PIN-код
bWriteClick(Sender);

tData.Text:=LeftStr(Edit6.Text,6);
tAdd.Text:='fd';
tLen.Text:='03'; // Запис на номер на карта
bWriteClick(Sender);


end;

end.
