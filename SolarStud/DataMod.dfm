object DM: TDM
  OldCreateOrder = False
  Left = 192
  Top = 107
  Height = 480
  Width = 696
  object DataSource1: TDataSource
    DataSet = SOLARIUMI
    Left = 4
    Top = 630
  end
  object DataSource2: TDataSource
    AutoEdit = False
    DataSet = Qklienti
    Left = 68
    Top = 655
  end
  object sol1: TABSDatabase
    Connected = True
    CurrentVersion = '6.02 '
    DatabaseFileName = '\SolarStudio1\data\solarbas.ABS'
    DatabaseName = 'sol1'
    Exclusive = False
    HandleShared = True
    MaxConnections = 500
    MultiUser = False
    SessionName = 'Default'
    Left = 261
    Top = 599
  end
  object SOLARIUMI: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    TableName = 'solarium'
    Exclusive = False
    Left = 4
    Top = 663
  end
  object Table3: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    StoreDefs = True
    TableName = 'klienti'
    Exclusive = False
    Left = 36
    Top = 663
    IndexDefs = <
      item
        Name = 'KLIENTNOMER'
        Fields = 'NOMER'
      end
    >
  end
  object Internet: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    TableName = 'internet'
    Exclusive = False
    Left = 380
    Top = 655
  end
  object DataSource3: TDataSource
    DataSet = Internet
    Left = 444
    Top = 655
  end
  object DayTotal: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = True
    SQL.Strings = (
      
      'SELECT * FROM Plashtania  LEFT OUTER join STOKI ON Plashtania.ST' +
      'OKA=STOKI.STOKAKOD'
      ' WHERE DATA = :DATA_COMBO_SELECTED ORDER BY :ORDERPARAM ASC')
    Left = 164
    Top = 656
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATA_COMBO_SELECTED'
        ParamType = ptUnknown
      end
    >
  end
  object DataSource5: TDataSource
    DataSet = DayTotal
    Left = 196
    Top = 656
  end
  object Spravka1: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = True
    SQL.Strings = (
      
      'SELECT DATA,SOLARIUM,VREME,CHAS FROM rabota1 WHERE DATA=:DATA_CO' +
      'MBO_SELECTED ORDER BY RECORDID')
    Left = 260
    Top = 656
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATA_COMBO_SELECTED'
        ParamType = ptUnknown
      end
    >
  end
  object STOKI: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    TableName = 'STOKI'
    Exclusive = False
    Left = 293
    Top = 600
  end
  object KARTI: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM STOKI WHERE STOKAKOD < 0')
    Left = 437
    Top = 728
  end
  object DataSource6: TDataSource
    DataSet = KARTI
    Left = 469
    Top = 728
  end
  object DataSource7: TDataSource
    DataSet = STOKITE
    Left = 533
    Top = 720
  end
  object STOKITE: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    RequestLive = True
    SQL.Strings = (
      'SELECT *  FROM STOKI WHERE STOKAKOD > 0 ORDER BY STOKAKOD')
    Left = 501
    Top = 720
  end
  object DataSource8: TDataSource
    DataSet = STOKI
    Left = 325
    Top = 600
  end
  object KARTIALL1: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    TableName = 'KARTIALL'
    Exclusive = False
    Left = 485
    Top = 600
  end
  object DataSource10: TDataSource
    DataSet = Qkarti
    Left = 517
    Top = 600
  end
  object Sdelka: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    SessionName = 'Default'
    InMemory = False
    ReadOnly = False
    RequestLive = True
    SQL.Strings = (
      
      'SELECT* FROM plashtania WHERE RECORDID>:SDELKANOMER ORDER BY STO' +
      'KA')
    Left = 581
    Top = 600
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SDELKANOMER'
        ParamType = ptUnknown
      end
    >
  end
  object PlashtaniaTable: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    TableName = 'plashtania'
    Exclusive = False
    Left = 549
    Top = 600
  end
  object DataSource9: TDataSource
    DataSet = Sdelka
    Left = 613
    Top = 600
  end
  object MinMax: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    SessionName = 'Default'
    InMemory = False
    ReadOnly = True
    Active = True
    SQL.Strings = (
      'SELECT* FROM plashtania ')
    Left = 653
    Top = 600
  end
  object DataSource11: TDataSource
    DataSet = MinMax
    Left = 685
    Top = 600
  end
  object DataSource12: TDataSource
    DataSet = PlashtaniaTable
    Left = 629
    Top = 672
  end
  object KARTIALL: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    SessionName = 'Default'
    InMemory = False
    ReadOnly = False
    Active = True
    StoreDefs = True
    TableName = 'KARTIALL'
    Exclusive = False
    Left = 765
    Top = 600
    IndexDefs = <
      item
        Name = 'KlientDet'
        Fields = 'KlientDetail'
      end
    >
    FieldDefs = <
      item
        Name = 'KARTANOMER'
        DataType = ftInteger
      end
    >
  end
  object solariumspr: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    SessionName = 'Default'
    InMemory = False
    ReadOnly = False
    Active = True
    IndexName = 'solariumnomer'
    TableName = 'solarium'
    Exclusive = False
    MasterFields = 'SOLARIUM'
    MasterSource = DataSource5
    Left = 292
    Top = 655
  end
  object stokispr: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    SessionName = 'Default'
    InMemory = False
    ReadOnly = False
    Active = True
    IndexName = 'stokanomer'
    TableName = 'STOKI'
    Exclusive = False
    MasterFields = 'STOKA'
    MasterSource = DataSource5
    Left = 100
    Top = 656
  end
  object DataSource13: TDataSource
    DataSet = stokispr
    Left = 132
    Top = 656
  end
  object Qklienti: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = True
    Active = True
    RequestLive = True
    SQL.Strings = (
      
      'SELECT * FROM klienti k left outer join KARTICHIP c on k.NOMER =' +
      ' c.KLIENTNOMER WHERE k.NOMER >-1 ORDER BY k.nomer')
    Left = 476
    Top = 656
  end
  object Qkarti: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM kartiall ORDER BY kartanomer')
    Left = 508
    Top = 656
  end
  object DataSource14: TDataSource
    DataSet = KARTIALL
    Left = 725
    Top = 608
  end
  object QKartiPaid: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = True
    Active = True
    SQL.Strings = (
      'SELECT * FROM Plashtania')
    Left = 228
    Top = 656
  end
  object QChipKarti: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM KARTICHIP ORDER BY CHIPNOMER DESC')
    Left = 540
    Top = 656
  end
  object DataSource4: TDataSource
    DataSet = QChipKarti
    Left = 36
    Top = 696
  end
  object CHIPKARTI: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    SessionName = 'Default'
    InMemory = False
    ReadOnly = False
    Active = True
    TableName = 'CHIPKARTI'
    Exclusive = False
    Left = 324
    Top = 655
  end
  object QStatistika: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    SessionName = 'Default'
    InMemory = False
    ReadOnly = True
    Active = True
    RequestLive = True
    SQL.Strings = (
      
      'SELECT STOKA AS STOKA1, CAST((BROI)*0.0167 AS CURRENCY)AS BROI1,' +
      ' '
      '(STOKA) AS SOLARIUM1, DATA AS DATA1, TOSTRING(DATA,"DD/M") AS '
      'WEEKDAY FROM PLASHTANIA WHERE (SOLARIUM > 0)  order by data')
    Left = 669
    Top = 672
  end
  object personal1: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    TableName = 'personal'
    Exclusive = False
    Left = 725
    Top = 640
  end
  object personalset: TDataSource
    DataSet = personal1
    Left = 722
    Top = 676
  end
  object DataSource15: TDataSource
    AutoEdit = False
    DataSet = QStatistika
    Left = 725
    Top = 712
  end
  object KARTICHIP: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    SessionName = 'Default'
    InMemory = False
    ReadOnly = False
    Active = True
    StoreDefs = True
    TableName = 'KARTICHIP'
    Exclusive = False
    Left = 324
    Top = 687
    IndexDefs = <
      item
        Name = 'KLIENT'
        Fields = 'KLIENTNOMER'
      end
    >
  end
  object DataSource16: TDataSource
    DataSet = KARTICHIP
    Left = 356
    Top = 687
  end
  object maxday: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = True
    SQL.Strings = (
      'select max(data) as maxdata from plashtania')
    Left = 196
    Top = 696
  end
  object Plashtania: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM plashtania ORDER BY recordid')
    Left = 572
    Top = 656
  end
  object CENITABLE: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    IndexName = 'a1'
    TableName = 'TABLICA_CENI'
    Exclusive = False
    MasterFields = 'SOLARIUM'
    MasterSource = DataSource1
    Left = 413
    Top = 688
  end
  object DataSource17: TDataSource
    DataSet = CENITABLE
    Left = 114
    Top = 780
  end
  end
  object QCeni: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM TABLICA_CENI')
    Left = 10
    Top = 780
  end
  end
  object USLUGITE: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM STOKI WHERE STOKATIP = "U"')
    Left = 581
    Top = 720
  end
  object DataSource18: TDataSource
    DataSet = USLUGITE
    Left = 621
    Top = 720
  end
  object Firmite: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    RequestLive = True
    SQL.Strings = (
      'select * from FIRMI order by NOMER')
    Left = 325
    Top = 728
  end
  object DataSource19: TDataSource
    DataSet = Firmite
    Left = 357
    Top = 728
  end
  object Planner: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    TableName = 'PLANNER'
    Exclusive = False
    Left = 4
    Top = 735
  end
  object DataSource20: TDataSource
    DataSet = Planner
    Left = 36
    Top = 736
  end
  object DBDaySource1: TDBDaySource
    AutoIncKey = False
    DataSource = DataSource20
    ResourceMap = <
      item
        ResourceIndex = 0
        PositionIndex = -1
      end
    >
  end
  object DBDaySource2: TDBDaySource
    AutoIncKey = False
    DataSource = DataSource21
    ResourceMap = <
      item
        ResourceIndex = 0
        PositionIndex = 0
        DisplayName = #1057#1086#1083#1072#1088#1080#1091#1084
      end
    >
  end
  object DBDaySource3: TDBDaySource
    AutoIncKey = False
    DataSource = DataSource22
    ResourceMap = <>
    StartTimeField = 'START'
    EndTimeField = 'END'
    KeyField = 'KEY'
    ReadOnly = False
    ResourceField = 'resource'
    SubjectField = 'subject'
    NotesField = 'NOTES'
    UpdateByQuery = True
    AutoHeaderUpdate = True
    DateFormat = 'mm/dd/yyyy'
    Mode = dmMultiResDay
    NumberOfDays = 1
    NumberOfResources = 7
    Left = 136
    Top = 736
  end
  object PLANNER02: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    TableName = 'PLANNER'
    Exclusive = False
    Left = 172
    Top = 735
  end
  object DataSource21: TDataSource
    DataSet = PLANNER02
    Left = 204
    Top = 736
  end
  object PLANNER03: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    TableName = 'PLANNER'
    Exclusive = False
    Left = 244
    Top = 735
  end
  object DataSource22: TDataSource
    DataSet = PLANNER03
    Left = 276
    Top = 736
  end
  object STOKITE_SKLAD: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = True
    Active = True
    RequestLive = True
    SQL.Strings = (
      'SELECT STOKAIME,'
      '  STOKAKOD,'
      '  STOKANASKLAD,'
      '  SUMA,'
      '  SUMA * STOKANASKLAD as STOKATOTAL_IN,'
      '  STOKACENA,'
      '  STOKACENA * STOKANASKLAD as STOKATOTAL_SELL, '
      '  POSESHTENIA,'
      '  STOKATIP,'
      '  STOKACENACARD'
      '  FROM STOKI WHERE STOKATIP = "S"'
      '  ORDER BY STOKAKOD')
    Left = 501
    Top = 752
  end
  object DataSource23: TDataSource
    DataSet = STOKITE_SKLAD
    Left = 533
    Top = 752
  end
  object DataSource24: TDataSource
    DataSet = QCeni
    Left = 162
    Top = 780
  end
end