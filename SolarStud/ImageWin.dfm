object ImageForm: TImageForm
  Left = 268
  Height = 300
  Top = 256
  Width = 490
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
  LCLVersion = '1.6.4.0'
  object Bevel1: TBevel
    Left = 316
    Height = 156
    Top = 5
    Width = 171
  end
  object Label1: TLabel
    Left = 328
    Height = 13
    Top = 8
    Width = 38
    Caption = 'Preview'
    ParentColor = False
  end
  object FileEdit: TEdit
    Left = 166
    Height = 21
    Top = 13
    Width = 139
    OnKeyPress = FileEditKeyPress
    TabOrder = 0
    Text = '*.bmp;*.jpg'
  end
  object Panel1: TPanel
    Left = 324
    Height = 118
    Top = 27
    Width = 153
    BevelInner = bvLowered
    ClientHeight = 118
    ClientWidth = 153
    TabOrder = 5
    object Image1: TImage
      Left = 2
      Height = 114
      Top = 2
      Width = 149
      Align = alClient
      Proportional = True
      Stretch = True
    end
  end
  object FileListBox1: TFileListBox
    Left = 166
    Height = 227
    Top = 41
    Width = 139
    Directory = 'D:\lazarus'
    ItemHeight = 0
    Mask = '*.bmp;*.jpg'
    OnClick = FileListBox1Click
    TabOrder = 1
  end
  object FilterComboBox1: TFilterComboBox
    Left = 166
    Height = 21
    Top = 275
    Width = 140
    Filter = 'images (*.bmp; jpg)|*.bmp;*.jpg|All files (*.*)|*.*'
    ItemIndex = 0
    TabOrder = 3
  end
  object Button1: TButton
    Left = 344
    Height = 33
    Top = 256
    Width = 89
    Caption = 'OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 344
    Height = 33
    Top = 200
    Width = 89
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object ShellTreeView1: TShellTreeView
    Left = 16
    Height = 281
    Top = 13
    Width = 145
    FileSortType = fstNone
    TabOrder = 6
    ObjectTypes = [otFolders]
  end
end
