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
uses MAIN, MainForm2;
{$R *.dfm}

procedure set6main();
begin

      with MainForm.ImagePress1 do 
    begin
      Left := 31;
      Top := 54;
      Width := 220;
      Height := 221;
    end;
    with MainForm.Kabina21 do 
    begin
      Left := 313;
      Top := 70;
      Width := 169;
      Height := 25;
    end;
    with MainForm.Kabina11 do 
    begin
      Left := 54;
      Top := 70;
      Width := 169;
      Height := 25;
    end;
    with MainForm.Kabina12 do 
    begin
      Left := 54;
      Top := 88;
      Width := 169;
      Height := 25;
    end;
    with MainForm.Imagesol1 do 
    begin
      Left := 66;
      Top := 112;
      Width := 149;
      Height := 97;
    end;
    with MainForm.StatusShape1 do 
    begin
      Left := 108;
      Top := 130;
      Width := 65;
      Height := 65;
    end;
    with MainForm.Kabina1minuti do 
    begin
      Left := 58;
      Top := 212;
      Width := 161;
      Height := 22;
    end;
    with MainForm.Kabina1cena do 
    begin
      Left := 56;
      Top := 232;
      Width := 161;
      Height := 22;
    end;
    with MainForm.Kabina22 do 
    begin
      Left := 313;
      Top := 88;
      Width := 169;
      Height := 25;
    end;
    with MainForm.Imagesol2 do 
    begin
      Left := 323;
      Top := 114;
      Width := 149;
      Height := 97;
    end;
    with MainForm.StatusShape2 do 
    begin
      Left := 365;
      Top := 130;
      Width := 65;
      Height := 65;
    end;
    with MainForm.Kabina2minuti do 
    begin
      Left := 311;
      Top := 212;
      Width := 161;
      Height := 22;
    end;
    with MainForm.Kabina2cena do 
    begin
      Left := 311;
      Top := 232;
      Width := 161;
      Height := 22;
    end;
    with MainForm.Imagepress3 do 
    begin
      Left := 541;
      Top := 53;
      Width := 220;
      Height := 221;
    end;
    with MainForm.Kabina31 do 
    begin
      Left := 574;
      Top := 70;
      Width := 169;
      Height := 25;
    end;
    with MainForm.Kabina32 do 
    begin
      Left := 574;
      Top := 88;
      Width := 169;
      Height := 25;
    end;
    with MainForm.Imagesol3 do 
    begin
      Left := 579;
      Top := 117;
      Width := 149;
      Height := 97;
    end;
    with MainForm.StatusShape3 do 
    begin
      Left := 622;
      Top := 130;
      Width := 65;
      Height := 65;
    end;
    with MainForm.Kabina3cena do 
    begin
      Left := 545;
      Top := 225;
      Width := 206;
      Height := 36;
    end;
    with MainForm.Kabina3minuti do 
    begin
      Left := 572;
      Top := 213;
      Width := 161;
      Height := 22;
    end;
    with MainForm.Imagepress4 do 
    begin
      Left := 29;
      Top := 301;
      Width := 220;
      Height := 221;
    end;
    with MainForm.Kabina41 do 
    begin
      Left := 54;
      Top := 318;
      Width := 169;
      Height := 25;
    end;
    with MainForm.Kabina42 do 
    begin
      Left := 54;
      Top := 336;
      Width := 169;
      Height := 25;
    end;
    with MainForm.Imagesol4 do 
    begin
      Left := 66;
      Top := 360;
      Width := 149;
      Height := 97;
    end;
    with MainForm.StatusShape4 do 
    begin
      Left := 108;
      Top := 378;
      Width := 65;
      Height := 65;
    end;
    with MainForm.Kabina4minuti do 
    begin
      Left := 58;
      Top := 457;
      Width := 161;
      Height := 22;
    end;
    with MainForm.Kabina4cena do 
    begin
      Left := 58;
      Top := 476;
      Width := 161;
      Height := 22;
    end;
    with MainForm.Imagepress5 do 
    begin
      Left := 287;
      Top := 298;
      Width := 220;
      Height := 221;
    end;
    with MainForm.Kabina51 do 
    begin
      Left := 313;
      Top := 318;
      Width := 169;
      Height := 25;
    end;
    with MainForm.Kabina52 do 
    begin
      Left := 313;
      Top := 336;
      Width := 169;
      Height := 25;
    end;
    with MainForm.Imagesol5 do 
    begin
      Left := 323;
      Top := 360;
      Width := 149;
      Height := 97;
    end;
    with MainForm.StatusShape5 do 
    begin
      Left := 365;
      Top := 378;
      Width := 65;
      Height := 65;
    end;
    with MainForm.Kabina5minuti do 
    begin
      Left := 312;
      Top := 457;
      Width := 161;
      Height := 22;
    end;
    with MainForm.Kabina5cena do 
    begin
      Left := 312;
      Top := 476;
      Width := 161;
      Height := 22;
    end;
    with MainForm.Imagepress6 do 
    begin
      Left := 545;
      Top := 300;
      Width := 220;
      Height := 221;
    end;
    with MainForm.Kabina61 do 
    begin
      Left := 573;
      Top := 318;
      Width := 169;
      Height := 25;
    end;
    with MainForm.Kabina62 do 
    begin
      Left := 573;
      Top := 336;
      Width := 169;
      Height := 25;
    end;
    with MainForm.Imagesol6 do 
    begin
      Left := 580;
      Top := 362;
      Width := 149;
      Height := 97;
    end;
    with MainForm.StatusShape6 do 
    begin
      Left := 622;
      Top := 378;
      Width := 65;
      Height := 65;
    end;
    with MainForm.Kabina6minuti do 
    begin
      Left := 571;
      Top := 458;
      Width := 161;
      Height := 22;
    end;
    with MainForm.Kabina6cena do 
    begin
      Left := 569;
      Top := 476;
      Width := 161;
      Height := 22;
    end;

    MainForm.Kabina11.Visible := true;
    MainForm.Kabina12.Visible := true;
    MainForm.Kabina1cena.Visible := true;
    MainForm.Kabina1minuti.Visible := true;

    MainForm.Kabina21.Visible := true;
    MainForm.Kabina22.Visible := true;
    MainForm.Kabina2cena.Visible := true;
    MainForm.Kabina2minuti.Visible := true;

    MainForm.Kabina31.Visible := true;
    MainForm.Kabina32.Visible := true;
    MainForm.Kabina3cena.Visible := true;
    MainForm.Kabina3minuti.Visible := true;

    MainForm.Kabina41.Visible := true;
    MainForm.Kabina42.Visible := true;
    MainForm.Kabina4cena.Visible := true;
    MainForm.Kabina4minuti.Visible := true;

    MainForm.Kabina51.Visible := true;
    MainForm.Kabina52.Visible := true;
    MainForm.Kabina5cena.Visible := true;
    MainForm.Kabina5minuti.Visible := true;

    MainForm.Kabina61.Visible := true;
    MainForm.Kabina62.Visible := true;
    MainForm.Kabina6cena.Visible := true;
    MainForm.Kabina6minuti.Visible := true;
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
    equalpictures(main2.Imagepress1, MainForm.Imagepress1);
    equalpictures2(main2.ImageSol1, MainForm.ImageSol1);
    equalpictures(main2.Imagepress2, MainForm.Imagepress2);
    equalpictures2(main2.ImageSol2, MainForm.ImageSol2);
    equalpictures(main2.Imagepress3, MainForm.Imagepress3);
    equalpictures2(main2.ImageSol3, MainForm.ImageSol3);
    equalpictures(main2.Imagepress4, MainForm.Imagepress4);
    equalpictures2(main2.ImageSol4, MainForm.ImageSol4);
    equalpictures(main2.Imagepress5, MainForm.Imagepress5);
    equalpictures2(main2.ImageSol5, MainForm.ImageSol5);
    equalpictures(main2.Imagepress6, MainForm.Imagepress6);
    equalpictures2(main2.ImageSol6, MainForm.ImageSol6);

    equallabels(Main2.Kabina1minuti, MainForm.Kabina1minuti);
    equallabels(Main2.Kabina1cena, MainForm.Kabina1cena);
    equallabels(Main2.Kabina11, MainForm.Kabina11);
    equallabels(Main2.Kabina12, MainForm.Kabina12);

    equallabels(Main2.Kabina2minuti, MainForm.Kabina2minuti);
    equallabels(Main2.Kabina2cena, MainForm.Kabina2cena);
    equallabels(Main2.Kabina21, MainForm.Kabina21);
    equallabels(Main2.Kabina22, MainForm.Kabina22);

    equallabels(Main2.Kabina3minuti, MainForm.Kabina3minuti);
    equallabels(Main2.Kabina3cena, MainForm.Kabina3cena);
    equallabels(Main2.Kabina31, MainForm.Kabina31);
    equallabels(Main2.Kabina32, MainForm.Kabina32);

    equallabels(Main2.Kabina4minuti, MainForm.Kabina4minuti);
    equallabels(Main2.Kabina4cena, MainForm.Kabina4cena);
    equallabels(Main2.Kabina41, MainForm.Kabina41);
    equallabels(Main2.Kabina42, MainForm.Kabina42);

    equallabels(Main2.Kabina5minuti, MainForm.Kabina5minuti);
    equallabels(Main2.Kabina5cena, MainForm.Kabina5cena);
    equallabels(Main2.Kabina51, MainForm.Kabina51);
    equallabels(Main2.Kabina52, MainForm.Kabina52);

    equallabels(Main2.Kabina6minuti, MainForm.Kabina6minuti);
    equallabels(Main2.Kabina6cena, MainForm.Kabina6cena);
    equallabels(Main2.Kabina61, MainForm.Kabina61);
    equallabels(Main2.Kabina62, MainForm.Kabina62);

    equalStatus(Main2.StatusShape1, MainForm.StatusShape1);
    equalStatus(Main2.StatusShape2, MainForm.StatusShape2);
    equalStatus(Main2.StatusShape3, MainForm.StatusShape3);
    equalStatus(Main2.StatusShape4, MainForm.StatusShape4);
    equalStatus(Main2.StatusShape5, MainForm.StatusShape5);
    equalStatus(Main2.StatusShape6, MainForm.StatusShape6);

end;

procedure set3main();
begin
    with MainForm.Kabina1minuti do
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
    with MainForm.Kabina21 do
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
    with MainForm.Kabina22 do
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
    with MainForm.Kabina2cena do
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
    with MainForm.kabina2minuti do
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
    with MainForm.Kabina31 do
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
    with MainForm.Kabina32 do
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
    with MainForm.Kabina3cena do
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
    with MainForm.Kabina3minuti do
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
    with MainForm.Kabina11 do
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
    with MainForm.Kabina12 do
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
    with MainForm.Kabina1cena do
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
    with MainForm.Imagepress1 do
    begin
        Left := 67;
        Top := 99;
        Width := 235;
        Height := 235;
    end;
    with MainForm.Imagepress2 do
    begin
        Left := 507;
        Top := 99;
        Width := 235;
        Height := 235;
    end;
    with MainForm.Imagepress3 do
    begin
        Left := 289;
        Top := 243;
        Width := 235;
        Height := 235;
    end;
    with MainForm.Imagesol1 do
    begin
        Left := 104;
        Top := 160;
        Width := 161;
        Height := 113;
    end;
    with MainForm.Imagesol2 do
    begin
        Left := 543;
        Top := 160;
        Width := 161;
        Height := 112;
    end;
    with MainForm.Imagesol3 do
    begin
        Left := 325;
        Top := 303;
        Width := 162;
        Height := 115;
    end;

    with MainForm.StatusShape1 do
    begin
        Left := 149;
        Top := 178;
        Width := 80;
        Height := 80;
    end;
    with MainForm.StatusShape3 do
    begin
        Left := 370;
        Top := 319;
        Width := 80;
        Height := 80;
    end;
    with MainForm.StatusShape2 do
    begin
        Left := 587;
        Top := 178;
        Width := 80;
        Height := 80;
    end;
    with MainForm do
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
end;

procedure set4main();
begin
    with MainForm.Kabina3Minuti do
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
    with MainForm.Kabina3cena do
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
    with MainForm.Kabina32 do
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
    with MainForm.Kabina31 do
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
    with MainForm.Kabina2minuti do
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
    with MainForm.Kabina41 do
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
    with MainForm.Kabina42 do
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
    with MainForm.Kabina4cena do
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
    with MainForm.Kabina4minuti do
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
    with MainForm.Kabina11 do
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
    with MainForm.Kabina12 do
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
    with MainForm.Kabina1cena do
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
    with MainForm.Kabina1minuti do
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
    with MainForm.Kabina21 do
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
    with MainForm.Kabina22 do
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
    with MainForm.Kabina2cena do
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
    with MainForm.Imagepress1 do
    begin
        Left := 62;
        Top := 90;
        Width := 230;
        Height := 230;
    end;
    with MainForm.Imagepress2 do
    begin
        Left := 366;
        Top := 90;
        Width := 230;
        Height := 230;
    end;
    with MainForm.Imagepress3 do
    begin
        Left := 214;
        Top := 276;
        Width := 230;
        Height := 230;
    end;
    with MainForm.Imagepress4 do
    begin
        Left := 518;
        Top := 276;
        Width := 230;
        Height := 230;
    end;
    with MainForm.Imagesol1 do
    begin
        Left := 98;
        Top := 149;
        Width := 160;
        Height := 110;
    end;
    with MainForm.Imagesol2 do
    begin
        Left := 402;
        Top := 149;
        Width := 160;
        Height := 110;
    end;
    with MainForm.Imagesol3 do
    begin
        Left := 251;
        Top := 333;
        Width := 160;
        Height := 110;
    end;
    with MainForm.Imagesol4 do
    begin
        Left := 555;
        Top := 333;
        Width := 160;
        Height := 110;
    end;
    with MainForm.StatusShape4 do
    begin
        Left := 600;
        Top := 348;
        Width := 75;
        Height := 75;
    end;
    with MainForm.StatusShape3 do
    begin
        Left := 293;
        Top := 348;
        Width := 75;
        Height := 75;
    end;
    with MainForm.StatusShape2 do
    begin
        Left := 446;
        Top := 163;
        Width := 75;
        Height := 75;
    end;
    with MainForm.StatusShape1 do
    begin
        Left := 135;
        Top := 163;
        Width := 75;
        Height := 75;
    end;
    with MainForm do
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
end;

procedure set2main();
begin
    with MainForm.statusShape1 do
    begin
        Left := 189;
        Top := 234;
        Width := 90;
        Height := 90;
    end;
    with MainForm.StatusShape2 do
    begin
        Left := 525;
        Top := 234;
        Width := 90;
        Height := 90;
    end;
    with MainForm.Kabina11 do
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
    with MainForm.Kabina12 do
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
    with MainForm.Kabina1cena do
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
    with MainForm.Kabina1minuti do
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
    with MainForm.Kabina21 do
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
    with MainForm.Kabina22 do
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
    with MainForm.Kabina2cena do
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
    with MainForm.Kabina2minuti do
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
    with MainForm.Imagesol2 do
    begin
        Left := 464;
        Top := 208;
        Width := 201;
        Height := 145;
    end;
    with MainForm.Imagesol1 do
    begin
        Left := 135;
        Top := 207;
        Width := 201;
        Height := 145;
    end;
    with MainForm.Imagepress2 do
    begin
        Left := 408;
        Top := 112;
        Width := 321;
        Height := 329;
    end;
    with MainForm.Imagepress1 do
    begin
        Left := 72;
        Top := 112;
        Width := 313;
        Height := 329;
    end;
    with MainForm do
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

end;

procedure set5main();
begin

    with MainForm.StatusShape1 do
    begin
        Left := 130;
        Top := 156;
        Width := 70;
        Height := 70;
    end;
    with MainForm.StatusShape2 do
    begin
        Left := 360;
        Top := 156;
        Width := 70;
        Height := 70;
    end;
    with MainForm.StatusShape3 do
    begin
        Left := 590;
        Top := 156;
        Width := 70;
        Height := 70;
    end;
    with MainForm.StatusShape4 do
    begin
        Left := 243;
        Top := 358;
        Width := 70;
        Height := 70;
    end;
    with MainForm.StatusShape5 do
    begin
        Left := 473;
        Top := 358;
        Width := 70;
        Height := 70;
    end;
    with MainForm.Kabina3minuti do
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
    with MainForm.Kabina41 do
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
    with MainForm.Kabina42 do
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
    with MainForm.Kabina4cena do
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
    with MainForm.Kabina4minuti do
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
    with MainForm.Kabina51 do
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
    with MainForm.Kabina52 do
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
    with MainForm.Kabina5cena do
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
    with MainForm.Kabina5minuti do
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
    with MainForm.Kabina11 do
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
    with MainForm.Kabina12 do
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
    with MainForm.Kabina1cena do
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
    with MainForm.Kabina1minuti do
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
    with MainForm.Kabina21 do
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
    with MainForm.Kabina22 do
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
    with MainForm.Kabina2cena do
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
    with MainForm.Kabina2minuti do
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
    with MainForm.Kabina31 do
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
    with MainForm.Kabina32 do
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
    with MainForm.Kabina3cena do
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
    with MainForm.ImagePress1 do
    begin
        Left := 55;
        Top := 80;
        Width := 220;
        Height := 220;
    end;
    with MainForm.Imagepress2 do
    begin
        Left := 285;
        Top := 80;
        Width := 220;
        Height := 220;
    end;
    with MainForm.Imagepress3 do
    begin
        Left := 515;
        Top := 80;
        Width := 220;
        Height := 220;
    end;
    with MainForm.ImagePress4 do
    begin
        Left := 170;
        Top := 286;
        Width := 220;
        Height := 220;
    end;
    with MainForm.ImagePress5 do
    begin
        Left := 400;
        Top := 286;
        Width := 220;
        Height := 220;
    end;
    with MainForm.ImageSol1 do
    begin
        Left := 90;
        Top := 144;
        Width := 149;
        Height := 97;
    end;
    with MainForm.ImageSol2 do
    begin
        Left := 320;
        Top := 144;
        Width := 149;
        Height := 97;
    end;
    with MainForm.ImageSol3 do
    begin
        Left := 550;
        Top := 144;
        Width := 149;
        Height := 97;
    end;
    with MainForm.ImageSol4 do
    begin
        Left := 203;
        Top := 344;
        Width := 149;
        Height := 97;
    end;
    with MainForm.ImageSol5 do
    begin
        Left := 433;
        Top := 344;
        Width := 149;
        Height := 97;
    end;
    with MainForm do
    begin
        //  Image2.picture:=Image22.Picture;
        Kabina61.Visible := False;
        Kabina62.Visible := False;
        Kabina6minuti.Visible := False;
        Kabina6cena.Visible := False;
        Imagepress6.Visible := False;
        Imagesol6.Visible := False;
    end;
end;

end.

