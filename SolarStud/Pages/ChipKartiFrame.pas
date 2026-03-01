unit ChipKartiFrame;

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
  TChipKartiFrame = class(TFrame)
    Image12: TImage;
    LMDLImage10: TLMDLImage;
    LMDLImage61: TLMDLImage;
    LMDLImage60: TLMDLImage;
    LMDLImage8: TLMDLImage;
    LMDLImage5: TLMDLImage;
    LMDLImage6: TLMDLImage;
    LMDLImage7: TLMDLImage;
    LMDLImage9: TLMDLImage;
    Label137: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Label136: TLabel;
    Label139: TLabel;
    LMDLImage11: TLMDLImage;
    Label138: TLabel;
    Label145: TLabel;
    Label159: TLabel;
    Label89: TLabel;
    Label112: TLabel;
    Label157: TLabel;
    Label128: TLabel;
    Label171: TLabel;
    wwDBGrid5: TwwDBGrid;
    Edit10: TEdit;
    mMsg: TRichEdit;
    PosEdit: TLMDDBEdit;
    SumaEdit: TLMDDBEdit;
    PercentEdit: TLMDDBEdit;
    NuliraneChipCartaButton: TLMDButton;
    RangCombo: TwwDBComboBox;
    FirmaCombo: TRzDBLookupComboBox;
    LMDButton3: TLMDButton;
    ValidnostDate: TRzDBDateTimeEdit;
    OncePerDayBox: TLMDDBCheckBox;
    Button111: TRzButton;
    ValidnostTime: TRzDBDateTimeEdit;
    NovKlientButton: TLMDButton;
  protected
    procedure DoPageActivate; override;
    procedure DoPageDeactivate; override;
    procedure DoInitialize; override;
  end;

implementation

uses
  MAIN;

{$R *.dfm}

procedure TChipKartiFrame.DoInitialize;
begin
  inherited;
end;

procedure TChipKartiFrame.DoPageActivate;
begin
  inherited;
end;

procedure TChipKartiFrame.DoPageDeactivate;
begin
  inherited;
end;

end.
