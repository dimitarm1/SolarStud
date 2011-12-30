unit ImageWin;

interface

uses Windows, Classes, Graphics, Forms, Controls,
  FileCtrl, StdCtrls, ExtCtrls, Buttons, Spin, ComCtrls, Dialogs;

type
  TImageForm = class(TForm)
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1   : TDriveComboBox;
    FileEdit         : TEdit;
    Panel1           : TPanel;
    Image1           : TImage;
    FileListBox1     : TFileListBox;
    Bevel1           : TBevel;
    FilterComboBox1  : TFilterComboBox;
    Button1          : TButton;
    Button2          : TButton;
    Label1           : TLabel;
    procedure FileListBox1Click(Sender: TObject);
    procedure ViewBtnClick     (Sender: TObject);
    procedure ViewAsGlyph      (const FileExt: string);
    procedure GlyphCheckClick  (Sender: TObject);
    procedure StretchCheckClick(Sender: TObject);
    procedure FileEditKeyPress (Sender: TObject; var Key: Char);
    procedure UpDownEditChange (Sender: TObject);
    procedure FormCreate       (Sender: TObject);
  private
    FormCaption: string;    
  end;

var
  ImageForm: TImageForm;
 // MainForm.ImageName: String;

implementation

uses  SysUtils, MAIN;   //ViewWin,

{$R *.dfm}

procedure TImageForm.FileListBox1Click(Sender: TObject);
var
  FileExt: string[4];
begin
  FileExt := AnsiUpperCase(ExtractFileExt(FileListBox1.Filename));
  if (FileExt = '.BMP')  or  (FileExt = '.JPG') then
  begin
    Image1.Picture.LoadFromFile(FileListBox1.Filename);
    ImageName:= FileListBox1.Filename;
    Caption  := FormCaption + ExtractFilename(FileListBox1.Filename);
    if (FileExt = '.BMP') or (FileExt = '.JPG')then
     begin
      Caption := Caption +
        Format(' (%d x %d)', [Image1.Picture.Width, Image1.Picture.Height]);
     //  ViewForm.Image1.Picture := Image1.Picture;
      Button1.Enabled:=True;
     end;

   end
  else
  //Button1.Enabled:=False;
end;

procedure TImageForm.GlyphCheckClick(Sender: TObject);
begin
 // ViewAsGlyph(AnsiUpperCase(ExtractFileExt(FileListBox1.Filename)));
end;

procedure TImageForm.ViewAsGlyph(const FileExt: string);
begin
 // if GlyphCheck.Checked and (FileExt = '.BMP') then
 // begin
 //   SpeedButton1.Glyph := Image1.Picture.Bitmap;
 //   SpeedButton2.Glyph := Image1.Picture.Bitmap;
 //   UpDown1.Position := SpeedButton1.NumGlyphs;
  //  BitBtn1.Glyph := Image1.Picture.Bitmap;
  //  BitBtn2.Glyph := Image1.Picture.Bitmap;
 // end
 /// else begin
  //  SpeedButton1.Glyph := nil;
  //  SpeedButton2.Glyph := nil;
   // BitBtn1.Glyph := nil;
  //  BitBtn2.Glyph := nil;
 // end;
//  UpDown1.Enabled := GlyphCheck.Checked;
 // UpDownEdit.Enabled := GlyphCheck.Checked;
 // Label2.Enabled := GlyphCheck.Checked;
end;

procedure TImageForm.ViewBtnClick(Sender: TObject);
begin
  //ViewForm.HorzScrollBar.Range := Image1.Picture.Width;
 // ViewForm.VertScrollBar.Range := Image1.Picture.Height;
//  ViewForm.Caption := Caption;
 // ViewForm.Show;
 // ViewForm.WindowState := wsNormal;
end;

procedure TImageForm.UpDownEditChange(Sender: TObject);
resourcestring
  sMinValue = 'Value below minimum';
  sMaxValue = 'Value over maximum';

begin
 // if (StrToInt(UpDownEdit.Text) < UpDown1.Min) then
//  begin
  //  UpDownEdit.Text := '1';
  //  raise ERangeError.Create(sMinValue);
 // end
 // else if (StrToInt(UpDownEdit.Text) > UpDown1.Max) then
//  begin
  //  UpDownEdit.Text := '4';
  //  raise ERangeError.Create(sMaxValue);
 // end;

//  SpeedButton1.NumGlyphs := UpDown1.Position;
//  SpeedButton2.NumGlyphs := UpDown1.Position;
end;

procedure TImageForm.StretchCheckClick(Sender: TObject);
begin
 // Image1.Stretch := StretchCheck.Checked;
end;

procedure TImageForm.FileEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    FileListBox1.ApplyFilePath(FileEdit.Text);
    Key := #0;
  end;
end;

procedure TImageForm.FormCreate(Sender: TObject);
begin
  FormCaption := Caption + ' - ';
 // UpDown1.Min := 1;
 // UpDown1.Max := 4;
end;

end.
