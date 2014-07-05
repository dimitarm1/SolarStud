unit MainForm2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDCustomParentPanel, LMDCustomPanelFill, LMDPanelShape, jpeg, ExtCtrls,
  StdCtrls, setformdata, OleCtrls,  
  LMDControl, LMDBaseControl, LMDBaseGraphicControl, LMDGraphicControl,
  LMDBaseImage, LMDCustomLImage, LMDLImage, LMDCustomComponent,
  LMDBaseController, LMDCustomContainer, LMDCustomImageList, LMDImageList,
  ImgList;

type
  TMain2 = class(TForm)
    Image2          : TImage;
    Imagesol1    : TImage;
    Imagesol2    : TImage;
    Imagesol3    : TImage;
    Kabina1minuti: TLabel;
    Kabina1cena  : TLabel;
    Kabina2minuti: TLabel;
    Kabina2cena  : TLabel;
    Kabina4minuti: TLabel;
    Kabina4cena  : TLabel;
    Kabina5minuti: TLabel;
    Kabina5cena  : TLabel;
    Kabina6minuti: TLabel;
    Kabina6cena  : TLabel;
    Kabina3minuti: TLabel;
    Kabina3cena  : TLabel;
    Kabina11 : TLabel;
    Kabina12 : TLabel;
    Kabina21 : TLabel;
    Kabina22 : TLabel;
    Kabina31 : TLabel;
    Kabina32 : TLabel;
    Kabina61 : TLabel;
    Kabina62 : TLabel;
    Kabina51 : TLabel;
    Kabina52 : TLabel;
    Kabina41 : TLabel;
    Kabina42 : TLabel;
    ImageSol4: TImage;
    ImageSol5: TImage;
    ImageSol6: TImage;
    LMDImageList1: TLMDImageList;
    ImagePress1  : TLMDLImage;
    Imagepress2  : TLMDLImage;
    Imagepress3  : TLMDLImage;
    Imagepress6  : TLMDLImage;
    imagepress5  : TLMDLImage;
    Imagepress4  : TLMDLImage;
    Image128: TImage;
    StatusShape1: TShape;
    StatusShape2: TShape;
    StatusShape3: TShape;
    StatusShape4: TShape;
    StatusShape5: TShape;
    StatusShape6: TShape;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main2: TMain2;

implementation

{$R *.dfm}

procedure TMain2.FormShow(Sender: TObject);
begin
  if   screen.Monitors[0].Primary then
       Main2.Left:= screen.Monitors[0].Width+1
  else Main2.Left:= screen.Monitors[1].Width+1;
  main2.Top   :=0;
  main2.Width :=800;
  main2.Height:=600;
end;

procedure TMain2.FormResize(Sender: TObject);
begin
  Image2.Width :=Main2.Width;
  Image2.Height:=Main2.Height;
end;

procedure TMain2.FormCreate(Sender: TObject);
begin
//equalscreens();
end;

end.
