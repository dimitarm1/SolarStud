unit SolariumiInfoFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, Buttons, Mask,
  ComCtrls, jpeg, DB,
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
  TSolariumiInfoFrame = class(TFrame)
    Image15: TImage;
    LMDLImage98: TLMDLImage;
    LMDLImage4: TLMDLImage;
    LMDLImage112: TLMDLImage;
    LMDLImage93: TLMDLImage;
    LMDLImage92: TLMDLImage;
    LMDLImage57: TLMDLImage;
    LMDLImage56: TLMDLImage;
    Image29: TImage;
    Image28: TImage;
    Image18: TImage;
    Label46: TLabel;
    Label116: TLabel;
    Label56: TLabel;
    Label66: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    LMDLImage3: TLMDLImage;
    Label57: TLabel;
    Label63: TLabel;
    Label65: TLabel;
    DBEdit12: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit9: TDBEdit;
  protected
    procedure DoPageActivate; override;
    procedure DoPageDeactivate; override;
    procedure DoInitialize; override;
  end;

implementation

uses
  MAIN;

{$R *.dfm}

procedure TSolariumiInfoFrame.DoInitialize;
begin
  inherited;
end;

procedure TSolariumiInfoFrame.DoPageActivate;
begin
  inherited;
end;

procedure TSolariumiInfoFrame.DoPageDeactivate;
begin
  inherited;
end;

end.
