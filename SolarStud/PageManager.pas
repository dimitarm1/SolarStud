unit PageManager;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, BasePageFrame;

type
  TPageInfo = record
    PageIndex: Integer;
    PageName: string;
    FrameClass: TBasePageFrameClass;
    Frame: TBasePageFrame;
    Loaded: Boolean;
  end;
  PPageInfo = ^TPageInfo;

  TPageChangeEvent = procedure(Sender: TObject; OldPageIndex, NewPageIndex: Integer) of object;
  TFrameBindEvent = procedure(AFrame: TFrame) of object;

  TPageManager = class(TObject)
  private
    FContainer: TWinControl;
    FPages: array of TPageInfo;
    FActivePageIndex: Integer;
    FOnPageChange: TPageChangeEvent;
    FOnBeforePageChange: TPageChangeEvent;
    FOnFrameBind: TFrameBindEvent;
    FOnFrameUnbind: TFrameBindEvent;
    function GetActiveFrame: TBasePageFrame;
    function GetPageCount: Integer;
    function GetPageInfo(Index: Integer): PPageInfo;
    function FindPageInfoIndex(APageIndex: Integer): Integer;
  public
    constructor Create(AContainer: TWinControl);
    destructor Destroy; override;

    procedure RegisterPage(APageIndex: Integer; const APageName: string; AFrameClass: TBasePageFrameClass);
    procedure ShowPage(APageIndex: Integer);
    procedure PreloadPage(APageIndex: Integer);
    procedure UnloadPage(APageIndex: Integer);
    procedure UnloadAllPages;
    function IsPageLoaded(APageIndex: Integer): Boolean;
    function GetFrame(APageIndex: Integer): TBasePageFrame;
    function GetFrameByName(const APageName: string): TBasePageFrame;

    property ActivePageIndex: Integer read FActivePageIndex;
    property ActiveFrame: TBasePageFrame read GetActiveFrame;
    property PageCount: Integer read GetPageCount;
    property Pages[Index: Integer]: PPageInfo read GetPageInfo;
    property OnPageChange: TPageChangeEvent read FOnPageChange write FOnPageChange;
    property OnBeforePageChange: TPageChangeEvent read FOnBeforePageChange write FOnBeforePageChange;
    property OnFrameBind: TFrameBindEvent read FOnFrameBind write FOnFrameBind;
    property OnFrameUnbind: TFrameBindEvent read FOnFrameUnbind write FOnFrameUnbind;
  end;

implementation

constructor TPageManager.Create(AContainer: TWinControl);
begin
  inherited Create;
  FContainer := AContainer;
  FActivePageIndex := -1;
  SetLength(FPages, 0);
end;

destructor TPageManager.Destroy;
begin
  UnloadAllPages;
  SetLength(FPages, 0);
  inherited;
end;

function TPageManager.GetActiveFrame: TBasePageFrame;
var
  Idx: Integer;
begin
  Result := nil;
  Idx := FindPageInfoIndex(FActivePageIndex);
  if Idx >= 0 then
    Result := FPages[Idx].Frame;
end;

function TPageManager.GetPageCount: Integer;
begin
  Result := Length(FPages);
end;

function TPageManager.GetPageInfo(Index: Integer): PPageInfo;
begin
  if (Index >= 0) and (Index < Length(FPages)) then
    Result := @FPages[Index]
  else
    Result := nil;
end;

function TPageManager.FindPageInfoIndex(APageIndex: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to High(FPages) do
    if FPages[I].PageIndex = APageIndex then
    begin
      Result := I;
      Break;
    end;
end;

procedure TPageManager.RegisterPage(APageIndex: Integer; const APageName: string; AFrameClass: TBasePageFrameClass);
var
  Idx: Integer;
begin
  // Check if page already registered
  Idx := FindPageInfoIndex(APageIndex);
  if Idx >= 0 then
    raise Exception.CreateFmt('Page with index %d is already registered', [APageIndex]);

  Idx := Length(FPages);
  SetLength(FPages, Idx + 1);
  FPages[Idx].PageIndex := APageIndex;
  FPages[Idx].PageName := APageName;
  FPages[Idx].FrameClass := AFrameClass;
  FPages[Idx].Frame := nil;
  FPages[Idx].Loaded := False;
end;

procedure TPageManager.ShowPage(APageIndex: Integer);
var
  Idx: Integer;
  OldPageIndex: Integer;
  OldFrame: TBasePageFrame;
begin
  Idx := FindPageInfoIndex(APageIndex);
  if Idx < 0 then
    raise Exception.CreateFmt('Page with index %d is not registered', [APageIndex]);

  OldPageIndex := FActivePageIndex;

  // Call before change event
  if Assigned(FOnBeforePageChange) then
    FOnBeforePageChange(Self, OldPageIndex, APageIndex);

  // Deactivate old page
  OldFrame := GetActiveFrame;
  if Assigned(OldFrame) then
  begin
    // Unbind components from MainForm
    if Assigned(FOnFrameUnbind) then
      FOnFrameUnbind(OldFrame);
    OldFrame.PageDeactivate;
    OldFrame.Visible := False;
  end;

  FActivePageIndex := APageIndex;

  // Lazy load frame if not already loaded
  if not FPages[Idx].Loaded then
  begin
    FPages[Idx].Frame := FPages[Idx].FrameClass.Create(FContainer);
    FPages[Idx].Frame.Parent := FContainer;
    FPages[Idx].Frame.Align := alClient;
    FPages[Idx].Frame.PageIndex := APageIndex;
    FPages[Idx].Frame.Name := 'PageFrame_' + IntToStr(APageIndex);
    FPages[Idx].Loaded := True;
  end;

  // Bind components to MainForm
  if Assigned(FOnFrameBind) then
    FOnFrameBind(FPages[Idx].Frame);

  FPages[Idx].Frame.Visible := True;
  FPages[Idx].Frame.BringToFront;
  FPages[Idx].Frame.PageActivate;

  // Call after change event
  if Assigned(FOnPageChange) then
    FOnPageChange(Self, OldPageIndex, APageIndex);
end;

procedure TPageManager.PreloadPage(APageIndex: Integer);
var
  Idx: Integer;
begin
  Idx := FindPageInfoIndex(APageIndex);
  if Idx < 0 then
    raise Exception.CreateFmt('Page with index %d is not registered', [APageIndex]);

  if not FPages[Idx].Loaded then
  begin
    FPages[Idx].Frame := FPages[Idx].FrameClass.Create(FContainer);
    FPages[Idx].Frame.Parent := FContainer;
    FPages[Idx].Frame.Align := alClient;
    FPages[Idx].Frame.PageIndex := APageIndex;
    FPages[Idx].Frame.Name := 'PageFrame_' + IntToStr(APageIndex);
    FPages[Idx].Frame.Visible := False;
    FPages[Idx].Loaded := True;
  end;
end;

procedure TPageManager.UnloadPage(APageIndex: Integer);
var
  Idx: Integer;
begin
  Idx := FindPageInfoIndex(APageIndex);
  if Idx < 0 then
    Exit;

  if FPages[Idx].Loaded then
  begin
    if FActivePageIndex = APageIndex then
    begin
      // Unbind before destroying
      if Assigned(FOnFrameUnbind) then
        FOnFrameUnbind(FPages[Idx].Frame);
      FPages[Idx].Frame.PageDeactivate;
      FActivePageIndex := -1;
    end;
    FreeAndNil(FPages[Idx].Frame);
    FPages[Idx].Loaded := False;
  end;
end;

procedure TPageManager.UnloadAllPages;
var
  I: Integer;
begin
  for I := 0 to High(FPages) do
    if FPages[I].Loaded then
    begin
      if FPages[I].PageIndex = FActivePageIndex then
        if Assigned(FOnFrameUnbind) then
          FOnFrameUnbind(FPages[I].Frame);
      FreeAndNil(FPages[I].Frame);
      FPages[I].Loaded := False;
    end;
  FActivePageIndex := -1;
end;

function TPageManager.IsPageLoaded(APageIndex: Integer): Boolean;
var
  Idx: Integer;
begin
  Result := False;
  Idx := FindPageInfoIndex(APageIndex);
  if Idx >= 0 then
    Result := FPages[Idx].Loaded;
end;

function TPageManager.GetFrame(APageIndex: Integer): TBasePageFrame;
var
  Idx: Integer;
begin
  Result := nil;
  Idx := FindPageInfoIndex(APageIndex);
  if (Idx >= 0) and FPages[Idx].Loaded then
    Result := FPages[Idx].Frame;
end;

function TPageManager.GetFrameByName(const APageName: string): TBasePageFrame;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to High(FPages) do
    if SameText(FPages[I].PageName, APageName) and FPages[I].Loaded then
    begin
      Result := FPages[I].Frame;
      Break;
    end;
end;

end.
