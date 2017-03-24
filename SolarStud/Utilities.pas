Unit Utilities;

interface

Uses Types, Classes, Windows, Graphics, SysUtils, Registry, Math;

{$Z4}

type
  TRlevAccuracy         = (raMinimum,raFromCsq,raFromMoni);
  TStringListExSortType = (srtAlpha,srtInteger,srtDouble);
  TDelimiters           = set of Char;

const

  taLeft      = taLeftJustify;
  taRight     = taRightJustify;

  NOVALUE     = -1;
  SKIPVALUE   = -2;

  CRLF          = #13#10;
  TAB           = #9;

  clLightYellow : TColor = $00D0FFFF;
  clLightRed    : TColor = $00D0D0FF;
  clLightGreen  : TColor = $00D0FFD0;
  clLightBlue   : TColor = $00FFD0D0;

  {checks if a string contains a numeric}
  function IsNumeric(const s: string): boolean;

  {checks if a interger is within a given interval}
  function IsIn(const Value,LowBorder,HighBorder: integer): boolean;

  {returns the version of the executable}
  function FindExeVersion: string;

  {returns the OS string}
  function FindBSVersion : string;

  {returns the date og linkage of the executable as a UNIX timestamp}
  function GetImageLinkTimeStamp: DWORD;

  {gives a list of all available comports or seraches for a comport}
  function GetAvailableComPorts(const Search: string): string;

  {removes all occurences of 'what' from string 'from'}
  function RemoveChr(const from,what:string): string;

  {converts RX_LEV [0..63] to the corresponding dBm value and creates a text}
  function RxLevToText(const RxLev: integer): string;

  {converts RX_LEV to the corresponding dBm value}
  function RxLevToDbm(const RxLev : integer): integer;

  {converts RX_QUAL [0..7] to the corresponding BER value}
  function RxQualToText(const RxQual: integer): string;

  {converts POWERLEV to the corresponding dBm and power value}
  function DbmToWatt(const pl:integer):string;
  function PowerLevToDbm(const PwrLev: string; AddText,Gsm900:boolean) : string;

  {calculates Feldstärkepegel in dBuV/m from Leistungspegel in dBm}
  function lp2le(const lp: integer; freq: extended):extended;

  {calculates Feldstärke in uV/m from Feldstärkepegel in dBuV/m}
  function le2e(const le: extended):extended;

  {calculates Flussdichte in W/m2 from Feldstärke in uV/m}
  function e2s(const e: extended):extended;

  {sorts a stringlist acc. to the parameter SortType}
  procedure SortStringList(SL:TStringList; const FromRow,ToRow : integer; SortType : TStringListExSortType = srtAlpha);

  {executes command, waits for TimeOut, returns the output in Output and returns a error value}
  function CallAndWaitWithStdOut(const Command: string; const TimeOut: integer; var Output: string): integer;

  {breaks a string up in substrings, according to the settings}
  function SortOutSubstrings(const From: string; var Values: array of string;
                             const Delim: TDelimiters = [' ',';'];
                             const ConcatDelim: boolean = true): integer;


implementation

function IsNumeric(const s: string): boolean;
begin
  if (StrToIntDef(s,MAXINT) = MAXINT) and (StrToIntDef(s,0) = 0)
    then Result := false
    else Result := true; 
end;

function FindExeVersion : string;
var
  VHandle : cardinal;
  VSize   : cardinal;
  VBuffer : string;
  TmpStr  : string;
begin
  TmpStr := '';
//  VSize := GetFileVersionInfoSize(PChar(Application.ExeName),VHandle);
  VSize := GetFileVersionInfoSize(PChar(ParamStr(0)),VHandle);
  if VSize > 0 then
    begin
    SetLength(VBuffer, VSize);
    GetFileVersionInfo(PChar(ParamStr(0)),VHandle,VSize,PChar(VBuffer));
    if VerQueryValue(PChar(VBuffer),PChar('\StringFileInfo\040904E4\FileVersion'),Pointer(TmpStr),VSize)
    or VerQueryValue(PChar(VBuffer),PChar('\StringFileInfo\040704E4\FileVersion'),Pointer(TmpStr),VSize)
      then Result := StrPas(PChar(TmpStr))
      else Result := 'not available';
    end
  else
    Result := 'not available';
end;

function FindBSVersion : string;
begin
case Win32Platform of
     VER_PLATFORM_WIN32s        : Result := 'W3.1';
     VER_PLATFORM_WIN32_WINDOWS : case Win32MajorVersion of
                                       4 :  case Win32MinorVersion of
                                                 0  : Result := 'W95';
                                                 10 : Result := 'W98';
                                                 else Result := 'W32/W';
                                            end;
                                       5 :  Result := 'WME';
                                       else Result := 'W32/W';
                                  end;
     VER_PLATFORM_WIN32_NT      : case Win32MajorVersion of
                                       3  : Result := 'WNT3';
                                       4  : Result := 'WNT4';
                                       5  : Result := 'W2K';
                                       else Result := 'W32/NT';
                                  end;
end;
Result := Result + ' ' + IntToStr(Win32MajorVersion) + '/' + IntToStr(Win32MinorVersion)+ ' B' + IntToStr(Win32BuildNumber);
end;

function GetImageLinkTimeStamp: DWORD;
const
  INVALID_SET_FILE_POINTER = DWORD(-1);
  BorlandMagicTimeStamp = $2A425E19;  // Delphi 4-6 (and above?)
  FileTime1970: TFileTime = (dwLowDateTime:$D53E8000; dwHighDateTime:$019DB1DE);
type
  PImageSectionHeaders = ^TImageSectionHeaders;
  TImageSectionHeaders = array [Word] of TImageSectionHeader;
  PImageResourceDirectory = ^TImageResourceDirectory;
  TImageResourceDirectory = packed record
    Characteristics: DWORD;
    TimeDateStamp: DWORD;
    MajorVersion: Word;
    MinorVersion: Word;
    NumberOfNamedEntries: Word;
    NumberOfIdEntries: Word;
  end;
var
  FileHandle: THandle;
  BytesRead: DWORD;
  ImageDosHeader: TImageDosHeader;
  ImageNtHeaders: TImageNtHeaders;
  SectionHeaders: PImageSectionHeaders;
  Section: Word;
  ResDirRVA: DWORD;
  ResDirSize: DWORD;
  ResDirRaw: DWORD;
  ResDirTable: TImageResourceDirectory;
  FileTime: TFileTime;
begin
  Result := 0;
  FileHandle := CreateFile(PChar(ParamStr(0)), GENERIC_READ,
                           FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
  if (FileHandle <> INVALID_HANDLE_VALUE) then
  try
    // Read MS-DOS header to get the offset of the PE32 header
    // (not required on WinNT based systems - but mostly available)
    if not ReadFile(FileHandle, ImageDosHeader, SizeOf(TImageDosHeader), BytesRead, nil) or
           (BytesRead <> SizeOf(TImageDosHeader)) or
           (ImageDosHeader.e_magic <> IMAGE_DOS_SIGNATURE)
      then ImageDosHeader._lfanew := 0;
    // Read PE32 header (including optional header
    if (SetFilePointer(FileHandle, ImageDosHeader._lfanew, nil, FILE_BEGIN) = INVALID_SET_FILE_POINTER)
      then Exit;
    if not(ReadFile(FileHandle, ImageNtHeaders, SizeOf(TImageNtHeaders), BytesRead, nil) and
          (BytesRead = SizeOf(TImageNtHeaders))) then Exit;
    // Validate PE32 image header
    if (ImageNtHeaders.Signature <> IMAGE_NT_SIGNATURE) then Exit;
    // Seconds since 1970 (UTC)
    Result := ImageNtHeaders.FileHeader.TimeDateStamp;
    // Check for Borland's magic value for the link time stamp
    // (we take the time stamp from the resource directory table)
    if (ImageNtHeaders.FileHeader.TimeDateStamp = BorlandMagicTimeStamp) then
      with ImageNtHeaders, FileHeader, OptionalHeader do
        begin
        // Validate Optional header
        if (SizeOfOptionalHeader < IMAGE_SIZEOF_NT_OPTIONAL_HEADER) or
           (Magic <> IMAGE_NT_OPTIONAL_HDR_MAGIC) then Exit;
        // Read section headers
        SectionHeaders := GetMemory(NumberOfSections * SizeOf(TImageSectionHeader));
        if Assigned(SectionHeaders) then
          try
            if (SetFilePointer(FileHandle, SizeOfOptionalHeader - IMAGE_SIZEOF_NT_OPTIONAL_HEADER,
                nil, FILE_CURRENT) = INVALID_SET_FILE_POINTER)
              then Exit;
            if not(ReadFile(FileHandle, SectionHeaders^, NumberOfSections * SizeOf(TImageSectionHeader), BytesRead, nil) and
                  (BytesRead = NumberOfSections * SizeOf(TImageSectionHeader)))
              then Exit;
            // Get RVA and size of the resource directory
            ResDirRVA := DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress;
            ResDirSize := DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].Size;
            // Search for section which contains the resource directory
            ResDirRaw := 0;
            for Section := 0 to NumberOfSections - 1 do
              with SectionHeaders[Section] do
                if (VirtualAddress <= ResDirRVA) and
                   (VirtualAddress + SizeOfRawData >= ResDirRVA + ResDirSize) then
                begin
                  ResDirRaw := PointerToRawData - (VirtualAddress - ResDirRVA);
                  Break;
                end;
            // Resource directory table found?
            if (ResDirRaw = 0) then Exit;
            // Read resource directory table
            if (SetFilePointer(FileHandle, ResDirRaw, nil, FILE_BEGIN) = INVALID_SET_FILE_POINTER)
              then Exit;
            if not(ReadFile(FileHandle, ResDirTable, SizeOf(TImageResourceDirectory), BytesRead, nil) and
                  (BytesRead = SizeOf(TImageResourceDirectory)))
              then Exit;
            // Convert from DosDateTime to SecondsSince1970
            if DosDateTimeToFileTime(HiWord(ResDirTable.TimeDateStamp),
                                     LoWord(ResDirTable.TimeDateStamp), FileTime)
              then Result := (ULARGE_INTEGER(FileTime).QuadPart - ULARGE_INTEGER(FileTime1970).QuadPart) div 10000000;
              // FIXME: Borland's linker uses the local system time
              // of the user who linked the executable image file.
              // (is that information anywhere?)
          finally
            FreeMemory(SectionHeaders);
          end;
        end;
  finally
    CloseHandle(FileHandle);
  end;
end;

function GetAvailableComPorts(const Search: string): string;
var
  Registry : TRegistry;
  i        : integer;
  s, t, u  : string;
  ComPorts : TStringlist;
begin
  Registry := TRegistry.Create;
  ComPorts := TStringList.Create;
  Registry.RootKey := HKEY_LOCAL_MACHINE;
  if Registry.OpenKey('hardware\devicemap\SerialComm',false) then
    begin
    Registry.GetValueNames(ComPorts);
    if ComPorts.Count > 0 then
      begin
      for i := 0 to ComPorts.Count - 1 do
        begin
        t := Registry.ReadString(ComPorts[i]);
        s := s + t + ',';
        if t = Search then u := ComPorts[i];
        end;
      Delete(s,Length(s),1);
      end;
    end;
  if Search = '' then Result := s else Result := u;
  ComPorts.Free;
  Registry.Free;
end;

function RemoveChr(const from,what:string): string;
begin
  Result := StringReplace(from,what,'',[rfReplaceAll]);
end;

function RxLevToText(const RxLev: integer): string;
begin
  case RxLev of
    0     : Result := '<= -110 dBm';
    1..62 : Result := IntToStr(-110 + RxLev) + ' dBm';
    63    : Result := '>= -47 dBm';
    else    Result := 'unknown';
  end;
end;

function RxLevToDbm(const RxLev: integer): integer;
begin
  case RxLev of
        0 : Result := -110;
    1..62 : Result := -110 + RxLev;
       63 : Result := -47;
    else    Result := 0;
    end;
end;

function RxQualToText(const RxQual: integer): string;
const
  RxqLevels: array[0..7] of string = ('0.14%','0.28%','0.57%','1.13%','2.26%','4.53%','9.05%','18.10%');
begin
  if RxQual in [0..7]
    then Result := IntToStr(RxQual) + ' (' + RxqLevels[RxQual] + ')'
    else Result := '-';
end;

function DbmToWatt(const pl:integer):string;
var
p  : real;
pu : string;
begin
p := power(10,(pl*0.1))*0.001;
if p < 1 then pu := floattostr(int(p*1000))+' mW'
         else pu := format('%f',[p])+' W';
result := inttostr(pl)+' dBm ('+pu+')';
end;

function PowerLevToDbm(const PwrLev: string; AddText,Gsm900:boolean):string;
var
pl,bpl : integer;
begin
  if Gsm900 then bpl:=43 else bpl:=30;
  pl := bpl - StrToIntDef(PwrLev,0)*2;
  if AddText
    then Result := DbmToWatt(pl)
    else Result := IntToStr(pl);
end;

function lp2le(const lp: integer; freq: extended):extended;
begin
if (lp <> 0) and (freq <> 0) then result := lp + 77.216 + 20 * log10(freq)
           else result := 0;
end;

function le2e(const le: extended):extended;
begin
result := power(10,le/20);
end;

function e2s(const e: extended):extended;
begin
result := (power(e/1000000,2)/376.73) * 1000000000000;
end;

function IsIn(const Value,LowBorder,HighBorder: integer): boolean;
begin
  if (Value < LowBorder) or (Value > HighBorder) then Result := false else Result := true;
end;

procedure SortStringList(SL: TStringList; const FromRow,ToRow: integer; SortType: TStringListExSortType = srtAlpha);

  function SortStr(Line : string) : string;
  var RetVar : string;
  begin
  case SortType of
       srtAlpha   : Retvar := Line;
       srtInteger : Retvar := FormatFloat('000000000',StrToIntDef(Trim(Line),0));
       srtDouble  : try
                      Retvar := FormatFloat('000000000.000000',StrToFloat(Trim(Line)));
                    except
                      RetVar  := '0.00';
                    end;
       end;
  Result := RetVar;
  end;

  procedure QuickSort(const Lo, Hi:integer);

    procedure Sort(const l,r: integer);
    var  i,j : integer;
         x   : string;
    begin
    i := l;
    j := r;
    x := SortStr(SL[(l+r) DIV 2]);
    repeat
          while SortStr(SL[i]) < x do inc(i);
          while x < SortStr(SL[j]) do dec(j);
          if i <= j then
             begin
             SL.Exchange(j,i);
             inc(i);
             dec(j);
             end;
    until i > j;
    if l < j then Sort(l,j);
    if i < r then Sort(i,r);
    end;

  begin
  Sort(Lo,Hi);
  end;

begin
QuickSort(FromRow,ToRow);
end;

function CallAndWaitWithStdOut(const Command: string; const TimeOut: integer; var Output: string): integer;
const
  BufSize = 4096;
var
  StartupInfo        : TStartupInfo;
  ProcessInformation : TProcessInformation;
  SecurityAttributes : TSecurityAttributes;
  CreateOK           : boolean;
  WaitResult         : integer;
  CommandLine        : PChar;
  ReadHandle,
  WriteHandle        : THandle;
  ReadBuf            : array[0..1024] of Char;
  ExitCode           : cardinal;
  BytesRead          : cardinal;

begin
  Output := '';
  try
    FillChar(StartupInfo,SizeOf(TStartupInfo),#0);
    FillChar(ReadBuf,SizeOf(ReadBuf),#0);
    FillChar(ProcessInformation,SizeOf(TProcessInformation),#0);
    FillChar(SecurityAttributes,SizeOf(TSecurityAttributes),#0);

    SecurityAttributes.nLength        := SizeOf(TSecurityAttributes);
    SecurityAttributes.bInheritHandle := true;

    if CreatePipe(ReadHandle, WriteHandle, @SecurityAttributes, 0) then
      begin
      SetHandleInformation(ReadHandle, HANDLE_FLAG_INHERIT, 0);
      StartupInfo.cb          := SizeOf(TStartupInfo);
      StartupInfo.dwFlags     := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      StartupInfo.wShowWindow := SW_HIDE;
      StartupInfo.hStdOutput  := WriteHandle;
      StartupInfo.hStdError   := WriteHandle;

      CommandLine := PChar(Command);
      CreateOK := CreateProcess(nil, CommandLine, nil, nil, true,
                                NORMAL_PRIORITY_CLASS,
                                nil, nil, StartupInfo, ProcessInformation);
      if CreateOK then
        begin
        WaitResult := WaitForSingleObject(ProcessInformation.hProcess, TimeOut);
        case WaitResult of
          WAIT_OBJECT_0,
          WAIT_TIMEOUT  : begin
                          CloseHandle(WriteHandle);
                          ReadFile(ReadHandle, ReadBuf, SizeOf(ReadBuf), BytesRead, nil);
                          Result := WaitResult;
                          Output := string(ReadBuf);
                          end;
          else Result := GetLastError;
          end;

        GetExitCodeProcess(ProcessInformation.hProcess,ExitCode);
        if ExitCode = STILL_ACTIVE then
          TerminateProcess(ProcessInformation.hProcess,ExitCode);
        end
      else
        Result := GetLastError;
      end
    else
      Result := GetLastError;
  finally
    CloseHandle(ReadHandle);
    CloseHandle(ProcessInformation.hProcess);
    CloseHandle(ProcessInformation.hThread);
  end;
end;

function SortOutSubstrings(const From: string; var Values: array of string;
                           const Delim: TDelimiters = [' ',';'];
                           const ConcatDelim: boolean = true): integer;
var
  i,Start,Len,TheEnd : integer;
  LastCharWasSep     : boolean;
  ValPtr             : integer;
begin
  i      := 1;
  ValPtr := Low(Values);
  TheEnd := Length(From);
  Start  := 0;
  Len    := 0;
  LastCharWasSep := ConcatDelim;
  Values[ValPtr] := '';

  while i <= TheEnd do
    begin
    if not (From[i] in Delim) then
      begin
      Inc(Len);
      LastCharWasSep := false;
      end
    else
      begin
      if not LastCharWasSep then
        begin
        SetString(Values[ValPtr],PChar(From) + Start,Len);
        Inc(ValPtr);
        if ValPtr > High(Values) then Break;
        Values[ValPtr] := '';
        end;
      if ConcatDelim then LastCharWasSep := true;
      Start := i;
      Len := 0;
      end;
    Inc(i);
    end;

  if (ValPtr <= High(Values)) and (Len > 0) then
    begin
    SetString(Values[ValPtr],PChar(From) + Start,Len);
    Inc(ValPtr);
    end;

  for i := ValPtr to High(Values) do Values[i] := '';
  Result := ValPtr - Low(Values);
end;

{
procedure SortData(Data: array of ...);

  function SortStr(Line : string) : string;
  begin
    Result := Data.;
  end;

  procedure QuickSort(const Lo, Hi:integer);

    procedure Sort(const l,r: integer);
    var  i,j : integer;
         x   : string;
         d   : ...;
    begin
    i := l;
    j := r;
    x := SortStr(SL[(l+r) DIV 2]);
    repeat
          while SortStr(SL[i]) < x do inc(i);
          while x < SortStr(SL[j]) do dec(j);
          if i <= j then
             begin
             d := Data[j];
             Data[j] := Data[i];
             Data[i] := d;
             inc(i);
             dec(j);
             end;
    until i > j;
    if l < j then Sort(l,j);
    if i < r then Sort(i,r);
    end;

  begin
  Sort(Lo,Hi);
  end;

begin
QuickSort(Low(Data),High(Data));
end;


}
end.
