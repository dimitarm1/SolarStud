unit KlubniKartiFrame;

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
  TKlubniKartiFrame = class(TFrame)
    Image58: TImage;
    LMDLImage13: TLMDLImage;
    LMDLImage63: TLMDLImage;
    LMDLImage62: TLMDLImage;
    LMDLImage18: TLMDLImage;
    LMDLImage17: TLMDLImage;
    LMDLImage16: TLMDLImage;
    LMDLImage15: TLMDLImage;
    LMDLImage14: TLMDLImage;
    LMDLImage12: TLMDLImage;
    KlientLabel_p18: TLabel;
    Label129: TLabel;
    Label94: TLabel;
    Label126: TLabel;
    Label125: TLabel;
    Label169: TLabel;
    wwDBGrid6: TwwDBGrid;
    wwDBGrid7: TwwDBGrid;
    LMDButton5: TLMDButton;
    LMDButton6: TLMDButton;
    LMDButton7: TLMDButton;
    LMDButton8: TLMDButton;
    Edit6: TEdit;
    KartaSearchBox: TEdit;
    ShowAllKlientsCb: TCheckBox;
  protected
    procedure DoPageActivate; override;
    procedure DoPageDeactivate; override;
    procedure DoInitialize; override;
  end;

implementation

uses
  MAIN;

{$R *.dfm}

procedure TKlubniKartiFrame.DoInitialize;
begin
  inherited;
end;

procedure TKlubniKartiFrame.DoPageActivate;
begin
  inherited;
end;

procedure TKlubniKartiFrame.DoPageDeactivate;
begin
  inherited;
end;

end.
