unit SLE4442;

interface
uses main, Password, Windows, Messages, SysUtils, Variants, Classes, Graphics,
    Controls, Forms, Dialogs, ACSModule, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
    ABSMain;
const
    MAX_BUFFER_LEN = 256;
const
    INVALID_SW1SW2 = -450;

var
    //  SLE4432_4442Main: TSLE4432_4442Main;
    hContext: SCARDCONTEXT;
    hCard: SCARDCONTEXT;
    ioRequest: SCARD_IO_REQUEST;
    retCode: Integer;
    dwActProtocol, BufferLen: DWORD;
    SendBuff, RecvBuff: array[0..262] of Byte;
    SendLen, RecvLen, nBytesRet: DWORD;
    Buffer: array[0..MAX_BUFFER_LEN] of char;
    ConnActive: Boolean;
    Address: string;
    Length1: string;
    Data: string;
    dwState: DWORD;
    bATR: Byte;
    TimerTime: Integer;
    dwState1: DWORD;
    bATR1: Byte;
    cBAtrLen1: DWORD;
    dwActProtocol1: DWORD;
    cBAtrLen: DWORD;
    abc1, abc2, abc3, abc4: integer;
    readerName: string;

procedure ClearBuffers();
//procedure InitMenu();
//procedure AddButtons();
//procedure ClearFields();
procedure GetATR();
procedure displayOut(errType: Integer; retVal: Integer; PrintText: string);
function SendAPDUandDisplay(SendType: integer; ApduIn: string): integer;
function CallCardControl(): integer;
function InputOK(checkType: integer): boolean;
function TrimInput(InString: string): string;
procedure SLE4442ShowCardInPaiment();
procedure SLE4442Timer3();
procedure SLE4442ReadCardInfo();
procedure SLE4442WriteCardInfo();
procedure SLE4442ShowCardInfo();
function SLE4442Submit(): Boolean;
procedure SLE4442Init();
procedure SLE4442Deinit();
procedure ClearCard();
procedure SLE4442ChangePIN();
procedure SLE4442Read(addr: integer; length: integer);
procedure SLE4442Write(addr: integer; len: integer);

implementation
uses SetLang;

procedure ClearBuffers();
var
    indx: integer;
begin
    for indx := 0 to 262 do
    begin
        SendBuff[indx] := $00;
        RecvBuff[indx] := $00;
    end;
end;

procedure displayOut(errType: Integer; retVal: Integer; PrintText: string);
begin

    case errType of
        0:
            begin
                MainForm.mMsg.SelAttributes.Color := clTeal; // Notifications
                IsReader := true;
            end;
        1:
            begin // Error Messages
                MainForm.mMsg.SelAttributes.Color := clRed;
                MainForm.mMsg.Lines.Clear;
                PrintText := 'Connect reader!'; //GetScardErrMsg(retVal);
                IsReader := False;
            end;
        2:
            begin
                MainForm.mMsg.SelAttributes.Color := clBlack;
                PrintText := '< ' + PrintText; // Input data
                IsReader := true;
            end;
        3:
            begin
                MainForm.mMsg.SelAttributes.Color := clBlack;
                PrintText := '> ' + PrintText; // Output data
                IsReader := true;
            end;
    end;
    if MainForm.mMsg.Lines.Count > 10 then
        MainForm.mMsg.Lines.Clear;
    MainForm.mMsg.Lines.Add(PrintText);
    MainForm.mMsg.SelAttributes.Color := clBlack;

end;

function InputOK(checkType: integer): boolean;
var
    tmpStr: string;
    indx: integer;
begin

    InputOK := True;

end;

procedure GetATR();
var
    tmpStr: string;
    indx: integer;
begin

    DisplayOut(2, 0, 'Get ATR');     // Select Card type
    ClearBuffers();
    SendLen := 6;
    RecvLen := 6;
    SendBuff[0] := $FF;
    SendBuff[1] := $A4;
    SendBuff[2] := $00;
    SendBuff[3] := $00;
    SendBuff[4] := $01;
    SendBuff[5] := $06; // SLE4432/4442 value
    tmpStr := '';
    for indx := 0 to SendLen - 1 do
        tmpStr := tmpStr + Format('%.02X ', [SendBuff[indx]]);
    retCode := SendAPDUandDisplay(1, tmpStr);
    if retCode <> SCARD_S_SUCCESS then
        Exit;

end;

function SendAPDUandDisplay(SendType: integer; ApduIn: string): integer;
var
    tmpStr: string;
    indx: integer;
begin

    ioRequest.dwProtocol := dwActProtocol;
    ioRequest.cbPciLength := sizeof(SCARD_IO_REQUEST);
    DisplayOut(2, 0, ApduIn);
    retCode := SCardTransmit(hCard,
        @ioRequest,
        @SendBuff,
        SendLen,
        nil,
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
            0:
                begin // Display SW1/SW2 value
                    for indx := (RecvLen - 2) to (RecvLen - 1) do
                        tmpStr := tmpStr + Format('%.02X ', [(RecvBuff[indx])]);
                    if (Trim(tmpStr) <> '90 00') then
                    begin
                        DisplayOut(1, 0, 'Return bytes are not acceptable.');
                        retCode:= SCARD_F_UNKNOWN_ERROR;
                    end;
                end;
            1:
                begin // Display ATR after checking SW1/SW2
                    for indx := (RecvLen - 2) to (RecvLen - 1) do
                        tmpStr := tmpStr + Format('%.02X ', [(RecvBuff[indx])]);
                    if (Trim(tmpStr) <> '90 00') then
                    begin
                        DisplayOut(1, 0, 'Return bytes are not acceptable.');
                        retCode:= SCARD_F_UNKNOWN_ERROR;
                    end
                    else
                    begin
                        tmpStr := 'ATR :';
                        for indx := 0 to (RecvLen - 3) do
                            tmpStr := tmpStr + Format('%.2X ',
                                [(RecvBuff[Indx])]);
                    end;
                end;
            2:
                begin // Display all data after checking SW1/SW2
                    for indx := (RecvLen - 2) to (RecvLen - 1) do
                        tmpStr := tmpStr + Format('%.02X ', [(RecvBuff[indx])]);
                    if (Trim(tmpStr) <> '90 00') then
                    begin
                        DisplayOut(1, 0, 'Return bytes are not acceptable.');
                        retCode:= SCARD_F_UNKNOWN_ERROR;
                    end
                    else
                    begin
                        tmpStr := '';
                        for indx := 0 to (RecvLen - 1) do
                            tmpStr := tmpStr + Format('%.2X ',
                                [(RecvBuff[Indx])]);
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

function TrimInput(InString: string): string;
var
    tmpStr: string;
    indx: integer;
begin
    tmpStr := '';
    for indx := 1 to length(InString) do
        if (InString[indx] <> chr(32)) then
            tmpStr := tmpStr + InString[indx];
    TrimInput := tmpStr;

end;

procedure SLE4442Connect();
begin
    if hCard <> 0 then
    begin
        retCode := SCardState(hCard, @dwState1, @dwActProtocol1, @bATR1,
            @cBAtrLen1);
        if dwState1 = 6 {ConnActive} then
        begin
            DisplayOut(0, 0, '!Connection is already active.');
            Exit;
        end
        else
        begin
            displayOut(0, 0, IntToStr(retCode) + 'state=' + IntToStr(dwState1) +
                ' protocol=' + IntToStr(dwActProtocol1) + IntToStr(bATR1));

        end;
    end;
    // 1. Direct Connection
    retCode := SCardConnectA(hContext,
        //        PChar('ACS ACR38U 0'),
        Buffer,
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
    SendBuff[0] := $12; // Card Type for SLE4442
    retCode := CallCardControl();
    //    if retCode <> SCARD_S_SUCCESS then
    //        Exit;

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
        //PChar('ACS ACR38U 0'),
        Buffer,
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

procedure SLE4442Read(addr: integer; length: integer);
var
    tmpStr: string;
    indx: integer;
begin

    // 2. Send all inputs to the card
    ClearBuffers();
    SendBuff[0] := $FF;
    SendBuff[1] := $B0;
    SendBuff[2] := $00;
    SendBuff[3] := addr;
    SendBuff[4] := length;
    SendLen := 5;
    RecvLen := SendBuff[4] + 6;
    tmpStr := '';
    for indx := 0 to SendLen - 1 do
        tmpStr := tmpStr + Format('%.02X ', [SendBuff[indx]]);
    retCode := SendAPDUandDisplay(2, tmpStr);
    if retCode <> SCARD_S_SUCCESS then
        Exit;

    // 3. Display data read from card into Data textbox
    tmpStr := '';
    for indx := 0 to SendBuff[4] - 1 do
        tmpStr := tmpStr + chr(RecvBuff[indx]);
    Data := tmpStr;

end;

procedure SLE4442Write(addr: integer; len: integer);
var
    tmpStr: string;
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
    SendBuff[3] := addr;
    SendBuff[4] := len;
    if not (Data = '') then
    begin
        tmpStr := Data;
        for indx := 0 to SendBuff[4] - 1 do
            SendBuff[indx + 5] := ord(tmpStr[indx + 1]);
    end;
    SendLen := 5 + SendBuff[4];
    RecvLen := 2;
    tmpStr := '';
    for indx := 0 to SendLen - 1 do
        tmpStr := tmpStr + Format('%.02X ', [SendBuff[indx]]);
    retCode := SendAPDUandDisplay(2, tmpStr);
    if retCode <> SCARD_S_SUCCESS then
        Exit;

    Data := '';

end;

function SLE4442Submit(): Boolean;
var
    tmpStr: string;
    indx: integer;
begin

    // 1. Check all input fields
    if not IsChipCard then
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
        SendBuff[indx + 5] := (StrToInt('$' + copy(tmpStr, (indx * 2) + 1, 2)));
    SendLen := 5 + SendBuff[4];
    RecvLen := 6;
    tmpStr := '';
    for indx := 0 to SendLen - 1 do
        tmpStr := tmpStr + Format('%.02X ', [SendBuff[indx]]);
    retCode := SendAPDUandDisplay(2, tmpStr);
    if retCode <> SCARD_S_SUCCESS then
        SLE4442Submit := False
    else
        SLE4442Submit := True;
    Data := '';

end;

function SLE4442ReadCounter(): Boolean;
var
    tmpStr: string;
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
//    SendBuff[4] := $00;
    SendBuff[4] := $04;
    SendLen := 5;
    RecvLen := 6;
    tmpStr := '';
    for indx := 0 to SendLen - 1 do
        tmpStr := tmpStr + Format('%.02X ', [SendBuff[indx]]);
    retCode := SendAPDUandDisplay(2, tmpStr);
    if retCode <> SCARD_S_SUCCESS then
        SLE4442ReadCounter := False
    else
        SLE4442ReadCounter := True;

end;

procedure SLE4442ChangePIN();
var
    tmpStr: string;
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
        SendBuff[indx + 5] := (StrToInt('$' + copy(tmpStr, (indx * 2) + 1, 2)));
    SendLen := 5 + SendBuff[4];
    RecvLen := 2;
    tmpStr := '';
    for indx := 0 to SendLen - 1 do
        tmpStr := tmpStr + Format('%.02X ', [SendBuff[indx]]);
    retCode := SendAPDUandDisplay(2, tmpStr);
    if retCode <> SCARD_S_SUCCESS then
        Exit;

    Data := '';

end;

function SLE4442GetReaderState(): string;
var
    dwState: DWORD;
    bATR: Byte;
    cBAtrLen: DWORD;

begin

    retCode := 0;
    retCode := SCardState(hCard, @dwState, @dwActProtocol, @bATR, @cBAtrLen);
    displayOut(0, 0, IntToStr(retCode) + 'state=' + IntToStr(dwState) +
        ' protocol=' + IntToStr(dwActProtocol) + IntToStr(bATR));
    //displayOut(0,0,GetReaderStateStrMsg(dwState));

end;

procedure SLE4442WriteCardInfo();
var
    Result: string;
    Buff: Real;
    Temp: Integer;
begin
    Data := LeftStr(Card.StudioName, 16);
    SLE4442Write($80, $0F); // Запис на име на студиото на адрес 80-8f

    Data := char(Card.StudioNomer);
    SLE4442Write($F9, $01); // Запис на номер на студиото

    Data := LeftStr(Card.ClientName, 32);
    SLE4442Write($90, $1F); // Запис на име на клиента

    //FmtStr(Result,'%4.2f',[Card.Balans]);
    if Card.Balans < 0 then
        Temp := 0
    else
        Temp := Round(Card.Balans * 100);
    //Data:= AnsiReplaceStr(Result,'.','');
    SendBuff[5] := Byte(Temp div (256 * 256));
    SendBuff[6] := Byte((Temp - SendBuff[5] * 256 * 256) div 256);
    SendBuff[7] := Byte((Temp - SendBuff[5] * 256 * 256 - SendBuff[6] * 256));
    Data := '';
    SLE4442Write($B0, $03); // Запис на баланс

    Data := '';
    SendBuff[5] := Byte(StrToInt('$' + (LeftStr(Card.PIN, 2))));
    SendBuff[6] := Byte(StrToInt('$' + (MidStr(Card.PIN, 3, 2))));
    SendBuff[7] := Byte(StrToInt('$' + (MidStr(Card.PIN, 5, 2))));
    SLE4442Write($FA, $03); // Запис на PIN-код

    SendBuff[5] := Byte(Card.CardNomer div (256 * 256));
    SendBuff[6] := Byte((Card.CardNomer - SendBuff[5] * 256 * 256) div 256);
    SendBuff[7] := Byte((Card.CardNomer - SendBuff[5] * 256 * 256 - SendBuff[6]
        * 256));
    if Card.CardNomer < 0 then
    begin
        SendBuff[5] := 255;
        SendBuff[6] := 255;
        SendBuff[7] := 255;
    end;
    Data := '';
    SLE4442Write($FD, $03); // Запис на номер на карта

    SendBuff[5] := Byte(Card.ClientNomer div (256 * 256));
    SendBuff[6] := Byte((Card.ClientNomer - SendBuff[5] * 256 * 256) div 256);
    SendBuff[7] := Byte((Card.ClientNomer - SendBuff[5] * 256 * 256 - SendBuff[6]
        * 256));
    if Card.ClientNomer < 0 then
    begin
        SendBuff[5] := 255;
        SendBuff[6] := 255;
        SendBuff[7] := 255;
    end;
    Data := '';
    SLE4442Write($F6, $03); // Запис на номер на клиент

end;

procedure SLE4442ReadCardInfo();
var
    i: Integer;
    Result: string;
    Buff: Real;
    Temp: Integer;
    AResult: Pointer;
    Result2: integer;
    StudioNomer: integer;
    tmpStr: string;
    indx: integer;
begin
    if IsChipCard then
    begin

        // 2. Send all inputs to the card
        ClearBuffers();
        SendBuff[0] := $FF;
        SendBuff[1] := $B0;
        SendBuff[2] := $00;
        SendBuff[3] := (StrToInt('$00'));
        SendBuff[4] := (StrToInt('$ff'));
        SendLen := 5;
        RecvLen := SendBuff[4] + 6;
        tmpStr := '';
        for indx := 0 to SendLen - 1 do
            tmpStr := tmpStr + Format('%.02X ', [SendBuff[indx]]);
        retCode := SendAPDUandDisplay(2, tmpStr);
        if retCode <> SCARD_S_SUCCESS then
            Exit;
        retCode := SendAPDUandDisplay(2, tmpStr);
        RecvBuff[0] := RecvBuff[0];

        SLE4442Read($80, $0F); // Четене на име на студиото на адрес 80-8f
        Result := #0;
        Temp := Pos(Result, Data) - 1;
        Card.StudioName := LeftStr(Data, Temp);

        SLE4442Read($F9, $01); // Четене на номер на студиото
        Card.StudioNomer := ord(Data[1]);

        SLE4442Read($90, $1F); // Четене на име на клиента
        Temp := Pos(Result, Data) - 1;
        Card.ClientName := LeftStr(Data, Temp);

        SLE4442Read($B0, $03); // Четене на баланс
        Data := '$';
        for i := 0 to 2 do
            Data := Data + Format('%.2X', [(RecvBuff[i])]);
        if not TryStrToInt(Data, Temp) then
            Temp := 0;
        if Temp > 65535 then
            Temp := -1;
        Card.Balans := Temp / 100;

        SLE4442Read($FA, $03); // Четене на PIN-код
        Address := IntToHex(Byte(RecvBuff[0]), 2);
        Card.PIN := IntToHex(Byte(RecvBuff[0]), 2) + IntToHex(Byte(RecvBuff[1]),
            2) + IntToHex(Byte(RecvBuff[2]), 2);

        SLE4442Read($FD, $03); // Четене на номер на карта
        Data := '$';
        for i := 0 to 2 do
            Data := Data + Format('%.2X', [(RecvBuff[i])]);
        if not TryStrToInt(Data, Temp) then
            Temp := 0;
        if Temp > 65535 then
            Temp := -1;
        Card.CardNomer := Temp;

        SLE4442Read($F6, $03); // Четене на номер на клиент
        Data := '$';
        for i := 0 to 2 do
            Data := Data + Format('%.2X', [(RecvBuff[i])]);
        if not TryStrToInt(Data, Temp) then
            Temp := 0;
        if Temp > 16777214 then
            Temp := -1;
        Card.ClientNomer := Temp;
        if Card.ClientNomer < 0 then
            Card.ClientNomer := 0;
        CardNomer := Card.ClientNomer;
        //if not TryStrToInt(Data,Card.CardNomer) then Card.CardNomer:=0;
        if SLE4442ReadCounter then
        begin
            Card.ErrCounter := RecvBuff[0];
            Card.ConStatus := RecvBuff[1];
        end
        else
        begin
            Card.ErrCounter := -99;
            Card.ConStatus := -99;
        end;
    end;
end;

procedure SLE4442ShowCardInfo();
var
    PrintText: string;
    Result2: Integer;
    vBalans: Real;
begin

    MainForm.mMsg.Clear;
    MainForm.mMsg.SelAttributes.Color := clBlue;
    if (Card.PIN = 'FFFFFF') or (Card.PIN = 'ffffff') then
        MainForm.mMsg.Lines.Add('--ПРАЗНА КАРТА--')
    else
    begin
        PrintText := GetMessage('M37') + ' ' + IntToStr(Card.ClientNomer);
        // 'Клиент номер:> '
        MainForm.mMsg.Lines.Add(PrintText);
        MainForm.mMsg.SelAttributes.Color := clBlack;
        PrintText := GetMessage('M38') + ' ' + Card.ClientName; //'Клиент:> '
        MainForm.mMsg.Lines.Add(PrintText);
        MainForm.mMsg.SelAttributes.Color := clRed;
        PrintText := GetMessage('M39') + ' '; // 'Сума в карта:> '
        if not (Card.Balans < 0) then
            PrintText := PrintText + FloatToStr(Card.Balans, LocalFormat) +
                'лв.';
        MainForm.mMsg.Lines.Add(PrintText);
        MainForm.mMsg.SelAttributes.Color := clPurple;
        PrintText := GetMessage('M40') + ' ' + Card.StudioName; //'Студио:> '
        MainForm.mMsg.Lines.Add(PrintText);
        MainForm.mMsg.SelAttributes.Color := clBlack;
        PrintText := GetMessage('M41') + ' ' + IntToStr(Card.StudioNomer);
        //'Студио №:> '
        MainForm.mMsg.Lines.Add(PrintText);
        MainForm.mMsg.SelAttributes.Color := clBlack;
    end;
    MainForm.mMsg.Lines.Add('-----------------');
    PrintText := 'PIN:> ' + Card.PIN;
    MainForm.mMsg.Lines.Add(PrintText);

    if Card.ErrCounter = 7 then
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

procedure SLE4442ShowCardInPaiment();
var
    q: TABSQuery;
    q2: TABSQuery;
    res: Integer;
begin
    if not ((MainForm.AdvPageControl1.ActivePage = MainForm.AdvTabSheet16) and
        (MainForm.SDELKA.RecordCount > 0)) then
    begin
        q := TABSQuery.Create(MainForm);
        q.Databasename := 'sol1';
        q.ReadOnly := False;
        q.RequestLive := TRUE;
        q.SQL.SetText(PChar('SELECT * FROM kartichip WHERE KLIENTNOMER = ' +
            IntToStr(CardNomer)));
        q.open;
        if q.IsEmpty and (CardNomer > 0) then
        begin
            VipDiscount := 0;
            MainForm.KARTICHIP.Append;
            MainForm.KARTICHIP.FieldValues['KLIENTNOMER'] := CardNomer;
            MainForm.KARTICHIP.FieldValues['COUNTER'] := 0;
            MainForm.KARTICHIP.FieldValues['DISCOUNT'] := 0;
            MainForm.KARTICHIP.FieldValues['SUMA'] := 0;
            MainForm.KARTICHIP.Post;
        end;
        q2 := TABSQuery.Create(MainForm);
        q2.Databasename := 'sol1';
        q2.ReadOnly := False;
        q2.RequestLive := TRUE;
        q2.SQL.SetText(PChar('SELECT * FROM klienti WHERE NOMER = ' +
            IntToStr(CardNomer)));
        q2.open;
        if q2.RecordCount > 0 then
        begin
            MainForm.QKlienti.Active := False;
            MainForm.QKlienti.SQL.Clear;
            MainForm.QKlienti.SQL.Add('SELECT * FROM klienti WHERE NOMER = ' +
                IntToStr(CardNomer));
            MainForm.QKlienti.Active := True;
            ShowKlInfo;
            if not IsChipCard then
            begin
                Card.Balans := MainForm.KARTICHIP.FieldValues['SUMA'];
                Card.ClientNomer := CardNomer;
                Card.CardNomer := CardNomer;
                DiscountPrize := 0;
                VipDiscount := 0;
            end;
            abc3 := (q.FieldValues['COUNTER'] + 1);
            abc4 := MainForm.Internet.FieldValues['DISCOUNT_COUNT'];
            abc2 := q.FieldValues['KLIENTNOMER'];
            abc1 := abc3 mod abc4;
            if abc1 = 0 then
                DiscountPrize :=
                    MainForm.Internet.FieldValues['DISCOUNT_PERCENT'];
            VipDiscount := q.FieldValues['DISCOUNT'];
            if VipDiscount > 0.1 then
                DiscountPrize := 0;

        end
        else if not IsChipCard then
        begin
            res := Application.MessageBox(PChar('Желаете ли да добавите Клиент №' + IntTostr(CardNomer) +
                ' към списъка с клиенти'), PChar('Нов клиент'), MB_YESNO);
            if(res = 6) then
            begin
                Card.Balans := 0;
                MainForm.Table3.Append;
                MainForm.Table3.FieldValues['NOMER'] := CardNomer;
                MainForm.Table3.FieldValues['FIRMA'] := 0;
                MainForm.Table3.FieldValues['IME'] := GetMessage('M66') +
                    IntTostr(CardNomer); //'Нов клиент №'
                MainForm.Table3.Post;
                MainForm.Table3.Last;
                Application.MessageBox(PChar('Клиент №' + IntTostr(CardNomer) +
                    ' беше добавен към списъка'), PChar('Нов клиент'), MB_OK);
                MainForm.QKlienti.Active := False;
                MainForm.QKlienti.Active := True;
                MainForm.Qklienti.Locate('NOMER', CardNomer, []);
                if MainForm.KARTICHIP.RecordCount = 0 then
                    MainForm.KARTICHIP.Append
                else
                    MainForm.KARTICHIP.Edit;
                MainForm.KARTICHIP.FieldValues['DISCOUNT'] := 0;
                MainForm.KARTICHIP.FieldValues['COUNTER'] := -1; // Нов клиент - Нова карта
                MainForm.KARTICHIP.post;
                MainForm.Timer3.enabled := True;
            end;
        end;
        Mainform.BonusLabel.Caption := FloatToStr(DiscountPrize);
        q.Free;
        q2.Free;
    end;
end;

procedure SLE4442Timer3();
var
    dwState: DWORD;
    bATR: Byte;
    cBAtrLen: DWORD;
    Result: string;
    Ostatak, vBalans: Real;
    Result2: Integer;
    _Q: TABSQuery;
begin

    _Q := TABSQuery.Create(nil);
    _Q.Databasename := 'sol1';
    _Q.ReadOnly := False;
    _Q.RequestLive := True;
    if (TimerTime > 4) and (MainForm.Label137.Font.Color = clRed) then
        TimerTime := 0;
    TimerTime := TimerTime + 1;
    if TimerTime = 2 then
    begin
        if hCard = 0 then
            SLE4442Init();
    end;

    //Само ако има връзка с карта
    if hCard <> 0 then
    begin
        // retCode:=SCardState(hCard,@dwState1,@dwActProtocol1,@bATR1,@cBAtrLen1);
        retCode := SCardState(hCard, @dwState, @dwActProtocol1, @bATR1,
            @cBAtrLen1);
        if dwState = 6 {ConnActive} then
        begin
            if not (MainForm.Label137.Font.Color = clGreen) then
            begin
                ConnActive := True;
                IsChipCard := True;
                MainForm.NovKlientButton.Visible := TRUE;

                MainForm.Label137.Caption := GetMessage('M84'); //'Има Карта!';
                MainForm.Label137.Font.Color := clGreen;
                SLE4442ReadCardInfo();
                SLE4442ShowCardInfo();
                if (card.StudioNomer =
                    MainForm.Internet.FieldValues['StudioNomer']) then
                begin
                    MainForm.QKlienti.Active := False;
                    //     MainForm.QKlienti.SQL.SetText(PChar('SELECT * FROM klienti ORDER BY IME'));
                    MainForm.QKlienti.SQL.SetText(PChar('SELECT * FROM klienti WHERE NOMER = ' + IntToStr(Card.ClientNomer)));
                    MainForm.QKlienti.Active := True;
                    if MainForm.Qklienti.Locate('NOMER', Card.ClientNomer, [])
                        then
                    begin
                        ShowKlInfo;
                        if not (card.ClientName =
                            MainForm.Qklienti.FieldValues['ime']) then
                        begin
                            MainForm.Qklienti.Edit;
                            MainForm.Qklienti.FieldValues['ime'] :=
                                card.ClientName;
                            MainForm.Qklienti.Post;
                        end;

                    end;
                end;
                MainForm.Label71.Visible := True;
                MainForm.Label72.Visible := True;
                if (Card.StudioNomer =
                    MainForm.Internet.FieldValues['STUDIONOMER']) and (Card.PIN
                    =
                    MainForm.Internet.FieldValues['PIN']) then
                begin
                    _Q.SQL.SetText(PChar('select * from KARTICHIP where KLIENTNOMER = ' + IntToStr(Card.ClientNomer)));
                    _Q.Open;
                    if _Q.RecordCount > 0 then
                    begin
                        if varType(MainForm.KARTICHIP.FieldValues['DISCOUNT'])
                            <> varNull then

                            VipDiscount :=
                                MainForm.KARTICHIP.FieldValues['DISCOUNT']
                        else
                            VipDiscount := 0;
                    end
                    else if Card.ClientNomer > 0 then
                    begin
                        VipDiscount := 0;
                        _Q.Append;
                        _Q.FieldValues['KLIENTNOMER'] := Card.ClientNomer;
                        _Q.FieldValues['COUNTER'] := 0;
                        _Q.FieldValues['DISCOUNT'] := 0;
                        _Q.FieldValues['SUMA'] := 0;
                        _Q.Post;
                    end;
                end;
                Ostatak := (Card.Balans) /
                    MainForm.SOLARIUMI.FieldValues['CENA'];
                FmtStr(Result, '%4.2f', [Ostatak]);
                MainForm.Label72.Caption := '' + Result + GetMessage('M85');
                //'минути / ';
                FmtStr(Result, '%4.2f', [Card.Balans]);
                MainForm.Label72.Caption := MainForm.Label72.Caption + '' +
                    Result + GetMessage('29'); //'лв.';
            end;
            Exit;
        end
        else
        begin
            MainForm.Label137.Caption := GetMessage('M83'); //'Няма Карта!';
            MainForm.Label137.Font.Color := clRed;
            VipDiscount := 0;
            DiscountPrize := 0;
            if PaidChipCard > 0 then
            begin
                PaidChipCard := 0;
                CalcPaid;
            end;
            if MainForm.Label119.Visible = False then
            begin
                HideKlInfo;
            end;
            MainForm.mMsg.Clear;
            Card.ClientNomer := -1;

            retCode := SCardConnectA(hContext,
                //            PChar('ACS ACR38U 0'),
                Buffer,
                SCARD_SHARE_SHARED,
                SCARD_PROTOCOL_T0 or SCARD_PROTOCOL_T1,
                @hCard,
                @dwActProtocol);
            if retCode <> SCARD_S_SUCCESS then
            begin
                //  DisplayOut(1, retCode, '');
                ConnActive := False;
                IsChipCard := FALSE;
                MainForm.NovKlientButton.Visible := False;
                //       MainForm.NuliraneChipCartaButton.Visible:=False;
                Exit;
            end
            else
            begin
                ConnActive := True;
                IsChipCard := True;
                MainForm.NovKlientButton.Visible := TRUE;
                //     MainForm.NuliraneChipCartaButton.Visible:=TRUE;
            end;
        end;
    end
    else
    begin

    end;
    _Q.Free;
end;

procedure ClearCard();
var
    indx: integer;
begin
    Data := 'ffffff';
    SLE4442ChangePIN();
    for indx := 0 to 80 do
    begin
        SendBuff[indx + 5] := $FF;
        RecvBuff[indx + 5] := $FF;
    end;
    Data := '';
    SLE4442Write($80, $3F); // Запис
    for indx := 0 to 80 do
    begin
        SendBuff[indx + 5] := $FF;
        RecvBuff[indx + 5] := $FF;
    end;
    SLE4442Write($C0, $3F); // Запис

end;

procedure SLE4442Init();
var
    i: integer;
    tmpStr: string;
    indx: integer;
begin
    IsChipCard := false;
    // 1. Establish context and obtain hContext handle
    retCode := SCardEstablishContext(SCARD_SCOPE_USER,
        nil,
        nil,
        @hContext);
    if retCode <> SCARD_S_SUCCESS then
    begin
        DisplayOut(1, retCode, '');
        Exit;
    end;

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
    readerName := string(buffer);

    if ConnActive then
    begin
        DisplayOut(0, 0, 'Connection is already active.');
        Exit;
    end;
    if (not StrUtils.ContainsText(readerName, 'CCID')) and (not StrUtils.ContainsText(readerName, 'OMNIKEY'))then
    begin

        // 1. Direct Connection
        retCode := SCardConnectA(hContext,
            PChar(readerName),
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
        SendBuff[0] := $12; // Card Type for SLE4442
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
    end;
    retCode := SCardConnectA(hContext,
        PChar(readerName),
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
        DisplayOut(0, 0, 'Successful connection to ' + readerName);
    ConnActive := True;
    IsChipCard := True;
    // Get ATR
    GetATR();
    SLE4442Timer3();
    // // 2. Send all inputs to the card
    //  ClearBuffers();
    //  SendBuff[0] := $FF;
    //  SendBuff[1] := $B0;
    //  SendBuff[2] := $00;
    //  SendBuff[3] := (StrToInt('$80'));
    //  SendBuff[4] := (StrToInt('$20'));
    //  SendLen := 5;
    //  RecvLen := SendBuff[4] + 6;
    //  tmpStr := '';
    //  for indx := 0 to SendLen-1 do
    //    tmpStr := tmpStr + Format('%.02X ',[SendBuff[indx]]);
    //  retCode := SendAPDUandDisplay(2, tmpStr);
    //  if retCode <> SCARD_S_SUCCESS then
    //    Exit;
    //
    //  // 3. Display data read from card into Data textbox
    //  tmpStr := '';
    //  for indx := 0 to SendBuff[4]-1 do
    //    tmpStr := tmpStr + chr(RecvBuff[indx]);
    //  DisplayOut(2, 0, tmpStr);

end;

procedure SLE4442Deinit();
var
    i: integer;
begin
    if ConnActive then
    begin
        retCode := SCardDisconnect(hCard, SCARD_UNPOWER_CARD);
        ConnActive := False;
    end;
    retCode := SCardReleaseContext(hCard);
end;

end.

