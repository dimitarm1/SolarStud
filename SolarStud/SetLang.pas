unit SetLang;

interface
uses inifiles,SysUtils, forms;
  function GetMessage(MessageNum: string) : string;
  procedure SetLangtext();
   procedure InitLang();
   Procedure EndLang();
   procedure SaveLangText();
   var
   LangIniFile : TIniFile;



implementation
  uses main,  Password,QReportKlienti, Refill,
  QReportSolariumiNastroiki, QReportDneven,  Stoki,NotShalter;
   var i:integer;
   Temp: string;
procedure InitLang();
 begin
  Temp := ExtractFilePath(application.ExeName)+'Language.ini';
  LangIniFile:=TIniFile.Create(ExtractFilePath(application.ExeName)+'Language.ini');
  Temp := '';
 end;
Procedure EndLang();
 begin
 LangIniFile.Free;
 end;

function GetMessage(MessageNum: string) : string;
  begin
   result:= LangIniFile.ReadString('MESSAGES',MessageNum,'');
  end;
function GetLabel(LabelName: string) : string;
  begin
     result:= LangIniFile.ReadString('LABELS',LabelName,'');
  end;
function GetMenuItem(MenuName: string) : string;
  begin
   result:= LangIniFile.ReadString('MENUS',MenuName,'');
  end;
function GetButtonText(ButtonName: string) : string;
  begin
  result:= LangIniFile.ReadString('BUTTONS',ButtonName,'');
  end;

procedure SaveLabel(key:string; value:string);
 begin
  LangIniFile.WriteString('LABELS',key,value);
 end;

procedure SaveButton(key:string; value:string);
 begin
  LangIniFile.WriteString('BUTTONS',key,value);
 end;
procedure SaveMenu(key:string; value:string);
 begin
  LangIniFile.WriteString('MENUS',key,value);
 end;
procedure SetLangText();
  begin
  with MainForm do
   begin

    Label4.Caption:=GetLabel('L4') ;
    Label5.Caption:=GetLabel('L5');
    Label7.Caption:=GetLabel('L7');
 //   Label10.Caption:=GetLabel('L10');
    Label11.Caption:=GetLabel('L11');
    Label12.Caption:=GetLabel('L12');
    Label13.Caption:=GetLabel('L13');

    Label16.Caption:=GetLabel('L16');
    Label17.Caption:=GetLabel('L17');
    Label21.Caption:=GetLabel('L21');
    Label22.Caption:=GetLabel('L22');
    Label25.Caption:=GetLabel('L25');
    Label26.Caption:=GetLabel('L26');
    Label27.Caption:=GetLabel('L27');
 //   Label28.Caption:=GetLabel('L28');
    Label29.Caption:=GetLabel('L29');
    Label31.Caption:=GetLabel('L31');
    Label32.Caption:=GetLabel('L32');
//    Label33.Caption:=GetLabel('L33');
    Label34.Caption:=GetLabel('L34');
    Label35.Caption:=GetLabel('L35');
    Label36.Caption:=GetLabel('L36');
    Label37.Caption:=GetLabel('L37');
    Label38.Caption:=GetLabel('L38');
    Label39.Caption:=GetLabel('L39');
    Label41.Caption:=GetLabel('L41');
    Label43.Caption:=GetLabel('L43');
    Label44.Caption:=GetLabel('L44');
    Label45.Caption:=GetLabel('L45');
//    Label40.Caption:=GetLabel('L40');
    Label46.Caption:=GetLabel('L46');
  //  Label47.Caption:=GetLabel('L47');
    Label48.Caption:=GetLabel('L48');
    Label49.Caption:=GetLabel('L49');
    Label50.Caption:=GetLabel('L50');
    Label53.Caption:=GetLabel('L53');
    Label51.Caption:=GetLabel('L51');
 //   Label54.Caption:=GetLabel('L54');
    Label55.Caption:=GetLabel('L55');
    Label57.Caption:=GetLabel('L57');
    Label63.Caption:=GetLabel('L63');
    Label65.Caption:=GetLabel('L65');
    Label61.Caption:=GetLabel('L61');
    Label66.Caption:=GetLabel('L66');
    Label67.Caption:=GetLabel('L67');
    Label68.Caption:=GetLabel('L68');
    Label75.Caption:=GetLabel('L75');
    Label76.Caption:=GetLabel('L76');
    Label77.Caption:=GetLabel('L77');
    Label78.Caption:=GetLabel('L78');
    Label79.Caption:=GetLabel('L79');
    Label80.Caption:=GetLabel('L80');
    Label91.Caption:=GetLabel('L91');
    Label90.Caption:=GetLabel('L90');
    Label92.Caption:=GetLabel('L92');
    Label95.Caption:=GetLabel('L95');
    Label96.Caption:=GetLabel('L96');
//    Label30.Caption:=GetLabel('L30');
//    Label56.Caption:=GetLabel('L56');
//    Label97.Caption:=GetLabel('L97');
    Label98.Caption:=GetLabel('L98');
    Label52.Caption:=GetLabel('L52');
    Label99.Caption:=GetLabel('L99');
    Label100.Caption:=GetLabel('L100');
    Label101.Caption:=GetLabel('L101');
    Label102.Caption:=GetLabel('L102');
    Label103.Caption:=GetLabel('L103');
    Label104.Caption:=GetLabel('L104');
    Label105.Caption:=GetLabel('L105');
    Label106.Caption:=GetLabel('L106');
    Label107.Caption:=GetLabel('L107');
    Label108.Caption:=GetLabel('L108');
    Label109.Caption:=GetLabel('L109');
   // Label121.Caption:=GetLabel('L121');
    Label123.Caption:=GetLabel('L123');
    //Label124.Caption:=GetLabel('L124');
//    LMDSimpleLabel1.Caption:=GetLabel('LMDSL1');
    LMDSimpleLabel2.Caption:=GetLabel('LMDSL2');
    Label122.Caption:=GetLabel('L122');
    Label125.Caption:=GetLabel('L125');
    //Label126.Caption:=GetLabel('L126');
    //Label128.Caption:=GetLabel('L128');
    Label129.Caption:=GetLabel('L129');
    Label130.Caption:=GetLabel('L130');
    Label6.Caption:=GetLabel('L6');
    LMDSimpleLabel3.Caption:=GetLabel('LMDSL3');
    LMDSimpleLabel4.Caption:=GetLabel('LMDSL4');
//    LMDSimpleLabel5.Caption:=GetLabel('LMDSL5');
  //  KasseLabel.Caption:=GetLabel('KL');
    Label111.Caption:=GetLabel('L111');
  //  Label112.Caption:=GetLabel('L112');
    Label113.Caption:=GetLabel('L113');
    Label114.Caption:=GetLabel('L114');
    Label115.Caption:=GetLabel('L115');
    Label116.Caption:=GetLabel('L116');
    Label117.Caption:=GetLabel('L117');
    Label119.Caption:=GetLabel('L119');
    Label127.Caption:=GetLabel('L127');
    //Label120.Caption:=GetLabel('L120');
    Label94.Caption:=GetLabel('L94');
    Label133.Caption:=GetLabel('L133');
  //  Label143.Caption:=GetLabel('L143');
    Label147.Caption:=GetLabel('L147');
    Label148.Caption:=GetLabel('L148');
    Label149.Caption:=GetLabel('L149');
    Label58.Caption:=GetLabel('L58');
    //Label59.Caption:=GetLabel('L59');
    Label60.Caption:=GetLabel('L60');
    Label69.Caption:=GetLabel('L69');
    Label70.Caption:=GetLabel('L70');
    Label71.Caption:=GetLabel('L71');
    Label72.Caption:=GetLabel('L72');
    Label93.Caption:=GetLabel('L93');
    Label118.Caption:=GetLabel('L118');
    Label131.Caption:=GetLabel('L131');
    Label132.Caption:=GetLabel('L132');
    Label74.Caption:=GetLabel('L74');
    Label134.Caption:=GetLabel('L134');
    Label135.Caption:=GetLabel('L135');
    Label136.Caption:=GetLabel('L136');
    Label137.Caption:=GetLabel('L137');
//    Label138.Caption:=GetLabel('L138');
    Label139.Caption:=GetLabel('L139');
    Label140.Caption:=GetLabel('L140');
    Label141.Caption:=GetLabel('L141');
    Label151.Caption:=GetLabel('L151');
    Label152.Caption:=GetLabel('L152');
    Label153.Caption:=GetLabel('L153');
    //PopupMenu1.Items[0].Caption := GetMenuItem(14);
    N1.Caption:= GetMenuItem('N1');
    N2.Caption:= GetMenuItem('N2');
    //PopupMenu2: TPopupMenu;
    N3.Caption:= GetMenuItem('N3');
    N4.Caption:= GetMenuItem('N4');
   // PopupMenu3: TPopupMenu;
    Label64.Caption:=GetLabel('L64');
    Label81.Caption:=GetLabel('L81');
    Label82.Caption:=GetLabel('L82');
    Label83.Caption:=GetLabel('L83');
    Label84.Caption:=GetLabel('L84');
    Label85.Caption:=GetLabel('L85');
    Label86.Caption:=GetLabel('L86');
    Label87.Caption:=GetLabel('L87');
 //   Label88.Caption:=GetLabel('L88');
  //  Label89.Caption:=GetLabel('L89');
   // Label90.Caption:=GetLabel('L90');
  //  Label106.Caption:=GetLabel('L106');
  //  Label142.Caption:=GetLabel('L142');
  //  Label145.Caption:=GetLabel('L145');
    Label146.Caption:=GetLabel('L146');
    Label150.Caption:=GetLabel('L150');
    Label42.Caption:=GetLabel('L42');
    Label1000.Caption:=GetLabel('L1000');
    Label2.Caption:=GetLabel('L2');
    Label3.Caption:=GetLabel('L3');
    Label1.Caption:=GetLabel('L1');

    DBComboBox1.Text:=GetButtonText('DBCB1');
    DBComboBox3.Text:=GetButtonText('DBCB3');
    DBComboBox4.Text:=GetButtonText('DBCB4');
    DBComboBox5.Text:=GetButtonText('DBCB5');
    DBComboBox8.Text:=GetButtonText('DBCB8');
    LMDDBCheckBox1.Caption:=GetButtonText('LMDCB1');
//    wwDBGrid2.ControlType.Names[0]:=GetButtonText('WWDBG2-0');
 //   wwDBGrid4.ControlType.Names[0]:=GetButtonText('WWDBG4-0');
//    LMDButton2.Caption:=GetButtonText('LMDB2');
//    LMDButton3.caption:=GetButtonText('LMDB3');
//    LMDButton4.Caption:=GetButtonText('LMDB4');
//    wwDBGrid6.ControlType.Names[0]:=GetButtonText('WWDBG6-0');
//    wwDBGrid7.ControlType.Names[0]:=GetButtonText('WWDBG7-0');
    AdvComboBox1.Text:=GetButtonText('ADVCB1');
    LMDButton5.Caption:=GetButtonText('LMDB5');
    LMDButton6.Caption:=GetButtonText('LMDB6');
    LMDButton7.Caption:=GetButtonText('LMDB7');
    LMDButton8.Caption:=GetButtonText('LMDB8');
    AdvComboBox2.Text:=GetButtonText('ADVCB2');
//    wwDBGrid5.ControlType.Names[0]:=GetButtonText('WWDBG5-0');
    NuliraneChipCartaButton.Caption:=GetButtonText('LMDB9');

    NovKlientButton.Caption:=GetButtonText('LMDB6');
    LMDButton12.Caption:=GetButtonText('LMDB12');
    LMDButton13.Caption:=GetButtonText('LMDB13');
    LMDButton14.Caption:=GetButtonText('LMDB14');
//    LMDButton1.Caption:=GetButtonText('LMDB1');

    StatistikaBox1.Caption:=GetButtonText('SB1');
    LMDButton16.Caption:=GetButtonText('LMDB16');
    LMDButton17.Caption:=GetButtonText('LMDB17');

      for i:=0 to 20 do
       begin
         if i < SOLARIUMI.Fields.Count then SOLARIUMI.Fields.Fields[i].DisplayLabel
            :=GetButtonText('SOLARIUMI'+IntToStr(i));
         if i < Table3.Fields.Count then Table3.Fields.Fields[i].DisplayLabel
            :=GetButtonText('Table3'+IntToStr(i));
         if i < STOKI.Fields.Count then STOKI.Fields.Fields[i].DisplayLabel
            :=GetButtonText('STOKI'+IntToStr(i));
         if i < KARTIALL1.Fields.Count then KARTIALL1.Fields.Fields[i].DisplayLabel
            :=GetButtonText('KARTIALL1'+IntToStr(i));
         if i < Plashtania.Fields.Count then Plashtania.Fields.Fields[i].DisplayLabel
            :=GetButtonText('Plashtania'+IntToStr(i));
         if i < KARTIALL.Fields.Count then KARTIALL.Fields.Fields[i].DisplayLabel
            :=GetButtonText('KARTIALL'+IntToStr(i));
         if i < solariumspr.Fields.Count then solariumspr.Fields.Fields[i].DisplayLabel
            :=GetButtonText('solariumspr'+IntToStr(i));
         if i < stokispr.Fields.Count then stokispr.Fields.Fields[i].DisplayLabel
            :=GetButtonText('stokispr'+IntToStr(i));
         if i < CHIPKARTI.Fields.Count then CHIPKARTI.Fields.Fields[i].DisplayLabel
            :=GetButtonText('CHIPKARTI'+IntToStr(i));
         if i < personal1.Fields.Count then personal1.Fields.Fields[i].DisplayLabel
            :=GetButtonText('personal1'+IntToStr(i));

         if i < KARTI.Fields.Count then KARTI.Fields.Fields[i].DisplayLabel
            :=GetButtonText('KARTI'+IntToStr(i));
         if i < STOKITE.Fields.Count then STOKITE.Fields.Fields[i].DisplayLabel
            :=GetButtonText('STOKITE'+IntToStr(i));
         if i < QKLIENTI.Fields.Count then QKLIENTI.Fields.Fields[i].DisplayLabel
            :=GetButtonText('QKLIENTI'+IntToStr(i));
         if i < QKARTI.Fields.Count then QKARTI.Fields.Fields[i].DisplayLabel
            :=GetButtonText('QKARTI'+IntToStr(i));
         if i < SDELKA.Fields.Count then SDELKA.Fields.Fields[i].DisplayLabel
            :=GetButtonText('SDELKA'+IntToStr(i));
         if i < DayTotal.Fields.Count then DayTotal.Fields.Fields[i].DisplayLabel
            :=GetButtonText('DayTotal'+IntToStr(i));
         if i < QStatistika.Fields.Count then QStatistika.Fields.Fields[i].DisplayLabel
            :=GetButtonText('QStatistika'+IntToStr(i));



         if i < SOLARIUMI.Fields.Count then SOLARIUMI.Fields.Fields[i].DisplayLabel
            :=GetButtonText('SOLARIUMI'+IntToStr(i));
         if i < Table3.Fields.Count then Table3.Fields.Fields[i].DisplayLabel
            :=GetButtonText('Table3'+IntToStr(i));
         if i < STOKI.Fields.Count then STOKI.Fields.Fields[i].DisplayLabel
            :=GetButtonText('STOKI'+IntToStr(i));
         if i < KARTIALL1.Fields.Count then KARTIALL1.Fields.Fields[i].DisplayLabel
            :=GetButtonText('KARTIALL1'+IntToStr(i));
         if i < wwdbgrid2.FieldCount then wwdbgrid2.Fields[i].DisplayLabel
            :=GetButtonText('Plashtania'+IntToStr(i));
 //        if i < KARTIALL.Fields.Count then KARTIALL.Fields.Fields[i].DisplayLabel
 //           :=GetButtonText('KARTIALL'+IntToStr(i));
 //        if i < solariumspr.Fields.Count then solariumspr.Fields.Fields[i].DisplayLabel
 //           :=GetButtonText('solariumspr'+IntToStr(i));
 //        if i < stokispr.Fields.Count then stokispr.Fields.Fields[i].DisplayLabel
 //           :=GetButtonText('stokispr'+IntToStr(i));
 //        if i < CHIPKARTI.Fields.Count then CHIPKARTI.Fields.Fields[i].DisplayLabel
 //           :=GetButtonText('CHIPKARTI'+IntToStr(i));
         if i < wwdbgrid1.FieldCount then wwdbgrid1.Fields[i].DisplayLabel
            :=GetButtonText('personal1'+IntToStr(i));

         if i < wwdbgrid3.FieldCount then wwdbgrid3.Fields[i].DisplayLabel
            :=GetButtonText('KARTI'+IntToStr(i));
         if i < KasaGrid.FieldCount then KasaGrid.Fields[i].DisplayLabel
            :=GetButtonText('STOKITE'+IntToStr(i));
            //MainForm.sol1.DataSets[1].Fields[1].DisplayName
         if i < wwdbgrid5.FieldCount then wwdbgrid5.Fields[i].DisplayLabel
            :=GetButtonText('QKLIENTI'+IntToStr(i));
         if i < wwdbgrid7.FieldCount then wwdbgrid7.Fields[i].DisplayLabel
            :=GetButtonText('QKARTI'+IntToStr(i));
         if i < wwdbgrid9.FieldCount  then wwdbgrid9.Fields[i].DisplayLabel
            :=GetButtonText('SDELKA'+IntToStr(i));
         if i < DayTotal.Fields.Count then DayTotal.Fields.Fields[i].DisplayLabel
            :=GetButtonText('DayTotal'+IntToStr(i));
         if i < wwdbgrid10.FieldCount  then wwdbgrid10.Fields[i].DisplayLabel
            :=GetButtonText('QStatistika'+IntToStr(i));

       end;
   end;

     with Form1 do // QReportKlienti
    begin
//     QRLabel1.Caption:=  GetLabel('QRF1L1');
//     QRLabel2.Caption:= GetLabel('QRF1L2');
//     QRLabel3.Caption:= GetLabel('QRF1L3');
//     QRLabel4.Caption:=  GetLabel('QRF1L4');
     QRLabel5.Caption:= GetLabel('QRF1L5');
//     QRLabel6.Caption:= GetLabel('QRF1L6');
//     QRLabel7.Caption:= GetLabel('QRF1L7');
//     QRLabel8.Caption:= GetLabel('QRF1L8');
//     QRLabel9.Caption:= GetLabel('QRF1L9');
     QRLabel10.Caption:= GetLabel('QRF1L10');
      QRLabel11.Caption:= GetLabel('QRF1L11');
    end;
   with Form2 do //QReportSolariumNastroiki
    begin
     QRLabel1.Caption:= GetLabel('QRF2L1');
     QRLabel2.Caption:= GetLabel('QRF2L2');
     QRLabel3.Caption:= GetLabel('QRF2L3');
     QRLabel5.Caption:= GetLabel('QRF2L5');
     QRLabel6.Caption:= GetLabel('QRF2L6');
     QRLabel7.Caption:= GetLabel('QRF2L7');
     QRLabel8.Caption:= GetLabel('QRF2L8');
     QRLabel9.Caption:= GetLabel('QRF2L9');
     QRLabel10.Caption:= GetLabel('QRF2L10');
     QRLabel12.Caption:= GetLabel('QRF2L12');
     QRLabel13.Caption:= GetLabel('QRF2L13');
    end;
   with   Form3 do //QReportDneven
    begin
    QRLabel1.Caption:= GetLabel('QRF3L1');
    QRLabel2.Caption:= GetLabel('QRF3L2');
    QRLabel3.Caption:= GetLabel('QRF3L3');
    QRLabel4.Caption:= GetLabel('QRF3L4');
    QRLabel5.Caption:= GetLabel('QRF3L5');



    QRLabel9.Caption:= GetLabel('QRF3L9');
    QRLabel11.Caption:= GetLabel('QRF3L11');
    QRLabel12.Caption:= GetLabel('QRF3L12');
    QRLabel10.Caption:= GetLabel('QRF3L10');
    QRLabel13.Caption:= GetLabel('QRF3L13');
    QRLabel14.Caption:= GetLabel('QRF3L14');
    QRLabel15.Caption:= GetLabel('QRF3L15');
    QRLabel16.Caption:=  GetLabel('QRF3L16');
    end;
   with form4 do //Stoki
    begin
    QRLabel1.Caption:=  GetLabel('QRF4L1');
    QRLabel2.Caption:= GetLabel('QRF4L2');
    QRLabel3.Caption:= GetLabel('QRF4L3');
    QRLabel4.Caption:= GetLabel('QRF4L4');
    QRLabel5.Caption:= GetLabel('QRF4L5');
    QRLabel6.Caption:= GetLabel('QRF4L6');
    QRLabel7.Caption:=  GetLabel('QRF4L7');
    end;


   with NotshalterForm do //NotShalter
    begin
    Label1.Caption:= GetLabel('NSHL1');
    Label2.Caption:= GetLabel('NSHL2');
    Label3.Caption:= GetLabel('NSHL3');
    Label4.Caption:= GetLabel('NSHL4');
    Label5.Caption:= GetLabel('NSHL5');
    Panel1.Caption:= GetLabel('NSHP1');
    Panel2.Caption:= GetLabel('NSHP2');
    end;
     NotshalterForm.caption:= GetLabel('NSHFM');
   with RefillForm do //Refill
    begin
    Label1.Caption:= GetLabel('RFL1');

    Label5.Caption:= GetLabel('RFL5');
    Label3.Caption:= GetLabel('RFL3');
    Label4.Caption:= GetLabel('RFL4');
    Panel1.Caption:= GetLabel('RFP1');
    Panel2.Caption:= GetLabel('RFP2');
    end;
    RefillForm.caption:= GetLabel('RFFM');
  end;

procedure SaveLangText();
  begin
  with MainForm do
   begin

    SaveLabel('L4',  Label4.Caption);
    SaveLabel('L5',Label5.Caption);
    SaveLabel('L7',Label7.Caption);
    SaveLabel('L10',Label10.Caption);
    SaveLabel('L11',Label11.Caption);
    SaveLabel('L12',  Label12.Caption);
    SaveLabel('L13',  Label13.Caption);
    SaveLabel('L16',  Label16.Caption);
    SaveLabel('L17',  Label17.Caption);
    SaveLabel('L21',  Label21.Caption);
    SaveLabel('L22',  Label22.Caption);
    SaveLabel('L25',  Label25.Caption);
    SaveLabel('L26',  Label26.Caption);
    SaveLabel('L27',  Label27.Caption);
    //SaveLabel('L28',  Label28.Caption);
    SaveLabel('L29',  Label29.Caption);
    SaveLabel('L31',  Label31.Caption);
    SaveLabel('L32',  Label32.Caption);
    //SaveLabel('L33',  Label33.Caption);
    SaveLabel('L34',  Label34.Caption);
    SaveLabel('L35',  Label35.Caption);
    SaveLabel('L36',  Label36.Caption);
    SaveLabel('L37',  Label37.Caption);
    SaveLabel('L38',  Label38.Caption);
    SaveLabel('L39',  Label39.Caption);
    SaveLabel('L41',  Label41.Caption);
    SaveLabel('L43',  Label43.Caption);
    SaveLabel('L44',  Label44.Caption);
    SaveLabel('L45',  Label45.Caption);
    //SaveLabel('L40',  Label40.Caption);
    SaveLabel('L46',  Label46.Caption);
    SaveLabel('L47',  Label47.Caption);
    SaveLabel('L48',  Label48.Caption);
    SaveLabel('L49',  Label49.Caption);
    SaveLabel('L50',  Label50.Caption);
    SaveLabel('L53',  Label53.Caption);
    SaveLabel('L51',  Label51.Caption);
    SaveLabel('L54',  Label54.Caption);
    SaveLabel('L55',  Label55.Caption);
    SaveLabel('L61',  Label61.Caption);
    SaveLabel('L66',  Label66.Caption);
    SaveLabel('L67',  Label67.Caption);
    SaveLabel('L68',  Label68.Caption);
    SaveLabel('L75',  Label75.Caption);
    SaveLabel('L76',  Label76.Caption);
    SaveLabel('L77',  Label77.Caption);
    SaveLabel('L78',  Label78.Caption);
    SaveLabel('L79',  Label79.Caption);
    SaveLabel('L80',  Label80.Caption);
    SaveLabel('L91',  Label91.Caption);
    SaveLabel('L92',  Label92.Caption);
    SaveLabel('L95',  Label95.Caption);
    SaveLabel('L96',  Label96.Caption);
//    SaveLabel('L30',  Label30.Caption);
//    SaveLabel('L56',  Label56.Caption);
//    SaveLabel('L97',  Label97.Caption);
    SaveLabel('L98',  Label98.Caption);
    SaveLabel('L52',  Label52.Caption);
    SaveLabel('L99',  Label99.Caption);
    SaveLabel('L100',  Label100.Caption);
    SaveLabel('L101',  Label101.Caption);
    SaveLabel('L102',  Label102.Caption);
    SaveLabel('L103',  Label103.Caption);
    SaveLabel('L104',  Label104.Caption);
    SaveLabel('L105',  Label105.Caption);
    SaveLabel('L107',  Label107.Caption);
    SaveLabel('L108',  Label108.Caption);
    SaveLabel('L109',  Label109.Caption);
    //SaveLabel('L121',  Label121.Caption);
    SaveLabel('L123',  Label123.Caption);
    //SaveLabel('L124',  Label124.Caption);
    //SaveLabel('LMDSL1',  LMDSimpleLabel1.Caption);
    SaveLabel('LMDSL2',  LMDSimpleLabel2.Caption);
    SaveLabel('L122',  Label122.Caption);
    SaveLabel('L125',  Label125.Caption);
    //SaveLabel('L126',  Label126.Caption);
    //SaveLabel('L128',  Label128.Caption);
    SaveLabel('L129',  Label129.Caption);
    SaveLabel('L130',  Label130.Caption);
    SaveLabel('L6',  Label6.Caption);
    SaveLabel('LMDSL3',  LMDSimpleLabel3.Caption);
    SaveLabel('LMDSL4',  LMDSimpleLabel4.Caption);
    //SaveLabel('LMDSL5',  LMDSimpleLabel5.Caption);
    //SaveLabel('KL',  KasseLabel.Caption);
    SaveLabel('L111',  Label111.Caption);
    //SaveLabel('L112',  Label112.Caption);
    SaveLabel('L113',  Label113.Caption);
    SaveLabel('L114',  Label114.Caption);
    SaveLabel('L115',  Label115.Caption);
    SaveLabel('L116',  Label116.Caption);
    SaveLabel('L117',  Label117.Caption);
    SaveLabel('L119',  Label119.Caption);
    SaveLabel('L127',  Label127.Caption);
//    SaveLabel('L120',  Label120.Caption);
    SaveLabel('L94',  Label94.Caption);
    SaveLabel('L133',  Label133.Caption);
    SaveLabel('L147',  Label147.Caption);
    SaveLabel('L148',  Label148.Caption);
    SaveLabel('L149',  Label149.Caption);
    SaveLabel('L58',  Label58.Caption);
    SaveLabel('L60',  Label60.Caption);
    SaveLabel('L69',  Label69.Caption);
    SaveLabel('L70',  Label70.Caption);
    SaveLabel('L71',  Label71.Caption);
    SaveLabel('L72',  Label72.Caption);
    SaveLabel('L93',  Label93.Caption);
    SaveLabel('L118',  Label118.Caption);
    SaveLabel('L131',  Label131.Caption);
    SaveLabel('L132',  Label132.Caption);
    SaveLabel('L74',  Label74.Caption);
    SaveLabel('L134',  Label134.Caption);
    SaveLabel('L135',  Label135.Caption);
    SaveLabel('L136',  Label136.Caption);
    SaveLabel('L137',  Label137.Caption);
//    SaveLabel('L138',  Label138.Caption);
    SaveLabel('L139',  Label139.Caption);
    SaveLabel('L140',  Label140.Caption);
    SaveLabel('L141',  Label141.Caption);
    //PopupMenu1.Items[0].Caption ) GetMenuItem(14,;
    SaveMenu('N1',  N1.Caption) ;
    SaveMenu('N2',  N2.Caption) ;
    //PopupMenu2: TPopupMenu;
    SaveMenu('N3',  N3.Caption) ;
    SaveMenu('N4',  N4.Caption) ;
   // PopupMenu3: TPopupMenu;
    SaveLabel('L64',  Label64.Caption);
    SaveLabel('L81',  Label81.Caption);
    SaveLabel('L82',  Label82.Caption);
    SaveLabel('L83',  Label83.Caption);
    SaveLabel('L84',  Label84.Caption);
    SaveLabel('L85',  Label85.Caption);
    SaveLabel('L86',  Label86.Caption);
    SaveLabel('L87',  Label87.Caption);
    SaveLabel('L88',  Label88.Caption);
    //SaveLabel('L89',  Label89.Caption);
    //SaveLabel('L90',  Label90.Caption);
    //SaveLabel('L106',  Label106.Caption);
    //SaveLabel('L142',  Label142.Caption);
    // SaveLabel('L145',  Label145.Caption);
    SaveLabel('L146',  Label146.Caption);
    SaveLabel('L150',  Label150.Caption);
    SaveLabel('L42',  Label42.Caption);
    SaveLabel('L1000',  Label1000.Caption);
    SaveLabel('L2',  Label2.Caption);
    SaveLabel('L3',  Label3.Caption);
    SaveLabel('L1',  Label1.Caption);

    SaveButton('DBCB1', DBComboBox1.Text);
    SaveButton('DBCB3', DBComboBox3.Text);
    SaveButton('DBCB4', DBComboBox4.Text);
    SaveButton('DBCB5', DBComboBox5.Text);
    SaveButton('DBCB8', DBComboBox8.Text);
    SaveButton('LMDCB1', LMDDBCheckBox1.Caption);
    //SaveButton('WWDBG2-0', wwDBGrid2.ControlType.Names[1]);
    //SaveButton('WWDBG4-0', wwDBGrid4.ControlType.Names[1]);
    //SaveButton('LMDB2', LMDButton2.Caption);
    //SaveButton('LMDB3', LMDButton3.caption);
    //SaveButton('LMDB4', LMDButton4.Caption);
    //SaveButton('WWDBG6-0', wwDBGrid6.ControlType.Names[1]);
    //SaveButton('WWDBG7-0', wwDBGrid7.ControlType.Names[1]);
    SaveButton('ADVCB1', AdvComboBox1.Text);
    //SaveButton('WWDBG8-0', wwDBGrid8.ControlType.Names[1]);
    //SaveButton('WWDBG9-0', wwDBGrid9.ControlType.Names[1]);
    SaveButton('LMDB5', LMDButton5.Caption);
    SaveButton('LMDB6', LMDButton6.Caption);
    SaveButton('LMDB7', LMDButton7.Caption);
    SaveButton('LMDB8', LMDButton8.Caption);
    SaveButton('ADVCB2', AdvComboBox2.Text);
    //SaveButton('WWDBG5-0', wwDBGrid5.ControlType.Names[1]);
    //SaveButton('WWIB1', wwIButton1.Caption);
    SaveButton('LMDB9', NuliraneChipCartaButton.Caption);
    SaveButton('LMDB1', NovKlientButton.Caption);
    SaveButton('LMDB12', LMDButton12.Caption);
    SaveButton('LMDB13', LMDButton13.Caption);
    SaveButton('LMDB14', LMDButton14.Caption);
    //SaveButton('LMDB1', LMDButton1.Caption);

    //SaveButton('WWDBG1-0', wwDBGrid1.ControlType.Names[1]);
    //SaveButton('WWIB2', wwIButton2.Caption);
    //SaveButton('WWDBG10-0', wwDBGrid10.ControlType.Names[1]);
    SaveButton('SB1', StatistikaBox1.Caption);
    // SaveButton('WWDBG10IB',wwDBGrid10IButton.Caption);
     for i:=0 to 20 do
       begin
         if i < SOLARIUMI.Fields.Count then SaveButton(('SOLARIUMI'+IntToStr(i)),SOLARIUMI.Fields.Fields[i].DisplayName);
         if i < Table3.Fields.Count then SaveButton(('Table3'+IntToStr(i)),Table3.Fields.Fields[i].DisplayName);
         if i < STOKI.Fields.Count then SaveButton(('STOKI'+IntToStr(i)),STOKI.Fields.Fields[i].DisplayName);
         if i < KARTIALL1.Fields.Count then SaveButton(('KARTIALL1'+IntToStr(i)),KARTIALL1.Fields.Fields[i].DisplayName);
         if i < Plashtania.Fields.Count then SaveButton(('Plashtania'+IntToStr(i)),Plashtania.Fields.Fields[i].DisplayName);
         if i < KARTIALL.Fields.Count then SaveButton(('KARTIALL'+IntToStr(i)),KARTIALL.Fields.Fields[i].DisplayName);
         if i < solariumspr.Fields.Count then SaveButton(('solariumspr'+IntToStr(i)),solariumspr.Fields.Fields[i].DisplayName);
         if i < stokispr.Fields.Count then SaveButton(('stokispr'+IntToStr(i)),stokispr.Fields.Fields[i].DisplayName);
         if i < CHIPKARTI.Fields.Count then SaveButton(('CHIPKARTI'+IntToStr(i)),CHIPKARTI.Fields.Fields[i].DisplayName);
         if i < personal1.Fields.Count then SaveButton(('personal1'+IntToStr(i)),personal1.Fields.Fields[i].DisplayName);
         if i < KARTI.Fields.Count then SaveButton(('KARTI'+IntToStr(i)),KARTI.Fields.Fields[i].DisplayName);
         if i < STOKITE.Fields.Count then SaveButton(('STOKITE'+IntToStr(i)),STOKITE.Fields.Fields[i].DisplayName);
         if i < QKLIENTI.Fields.Count then SaveButton(('QKLIENTI'+IntToStr(i)),QKLIENTI.Fields.Fields[i].DisplayName);
         if i < QKARTI.Fields.Count then SaveButton(('QKARTI'+IntToStr(i)),QKARTI.Fields.Fields[i].DisplayName);
         if i < SDELKA.Fields.Count then SaveButton(('SDELKA'+IntToStr(i)),SDELKA.Fields.Fields[i].DisplayName);
         if i < DayTotal.Fields.Count then SaveButton(('DayTotal'+IntToStr(i)),DayTotal.Fields.Fields[i].DisplayName);
         if i < QStatistika.Fields.Count then SaveButton(('QStatistika'+IntToStr(i)),QStatistika.Fields.Fields[i].DisplayName);
       end;
   end;
   with Form1 do // QReportKlienti
    begin
//     SaveLabel('QRF1L1' ,QRLabel1.Caption ) ;
//     SaveLabel('QRF1L2' ,QRLabel2.Caption ) ;
//     SaveLabel('QRF1L3' ,QRLabel3.Caption ) ;
//     SaveLabel('QRF1L4' ,QRLabel4.Caption ) ;
     SaveLabel('QRF1L5' ,QRLabel5.Caption ) ;
//     SaveLabel('QRF1L6' ,QRLabel6.Caption ) ;
//     SaveLabel('QRF1L7' ,QRLabel7.Caption ) ;
//     SaveLabel('QRF1L8' ,QRLabel8.Caption ) ;
//     SaveLabel('QRF1L9' ,QRLabel9.Caption ) ;
     SaveLabel('QRF1L10',QRLabel10.Caption) ;
     SaveLabel('QRF1L11',QRLabel11.Caption) ;
    end;
   with Form2 do //QReportSolariumNastroiki
    begin
     SaveLabel('QRF2L1' ,QRLabel1.Caption );
     SaveLabel('QRF2L2' ,QRLabel2.Caption );
     SaveLabel('QRF2L3' ,QRLabel3.Caption );
     SaveLabel('QRF2L5' ,QRLabel5.Caption );
     SaveLabel('QRF2L6' ,QRLabel6.Caption );
     SaveLabel('QRF2L7' ,QRLabel7.Caption );
     SaveLabel('QRF2L8' ,QRLabel8.Caption );
     SaveLabel('QRF2L9' ,QRLabel9.Caption );
     SaveLabel('QRF2L10',QRLabel10.Caption);
     SaveLabel('QRF2L12',QRLabel12.Caption);
     SaveLabel('QRF2L13',QRLabel13.Caption);
    end;
   with   Form3 do //QReportDneven
    begin
     SaveLabel('QRF3L1',QRLabel1.Caption);
     SaveLabel('QRF3L2',QRLabel2.Caption);
     SaveLabel('QRF3L3',QRLabel3.Caption);
     SaveLabel('QRF3L4',QRLabel4.Caption);
     SaveLabel('QRF3L5',QRLabel5.Caption);



     SaveLabel('QRF3L9',QRLabel9.Caption);
     SaveLabel('QRF3L11',QRLabel11.Caption);
     SaveLabel('QRF3L12',QRLabel12.Caption);
     SaveLabel('QRF3L10',QRLabel10.Caption);
     SaveLabel('QRF3L13',QRLabel13.Caption);
     SaveLabel('QRF3L14',QRLabel14.Caption);
     SaveLabel('QRF3L15',QRLabel15.Caption);
     SaveLabel('QRF3L16',QRLabel16.Caption);
    end;
   with form4 do //Stoki
    begin
     SaveLabel('QRF4L1',QRLabel1.Caption);
     SaveLabel('QRF4L2',QRLabel2.Caption);
     SaveLabel('QRF4L3',QRLabel3.Caption);
     SaveLabel('QRF4L4',QRLabel4.Caption);
     SaveLabel('QRF4L5',QRLabel5.Caption);
     SaveLabel('QRF4L6',QRLabel6.Caption);
     SaveLabel('QRF4L7',QRLabel7.Caption);
    end;


   with NotshalterForm do //NotShalter
    begin
     SaveLabel('NSHL1',Label1.Caption);
     SaveLabel('NSHL2',Label2.Caption);
     SaveLabel('NSHL3',Label3.Caption);
     SaveLabel('NSHL4',Label4.Caption);
     SaveLabel('NSHL5',Label5.Caption);
    end;
    SaveLabel('NSHFM', NotshalterForm.caption);
   with RefillForm do //Refill
    begin
     SaveLabel('RFL1',Label1.Caption);
     SaveLabel('RFL5',Label5.Caption);
     SaveLabel('RFL3',Label3.Caption);
     SaveLabel('RFL4',Label4.Caption);
     SaveLabel('RFP1',Panel1.Caption);
     SaveLabel('RFP2',Panel2.Caption);
    end;
    SaveLabel('RFFM',RefillForm.caption);
  end;

end.
