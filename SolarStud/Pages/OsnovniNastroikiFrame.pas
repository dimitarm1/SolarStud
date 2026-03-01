unit OsnovniNastroikiFrame;

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
  TOsnovniNastroikiFrame = class(TFrame)
    Image51: TImage;
    LMDLImage146: TLMDLImage;
    LMDLImage46: TLMDLImage;
    LMDLImage43: TLMDLImage;
    Label74: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    Label42: TLabel;
    Label95: TLabel;
    LMDLImage44: TLMDLImage;
    Label58: TLabel;
    LMDLImage147: TLMDLImage;
    wwDBEdit6: TwwDBEdit;
    wwDBEdit5: TwwDBEdit;
    wwDBEdit7: TwwDBEdit;
    LMDButton10: TLMDButton;
    LMDButton12: TLMDButton;
    LMDButton13: TLMDButton;
    LMDButton14: TLMDButton;
    LMDButton15: TLMDButton;
    wwDBGrid1: TwwDBGrid;
    DBNavigator1: TDBNavigator;
  protected
    procedure DoPageActivate; override;
    procedure DoPageDeactivate; override;
    procedure DoInitialize; override;
  end;

implementation

uses
  MAIN;

{$R *.dfm}

procedure TOsnovniNastroikiFrame.DoInitialize;
begin
  inherited;
end;

procedure TOsnovniNastroikiFrame.DoPageActivate;
begin
  inherited;
end;

procedure TOsnovniNastroikiFrame.DoPageDeactivate;
begin
  inherited;
end;

end.
