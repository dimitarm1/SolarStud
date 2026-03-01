unit setformdata;

interface
uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ExtCtrls, LMDCustomControl, LMDCustomPanel,
    LMDCustomBevelPanel, LMDCustomParentPanel, LMDCustomPanelFill,
    LMDPanelShape, LMDCustomImageList, LMDControl, LMDBaseControl,
    LMDBaseGraphicControl, LMDGraphicControl, LMDBaseImage, LMDCustomLImage,
    LMDLImage;

type
    TForm6 = class(TForm)
        Label1: TLabel;
        Image1: TImage;
        Image68: TLMDLImage;
        StatusShape3: TShape;

    private
        { Private declarations }
    public
        { Public declarations }
    end;
type
    tlabel1 = class(TLabel)

    private
        { Private declarations }
    public
        { Public declarations }
    end;
type
    tlabel2 = class(TLabel)

    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    Form6: TForm6;
    label1: TLabel;
    label2: TLabel2;

procedure set8main();
procedure set7main();
procedure set6main();
procedure set3main();
procedure set2main();
procedure set4main();
procedure set5main();
procedure equalscreens();
procedure equalStatus(Status1: TShape; Status2: TShape);
procedure equallabels(Label1: TLabel; Label2: TLabel);
procedure equalpictures(picture1: TLMDLImage; picture2: TLMDLImage);
implementation
uses MAIN, MainForm2, OsnovenEkranFrame;
{$R *.dfm}

procedure set8main();
begin

  

    MainForm.GetOsnovenEkranFrame.Kabina11.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina12.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina1cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina1minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina21.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina22.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina2cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina2minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina31.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina32.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina3cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina3minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina41.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina42.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina4cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina4minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina51.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina52.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina5cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina5minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina61.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina62.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina6cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina6minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina71.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina72.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina7cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina7minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina81.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina82.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina8cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina8minuti.Visible := true;
end;



procedure set7main();
begin
    with MainForm.GetOsnovenEkranFrame.ImagePress1 do 
    begin
      Left := 38;
      Top := 103;
      Width := 172;
      Height := 172;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina11 do 
    begin
      Left := 63;
      Top := 115;
      Width := 120;
      Height := 21;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina12 do 
    begin
      Left := 64;
      Top := 127;
      Width := 117;
      Height := 25;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol1 do 
    begin
      Left := 67;
      Top := 150;
      Width := 115;
      Height := 78;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape1 do 
    begin
      Left := 98;
      Top := 163;
      Width := 52;
      Height := 52;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina1minuti do 
    begin
      Left := 61;
      Top := 225;
      Width := 124;
      Height := 22;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina1cena do 
    begin
      Left := 71;
      Top := 239;
      Width := 108;
      Height := 22;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress2 do 
    begin
      Left := 215;
      Top := 103;
      Width := 172;
      Height := 172;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina21 do 
    begin
      Left := 242;
      Top := 113;
      Width := 117;
      Height := 25;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina22 do 
    begin
      Left := 243;
      Top := 127;
      Width := 115;
      Height := 25;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol2 do 
    begin
      Left := 243;
      Top := 150;
      Width := 115;
      Height := 78;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape2 do 
    begin
      Left := 274;
      Top := 163;
      Width := 52;
      Height := 52;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina2minuti do 
    begin
      Left := 241;
      Top := 225;
      Width := 117;
      Height := 22;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina2cena do 
    begin
      Left := 246;
      Top := 239;
      Width := 109;
      Height := 22;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress3 do 
    begin
      Left := 392;
      Top := 103;
      Width := 172;
      Height := 172;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina31 do 
    begin
      Left := 428;
      Top := 113;
      Width := 99;
      Height := 25;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina32 do 
    begin
      Left := 427;
      Top := 127;
      Width := 102;
      Height := 25;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol3 do 
    begin
      Left := 421;
      Top := 150;
      Width := 115;
      Height := 78;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape3 do 
    begin
      Left := 452;
      Top := 163;
      Width := 52;
      Height := 52;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina3minuti do 
    begin
      Left := 419;
      Top := 225;
      Width := 121;
      Height := 22;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina3cena do 
    begin
      Left := 427;
      Top := 239;
      Width := 111;
      Height := 23;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress4 do 
    begin
      Left := 570;
      Top := 103;
      Width := 172;
      Height := 172;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina41 do 
    begin
      Left := 608;
      Top := 110;
      Width := 98;
      Height := 31;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina42 do 
    begin
      Left := 599;
      Top := 127;
      Width := 116;
      Height := 25;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol4 do 
    begin
      Left := 599;
      Top := 150;
      Width := 115;
      Height := 78;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape4 do 
    begin
      Left := 630;
      Top := 163;
      Width := 52;
      Height := 52;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina4minuti do 
    begin
      Left := 596;
      Top := 225;
      Width := 122;
      Height := 22;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina4cena do 
    begin
      Left := 604;
      Top := 239;
      Width := 107;
      Height := 22;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress5 do 
    begin
      Left := 38;
      Top := 294;
      Width := 172;
      Height := 172;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina52 do 
    begin
      Left := 67;
      Top := 321;
      Width := 114;
      Height := 21;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina51 do 
    begin
      Left := 74;
      Top := 305;
      Width := 100;
      Height := 25;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol5 do 
    begin
      Left := 67;
      Top := 341;
      Width := 115;
      Height := 78;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape5 do 
    begin
      Left := 98;
      Top := 354;
      Width := 52;
      Height := 52;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina5minuti do 
    begin
      Left := 67;
      Top := 416;
      Width := 115;
      Height := 22;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina5cena do 
    begin
      Left := 65;
      Top := 430;
      Width := 117;
      Height := 22;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress6 do 
    begin
      Left := 215;
      Top := 294;
      Width := 172;
      Height := 172;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina61 do 
    begin
      Left := 247;
      Top := 305;
      Width := 107;
      Height := 25;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina62 do 
    begin
      Left := 243;
      Top := 319;
      Width := 116;
      Height := 25;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol6 do 
    begin
      Left := 243;
      Top := 341;
      Width := 115;
      Height := 78;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape6 do 
    begin
      Left := 274;
      Top := 354;
      Width := 52;
      Height := 52;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina6minuti do 
    begin
      Left := 241;
      Top := 416;
      Width := 120;
      Height := 22;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina6cena do 
    begin
      Left := 243;
      Top := 430;
      Width := 115;
      Height := 22;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress7 do 
    begin
      Left := 392;
      Top := 294;
      Width := 172;
      Height := 172;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina71 do 
    begin
      Left := 425;
      Top := 305;
      Width := 107;
      Height := 25;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina72 do 
    begin
      Left := 422;
      Top := 319;
      Width := 113;
      Height := 25;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol7 do
    begin
      Left := 421;
      Top := 341;
      Width := 115;
      Height := 78;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape7 do 
    begin
      Left := 452;
      Top := 354;
      Width := 52;
      Height := 52;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina7minuti do 
    begin
      Left := 423;
      Top := 416;
      Width := 113;
      Height := 22;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina7cena do 
    begin
      Left := 424;
      Top := 430;
      Width := 110;
      Height := 22;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress8 do 
    begin
      Left := 570;
      Top := 294;
      Width := 172;
      Height := 172;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina81 do 
    begin
      Left := 601;
      Top := 308;
      Width := 107;
      Height := 19;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina82 do 
    begin
      Left := 599;
      Top := 322;
      Width := 114;
      Height := 19;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol8 do 
    begin
      Left := 599;
      Top := 341;
      Width := 115;
      Height := 78;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape8 do 
    begin
      Left := 630;
      Top := 354;
      Width := 52;
      Height := 52;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina8minuti do 
    begin
      Left := 600;
      Top := 416;
      Width := 116;
      Height := 22;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina8cena do 
    begin
      Left := 601;
      Top := 430;
      Width := 110;
      Height := 22;
    end;



    MainForm.GetOsnovenEkranFrame.Kabina11.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina12.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina1cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina1minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina21.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina22.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina2cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina2minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina31.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina32.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina3cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina3minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina41.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina42.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina4cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina4minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina51.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina52.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina5cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina5minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina61.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina62.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina6cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina6minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina71.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina72.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina7cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina7minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina81.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina82.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina8cena.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina8minuti.Visible := false;

    MainForm.GetOsnovenEkranFrame.Imagepress8.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagesol8.Visible := False;
end;





procedure set6main();
begin

      with MainForm.GetOsnovenEkranFrame.ImagePress1 do
    begin
      Left := 31;
      Top := 54;
      Width := 220;
      Height := 221;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina21 do
    begin
      Left := 313;
      Top := 70;
      Width := 169;
      Height := 25;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina11 do 
    begin
      Left := 54;
      Top := 70;
      Width := 169;
      Height := 25;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina12 do
    begin
      Left := 54;
      Top := 88;
      Width := 169;
      Height := 25;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol1 do
    begin
      Left := 66;
      Top := 112;
      Width := 149;
      Height := 97;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape1 do 
    begin
      Left := 108;
      Top := 130;
      Width := 65;
      Height := 65;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina1minuti do 
    begin
      Left := 58;
      Top := 212;
      Width := 161;
      Height := 22;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina1cena do 
    begin
      Left := 56;
      Top := 232;
      Width := 161;
      Height := 22;
      Font.Height := -16;
    end;
     with MainForm.GetOsnovenEkranFrame.Imagepress2 do 
    begin
      Left := 287;
      Top := 54;
      Width := 220;
      Height := 221;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina21 do 
    begin
      Left := 313;
      Top := 70;
      Width := 169;
      Height := 25;
      Font.Height := -16;
    end;




    with MainForm.GetOsnovenEkranFrame.Kabina22 do 
    begin
      Left := 313;
      Top := 88;
      Width := 169;
      Height := 25;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol2 do 
    begin
      Left := 323;
      Top := 114;
      Width := 149;
      Height := 97;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape2 do 
    begin
      Left := 365;
      Top := 130;
      Width := 65;
      Height := 65;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina2minuti do 
    begin
      Left := 311;
      Top := 212;
      Width := 161;
      Height := 22;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina2cena do 
    begin
      Left := 311;
      Top := 232;
      Width := 161;
      Height := 22;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress3 do 
    begin
      Left := 541;
      Top := 53;
      Width := 220;
      Height := 221;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina31 do 
    begin
      Left := 574;
      Top := 70;
      Width := 169;
      Height := 25;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina32 do 
    begin
      Left := 574;
      Top := 88;
      Width := 169;
      Height := 25;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol3 do 
    begin
      Left := 579;
      Top := 117;
      Width := 149;
      Height := 97;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape3 do 
    begin
      Left := 622;
      Top := 130;
      Width := 65;
      Height := 65;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina3cena do 
    begin
      Left := 545;
      Top := 225;
      Width := 206;
      Height := 36;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina3minuti do 
    begin
      Left := 572;
      Top := 213;
      Width := 161;
      Height := 22;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress4 do 
    begin
      Left := 29;
      Top := 301;
      Width := 220;
      Height := 221;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina41 do 
    begin
      Left := 54;
      Top := 318;
      Width := 169;
      Height := 25;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina42 do 
    begin
      Left := 54;
      Top := 336;
      Width := 169;
      Height := 25;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol4 do 
    begin
      Left := 66;
      Top := 360;
      Width := 149;
      Height := 97;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape4 do 
    begin
      Left := 108;
      Top := 378;
      Width := 65;
      Height := 65;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina4minuti do 
    begin
      Left := 58;
      Top := 457;
      Width := 161;
      Height := 22;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina4cena do 
    begin
      Left := 58;
      Top := 476;
      Width := 161;
      Height := 22;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress5 do 
    begin
      Left := 287;
      Top := 298;
      Width := 220;
      Height := 221;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina51 do 
    begin
      Left := 313;
      Top := 318;
      Width := 169;
      Height := 25;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina52 do 
    begin
      Left := 313;
      Top := 336;
      Width := 169;
      Height := 25;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol5 do 
    begin
      Left := 323;
      Top := 360;
      Width := 149;
      Height := 97;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape5 do 
    begin
      Left := 365;
      Top := 378;
      Width := 65;
      Height := 65;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina5minuti do 
    begin
      Left := 312;
      Top := 457;
      Width := 161;
      Height := 22;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina5cena do 
    begin
      Left := 312;
      Top := 476;
      Width := 161;
      Height := 22;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress6 do 
    begin
      Left := 545;
      Top := 300;
      Width := 220;
      Height := 221;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina61 do 
    begin
      Left := 573;
      Top := 318;
      Width := 169;
      Height := 25;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina62 do 
    begin
      Left := 573;
      Top := 336;
      Width := 169;
      Height := 25;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol6 do 
    begin
      Left := 580;
      Top := 362;
      Width := 149;
      Height := 97;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape6 do 
    begin
      Left := 622;
      Top := 378;
      Width := 65;
      Height := 65;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina6minuti do 
    begin
      Left := 571;
      Top := 458;
      Width := 161;
      Height := 22;
      Font.Height := -16;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina6cena do 
    begin
      Left := 569;
      Top := 476;
      Width := 161;
      Height := 22;
      Font.Height := -16;
    end;

    MainForm.GetOsnovenEkranFrame.Kabina11.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina12.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina1cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina1minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina21.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina22.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina2cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina2minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina31.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina32.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina3cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina3minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina41.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina42.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina4cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina4minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina51.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina52.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina5cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina5minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina61.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina62.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina6cena.Visible := true;
    MainForm.GetOsnovenEkranFrame.Kabina6minuti.Visible := true;

    MainForm.GetOsnovenEkranFrame.Kabina71.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina72.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina7cena.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina7minuti.Visible := false;

    MainForm.GetOsnovenEkranFrame.Kabina81.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina82.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina8cena.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina8minuti.Visible := false;
    MainForm.GetOsnovenEkranFrame.Imagepress7.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagesol7.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagepress8.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagesol8.Visible := False;
end;

procedure equalStatus(Status1: TShape; Status2: TShape);
begin
    Status1.Left := Status2.Left;
    Status1.Top := Status2.Top;
    Status1.Width := Status2.Width;
    Status1.Height := Status2.Height;

end;

procedure equalpictures(picture1: TLMDLImage; picture2: TLMDLImage);
begin
    picture1.Left := picture2.Left;
    picture1.Top := picture2.Top;
    picture1.Width := picture2.Width;
    picture1.Height := picture2.Height;
    //picture1.Picture:= picture2.Picture;
    picture1.Visible := picture2.Visible;
end;

procedure equalpictures2(picture1: TImage; picture2: TImage);
begin
    picture1.Left := picture2.Left;
    picture1.Top := picture2.Top;
    picture1.Width := picture2.Width;
    picture1.Height := picture2.Height;
    picture1.Picture := picture2.Picture;
    picture1.Visible := picture2.Visible;
end;

procedure equallabels(Label1: TLabel; Label2: TLabel);
begin
    Label1.Left := Label2.Left;
    Label1.Top := Label2.Top;
    Label1.Width := Label1.Width;
    Label1.Height := Label1.Height;
    Label1.Font.Height := Label1.Font.Height;
    Label1.Font.Name := Label1.Font.Name;
    Label1.Font.Style := Label1.Font.Style;
    Label1.Visible := Label2.Visible;
end;

procedure equalscreens();

begin
    equalpictures(main2.Imagepress1, MainForm.GetOsnovenEkranFrame.Imagepress1);
    equalpictures2(main2.ImageSol1, MainForm.GetOsnovenEkranFrame.ImageSol1);
    equalpictures(main2.Imagepress2, MainForm.GetOsnovenEkranFrame.Imagepress2);
    equalpictures2(main2.ImageSol2, MainForm.GetOsnovenEkranFrame.ImageSol2);
    equalpictures(main2.Imagepress3, MainForm.GetOsnovenEkranFrame.Imagepress3);
    equalpictures2(main2.ImageSol3, MainForm.GetOsnovenEkranFrame.ImageSol3);
    equalpictures(main2.Imagepress4, MainForm.GetOsnovenEkranFrame.Imagepress4);
    equalpictures2(main2.ImageSol4, MainForm.GetOsnovenEkranFrame.ImageSol4);
    equalpictures(main2.Imagepress5, MainForm.GetOsnovenEkranFrame.Imagepress5);
    equalpictures2(main2.ImageSol5, MainForm.GetOsnovenEkranFrame.ImageSol5);
    equalpictures(main2.Imagepress6, MainForm.GetOsnovenEkranFrame.Imagepress6);
    equalpictures2(main2.ImageSol6, MainForm.GetOsnovenEkranFrame.ImageSol6);

    equallabels(Main2.Kabina1minuti, MainForm.GetOsnovenEkranFrame.Kabina1minuti);
    equallabels(Main2.Kabina1cena, MainForm.GetOsnovenEkranFrame.Kabina1cena);
    equallabels(Main2.Kabina11, MainForm.GetOsnovenEkranFrame.Kabina11);
    equallabels(Main2.Kabina12, MainForm.GetOsnovenEkranFrame.Kabina12);

    equallabels(Main2.Kabina2minuti, MainForm.GetOsnovenEkranFrame.Kabina2minuti);
    equallabels(Main2.Kabina2cena, MainForm.GetOsnovenEkranFrame.Kabina2cena);
    equallabels(Main2.Kabina21, MainForm.GetOsnovenEkranFrame.Kabina21);
    equallabels(Main2.Kabina22, MainForm.GetOsnovenEkranFrame.Kabina22);

    equallabels(Main2.Kabina3minuti, MainForm.GetOsnovenEkranFrame.Kabina3minuti);
    equallabels(Main2.Kabina3cena, MainForm.GetOsnovenEkranFrame.Kabina3cena);
    equallabels(Main2.Kabina31, MainForm.GetOsnovenEkranFrame.Kabina31);
    equallabels(Main2.Kabina32, MainForm.GetOsnovenEkranFrame.Kabina32);

    equallabels(Main2.Kabina4minuti, MainForm.GetOsnovenEkranFrame.Kabina4minuti);
    equallabels(Main2.Kabina4cena, MainForm.GetOsnovenEkranFrame.Kabina4cena);
    equallabels(Main2.Kabina41, MainForm.GetOsnovenEkranFrame.Kabina41);
    equallabels(Main2.Kabina42, MainForm.GetOsnovenEkranFrame.Kabina42);

    equallabels(Main2.Kabina5minuti, MainForm.GetOsnovenEkranFrame.Kabina5minuti);
    equallabels(Main2.Kabina5cena, MainForm.GetOsnovenEkranFrame.Kabina5cena);
    equallabels(Main2.Kabina51, MainForm.GetOsnovenEkranFrame.Kabina51);
    equallabels(Main2.Kabina52, MainForm.GetOsnovenEkranFrame.Kabina52);

    equallabels(Main2.Kabina6minuti, MainForm.GetOsnovenEkranFrame.Kabina6minuti);
    equallabels(Main2.Kabina6cena, MainForm.GetOsnovenEkranFrame.Kabina6cena);
    equallabels(Main2.Kabina61, MainForm.GetOsnovenEkranFrame.Kabina61);
    equallabels(Main2.Kabina62, MainForm.GetOsnovenEkranFrame.Kabina62);

    equalStatus(Main2.StatusShape1, MainForm.GetOsnovenEkranFrame.StatusShape1);
    equalStatus(Main2.StatusShape2, MainForm.GetOsnovenEkranFrame.StatusShape2);
    equalStatus(Main2.StatusShape3, MainForm.GetOsnovenEkranFrame.StatusShape3);
    equalStatus(Main2.StatusShape4, MainForm.GetOsnovenEkranFrame.StatusShape4);
    equalStatus(Main2.StatusShape5, MainForm.GetOsnovenEkranFrame.StatusShape5);
    equalStatus(Main2.StatusShape6, MainForm.GetOsnovenEkranFrame.StatusShape6);

end;

procedure set3main();
begin
    with MainForm.GetOsnovenEkranFrame.Kabina1minuti do
    begin
        Left := 106;
        Top := 274;
        Width := 161;
        Height := 22;
        Font.Height := -19;
        Font.Name := 'Arial';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina21 do
    begin
        Left := 541;
        Top := 112;
        Width := 169;
        Height := 25;
        Font.Height := -19;
        Font.Name := 'Arial';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina22 do
    begin
        Left := 541;
        Top := 135;
        Width := 169;
        Height := 25;
        Font.Height := -19;
        Font.Name := 'Arial';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina2cena do
    begin
        Left := 543;
        Top := 295;
        Width := 161;
        Height := 22;
        Font.Height := -19;
        Font.Name := 'Arial';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.kabina2minuti do
    begin
        Left := 543;
        Top := 274;
        Width := 161;
        Height := 22;
        Font.Height := -19;
        Font.Name := 'Arial';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina31 do
    begin
        Left := 325;
        Top := 254;
        Width := 161;
        Height := 25;
        Font.Height := -19;
        Font.Name := 'Arial';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina32 do
    begin
        Left := 325;
        Top := 277;
        Width := 161;
        Height := 25;
        Font.Height := -19;
        Font.Name := 'Arial';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina3cena do
    begin
        Left := 326;
        Top := 436;
        Width := 161;
        Height := 22;
        Font.Height := -19;
        Font.Name := 'Arial';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina3minuti do
    begin
        Left := 326;
        Top := 417;
        Width := 161;
        Height := 22;
        Font.Height := -19;
        Font.Name := 'Arial';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina11 do
    begin
        Left := 104;
        Top := 112;
        Width := 169;
        Height := 25;
        Font.Height := -19;
        Font.Name := 'Arial';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina12 do
    begin
        Left := 104;
        Top := 135;
        Width := 169;
        Height := 25;
        Font.Height := -19;
        Font.Name := 'Arial';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina1cena do
    begin
        Left := 106;
        Top := 295;
        Width := 161;
        Height := 22;
        Font.Height := -19;
        Font.Name := 'Arial';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress1 do
    begin
        Left := 67;
        Top := 99;
        Width := 235;
        Height := 235;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress2 do
    begin
        Left := 507;
        Top := 99;
        Width := 235;
        Height := 235;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress3 do
    begin
        Left := 289;
        Top := 243;
        Width := 235;
        Height := 235;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol1 do
    begin
        Left := 104;
        Top := 160;
        Width := 161;
        Height := 113;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol2 do
    begin
        Left := 543;
        Top := 160;
        Width := 161;
        Height := 112;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol3 do
    begin
        Left := 325;
        Top := 303;
        Width := 162;
        Height := 115;
    end;

    with MainForm.GetOsnovenEkranFrame.StatusShape1 do
    begin
        Left := 149;
        Top := 178;
        Width := 80;
        Height := 80;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape3 do
    begin
        Left := 370;
        Top := 319;
        Width := 80;
        Height := 80;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape2 do
    begin
        Left := 587;
        Top := 178;
        Width := 80;
        Height := 80;
    end;
    with MainForm.GetOsnovenEkranFrame do
    begin
        Kabina41.Visible := False;
        Kabina42.Visible := False;
        Kabina51.Visible := False;
        Kabina52.Visible := False;
        Kabina61.Visible := False;
        Kabina62.Visible := False;
        Kabina4minuti.Visible := False;
        Kabina4cena.Visible := False;
        Kabina5minuti.Visible := False;
        Kabina5cena.Visible := False;
        Kabina6minuti.Visible := False;
        Kabina6cena.Visible := False;
        Imagepress4.Visible := False;
        Imagesol4.Visible := False;
        Imagepress5.Visible := False;
        Imagesol5.Visible := False;
        Imagepress6.Visible := False;
        Imagesol6.Visible := False;
        // Image2.picture:=Image61.Picture;
    end;
    
    MainForm.GetOsnovenEkranFrame.Kabina71.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina72.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina7cena.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina7minuti.Visible := false;

    MainForm.GetOsnovenEkranFrame.Kabina81.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina82.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina8cena.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina8minuti.Visible := false;
    MainForm.GetOsnovenEkranFrame.Imagepress7.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagesol7.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagepress8.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagesol8.Visible := False;
end;

procedure set4main();
begin
    with MainForm.GetOsnovenEkranFrame.Kabina3Minuti do
    begin
        Left := 246;
        Top := 444;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina3cena do
    begin
        Left := 246;
        Top := 461;
        Width := 161;
        Height := 22;
        Alignment := taCenter;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina32 do
    begin
        Left := 248;
        Top := 304;
        Width := 161;
        Height := 25;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina31 do
    begin
        Left := 248;
        Top := 287;
        Width := 161;
        Height := 25;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];

        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina2minuti do
    begin
        Left := 399;
        Top := 258;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina41 do
    begin
        Left := 543;
        Top := 287;
        Width := 169;
        Height := 28;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina42 do
    begin
        Left := 544;
        Top := 303;
        Width := 169;
        Height := 30;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina4cena do
    begin
        Left := 548;
        Top := 461;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina4minuti do
    begin
        Left := 548;
        Top := 444;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina11 do
    begin
        Left := 90;
        Top := 102;
        Width := 169;
        Height := 25;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina12 do
    begin
        Left := 90;
        Top := 120;
        Width := 169;
        Height := 25;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina1cena do
    begin
        Left := 95;
        Top := 273;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina1minuti do
    begin
        Left := 95;
        Top := 258;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina21 do
    begin
        Left := 394;
        Top := 102;
        Width := 169;
        Height := 25;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina22 do
    begin
        Left := 394;
        Top := 120;
        Width := 169;
        Height := 25;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina2cena do
    begin
        Left := 399;
        Top := 275;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress1 do
    begin
        Left := 62;
        Top := 90;
        Width := 230;
        Height := 230;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress2 do
    begin
        Left := 366;
        Top := 90;
        Width := 230;
        Height := 230;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress3 do
    begin
        Left := 214;
        Top := 276;
        Width := 230;
        Height := 230;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress4 do
    begin
        Left := 518;
        Top := 276;
        Width := 230;
        Height := 230;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol1 do
    begin
        Left := 98;
        Top := 149;
        Width := 160;
        Height := 110;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol2 do
    begin
        Left := 402;
        Top := 149;
        Width := 160;
        Height := 110;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol3 do
    begin
        Left := 251;
        Top := 333;
        Width := 160;
        Height := 110;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol4 do
    begin
        Left := 555;
        Top := 333;
        Width := 160;
        Height := 110;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape4 do
    begin
        Left := 600;
        Top := 348;
        Width := 75;
        Height := 75;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape3 do
    begin
        Left := 293;
        Top := 348;
        Width := 75;
        Height := 75;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape2 do
    begin
        Left := 446;
        Top := 163;
        Width := 75;
        Height := 75;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape1 do
    begin
        Left := 135;
        Top := 163;
        Width := 75;
        Height := 75;
    end;
    with MainForm.GetOsnovenEkranFrame do
    begin
        // Image2.picture:=Image23.Picture;
        Kabina51.Visible := False;
        Kabina52.Visible := False;
        Kabina61.Visible := False;
        Kabina62.Visible := False;
        Kabina5minuti.Visible := False;
        Kabina5cena.Visible := False;
        Kabina6minuti.Visible := False;
        Kabina6cena.Visible := False;
        Imagepress5.Visible := False;
        Imagesol5.Visible := False;
        Imagepress6.Visible := False;
        Imagesol6.Visible := False;

    end;
    
    MainForm.GetOsnovenEkranFrame.Kabina71.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina72.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina7cena.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina7minuti.Visible := false;

    MainForm.GetOsnovenEkranFrame.Kabina81.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina82.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina8cena.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina8minuti.Visible := false;
    MainForm.GetOsnovenEkranFrame.Imagepress7.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagesol7.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagepress8.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagesol8.Visible := False;
end;

procedure set2main();
begin
    with MainForm.GetOsnovenEkranFrame.statusShape1 do
    begin
        Left := 189;
        Top := 234;
        Width := 90;
        Height := 90;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape2 do
    begin
        Left := 525;
        Top := 234;
        Width := 90;
        Height := 90;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina11 do
    begin
        Left := 152;
        Top := 150;
        Width := 169;
        Height := 25;
        Font.Height := -24;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina12 do
    begin
        Left := 151;
        Top := 178;
        Width := 169;
        Height := 25;
        Font.Height := -24;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina1cena do
    begin
        Left := 147;
        Top := 379;
        Width := 167;
        Height := 34;
        Font.Height := -21;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina1minuti do
    begin
        Left := 154;
        Top := 356;
        Width := 161;
        Height := 29;
        Font.Height := -21;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina21 do
    begin
        Left := 480;
        Top := 150;
        Width := 169;
        Height := 25;
        Font.Height := -24;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina22 do
    begin
        Left := 479;
        Top := 180;
        Width := 169;
        Height := 25;
        Font.Height := -24;
        Font.Name := 'Arial Black';
        Visible := true;
        Font.Style := [];
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina2cena do
    begin
        Left := 476;
        Top := 376;
        Width := 169;
        Height := 34;
        Font.Height := -21;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina2minuti do
    begin
        Left := 478;
        Top := 354;
        Width := 169;
        Height := 31;
        Font.Height := -21;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol2 do
    begin
        Left := 464;
        Top := 208;
        Width := 201;
        Height := 145;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagesol1 do
    begin
        Left := 135;
        Top := 207;
        Width := 201;
        Height := 145;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress2 do
    begin
        Left := 408;
        Top := 112;
        Width := 321;
        Height := 329;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress1 do
    begin
        Left := 72;
        Top := 112;
        Width := 313;
        Height := 329;
    end;
    with MainForm.GetOsnovenEkranFrame do
    begin
        Kabina31.Visible := False;
        Kabina32.Visible := False;
        Kabina3minuti.Visible := False;
        Kabina3cena.Visible := False;
        Imagepress3.Visible := False;
        Imagesol3.Visible := False;
        //  Image2.picture:=Image63.Picture;
        Kabina41.Visible := False;
        Kabina42.Visible := False;
        Kabina51.Visible := False;
        Kabina52.Visible := False;
        Kabina61.Visible := False;
        Kabina62.Visible := False;
        Kabina4minuti.Visible := False;
        Kabina4cena.Visible := False;
        Kabina5minuti.Visible := False;
        Kabina5cena.Visible := False;
        Kabina6minuti.Visible := False;
        Kabina6cena.Visible := False;
        Imagepress4.Visible := False;
        Imagesol4.Visible := False;
        Imagepress5.Visible := False;
        Imagesol5.Visible := False;
        Imagepress6.Visible := False;
        Imagesol6.Visible := False;
    end;
    
    MainForm.GetOsnovenEkranFrame.Kabina71.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina72.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina7cena.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina7minuti.Visible := false;

    MainForm.GetOsnovenEkranFrame.Kabina81.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina82.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina8cena.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina8minuti.Visible := false;

    MainForm.GetOsnovenEkranFrame.Imagepress7.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagesol7.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagepress8.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagesol8.Visible := False;

end;

procedure set5main();
begin

    with MainForm.GetOsnovenEkranFrame.StatusShape1 do
    begin
        Left := 130;
        Top := 156;
        Width := 70;
        Height := 70;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape2 do
    begin
        Left := 360;
        Top := 156;
        Width := 70;
        Height := 70;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape3 do
    begin
        Left := 590;
        Top := 156;
        Width := 70;
        Height := 70;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape4 do
    begin
        Left := 243;
        Top := 358;
        Width := 70;
        Height := 70;
    end;
    with MainForm.GetOsnovenEkranFrame.StatusShape5 do
    begin
        Left := 473;
        Top := 358;
        Width := 70;
        Height := 70;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina3minuti do
    begin
        Left := 539;
        Top := 238;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina41 do
    begin
        Left := 205;
        Top := 300;
        Width := 169;
        Height := 28;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina42 do
    begin
        Left := 205;
        Top := 317;
        Width := 169;
        Height := 30;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina4cena do
    begin
        Left := 200;
        Top := 458;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina4minuti do
    begin
        Left := 200;
        Top := 442;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina51 do
    begin
        Left := 429;
        Top := 300;
        Width := 169;
        Height := 28;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina52 do
    begin
        Left := 429;
        Top := 319;
        Width := 169;
        Height := 28;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina5cena do
    begin
        Left := 430;
        Top := 458;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina5minuti do
    begin
        Left := 430;
        Top := 442;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina11 do
    begin
        Left := 79;
        Top := 103;
        Width := 169;
        Height := 25;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina12 do
    begin
        Left := 79;
        Top := 120;
        Width := 169;
        Height := 25;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina1cena do
    begin
        Left := 79;
        Top := 255;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina1minuti do
    begin
        Left := 79;
        Top := 240;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina21 do
    begin
        Left := 309;
        Top := 103;
        Width := 169;
        Height := 25;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina22 do
    begin
        Left := 309;
        Top := 120;
        Width := 169;
        Height := 25;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina2cena do
    begin
        Left := 309;
        Top := 255;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina2minuti do
    begin
        Left := 309;
        Top := 238;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina31 do
    begin
        Left := 539;
        Top := 103;
        Width := 161;
        Height := 25;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina32 do
    begin
        Left := 539;
        Top := 120;
        Width := 161;
        Height := 25;
        Font.Height := -15;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.Kabina3cena do
    begin
        Left := 545;
        Top := 256;
        Width := 161;
        Height := 22;
        Font.Height := -16;
        Font.Name := 'Arial Black';
        Font.Style := [];
        Visible := true;
    end;
    with MainForm.GetOsnovenEkranFrame.ImagePress1 do
    begin
        Left := 55;
        Top := 80;
        Width := 220;
        Height := 220;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress2 do
    begin
        Left := 285;
        Top := 80;
        Width := 220;
        Height := 220;
    end;
    with MainForm.GetOsnovenEkranFrame.Imagepress3 do
    begin
        Left := 515;
        Top := 80;
        Width := 220;
        Height := 220;
    end;
    with MainForm.GetOsnovenEkranFrame.ImagePress4 do
    begin
        Left := 170;
        Top := 286;
        Width := 220;
        Height := 220;
    end;
    with MainForm.GetOsnovenEkranFrame.ImagePress5 do
    begin
        Left := 400;
        Top := 286;
        Width := 220;
        Height := 220;
    end;
    with MainForm.GetOsnovenEkranFrame.ImageSol1 do
    begin
        Left := 90;
        Top := 144;
        Width := 149;
        Height := 97;
    end;
    with MainForm.GetOsnovenEkranFrame.ImageSol2 do
    begin
        Left := 320;
        Top := 144;
        Width := 149;
        Height := 97;
    end;
    with MainForm.GetOsnovenEkranFrame.ImageSol3 do
    begin
        Left := 550;
        Top := 144;
        Width := 149;
        Height := 97;
    end;
    with MainForm.GetOsnovenEkranFrame.ImageSol4 do
    begin
        Left := 203;
        Top := 344;
        Width := 149;
        Height := 97;
    end;
    with MainForm.GetOsnovenEkranFrame.ImageSol5 do
    begin
        Left := 433;
        Top := 344;
        Width := 149;
        Height := 97;
    end;
    with MainForm.GetOsnovenEkranFrame do
    begin
        //  Image2.picture:=Image22.Picture;
        Kabina61.Visible := False;
        Kabina62.Visible := False;
        Kabina6minuti.Visible := False;
        Kabina6cena.Visible := False;
        Imagepress6.Visible := False;
        Imagesol6.Visible := False;
    end;
    
    MainForm.GetOsnovenEkranFrame.Kabina71.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina72.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina7cena.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina7minuti.Visible := false;

    MainForm.GetOsnovenEkranFrame.Kabina81.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina82.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina8cena.Visible := false;
    MainForm.GetOsnovenEkranFrame.Kabina8minuti.Visible := false;
    MainForm.GetOsnovenEkranFrame.Imagepress7.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagesol7.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagepress8.Visible := False;
    MainForm.GetOsnovenEkranFrame.Imagesol8.Visible := False;
end;

end.

