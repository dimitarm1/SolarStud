object statistikatest: Tstatistikatest
  Left = 192
  Top = 107
  Width = 870
  Height = 746
  Caption = 'statistikatest'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object TeeCommander1: TTeeCommander
    Left = 0
    Top = 0
    Width = 862
    Height = 57
    Align = alTop
    ParentShowHint = False
    TabOrder = 0
  end
  object Chart1: TChart
    Left = 136
    Top = 80
    Width = 577
    Height = 409
    Legend.LegendStyle = lsSeries
    Title.Text.Strings = (
      'TChart')
    TabOrder = 1
    object Series1: TBarSeries
      Depth = 0
      Marks.Callout.Brush.Color = clBlack
      Marks.Visible = False
      DataSource = DBCrossTabSource1
      Gradient.Direction = gdTopBottom
      XValues.DateTime = True
      XValues.Name = 'X'
      XValues.Order = loNone
      YValues.Name = 'Bar'
      YValues.Order = loNone
      Data = {
        0407000000AB11A5BDC1873740013106E561A1D61438400132BED100DE02B933
        400133D254C1A8A44E34400134862F4CA60A163240013505075F984CE5364001
        3608098A1F63CE33400137}
    end
  end
  object DBGrid1: TDBGrid
    Left = 152
    Top = 504
    Width = 561
    Height = 161
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 256
    Top = 672
    Width = 200
    Height = 25
    DataSource = DataSource1
    TabOrder = 3
  end
  object Button1: TButton
    Left = 760
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 4
    OnClick = Button1Click
  end
  object ABSDatabase1: TABSDatabase
    Connected = True
    CurrentVersion = '5.04 '
    DatabaseFileName = 'F:\SolarStudio1\data\solarbas.ABS'
    DatabaseName = 'sol1'
    Exclusive = False
    MaxConnections = 500
    MultiUser = False
    SessionName = 'Default'
    Left = 144
    Top = 24
  end
  object ABSTable1: TABSTable
    CurrentVersion = '5.04 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    TableName = 'plashtania'
    Exclusive = False
    Left = 192
    Top = 24
  end
  object DataSource1: TDataSource
    DataSet = ABSQuery2
    Left = 264
    Top = 40
  end
  object DBCrossTabSource1: TDBCrossTabSource
    Active = True
    CaseSensitive = False
    DataSet = ABSQuery2
    GroupField = 'STOKA'
    LabelField = 'WEEKDAY'
    Series = Series1
    ValueField = 'BROI1'
  end
  object ABSQuery1: TABSQuery
    CurrentVersion = '5.04 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = True
    Active = True
    SQL.Strings = (
      
        'SELECT * FROM PLASHTANIA WHERE (DATA BETWEEN '#39'01/05/2006'#39' AND '#39'0' +
        '7/05/2006'#39') AND SOLARIUM >0')
    Left = 112
    Top = 24
  end
  object ABSQuery2: TABSQuery
    CurrentVersion = '5.04 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = True
    Active = True
    SQL.Strings = (
      
        ' (SELECT STOKA, CAST(BROI*0.0167 AS CURRENCY)  AS BROI1, SOLARIU' +
        'M, DATA , TOSTRING(DATA,"DW") AS WEEKDAY FROM PLASHTANIA WHERE (' +
        'DATA BETWEEN '#39'15/04/2006'#39' AND '#39'29/05/2006'#39') AND SOLARIUM BETWEEN' +
        ' 1 AND 6) '
      'ORDER BY WEEKDAY')
    Left = 32
    Top = 104
  end
  object ABSQuery3: TABSQuery
    CurrentVersion = '5.04 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = True
    Active = True
    SQL.Strings = (
      
        ' (SELECT CAST(BROI*0.0167 AS CURRENCY)  AS BROI1, SOLARIUM, DATA' +
        '  FROM PLASHTANIA WHERE (DATA BETWEEN '#39'01/05/2006'#39' AND '#39'07/05/20' +
        '06'#39') AND SOLARIUM =1) '
      'UNION'
      
        ' (SELECT CAST(BROI*0.0167 AS CURRENCY)  AS BROI1, SOLARIUM, DATA' +
        '  FROM PLASHTANIA WHERE (DATA BETWEEN '#39'01/05/2006'#39' AND '#39'07/05/20' +
        '06'#39') AND SOLARIUM =2) ')
    Left = 32
    Top = 144
  end
end
