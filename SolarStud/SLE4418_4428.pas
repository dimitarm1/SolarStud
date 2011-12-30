//  Copyright(C):      Advanced Card Systems Ltd
//
//  File:              SLE4418_4428Main.pas
//
//  Description:       This sample program outlines the steps on how to
//                     program SLE4418/4428 memory cards using ACS readers
//                     in PC/SC platform.
//
//  Author:	           Jose Isagani R. Mission
//
//  Date:	             June 18, 2004
//
//  Revision Trail:   (Date/Author/Description)
//
//======================================================================
unit SLE4418_4428;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACSModule, StdCtrls, ExtCtrls, ComCtrls;

Const MAX_BUFFER_LEN    = 256;
Const INVALID_SW1SW2    = -450;

type
  TSLE4418_4428Main = class(TForm)
    Label1: TLabel;
    cbReader: TComboBox;
    bInit: TButton;
    bConnect: TButton;
    mMsg: TRichEdit;
    bReset: TButton;
    bQuit: TButton;
    rgCardType: TRadioGroup;
    gbFunction: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    tHiAdd: TEdit;
    tLen: TEdit;
    tData: TEdit;
    bRead: TButton;
    bWrite: TButton;
    tLoAdd: TEdit;
    bReadProt: TButton;
    bWriteProt: TButton;
    bSubmit: TButton;
    bReadCtr: TButton;
    procedure bInitClick(Sender: TObject);
    procedure bResetClick(Sender: TObject);
    procedure cbReaderClick(Sender: TObject);
    procedure bQuitClick(Sender: TObject);
    procedure tHiAddKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tLenKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tHiAddKeyPress(Sender: TObject; var Key: Char);
    procedure tLenKeyPress(Sender: TObject; var Key: Char);
    procedure tRandKeyPress(Sender: TObject; var Key: Char);
    procedure bConnectClick(Sender: TObject);
    procedure tLoAddKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tLoAddKeyPress(Sender: TObject; var Key: Char);
    procedure bReadClick(Sender: TObject);
    procedure bWriteClick(Sender: TObject);
    procedure tLenExit(Sender: TObject);
    procedure tRPValKeyPress(Sender: TObject; var Key: Char);
    procedure rgCardTypeClick(Sender: TObject);
    procedure bSubmitClick(Sender: TObject);
    procedure bReadProtClick(Sender: TObject);
    procedure bWriteProtClick(Sender: TObject);
    procedure bReadCtrClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SLE4418_4428Main: TSLE4418_4428Main;
  hContext    : SCARDCONTEXT;
  hCard       : SCARDCONTEXT;
  ioRequest   : SCARD_IO_REQUEST;
  retCode     : Integer;
  dwActProtocol, BufferLen    : DWORD;
  SendBuff, RecvBuff          : array [0..262] of Byte;
  SendLen, RecvLen, nBytesRet : DWORD;
  Buffer      : array [0..MAX_BUFFER_LEN] of char;
  ConnActive  : Boolean;

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

  SLE4418_4428Main.cbReader.Clear;
  SLE4418_4428Main.mMsg.Clear;
  SLE4418_4428Main.cbReader.Enabled := False;
  SLE4418_4428Main.bInit.Enabled := True;
  SLE4418_4428Main.rgCardType.Enabled := False;
  SLE4418_4428Main.gbFunction.Enabled := False;
  SLE4418_4428Main.bConnect.Enabled := False;

end;

procedure AddButtons();
begin

  SLE4418_4428Main.rgCardType.Enabled := True;
  SLE4418_4428Main.rgCardType.ItemIndex := 0;
  SLE4418_4428Main.cbReader.Enabled := True;
  SLE4418_4428Main.bInit.Enabled := False;
  SLE4418_4428Main.bConnect.Enabled := True;
  SLE4418_4428Main.bReset.Enabled := True;

end;

procedure ClearFields();
begin

  SLE4418_4428Main.tHiAdd.Text := '';
  SLE4418_4428Main.tLoAdd.Text := '';
  SLE4418_4428Main.tLen.Text := '';
  SLE4418_4428Main.tData.Text := '';
  SLE4418_4428Main.tData.MaxLength := 0;

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
  SendBuff[5] := $05;  // SLE4418/4428 value
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
    0: SLE4418_4428Main.mMsg.SelAttributes.Color := clTeal;   // Notifications
    1: begin                                                  // Error Messages
         SLE4418_4428Main.mMsg.SelAttributes.Color := clRed;
         PrintText := GetScardErrMsg(retVal);
       end;
    2: begin
         SLE4418_4428Main.mMsg.SelAttributes.Color := clBlack;
         PrintText := '< ' + PrintText;                      // Input data
       end;
    3: begin
         SLE4418_4428Main.mMsg.SelAttributes.Color := clBlack;
         PrintText := '> ' + PrintText;                      // Output data
       end;
  end;
  SLE4418_4428Main.mMsg.Lines.Add(PrintText);
  SLE4418_4428Main.mMsg.SelAttributes.Color := clBlack;
  SLE4418_4428Main.mMsg.SetFocus;

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
         if (SLE4418_4428Main.tHiAdd.Text = '') then begin
           SLE4418_4428Main.tHiAdd.Text := '0';
           SLE4418_4428Main.tHiAdd.SetFocus;
           Exit;
         end;
         if (SLE4418_4428Main.tLoAdd.Text = '') then begin
           SLE4418_4428Main.tLoAdd.SetFocus;
           Exit;
         end;
         if (SLE4418_4428Main.tLen.Text = '') then begin
           SLE4418_4428Main.tLen.SetFocus;
           Exit;
         end;
       end;
    1: begin              // for Write function
         if (SLE4418_4428Main.tHiAdd.Text = '')  then begin
           SLE4418_4428Main.tHiAdd.Text := '0';
           SLE4418_4428Main.tHiAdd.SetFocus;
           Exit;
         end;
         if (SLE4418_4428Main.tLoAdd.Text = '') then begin
           SLE4418_4428Main.tLoAdd.SetFocus;
           Exit;
         end;
         if (SLE4418_4428Main.tLen.Text = '') then begin
           SLE4418_4428Main.tLen.SetFocus;
           Exit;
         end;
         if (SLE4418_4428Main.tData.Text = '') then begin
           SLE4418_4428Main.tData.SetFocus;
           Exit;
         end;
       end;
    2: begin              // for Verify function
         SLE4418_4428Main.tHiAdd.Text := '';
         SLE4418_4428Main.tLoAdd.Text := '';
         SLE4418_4428Main.tLen.Text := '';
         SLE4418_4428Main.tData.Text := UpperCase(SLE4418_4428Main.tData.Text);
         if (SLE4418_4428Main.tData.Text = '') then begin
           SLE4418_4428Main.tData.SetFocus;
           Exit;
         end;
         tmpStr := TrimInput(SLE4418_4428Main.tData.Text);
         if (Length(tmpStr) <> 4) then begin
           SLE4418_4428Main.tData.SelectAll;
           SLE4418_4428Main.tData.SetFocus;
           Exit;
         end;
         for indx := 1 to 4 do
           if not (tmpStr[indx] in ['A'..'F']) then
             if not (tmpStr[indx] in ['0'..'9']) then  begin
               SLE4418_4428Main.tData.SelectAll;
               SLE4418_4428Main.tData.SetFocus;
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

procedure TSLE4418_4428Main.bInitClick(Sender: TObject);
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

  SLE4418_4428Main.cbReader.Clear;
  LoadListToControl(SLE4418_4428Main.cbReader,@buffer,bufferLen);
  SLE4418_4428Main.cbReader.ItemIndex := 0;
  AddButtons();

end;

procedure TSLE4418_4428Main.bResetClick(Sender: TObject);
begin

  ClearFields();
  rgCardType.ItemIndex := -1;
  if ConnActive then
    begin
      retCode := SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
      ConnActive := False;
    end;

  retCode := SCardReleaseContext(hCard);
  InitMenu();

end;

procedure TSLE4418_4428Main.cbReaderClick(Sender: TObject);
begin

  ClearFields();
  gbFunction.Enabled := False;
  if ConnActive then
    begin
      retCode := SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
      ConnActive := False;
    end;

end;

procedure TSLE4418_4428Main.bQuitClick(Sender: TObject);
begin

  if ConnActive then
    begin
      retCode := SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
      ConnActive := False;
    end;
  retCode := SCardReleaseContext(hCard);
  Application.Terminate;

end;

procedure TSLE4418_4428Main.tHiAddKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Length(tHiAdd.Text) > 1 then
         tLoAdd.SetFocus;

end;

procedure TSLE4418_4428Main.tLenKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Length(tLen.Text) > 1 then
         tData.SetFocus;

end;

procedure TSLE4418_4428Main.tHiAddKeyPress(Sender: TObject; var Key: Char);
begin

  if Not(Key in ['0'..'3']) then
    if Key <> chr(8) then
      Key := #0;

end;

procedure TSLE4418_4428Main.tLenKeyPress(Sender: TObject; var Key: Char);
begin

  if Key in ['a'..'z'] then Dec(Key,32);
  if Not(Key in ['0'..'9']) then
    if not(Key in ['A'..'F'])  then
      if Key <> chr(8) then
        Key := #0;

end;

procedure TSLE4418_4428Main.tRandKeyPress(Sender: TObject; var Key: Char);
begin

  if Key in ['a'..'z'] then Dec(Key,32);
  if Not(Key in ['0'..'9']) then
    if not(Key in ['A'..'F'])  then
      if Key <> chr(8) then
        if Key <> chr(32) then
          Key := #0;

end;

procedure TSLE4418_4428Main.bConnectClick(Sender: TObject);
begin

  if ConnActive then
  begin
    DisplayOut(0, 0, 'Connection is already active.');
    Exit;
  end;

  // 1. Direct Connection
  retCode := SCardConnectA(hContext,
                           PChar(cbReader.Text),
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
  if rgCardType.ItemIndex = 0 then
    SendBuff[0] := $0F      // Card Type for SLE4418
  else
    SendBuff[0] := $10;     // Card Type for SLE4428
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
                           PChar(cbReader.Text),
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
    DisplayOut(0, 0, 'Successful connection to ' + cbReader.Text);
  ConnActive := True;

  // 4. Get ATR
  GetATR();

  ClearFields();
  gbFunction.Enabled := True;

end;

procedure TSLE4418_4428Main.tLoAddKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Length(tLoAdd.Text) > 1 then
         tLen.SetFocus;

end;

procedure TSLE4418_4428Main.tLoAddKeyPress(Sender: TObject; var Key: Char);
begin

  if Key in ['a'..'z'] then Dec(Key,32);
  if Not(Key in ['0'..'9']) then
    if not(Key in ['A'..'F'])  then
      if Key <> chr(8) then
        Key := #0;

end;

procedure TSLE4418_4428Main.bReadClick(Sender: TObject);
var tmpStr: string;
    indx: integer;
begin

  // 1. Check all input fields
  if not InputOK(0) then
    Exit;

  // 2. Send all inputs to the card
  ClearBuffers();
  SendBuff[0] := $FF;
  SendBuff[1] := $B2;
  SendBuff[2] := (StrToInt('$' + copy(tHiAdd.Text,1,1)));
  SendBuff[3] := (StrToInt('$' + copy(tLoAdd.Text,1,2)));
  SendBuff[4] := (StrToInt('$' + copy(tLen.Text,1,2)));
  SendLen := 5;
  RecvLen := SendBuff[4] + 2;
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

procedure TSLE4418_4428Main.bWriteClick(Sender: TObject);
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
  SendBuff[2] := (StrToInt('$' + copy(tHiAdd.Text,1,1)));
  SendBuff[3] := (StrToInt('$' + copy(tLoAdd.Text,1,2)));
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

procedure TSLE4418_4428Main.tLenExit(Sender: TObject);
begin

  if tLen.Text <> '' then begin
    tData.Clear;
    tData.MaxLength := StrToInt('$' + copy(tLen.Text,1,2));
  end;

end;

procedure TSLE4418_4428Main.tRPValKeyPress(Sender: TObject; var Key: Char);
begin

  if Key in ['a'..'f'] then Dec(Key,32);
  if Not(Key in ['0'..'9']) then
    if not(Key in ['A'..'F'])  then
      if Key <> chr(8) then
        Key := #0;

end;

procedure TSLE4418_4428Main.rgCardTypeClick(Sender: TObject);
begin

  ClearFields();
  gbFunction.Enabled := False;
  if ConnActive then
    begin
      retCode := SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
      ConnActive := False;
    end;
  if rgCardType.ItemIndex = 0 then begin
    bSubmit.Enabled := False;
    bReadCtr.Enabled := False;
  end
  else begin
    bSubmit.Enabled := True;
    bReadCtr.Enabled := True;
  end;
end;

procedure TSLE4418_4428Main.bSubmitClick(Sender: TObject);
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
  SendBuff[4] := $02;
  for indx := 0 to 1 do
    SendBuff[indx+5] := (StrToInt('$' + copy(tmpStr,(indx*2)+1,2)));
  SendLen := 5 + SendBuff[4];
  RecvLen := 5;
  tmpStr := '';
  for indx := 0 to SendLen-1 do
    tmpStr := tmpStr + Format('%.02X ',[SendBuff[indx]]);
  retCode := SendAPDUandDisplay(2, tmpStr);
  if retCode <> SCARD_S_SUCCESS then
    Exit;

  tData.Clear;

end;

procedure TSLE4418_4428Main.bReadProtClick(Sender: TObject);
var tmpStr: string;
    indx, protLen: integer;
begin

  // 1. Check all input fields
  if not InputOK(0) then
    Exit;

  // 2. Send all inputs to the card
  ClearBuffers();
  SendBuff[0] := $FF;
  SendBuff[1] := $B0;
  SendBuff[2] := (StrToInt('$' + copy(tHiAdd.Text,1,1)));
  SendBuff[3] := (StrToInt('$' + copy(tLoAdd.Text,1,2)));
  SendBuff[4] := (StrToInt('$' + copy(tLen.Text,1,2)));
  SendLen := 5;
  protLen := 1 + (SendBuff[4] div 8);
  RecvLen := SendBuff[4] + protLen + 2;
  tmpStr := '';
  for indx := 0 to SendLen-1 do
    tmpStr := tmpStr + Format('%.02X ',[SendBuff[indx]]);
  retCode := SendAPDUandDisplay(2, tmpStr);
  if retCode <> SCARD_S_SUCCESS then
    Exit;

  // 3. Display data read from card into Data textbox
  tmpStr := '';
  for indx := 0 to SendBuff[4] - 1 do
    tmpStr := tmpStr + chr(RecvBuff[indx]);
  tData.Text := tmpStr;

end;

procedure TSLE4418_4428Main.bWriteProtClick(Sender: TObject);
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
  SendBuff[1] := $D1;
  SendBuff[2] := (StrToInt('$' + copy(tHiAdd.Text,1,1)));
  SendBuff[3] := (StrToInt('$' + copy(tLoAdd.Text,1,2)));
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

procedure TSLE4418_4428Main.bReadCtrClick(Sender: TObject);
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
  RecvLen := 5;
  tmpStr := '';
  for indx := 0 to SendLen-1 do
    tmpStr := tmpStr + Format('%.02X ',[SendBuff[indx]]);
  retCode := SendAPDUandDisplay(2, tmpStr);
  if retCode <> SCARD_S_SUCCESS then
    Exit;

end;

end.
