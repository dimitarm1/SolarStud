unit FirmiISluziteliFrame;

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
  TFirmiISluziteliFrame = class(TFrame)
    NulImage: TImage;
    Image6: TImage;
    Label160: TLabel;
    LMDLImage141: TLMDLImage;
    LMDLImage142: TLMDLImage;
    LMDLImage143: TLMDLImage;
    LMDLImage144: TLMDLImage;
    LMDLImage145: TLMDLImage;
    Label161: TLabel;
    LMDLImage22: TLMDLImage;
    Label163: TLabel;
    Label162: TLabel;
    wwDBGrid12: TwwDBGrid;
    DBNavigator2: TDBNavigator;
    wwDBGrid13: TwwDBGrid;
    LMDButton1: TLMDButton;
    LMDButton2: TLMDButton;
  protected
    procedure DoPageActivate; override;
    procedure DoPageDeactivate; override;
    procedure DoInitialize; override;
  end;

implementation

uses
  MAIN;

{$R *.dfm}

procedure TFirmiISluziteliFrame.DoInitialize;
begin
  inherited;
end;

procedure TFirmiISluziteliFrame.DoPageActivate;
begin
  inherited;
end;

procedure TFirmiISluziteliFrame.DoPageDeactivate;
begin
  inherited;
end;

end.
