unit Checkdatabase;

interface
     uses Classes, Variants, SysUtils, Dialogs, Forms, Windows, DB,  AbsMain, AbsTypes;
     function Do_checkdatabase():boolean;
implementation
     uses  main;

function Do_checkdatabase() : boolean;
var
  Database   : TAbsDatabase;
  q1         : TAbsQuery;
  tables     : TStringList;
  _Q,_Q2     : TABSQuery;
  Cena1      : real;
  i1,i2      : integer;
  DBOK1      : boolean;
  dialog     : TOpenDialog;
  DBFileName : string ;
  DBVer      : integer;
  Const DataBaseName = '\SolarStudio1\data\Solarbas.abs';
  Const CurrentDBVer = 3;
  label endprogram;

    procedure ExecSQL(_SQLText : string);
    begin
      _Q.ReadOnly:=False;
      _Q.RequestLive:=True;
      _Q.SQL.Text := _SQLText;
      _Q.ExecSQL;
      _Q.Close;
    end;

    function GetDBVer (): integer;
    var Q: TABSQuery;
      Ver: Variant;
    begin
      if (tables.IndexOf('PARAMS')<0) and (tables.IndexOf('PARAMS')<0) then result := 0
      else begin
        Q := TABSQuery.Create(nil);
        Q.DatabaseName:='sol';
        Q.SQL.Text := 'SELECT * FROM PARAMS';
        Q.Active   := true;
        if not Q.Locate('KEY',VarArrayOf(['DBVer']),[]) then result := 3
        else begin
          Ver := Q.FieldValues['VALUE'];
          if Ver = null  then result := 3
          else result := Ver;
        end;
        Q.Close;
        Q.Free;
      end;
    end;

    function SetDBVer (Ver:Integer): boolean;
    var Q: TABSQuery;
    begin
      Q := TABSQuery.Create(nil);
      Q.DatabaseName:='sol';
      Q.ReadOnly := false;
      Q.RequestLive := true;
      Database.ReadOnly := false;
      Q.SQL.Text := 'SELECT * FROM PARAMS';
      Q.Active   := true;
      if not Q.Locate('KEY', 'DBVer',[]) then begin
        Q.Append;
        Q.FieldValues['KEY'] := 'DBVer';
      end else Q.Edit;
      Q.FieldValues['VALUE'] := IntToStr(Ver);
      Q.Post;
      Q.Close;
      Q.Free;
    end;
begin
  result:= true;
  DBFileName := ExtractFileDrive(Paramstr(0)) + DataBaseName ; // Извлича драйва от командните параметри и името на EXE-то
  DBOK1    := false;
  tables   := TStringList.Create;
  Database := TAbsDatabase.Create(nil);
  Database.Name:='sol';
  Database.DatabaseName:='sol';
  Database.DatabaseFileName := DBFileName;
  _Q :=TABSQuery.Create(nil);
  _Q.DatabaseName:='sol';
  _Q2:=TABSQuery.Create(nil);
  _Q2.DatabaseName:='sol';

  while not DBOK1 do
    begin
      if not FileExists(DBFileName) then  begin
        if  Application.MessageBox(PChar('Базата данни не е открита. Да създам ли нова база?'),PChar(''), MB_YESNO) = 6 then begin // 6= yes, 7=no
         Database.CreateDatabase;
        end else begin
          dialog :=  TOpenDialog.Create(nil);
          dialog.Filter := '*.abs';
          dialog.Title  := 'Възстановяване от архив';
          if not dialog.Execute or (dialog.Files.Count = 0) then begin
            Application.Terminate;
            result := false;
            goto endprogram;
          end else begin
            result:=CopyFIle(PChar(dialog.Files[0]),PChar(DBFileName),False);
          end;
        end;
      end;
      try
        Database.Connected:=true;
        DBOK1 := Database.Connected;
      except
      end;
    end;
  if not Database.Connected then  Application.Terminate;
  Database.GetTablesList(tables);
  if ( tables.Count < 1 ) then
  begin

    ExecSQL(' CREATE TABLE CHIPKARTI (            '+
            ' KARTANOMER AUTOINCINTEGER DEFAULT 0,'+
            ' STARTDATE DATE,                     '+
            ' BALANS CURRENCY DEFAULT 0,          '+
            ' ENDDATE DATE,                       '+
            ' KLIENTNOMER INTEGER DEFAULT 0,      '+
            ' INDEX karta (KARTANOMER))           ');

    ExecSQL(' CREATE TABLE HAPPYHOUR ( '+
            ' SOLARIUM SMALLINT,       '+
            ' DENOTSEDM SMALLINT,      '+
            ' NACH_CHAS FLOAT,         '+
            ' KRAJ_CHAS FLOAT,         '+
            ' CENAMINUTA FLOAT)        ');

    ExecSQL(' CREATE TABLE INTERNET (                '+
            ' TO VARCHAR(32),                        '+
            ' SUBJECT VARCHAR(20),                   '+
            ' PASSWORD VARCHAR(20),                  '+
            ' PROFILE VARCHAR(20),                   '+
            ' DIALOG LOGICAL,                        '+
            ' STUDIONOMER BYTE,                      '+
            ' PIN VARCHAR(6) DEFAULT "FFFFFF",       '+
            ' STUDIONAME VARCHAR(20),                '+
            ' DISCOUNT_COUNT INTEGER DEFAULT 99999,  '+
            ' DISCOUNT_PERCENT FLOAT DEFAULT 0,      '+
            ' DISCOUNT_PERCENT_FIRMI FLOAT DEFAULT 0)');

    ExecSQL(' INSERT INTO INTERNET (TO)       '+
            ' VALUES ("Admin@mail.bg")        ');

    ExecSQL(' CREATE TABLE KARTIALL (        '+
            ' KARTANOMER INTEGER,            '+
            ' KLIENTDETAIL INTEGER,          '+
            ' POSESHTENIA INTEGER,           '+
            ' STARTDATE DATE,                '+
            ' MINUTINA1 INTEGER,             '+
            ' INDEX KLIENTDET (KLIENTDETAIL))');

    ExecSQL(' CREATE TABLE KARTICHIP (      '+
            ' CHIPNOMER INTEGER DEFAULT 0,  '+
            ' STARTDATE DATE,               '+
            ' STARTTIME TIME,               '+
            ' KLIENTNOMER INTEGER DEFAULT 0,'+
            ' COUNTER INTEGER DEFAULT 0,    '+
            ' DISCOUNT FLOAT   DEFAULT 0,   '+
            ' SUMA CURRENCY DEFAULT 0,      '+
            ' INDEX KLIENT (KLIENTNOMER))   ');

    ExecSQL(' CREATE TABLE KLIENTI (    '+
            ' NOMER INTEGER,            '+
            ' BLOCKCODE BYTE,           '+
            ' IME VARCHAR(32),          '+
            ' TELEFON VARCHAR(14),      '+
            ' ADRES VARCHAR(32),        '+
            ' BALANS CURRENCY,          '+
            ' FIRMA INTEGER DEFAULT 0,  '+
            ' RANG CHAR(1) DEFAULT "S", '+
            ' INDEX KLIENTNOMER (NOMER),'+
            ' NOMER2 SMALLINT,          '+  
            ' INDEX FIRMA (FIRMA))      ');

    ExecSQL(' CREATE TABLE PERSONAL (  '+
            ' SLUZHITEL SMALLINT,      '+
            ' IME VARCHAR(12),         '+
            ' PAROLA VARCHAR(24),      '+
            ' PRAVA SMALLINT)          ');

    ExecSQL(' CREATE TABLE PLASHTANIA (     '+
            ' DATA DATE,                   '+
            ' CHAS VARCHAR(14),            '+
            ' SOLARIUM SMALLINT,           '+
            ' STOKA SMALLINT,              '+
            ' BROI SMALLINT,               '+
            ' CENA CURRENCY,               '+
            ' DISCOUNT SMALLINT DEFAULT 0, '+
            ' SUMABROI FLOAT,              '+
            ' RECORDID AUTOINCINTEGER,     '+
            ' OTKARTA INTEGER,             '+
            ' POSESHTENIA INTEGER,         '+
            ' OTCHIPKARTA INTEGER,         '+
            ' KARTASUMA CURRENCY,          '+
            ' STUDIOCODE BYTE,             '+
            ' STATUS CHAR(1) DEFAULT "P")  ');
            //'  ALTER TABLE plashtania ADD IF NOT EXISTS KLIENTNOMER INTEGER'));

    ExecSQL(' CREATE TABLE SOLARIUM (        '+
            ' SOLARIUM AUTOINCSHORTINT,      '+
            ' STATUS SMALLINT,               '+
            ' VREME SMALLINT,                '+
            ' CENA FLOAT,                    '+
            ' PREDVVREME SMALLINT,           '+
            ' OHLAZDANE SMALLINT,            '+
            ' PICTURE VARCHAR(127),          '+
            ' OPISANIE1 VARCHAR(20),         '+
            ' OPISANIE2 VARCHAR(20),         '+
            ' OPISANIE3 VARCHAR(20),         '+
            ' OPISANIE4 VARCHAR(20),         '+
            ' MIVREME SMALLINT,              '+
            ' ZVUK1 VARCHAR(127),            '+
            ' ZVUK2 VARCHAR(127),            '+
            ' ZVUK3 VARCHAR(127),            '+
            ' LAMPICHAS CURRENCY,            '+
            ' LICEVICHAS CURRENCY,           '+
            ' SAOBSHTAVA LOGICAL,            '+
            ' ADDRESS SMALLINT,              '+
            ' MINUTINA1 SMALLINT DEFAULT 5,  '+
            ' STAPKA SMALLINT DEFAULT 1,     '+
            ' KOEFICIENT SMALLINT DEFAULT 5, '+
            ' LICEVILASTDATE DATE,           '+
            ' LAMPILASTDATE DATE,            '+
            ' INDEX SOLARIUMNOMER (SOLARIUM))');

    ExecSQL(' INSERT INTO SOLARIUM (OPISANIE1) '+
            ' values ("Solarium1")');
            
    ExecSQL(' INSERT INTO SOLARIUM (OPISANIE1) '+
            ' values ("Solarium2")');

    ExecSQL(' CREATE TABLE STOKI (                  '+
            ' STOKAIME VARCHAR(30),                 '+
            ' STOKAKOD INTEGER NOT NULL,            '+
            ' STOKAORDER INTEGER NOT NULL DEFAULT 0,'+
            ' STOKACENA CURRENCY,                   '+
            ' STOKANASKLAD INTEGER,                 '+
            ' SUMA CURRENCY,                        '+
            ' POSESHTENIA INTEGER,                  '+
            ' STOKATIP CHAR(1) DEFAULT "S",         '+
            ' PRIMARY KEY  STOKANOMER (STOKAKOD))   ');

    ExecSQL(' CREATE TABLE               '+
            ' FIRMI ( IME VARCHAR(32),   '+
            ' NOMER AUTOINCINTEGER,      '+
            ' ADRES MEMO,                '+
            ' TELEFON MEMO,              '+
            ' PRIMARY KEY NOMER (NOMER)) ');

    ExecSQL(' INSERT INTO FIRMI (IME, NOMER, ADRES, TELEFON) '+
            ' values ("Физическо лице", 0, "", "")');


  end;
  DBVer := GetDBVer;
  if (DBVer < 3) then begin //
    // to ver 3
    ExecSQL(' CREATE TABLE IF NOT EXISTS  ' +
            ' TABLICA_CENI (              ' +
            ' SOLARIUM INTEGER DEFAULT 0, ' +
            ' MINUTA INTEGER DEFAULT 4,   ' +
            ' CENA CURRENCY DEFAULT 0,    ' +
            ' INDEX A1 (SOLARIUM))        ');

    ExecSQL(' CREATE TABLE IF NOT EXISTS    ' +
            ' PARAMS (                      ' +
            ' KEY VARCHAR(32) DEFAULT "",   ' +
            ' VALUE VARCHAR(64) DEFAULT "", ' +
            ' INDEX k1 (KEY))               ');

    ExecSQL(' INSERT INTO PARAMS (KEY, VALUE) '+
            ' values ("DBVer", 3)             ');

    ExecSQL(' INSERT INTO PARAMS (KEY, VALUE) '+
            ' values ("UpdateOK", "false")             ');


    ExecSQL(' CREATE TABLE IF NOT EXISTS '+
            ' FIRMI ( IME VARCHAR(32),   '+
            ' NOMER AUTOINCINTEGER,      '+
            ' ADRES MEMO,                '+
            ' TELEFON MEMO,              '+
            ' PRIMARY KEY NOMER (NOMER)) ');

    ExecSQL(' ALTER TABLE CHIPKARTI MODIFY (BALANS CURRENCY)');

    ExecSQL(' ALTER TABLE KLIENTI MODIFY (BALANS CURRENCY)');

    ExecSQL(' ALTER TABLE INTERNET ADD (                            '+
            ' IF NOT EXISTS DISCOUNT_COUNT INTEGER DEFAULT 99999,   '+
            ' IF NOT EXISTS DISCOUNT_PERCENT FLOAT DEFAULT 0,       '+
            ' IF NOT EXISTS DISCOUNT_PERCENT_FIRMI FLOAT DEFAULT 0) ');

    ExecSQL(' ALTER TABLE KARTICHIP ADD (              '+
            ' IF NOT EXISTS COUNTER INTEGER DEFAULT 0, '+
            ' IF NOT EXISTS DISCOUNT FLOAT DEFAULT 0,  '+
            ' IF NOT EXISTS SUMA CURRENCY DEFAULT 0   )');

    try
      ExecSQL(' ALTER TABLE KARTICHIP ADD (  '+
              ' INDEX KLIENT (KLIENTNOMER))  ');
    except 

    end;

    ExecSQL(' ALTER TABLE KLIENTI ADD (               '+
            ' IF NOT EXISTS FIRMA INTEGER DEFAULT 0,  '+
            ' IF NOT EXISTS RANG CHAR(1) DEFAULT "S", '+
            ' IF NOT EXISTS NOMER2 SMALLINT)          ');

    try
    ExecSQL(' ALTER TABLE KLIENTI ADD (               '+
            ' INDEX FIRMA (FIRMA))                    ');
    except
    
    end;

    ExecSQL(' CREATE TABLE IF NOT EXISTS  PLANNER (' +
            ' START DATETIME,                      ' +
            ' END DATETIME,                        ' +
            ' KEY VARCHAR(40),                     ' +
            ' NOTES MEMO,                          ' +
            ' subject VARCHAR(20),                 ' +
            ' resource INTEGER,                    ' +
            ' INDEX key (KEY))                     ');

    ExecSQL(' ALTER TABLE STOKI ADD (                     '+
            ' IF NOT EXISTS STOKATIP CHAR(1) DEFAULT "S", '+
            ' IF NOT EXISTS STOKACENACARD CURRENCY )      ');

    ExecSQL(' ALTER TABLE PLASHTANIA ADD (             '+
            ' IF NOT EXISTS  DISCOUNT FLOAT  ,         '+
            ' IF NOT EXISTS KARTASUMA CURRENCY,        '+
            ' IF NOT EXISTS CENA CURRENCY,             '+
            ' IF NOT EXISTS STATUS CHAR(1) DEFAULT "P",'+
            ' IF NOT EXISTS KLIENTNOMER INTEGER)       ');

    ExecSQL(' ALTER TABLE PLASHTANIA MODIFY ('+
            ' CENA CURRENCY,'+
            ' SUMABROI CURRENCY'+
            ' KARTASUMA CURRENCY)');

    ExecSQL(' ALTER TABLE SOLARIUM ADD (         '+
            ' IF NOT EXISTS LICEVILASTDATE DATE, '+
            ' IF NOT EXISTS LAMPILASTDATE DATE)  ');

    Database.Close;
    Database.CompactDatabase;
    Database.Open;
    SetDBVer(3);
    DBVer :=3;
  end;

  if (DBVer = 3) then begin //
    // to ver 4
    ExecSQL(' ALTER TABLE KARTICHIP ADD (         '+
            ' IF NOT EXISTS ENDDATE DATE, '+
            ' IF NOT EXISTS ONCE_PERDAY LOGICAL)  ');
    SetDBVer(4);
    DBVer:=4;
  end;

  ExecSQL(' ALTER TABLE STOKI ADD (                            '+
            ' IF NOT EXISTS VALIDNOST_KARTI INTEGER) ');
  ExecSQL(' ALTER TABLE KARTICHIP MODIFY (                            '+
            ' ONCE_PERDAY LOGICAL DEFAULT TRUE) ');


  ExecSQL('delete from KARTICHIP where not KLIENTNOMER >0'); //Truncate bad records silently

  _Q.SQL.Text:='select * from TABLICA_CENI';
  _Q.readonly:=False;
  _Q.InMemory:=false;
  _Q.Active  :=true;
  _Q.readonly:=False;
  if _Q.RecordCount < 60 then  begin  // Попълване на таблица цени ако е празна
    CENA1:=0;
    _Q2.SQL.Text:='select * from SOLARIUM ';
    _Q2.readonly:=False;
    _Q2.InMemory:=false;
    _Q2.Active  :=true;
    while not _Q2.Eof do  begin
      for i2:= 0 to 30 do  begin
        _Q.Append;
        _Q.FieldValues['SOLARIUM'] := _Q2.FieldValues['SOLARIUM'];
        _Q.FieldValues['MINUTA'  ] := i2;
        _Q.FieldValues['CENA'    ] := _Q2.FieldValues['CENA'] * i2;
        _Q.Post;
       end;
      _Q2.Next;
    end;
  end;

endprogram:
   tables.Free;
   _Q.Active :=False;
   _Q.Free;
   _Q2.Active :=False;
   _Q2.Free;
   Database.Connected:=false;
   Database.Free;
  end;
end.
