object ImageForm: TImageForm
  Left = 268
  Top = 256
  ActiveControl = FileEdit
  Align = alCustom
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  BorderWidth = 2
  Caption = 'Image Viewer'
  ClientHeight = 300
  ClientWidth = 490
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 316
    Top = 5
    Width = 171
    Height = 156
  end
  object Label1: TLabel
    Left = 328
    Top = 8
    Width = 38
    Height = 13
    Caption = 'Preview'
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 12
    Width = 148
    Height = 260
    FileList = FileListBox1
    IntegralHeight = True
    ItemHeight = 16
    TabOrder = 1
  end
  object DriveComboBox1: TDriveComboBox
    Left = 9
    Top = 277
    Width = 148
    Height = 19
    DirList = DirectoryListBox1
    TabOrder = 3
  end
  object FileEdit: TEdit
    Left = 166
    Top = 13
    Width = 139
    Height = 21
    TabOrder = 0
    Text = '*.bmp;*.jpg'
    OnKeyPress = FileEditKeyPress
  end
  object Panel1: TPanel
    Left = 324
    Top = 27
    Width = 153
    Height = 118
    BevelInner = bvLowered
    TabOrder = 5
    object Image1: TImage
      Left = 2
      Top = 2
      Width = 149
      Height = 114
      Align = alClient
      Proportional = True
      Stretch = True
    end
  end
  object FileListBox1: TFileListBox
    Left = 166
    Top = 41
    Width = 139
    Height = 227
    FileEdit = FileEdit
    ItemHeight = 13
    Mask = '*.bmp;*.jpg'
    TabOrder = 2
    OnClick = FileListBox1Click
  end
  object FilterComboBox1: TFilterComboBox
    Left = 166
    Top = 275
    Width = 140
    Height = 21
    FileList = FileListBox1
    Filter = 'images (*.bmp; jpg)|*.bmp;*.jpg|All files (*.*)|*.*'
    TabOrder = 4
  end
  object Button1: TButton
    Left = 344
    Top = 256
    Width = 89
    Height = 33
    Caption = 'OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 6
  end
  object Button2: TButton
    Left = 344
    Top = 200
    Width = 89
    Height = 33
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 7
  end
end
