unit NachalnoUstanoviavaneFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, Buttons, Mask,
  ComCtrls, jpeg, DB, Gauges,
  // LMD components
  LMDControl, LMDBaseControl, LMDBaseGraphicControl, LMDGraphicControl,
  LMDCustomLImage, LMDLImage, LMDBaseImage, LMDCustomNImage, LMDNImage,
  LMDLEDCustomLabel, LMDLEDLabel, LMDCustomButton, LMDButton,
  LMDBaseLabel, LMDCustomSimpleLabel, LMDSimpleLabel,
  LMDBaseGraphicButton, LMDCustomShapeButton, LMDShapeButton,
  LMDCustomCheckBox, LMDDBCheckBox, LMDCheckBox,
  LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit, LMDDBMaskEdit, LMDDBEdit,
  LMDCustomMemo, LMDMemo,
  LMDCustomImageList, LMDImageList,
  // Woll2Woll components
  Wwdbgrid, wwdbedit, wwdblook, Wwdbcomb, wwradiogroup, wwcheckbox, Wwdotdot, wwclearpanel,
  // TMS components
  AdvCombo, AdvEdit, AdvPageControl, AdvToolBtn, AdvEdBtn, AdvDBLookupComboBox,
  // Raize components  
  RzButton, RzRadChk, RzDBDTP, RzDBCmbo, RzLabel, RzEdit, RzDBEdit,
  RzBorder, RzStatus, RzBmpBtn, RzCmboBx,
  // Planner components
  Planner, DBPlanner, PlannerDatePicker, PlanSimpleEdit, PlanItemEdit, PlannerMaskDatePicker,
  // Chart components
  Chart, TeEngine, TeeProcs, Series, DBChart,
  // Base frame
  BasePageFrame;

type
  TNachalnoUstanoviavaneFrame = class(TFrame)
    Image19: TImage;
    LMDLImage126: TLMDLImage;
    LMDLImage124: TLMDLImage;
    LMDLImage134: TLMDLImage;
    LMDLImage136: TLMDLImage;
    LMDLImage138: TLMDLImage;
    LMDLImage137: TLMDLImage;
    LMDLImage135: TLMDLImage;
    LMDLImage133: TLMDLImage;
    LMDLImage123: TLMDLImage;
    LMDLImage130: TLMDLImage;
    LMDLImage129: TLMDLImage;
    LMDLImage125: TLMDLImage;
    LMDLImage122: TLMDLImage;
    Label80: TLabel;
    Label79: TLabel;
    Label78: TLabel;
    Label77: TLabel;
    Label76: TLabel;
    Label75: TLabel;
    Image39: TImage;
    Image38: TImage;
    Image37: TImage;
    Image36: TImage;
    Image35: TImage;
    Image34: TImage;
    Gauge1: TGauge;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    No5: TLabel;
    No6: TLabel;
    No7: TLabel;
    No1: TLabel;
    No2: TLabel;
    LMDLImage132: TLMDLImage;
    Image9: TImage;
    Label172: TLabel;
    No3: TLabel;
    No4: TLabel;
    LMDLImage148: TLMDLImage;
    Label173: TLabel;
    LMDLImage149: TLMDLImage;
    Image13: TImage;
    Label174: TLabel;
    No8: TLabel;
    LMDLImage151: TLMDLImage;
    Label176: TLabel;
  protected
    procedure DoPageActivate; override;
    procedure DoPageDeactivate; override;
    procedure DoInitialize; override;
  end;

implementation

uses
  MAIN;

{$R *.dfm}

procedure TNachalnoUstanoviavaneFrame.DoInitialize;
begin
  inherited;
end;

procedure TNachalnoUstanoviavaneFrame.DoPageActivate;
begin
  inherited;
end;

procedure TNachalnoUstanoviavaneFrame.DoPageDeactivate;
begin
  inherited;
end;

end.
