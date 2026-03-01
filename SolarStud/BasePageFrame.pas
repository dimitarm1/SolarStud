unit BasePageFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms;

type
  TBasePageFrame = class(TFrame)
  private
    FOnPageActivate: TNotifyEvent;
    FOnPageDeactivate: TNotifyEvent;
    FPageIndex: Integer;
    FInitialized: Boolean;
  protected
    procedure DoPageActivate; virtual;
    procedure DoPageDeactivate; virtual;
    procedure DoInitialize; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure PageActivate;
    procedure PageDeactivate;
    procedure Initialize;
    property PageIndex: Integer read FPageIndex write FPageIndex;
    property Initialized: Boolean read FInitialized;
    property OnPageActivate: TNotifyEvent read FOnPageActivate write FOnPageActivate;
    property OnPageDeactivate: TNotifyEvent read FOnPageDeactivate write FOnPageDeactivate;
  end;

  TBasePageFrameClass = class of TBasePageFrame;

implementation

constructor TBasePageFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInitialized := False;
  FPageIndex := -1;
end;

procedure TBasePageFrame.DoPageActivate;
begin
  if Assigned(FOnPageActivate) then
    FOnPageActivate(Self);
end;

procedure TBasePageFrame.DoPageDeactivate;
begin
  if Assigned(FOnPageDeactivate) then
    FOnPageDeactivate(Self);
end;

procedure TBasePageFrame.DoInitialize;
begin
  // Override in descendants to perform one-time initialization
end;

procedure TBasePageFrame.PageActivate;
begin
  if not FInitialized then
    Initialize;
  DoPageActivate;
end;

procedure TBasePageFrame.PageDeactivate;
begin
  DoPageDeactivate;
end;

procedure TBasePageFrame.Initialize;
begin
  if not FInitialized then
  begin
    DoInitialize;
    FInitialized := True;
  end;
end;

end.
