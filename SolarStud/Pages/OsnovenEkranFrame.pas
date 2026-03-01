unit OsnovenEkranFrame;

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
  TOsnovenEkranFrame = class(TFrame)
    Image2: TImage;
    Imagepress2: TLMDLImage;
    ImagePress1: TLMDLImage;
    Imagepress6: TLMDLImage;
    Imagepress3: TLMDLImage;
    Imagepress5: TLMDLImage;
    Imagepress4: TLMDLImage;
    Image128: TImage;
    Image69: TLMDLImage;
    Image64: TLMDLImage;
    Image67: TLMDLImage;
    Image68: TLMDLImage;
    Image21: TLMDLImage;
    Kabina42: TLabel;
    Kabina41: TLabel;
    Kabina51: TLabel;
    Kabina52: TLabel;
    Kabina61: TLabel;
    Kabina62: TLabel;
    Kabina11: TLabel;
    Kabina31: TLabel;
    Kabina1minuti: TLabel;
    Kabina1cena: TLabel;
    Kabina2minuti: TLabel;
    Kabina2cena: TLabel;
    Kabina3minuti: TLabel;
    Kabina3cena: TLabel;
    Kabina21: TLabel;
    Kabina12: TLabel;
    Kabina22: TLabel;
    Kabina32: TLabel;
    Imagesol6: TImage;
    Imagesol5: TImage;
    Imagesol4: TImage;
    Imagesol3: TImage;
    Imagesol2: TImage;
    Imagesol1: TImage;
    Kabina6cena: TLabel;
    Kabina6minuti: TLabel;
    Kabina5minuti: TLabel;
    Kabina5cena: TLabel;
    Kabina4minuti: TLabel;
    Kabina4cena: TLabel;
    Label110: TLabel;
    Label92: TLabel;
    Label91: TLabel;
    Label144: TLabel;
    Label143: TLabel;
    StatusShape1: TShape;
    StatusShape2: TShape;
    StatusShape3: TShape;
    StatusShape4: TShape;
    StatusShape5: TShape;
    StatusShape6: TShape;
    Imagepress7: TLMDLImage;
    Kabina71: TLabel;
    Kabina72: TLabel;
    Kabina7minuti: TLabel;
    Kabina7cena: TLabel;
    Imagepress8: TLMDLImage;
    Kabina81: TLabel;
    Kabina82: TLabel;
    Imagesol8: TImage;
    StatusShape8: TShape;
    Kabina8minuti: TLabel;
    Kabina8cena: TLabel;
    Imagesol7: TImage;
    StatusShape7: TShape;
    Edit5: TEdit;
    Bclose: TButton;
    BHelp: TButton;
    BMinimize: TButton;
  protected
    procedure DoPageActivate; override;
    procedure DoPageDeactivate; override;
    procedure DoInitialize; override;
  end;

implementation

uses
  MAIN;

{$R *.dfm}

procedure TOsnovenEkranFrame.DoInitialize;
begin
  inherited;
end;

procedure TOsnovenEkranFrame.DoPageActivate;
begin
  inherited;
end;

procedure TOsnovenEkranFrame.DoPageDeactivate;
begin
  inherited;
end;

end.
