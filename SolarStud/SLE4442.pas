unit SLE4442;

interface
uses main,  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACSModule, StdCtrls, ExtCtrls, ComCtrls, StrUtils;
  Const MAX_BUFFER_LEN    = 256;
  Const INVALID_SW1SW2    = -450;

  var
//  SLE4432_4442Main: TSLE4432_4442Main;
  hContext    : SCARDCONTEXT;
  hCard       : SCARDCONTEXT;
  ioRequest   : SCARD_IO_REQUEST;
  retCode     : Integer;
  dwActProtocol, BufferLen    : DWORD;
  SendBuff, RecvBuff          : array [0..262] of Byte;
  SendLen, RecvLen, nBytesRet : DWORD;
  Buffer      : array [0..MAX_BUFFER_LEN] of char;
  ConnActive  : Boolean;
  Address: String;
  Length1: String;
  Data: String;
   dwState:DWORD;
 bATR: Byte;
 TimerTime: Integer;
 dwState1:DWORD;
 bATR1: Byte;
 cBAtrLen1: DWORD;
 dwActProtocol1: DWORD;
 cBAtrLen: DWORD;

procedure ClearBuffers();
//procedure InitMenu();
//procedure AddButtons();
//procedure ClearFields();
procedure GetATR();
procedure displayOut(errType: Integer; retVal: Integer; PrintText: String);
function SendAPDUandDisplay(SendType: integer; ApduIn: string): integer;
function CallCardControl(): integer;
function InputOK(checkType: integer): boolean;
function TrimInput(InString: String): String;
procedure SLE4442Timer3();
procedure SLE4442ReadCardInfo();
procedure SLE4442WriteCardInfo();
procedure SLE4442ShowCardInfo();
function SLE4442Submit(): Boolean;
procedure ClearCard();
procedure SLE4442Init();  procedure SLE4442Reset();
procedure SLE4442ChangePIN();

implementation

procedure ClearBuffers();
var indx: integer;
begin

  for indx := 0 to 262 do
    begin
      SendBuff[indx] := $00;
      RecvBuff[indx] := $00;
    end;

end;

procedure displayOut(errType: Integer; retVal: Integer; PrintText: String);
begin

  case errType of
    0: MainForm.mMsg.SelAttributes.Color := clTeal;   // Notifications
    1: begin                                                  // Error Messages
         MainForm.mMsg.SelAttributes.Color := clRed;
         PrintText := GetScardErrMsg(retVal);
       end;
    2: begin
         MainForm.mMsg.SelAttributes.Color := clBlack;
         PrintText := '< ' + PrintText;                      // Input data
       end;
    3: begin
         MainForm.mMsg.SelAttributes.Color := clBlack;
         PrintText := '> ' + PrintText;                      // Output data
       end;
  end;
  if MainForm.mMsg.Lines.Count>10 then MainForm.mMsg.Lines.Clear;
  MainForm.mMsg.Lines.Add(PrintText);
  MainForm.mMsg.SelAttributes.Color := clBlack;

end;

function InputOK(checkType: integer): boolean;
var tmpStr: String;
    indx: integer;
begin

  InputOK := True;

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
procedure SLE4442Init();
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
    MainForm.mMsg.Clear;
    DisplayOut(0, 0, 'Поставете Карта!.');



end;

procedure SLE4442Reset();
begin

//  ClearFields();
//  rgCardType.ItemIndex := -1;
  if ConnActive then
    begin
      retCode := SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
      ConnActive := False;
    end;

  retCode := SCardReleaseContext(hCard);
//  InitMenu();

end;

procedure SLE4442Connect();
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

//  ClearFields();
//  gbFunction.Enabled := True;

end;
procedure SLE4442Read();
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
  SendBuff[3] := (StrToInt('$' + copy(Address,1,2)));
  SendBuff[4] := (StrToInt('$' + copy(Length1,1,2)));
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
  Data := tmpStr;

end;

procedure SLE4442Write();
var tmpStr: string;
    indx: integer;
begin

  // 1. Check all input fields
 // if not InputOK(1) then
 //   Exit;

  // 2. Send all inputs to the card

 // ClearBuffers();
  SendBuff[0] := $FF;
  SendBuff[1] := $D0;
  SendBuff[2] := $00;
  SendBuff[3] := (StrToInt('$' + copy(Address,1,2)));
  SendBuff[4] := (StrToInt('$' + copy(Length1,1,2)));
  if not (Data='') then
  begin
   tmpStr := Data;
   for indx := 0 to SendBuff[4]-1 do
     SendBuff[indx+5] := ord(tmpStr[indx+1]);
  end;
  SendLen := 5 + SendBuff[4];
  RecvLen := 2;
  tmpStr := '';
  for indx := 0 to SendLen-1 do
    tmpStr := tmpStr + Format('%.02X ',[SendBuff[indx]]);
  retCode := SendAPDUandDisplay(2, tmpStr);
  if retCode <> SCARD_S_SUCCESS then
    Exit;

  Data:='';

end;
function SLE4442Submit():Boolean;
var tmpStr: string;
    indx: integer;
begin

  // 1. Check all input fields
  if not InputOK(2) then
    Exit;

  // 2. Send all inputs to the card
  ClearBuffers();
  tmpStr := TrimInput(Data);
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
    SLE4442Submit:=False
   else
    SLE4442Submit:=True;
  Data:='';

end;

function SLE4442ReadCounter(): Boolean;
var tmpStr: string;
    indx: integer;
begin
  // 1. Clear all input fields
//  ClearFields();

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
  if retCode <> SCARD_S_SUCCESS then SLE4442ReadCounter:=False
   else SLE4442ReadCounter:=True;

end;

procedure SLE4442ChangePIN();
var tmpStr: string;
    indx: integer;
begin

  // 1. Check all input fields
  if not InputOK(2) then
    Exit;

  // 2. Send all inputs to the card
  ClearBuffers();
  tmpStr := TrimInput(Data);
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

  Data:='';

end;

Function SLE4442GetReaderState():String;
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


procedure SLE4442WriteCardInfo();
var
  Result: String;
  Buff: Real;
  Temp: Integer;
begin
Data:=LeftStr(Card.StudioName,16);
Address:='80';
Length1:='0f';
SLE4442Write; // Запис на име на студиото на адрес 80-8f

Data:=IntToStr(Card.StudioNomer);
Address:='f9';
Length1:='01'; // Запис на номер на студиото
SLE4442Write;

Data:=LeftStr(Card.ClientName,32);
Address:='90';
Length1:='1f'; // Запис на име на клиента
SLE4442Write;


//FmtStr(Result,'%4.2f',[Card.Balans]);
if Card.Balans<0 then Temp:=0 else
 Temp:=Round(Card.Balans*100);
//Data:= AnsiReplaceStr(Result,'.','');
SendBuff[5]:=Byte(Temp div (256*256));
SendBuff[6]:=Byte((Temp - SendBuff[5]*256*256) div 256);
SendBuff[7]:=Byte((Temp - SendBuff[5]*256*256- SendBuff[6]*256));
Data:='';
Address:='b0';
Length1:='03'; // Запис на баланс
SLE4442Write;

Data:='';
SendBuff[5]:=Byte(StrToInt('$' + (LeftStr(Card.PIN,2))));
SendBuff[6]:=Byte(StrToInt('$' + (MidStr(Card.PIN,3,2))));
SendBuff[7]:=Byte(StrToInt('$' + (MidStr(Card.PIN,5,2))));
Address:='fa';
Length1:='03'; // Запис на PIN-код
SLE4442Write;

SendBuff[5]:=Byte(Card.CardNomer div (256*256));
SendBuff[6]:=Byte((Card.CardNomer - SendBuff[5]*256*256) div 256);
SendBuff[7]:=Byte((Card.CardNomer - SendBuff[5]*256*256- SendBuff[6]*256));
if Card.CardNomer<0 then
 begin
  SendBuff[5]:=255;
  SendBuff[6]:=255;
  SendBuff[7]:=255;
 end;
Data:='';
Address:='fd';
Length1:='03'; // Запис на номер на карта
SLE4442Write;

SendBuff[5]:=Byte( Card.ClientNomer div (256*256));
SendBuff[6]:=Byte((Card.ClientNomer - SendBuff[5]*256*256) div 256);
SendBuff[7]:=Byte((Card.ClientNomer - SendBuff[5]*256*256- SendBuff[6]*256));
if Card.ClientNomer<0 then
 begin
  SendBuff[5]:=255;
  SendBuff[6]:=255;
  SendBuff[7]:=255;
 end;
Data:='';
Address:='f6';
Length1:='03'; // Запис на номер на клиент
SLE4442Write;

end;

procedure SLE4442ReadCardInfo();
var
  i:Integer;
  Result: String;
  Buff: Real;
  Temp: Integer;
  AResult: Pointer ;
begin

 Address:='80';
 Length1:='0f';
 SLE4442Read; // Четене на име на студиото на адрес 80-8f
 Result:=#0;
 Temp:= Pos(Result,Data)-1;
 Card.StudioName:=LeftStr(Data,Temp);
 Address:='f9';
 Length1:='01'; // Четене на номер на студиото
 SLE4442Read;
 if not tryStrToInt(Data,Card.StudioNomer) then Card.StudioNomer:=0;

 Address:='90';
 Length1:='1f'; // Четене на име на клиента
 SLE4442Read;
 Temp:= Pos(Result,Data)-1;
 Card.ClientName:=LeftStr(Data,Temp);

 Address:='b0';
 Length1:='03'; // Четене на баланс
 SLE4442Read;
 Data:='$';
 for i:=0 to 2 do
  Data:= Data+Format('%.2X', [(RecvBuff[i])]);
 if not TryStrToInt(Data,Temp) then Temp:=0;
 if Temp>65535 then Temp:=-1;
 Card.Balans:=Temp/100;

 Address:='fa';
 Length1:='03'; // Четене на PIN-код
 SLE4442Read;
 Address:=IntToHex(Byte(RecvBuff[0]),2);
 Card.PIN:= IntToHex(Byte(RecvBuff[0]),2)+ IntToHex(Byte(RecvBuff[1]),2)+IntToHex(Byte(RecvBuff[2]),2);

 Address:='fd';
 Length1:='03'; // Четене на номер на карта
 SLE4442Read;
  Data:='$';
 for i:=0 to 2 do
  Data:= Data+Format('%.2X', [(RecvBuff[i])]);
 if not TryStrToInt(Data,Temp) then Temp:=0;
 if Temp>65535 then Temp:=-1;
Card.CardNomer:= Temp;

 Address:='f6';
 Length1:='03'; // Четене на номер на клиент
 SLE4442Read;
  Data:='$';
 for i:=0 to 2 do
  Data:= Data+Format('%.2X', [(RecvBuff[i])]);
 if not TryStrToInt(Data,Temp) then Temp:=0;
 if Temp>65535 then Temp:=-1;
 Card.ClientNomer:= Temp;
 if Card.ClientNomer<0 then Card.ClientNomer:=0;

 //if not TryStrToInt(Data,Card.CardNomer) then Card.CardNomer:=0;
 if SLE4442ReadCounter then
   begin
    Card.ErrCounter:= RecvBuff[0];
    Card.ConStatus:= RecvBuff[1]
   end
   else
   begin
    Card.ErrCounter:=-99; Card.ConStatus:= -99;
   end;

end;

procedure SLE4442ShowCardInfo();
var
  PrintText: string;
begin
 MainForm.mMsg.Clear;
 MainForm.mMsg.SelAttributes.Color := clBlue;
 if (Card.PIN='FFFFFF') or (Card.PIN='ffffff') then  MainForm.mMsg.Lines.Add('--ПРАЗНА КАРТА--')
 else
  begin
   PrintText := 'Клиент номер:> ' + IntToStr(Card.ClientNomer);
   MainForm.mMsg.Lines.Add(PrintText);
   MainForm.mMsg.SelAttributes.Color := clBlack;
   PrintText := 'Клиент:> ' + Card.ClientName;
   MainForm.mMsg.Lines.Add(PrintText);
   MainForm.mMsg.SelAttributes.Color := clRed;
   PrintText := 'Сума в карта:> ';
    if not (Card.Balans<0)then PrintText:= PrintText + FloatToStr(Card.Balans,LocalFormat)+'лв.';
   MainForm.mMsg.Lines.Add(PrintText);
   MainForm.mMsg.SelAttributes.Color := clPurple;
   PrintText := 'Студио:> ' + Card.StudioName;
   MainForm.mMsg.Lines.Add(PrintText);
   MainForm.mMsg.SelAttributes.Color := clBlack;
   PrintText := 'Студио №:> ' + IntToStr(Card.StudioNomer);
   MainForm.mMsg.Lines.Add(PrintText);
   MainForm.mMsg.SelAttributes.Color := clBlack;
  end;
 MainForm.mMsg.Lines.Add('-----------------');
 PrintText := 'PIN:> ' + Card.PIN;
 MainForm.mMsg.Lines.Add(PrintText);

 if Card.ErrCounter=7 then
  begin
   MainForm.mMsg.SelAttributes.Color := clGreen;
   MainForm.mMsg.Lines.Add('Status: OK');
  end
 else
  begin
   MainForm.mMsg.SelAttributes.Color := clRed;
   MainForm.mMsg.Lines.Add('Status: BAD');
  end;
end;


procedure SLE4442Timer3();
var
 dwState:DWORD;
 bATR: Byte;
 cBAtrLen: DWORD;
 Result: String;
 Ostatak: Real;
begin
If (TimerTime>4) and (MainForm.Label137.Font.Color = clRed) then TimerTime:=0;
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
 { BufferLen := MAX_BUFFER_LEN;
  retCode := SCardListReadersA(hContext,
                               nil,
                               @Buffer,
                               @BufferLen);
  if retCode <> SCARD_S_SUCCESS then
    begin
      DisplayOut(1, retCode, ' List1');
      Exit;
    end;     }
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
      SLE4442Init();
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
   MainForm.Edit8.Visible:=False;
   if  not(MainForm.Label137.Font.Color=clGreen) then
    begin
     MainForm.Label137.Caption:='Има Карта!';
     MainForm.Label137.Font.Color:=clGreen;
     SLE4442ReadCardInfo();
     SLE4442ShowCardInfo();
     if (card.StudioNomer= MainForm.Internet.FieldValues['StudioNomer']) OR (card.StudioName= MainForm.Internet.FieldValues['StudioName']) then
     begin
      MainForm.QKlienti.Active:=False;
 //     MainForm.QKlienti.SQL.SetText(PChar('SELECT * FROM klienti ORDER BY IME'));
      MainForm.QKlienti.SQL.SetText(PChar('SELECT * FROM klienti WHERE NOMER = '+IntToStr(Card.ClientNomer)));
      MainForm.QKlienti.Active:=True;
      if MainForm.Qklienti.Locate('NOMER',Card.ClientNomer,[]) then
       begin
        MainForm.Label130.Visible:=True;
        MainForm.DBText7.Visible:=True;
        MainForm.DBText4.Visible:=True;
        if not (card.ClientName=MainForm.Qklienti.FieldValues['ime']) then
         begin
           MainForm.Qklienti.Edit;
           MainForm.Qklienti.FieldValues['ime']:= card.ClientName;
           MainForm.Qklienti.Post;
         end;
       end;
     end;
     MainForm.Label71.Visible:=True;
     MainForm.Label72.Visible:=True;
     Ostatak:= (Card.Balans)/MainForm.Table1.FieldValues['CENA'];
     FmtStr(Result,'%4.2f',[Ostatak]);
     MainForm.Label72.Caption:=''+ Result+'минути / ';
     FmtStr(Result,'%4.2f',[Card.Balans]);
     MainForm.Label72.Caption:=MainForm.Label72.Caption + ''+ Result+'лв.';
    end;
    Exit;
  end
  else
   begin
    MainForm.Label137.Caption:='Няма Карта!';
    MainForm.Label137.Font.Color:=clRed;
    if PaidChipCard>0 then
     begin
      PaidChipCard:=0;
      CalcPaid;
     end;
    if MainForm.Label119.Visible=False then
     begin
        MainForm.Label130.Visible:=False;
        MainForm.DBText7.Visible:=False;
        MainForm.DBText4.Visible:=False;
        MainForm.Label71.visible:=False;
        MainForm.Label72.visible:=False;
        MainForm.Edit8.Visible:=False;
     end;
    MainForm.mMsg.Clear;
    Card.ClientNomer:=-1;
   end;
 end;

end;

procedure ClearCard();
var indx: integer;
begin
  Data:='ffffff';
  SLE4442ChangePIN();
  for indx := 0 to 80 do
    begin
      SendBuff[indx+5] := $ff;
      RecvBuff[indx+5] := $ff;
    end;
  Data:='';
  Address:='80';
  Length1:='3f';
  SLE4442Write; // Запис
    for indx := 0 to 80 do
    begin
      SendBuff[indx+5] := $ff;
      RecvBuff[indx+5] := $ff;
    end;
  Address:='c0';
  Length1:='3f';
  SLE4442Write; // Запис

end;

end.
