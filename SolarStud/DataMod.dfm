object DM: TDM
  OldCreateOrder = False
  Height = 700
  Width = 600
  object DataSource1: TDataSource
    DataSet = SOLARIUMI
    Left = 16
    Top = 376
  end
  object DataSource2: TDataSource
    AutoEdit = False
    DataSet = Qklienti
    Left = 88
    Top = 376
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
    Left = 16
    Top = 16
  end
  object SOLARIUMI: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    TableName = 'solarium'
    Exclusive = False
    Left = 16
    Top = 96
  end
  object Table3: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'KLIENTNOMER'
        Fields = 'NOMER'
      end
      item
        Name = 'FIRMA'
        Fields = 'FIRMA'
      end>
    FieldDefs = <
      item
        Name = 'NOMER'
        DataType = ftInteger
      end
      item
        Name = 'BLOCKCODE'
        DataType = ftWord
      end
      item
        Name = 'IME'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'TELEFON'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'ADRES'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'BALANS'
        DataType = ftCurrency
      end
      item
        Name = 'FIRMA'
        DataType = ftInteger
      end
      item
        Name = 'RANG'
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'NOMER2'
        DataType = ftSmallint
      end>
    TableName = 'klienti'
    Exclusive = False
    Left = 36
    Top = 663
  end
  object Internet: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    TableName = 'internet'
    Exclusive = False
    Left = 160
    Top = 96
  end
  object DataSource3: TDataSource
    DataSet = Internet
    Left = 160
    Top = 376
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
    Left = 368
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATA_COMBO_SELECTED'
        ParamType = ptUnknown
      end>
  end
  object DataSource5: TDataSource
    DataSet = DayTotal
    Left = 232
    Top = 376
  end
  object Spravka1: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = True
    SQL.Strings = (
      
        'SELECT DATA,SOLARIUM,VREME,CHAS FROM rabota1 WHERE DATA=:DATA_CO' +
        'MBO_SELECTED ORDER BY RECORDID')
    Left = 312
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATA_COMBO_SELECTED'
        ParamType = ptUnknown
      end>
  end
  object STOKI: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    TableName = 'STOKI'
    Exclusive = False
    Left = 232
    Top = 96
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
    Left = 160
    Top = 216
  end
  object DataSource6: TDataSource
    DataSet = KARTI
    Left = 304
    Top = 376
  end
  object DataSource7: TDataSource
    DataSet = STOKITE
    Left = 376
    Top = 376
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
    Left = 232
    Top = 216
  end
  object DataSource8: TDataSource
    DataSet = STOKI
    Left = 448
    Top = 376
  end
  object KARTIALL1: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    TableName = 'KARTIALL'
    Exclusive = False
    Left = 304
    Top = 96
  end
  object DataSource10: TDataSource
    DataSet = Qkarti
    Left = 520
    Top = 376
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
    Left = 248
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SDELKANOMER'
        ParamType = ptUnknown
      end>
  end
  object PlashtaniaTable: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    TableName = 'plashtania'
    Exclusive = False
    Left = 376
    Top = 96
  end
  object DataSource9: TDataSource
    DataSet = Sdelka
    Left = 16
    Top = 416
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
    Left = 376
    Top = 216
  end
  object DataSource11: TDataSource
    DataSet = MinMax
    Left = 88
    Top = 416
  end
  object DataSource12: TDataSource
    DataSet = PlashtaniaTable
    Left = 160
    Top = 416
  end
  object KARTIALL: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    SessionName = 'Default'
    InMemory = False
    ReadOnly = False
    Active = True
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'KlientDet'
        Fields = 'KlientDetail'
      end>
    FieldDefs = <
      item
        Name = 'KARTANOMER'
        DataType = ftInteger
      end
      item
        Name = 'KlientDetail'
        DataType = ftInteger
      end
      item
        Name = 'POSESHTENIA'
        DataType = ftInteger
      end
      item
        Name = 'STARTDATE'
        DataType = ftDate
      end
      item
        Name = 'MINUTINA1'
        DataType = ftInteger
      end>
    TableName = 'KARTIALL'
    Exclusive = False
    Left = 765
    Top = 600
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
    Left = 520
    Top = 96
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
    Left = 16
    Top = 136
  end
  object DataSource13: TDataSource
    DataSet = stokispr
    Left = 232
    Top = 416
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
    Left = 448
    Top = 216
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
    Left = 520
    Top = 216
  end
  object DataSource14: TDataSource
    DataSet = KARTIALL
    Left = 304
    Top = 416
  end
  object QKartiPaid: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = True
    Active = True
    SQL.Strings = (
      'SELECT * FROM Plashtania')
    Left = 16
    Top = 256
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
    Left = 88
    Top = 256
  end
  object DataSource4: TDataSource
    DataSet = QChipKarti
    Left = 376
    Top = 416
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
    Left = 88
    Top = 136
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
    Left = 160
    Top = 256
  end
  object personal1: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    Active = True
    TableName = 'personal'
    Exclusive = False
    Left = 160
    Top = 136
  end
  object personalset: TDataSource
    DataSet = personal1
    Left = 448
    Top = 416
  end
  object DataSource15: TDataSource
    AutoEdit = False
    DataSet = QStatistika
    Left = 520
    Top = 416
  end
  object KARTICHIP: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    SessionName = 'Default'
    InMemory = False
    ReadOnly = False
    Active = True
    StoreDefs = True
    IndexDefs = <
      item
        Name = 'KLIENT'
        Fields = 'KLIENTNOMER'
      end
      item
        Name = 'TEMPORARY_INDEX_{D90E61EF-CCEB-41D2-8727-345EE15658F7}'
        DescFields = 'CHIPNOMER'
        Fields = 'CHIPNOMER'
        Options = [ixDescending]
      end>
    FieldDefs = <
      item
        Name = 'CHIPNOMER'
        DataType = ftInteger
      end
      item
        Name = 'STARTDATE'
        DataType = ftDate
      end
      item
        Name = 'STARTTIME'
        DataType = ftTime
      end
      item
        Name = 'KLIENTNOMER'
        DataType = ftInteger
      end
      item
        Name = 'COUNTER'
        DataType = ftInteger
      end
      item
        Name = 'DISCOUNT'
        DataType = ftCurrency
      end
      item
        Name = 'SUMA'
        DataType = ftCurrency
      end
      item
        Name = 'ENDDATE'
        DataType = ftDate
      end
      item
        Name = 'ONCE_PERDAY'
        DataType = ftBoolean
      end>
    TableName = 'KARTICHIP'
    Exclusive = False
    Left = 324
    Top = 687
  end
  object DataSource16: TDataSource
    DataSet = KARTICHIP
    Left = 16
    Top = 456
  end
  object maxday: TABSQuery
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = True
    SQL.Strings = (
      'select max(data) as maxdata from plashtania')
    Left = 232
    Top = 256
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
    Left = 304
    Top = 256
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
    Left = 304
    Top = 136
  end
  object DataSource17: TDataSource
    DataSet = CENITABLE
    Left = 88
    Top = 456
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
    Left = 376
    Top = 256
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
    Left = 448
    Top = 256
  end
  object DataSource18: TDataSource
    DataSet = USLUGITE
    Left = 160
    Top = 456
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
    Left = 520
    Top = 256
  end
  object DataSource19: TDataSource
    DataSet = Firmite
    Left = 232
    Top = 456
  end
  object Planner: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    TableName = 'PLANNER'
    Exclusive = False
    Left = 376
    Top = 136
  end
  object DataSource20: TDataSource
    DataSet = Planner
    Left = 304
    Top = 456
  end
  object DBDaySource1: TDBDaySource
    AutoIncKey = False
    DataSource = DataSource20
    ResourceMap = <
      item
        ResourceIndex = 0
        PositionIndex = -1
      end>
    ReadOnly = False
    UpdateByQuery = False
    DateFormat = 'mm/dd/yyyy'
    Mode = dmMultiDay
    Left = 152
    Top = 16
  end
  object DBDaySource2: TDBDaySource
    AutoIncKey = False
    DataSource = DataSource21
    ResourceMap = <
      item
        ResourceIndex = 0
        PositionIndex = 0
        DisplayName = #1057#1086#1083#1072#1088#1080#1091#1084
      end>
    ReadOnly = False
    UpdateByQuery = False
    DateFormat = 'mm/dd/yyyy'
    Mode = dmMultiDay
    Left = 88
    Top = 16
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
    Left = 160
    Top = 576
  end
  object PLANNER02: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    TableName = 'PLANNER'
    Exclusive = False
    Left = 448
    Top = 136
  end
  object DataSource21: TDataSource
    DataSet = PLANNER02
    Left = 376
    Top = 456
  end
  object PLANNER03: TABSTable
    CurrentVersion = '6.02 '
    DatabaseName = 'sol1'
    InMemory = False
    ReadOnly = False
    TableName = 'PLANNER'
    Exclusive = False
    Left = 520
    Top = 136
  end
  object DataSource22: TDataSource
    DataSet = PLANNER03
    Left = 448
    Top = 456
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
    Left = 16
    Top = 296
  end
  object DataSource23: TDataSource
    DataSet = STOKITE_SKLAD
    Left = 520
    Top = 456
  end
  object DataSource24: TDataSource
    DataSet = QCeni
    Left = 16
    Top = 496
  end
end
