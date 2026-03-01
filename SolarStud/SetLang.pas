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
  uses main, DataMod, Password, QReportKlienti, Refill, ArhiviraneFrame, ChipKartiFrame, DrugiNastroikiFrame, FirmiISluziteliFrame, IzborNaPlashtaneFrame, IzborNaVremeFrame, KlubniKartiFrame, LogoEkranFrame, MenuFrame, MenuKasaFrame, MenuStokiFrame, NachalnoUstanoviavaneFrame, OsnovenEkranFrame, OsnovniNastroikiFrame, ProtokolFrame, SolariumiCeniFrame, SolariumiInfoFrame, SolariumiNastroikiFrame, StatistikaFrame,
  QReportSolariumiNastroiki, QReportDneven,  Stoki,NotShalter;
   var i:integer;
procedure InitLang();
 begin
  LangIniFile:=TIniFile.Create(ExtractFilePath(application.ExeName)+'Language.ini');
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

    GetIzborNaVremeFrame.Label4.Caption:=GetLabel('L4') ;
    GetIzborNaVremeFrame.Label5.Caption:=GetLabel('L5');
    GetIzborNaVremeFrame.Label7.Caption:=GetLabel('L7');
 //   GetIzborNaVremeFrame.Label10.Caption:=GetLabel('L10');
    GetIzborNaVremeFrame.Label11.Caption:=GetLabel('L11');
    GetMenuFrame.Label12.Caption:=GetLabel('L12');
    GetMenuFrame.Label13.Caption:=GetLabel('L13');
    GetMenuFrame.Label14.Caption:=GetLabel('L14');
    GetMenuFrame.Label15.Caption:=GetLabel('L15');
    GetMenuFrame.Label16.Caption:=GetLabel('L16');
    GetMenuFrame.Label17.Caption:=GetLabel('L17');
    GetMenuFrame.Label18.Caption:=GetLabel('L18');
    GetMenuFrame.Label19.Caption:=GetLabel('L19');
    GetMenuFrame.Label20.Caption:=GetLabel('L20');
    GetMenuFrame.Label21.Caption:=GetLabel('L21');
    GetMenuFrame.Label22.Caption:=GetLabel('L22');
    GetMenuFrame.Label23.Caption:=GetLabel('L23');
    GetMenuFrame.Label24.Caption:=GetLabel('L24');
    GetIzborNaPlashtaneFrame.Label25.Caption:=GetLabel('L25');
    GetIzborNaPlashtaneFrame.Label26.Caption:=GetLabel('L26');
    GetIzborNaPlashtaneFrame.Label27.Caption:=GetLabel('L27');
 //   GetSolariumiCeniFrame.Label28.Caption:=GetLabel('L28');
    GetIzborNaPlashtaneFrame.Label29.Caption:=GetLabel('L29');
    GetSolariumiNastroikiFrame.Label31.Caption:=GetLabel('L31');
    GetSolariumiCeniFrame.Label32.Caption:=GetLabel('L32');
//    GetIzborNaVremeFrame.Label33.Caption:=GetLabel('L33');
    GetSolariumiNastroikiFrame.Label34.Caption:=GetLabel('L34');
    GetSolariumiNastroikiFrame.Label35.Caption:=GetLabel('L35');
    GetSolariumiNastroikiFrame.Label36.Caption:=GetLabel('L36');
    GetSolariumiNastroikiFrame.Label37.Caption:=GetLabel('L37');
    GetSolariumiNastroikiFrame.Label38.Caption:=GetLabel('L38');
    GetSolariumiNastroikiFrame.Label39.Caption:=GetLabel('L39');
    GetSolariumiNastroikiFrame.Label41.Caption:=GetLabel('L41');
    GetSolariumiNastroikiFrame.Label43.Caption:=GetLabel('L43');
    GetSolariumiNastroikiFrame.Label44.Caption:=GetLabel('L44');
    GetSolariumiNastroikiFrame.Label45.Caption:=GetLabel('L45');
//    GetIzborNaVremeFrame.Label40.Caption:=GetLabel('L40');
    GetSolariumiInfoFrame.Label46.Caption:=GetLabel('L46');
  //  GetIzborNaVremeFrame.Label47.Caption:=GetLabel('L47');
    GetSolariumiCeniFrame.Label48.Caption:=GetLabel('L48');
    GetSolariumiCeniFrame.Label49.Caption:=GetLabel('L49');
    GetSolariumiCeniFrame.Label50.Caption:=GetLabel('L50');
    GetSolariumiCeniFrame.Label53.Caption:=GetLabel('L53');
    GetSolariumiNastroikiFrame.Label51.Caption:=GetLabel('L51');
 //   GetSolariumiInfoFrame.Label54.Caption:=GetLabel('L54');
    GetSolariumiInfoFrame.Label55.Caption:=GetLabel('L55');
    GetSolariumiInfoFrame.Label57.Caption:=GetLabel('L57');
    GetSolariumiInfoFrame.Label63.Caption:=GetLabel('L63');
    GetSolariumiInfoFrame.Label65.Caption:=GetLabel('L65');
    GetSolariumiNastroikiFrame.Label61.Caption:=GetLabel('L61');
    GetSolariumiInfoFrame.Label66.Caption:=GetLabel('L66');
    GetSolariumiNastroikiFrame.Label67.Caption:=GetLabel('L67');
    GetStatistikaFrame.Label68.Caption:=GetLabel('L68');
    GetNachalnoUstanoviavaneFrame.Label75.Caption:=GetLabel('L75');
    GetNachalnoUstanoviavaneFrame.Label76.Caption:=GetLabel('L76');
    GetNachalnoUstanoviavaneFrame.Label77.Caption:=GetLabel('L77');
    GetNachalnoUstanoviavaneFrame.Label78.Caption:=GetLabel('L78');
    GetNachalnoUstanoviavaneFrame.Label79.Caption:=GetLabel('L79');
    GetNachalnoUstanoviavaneFrame.Label80.Caption:=GetLabel('L80');
    GetOsnovenEkranFrame.Label91.Caption:=GetLabel('L91');
    GetSolariumiNastroikiFrame.Label90.Caption:=GetLabel('L90');
    GetOsnovenEkranFrame.Label92.Caption:=GetLabel('L92');
    GetOsnovniNastroikiFrame.Label95.Caption:=GetLabel('L95');
    GetSolariumiNastroikiFrame.Label96.Caption:=GetLabel('L96');
    GetSolariumiNastroikiFrame.Label30.Caption:=GetLabel('L30');
    GetSolariumiInfoFrame.Label56.Caption:=GetLabel('L56');
    GetSolariumiCeniFrame.Label97.Caption:=GetLabel('L97');
    GetDrugiNastroikiFrame.Label98.Caption:=GetLabel('L98');
    GetProtokolFrame.Label52.Caption:=GetLabel('L52');
    GetDrugiNastroikiFrame.Label99.Caption:=GetLabel('L99');
    GetDrugiNastroikiFrame.Label100.Caption:=GetLabel('L100');
    GetDrugiNastroikiFrame.Label101.Caption:=GetLabel('L101');
    GetDrugiNastroikiFrame.Label102.Caption:=GetLabel('L102');
    GetIzborNaPlashtaneFrame.Label103.Caption:=GetLabel('L103');
    GetIzborNaPlashtaneFrame.Label104.Caption:=GetLabel('L104');
    GetIzborNaPlashtaneFrame.Label105.Caption:=GetLabel('L105');
    GetSolariumiNastroikiFrame.Label106.Caption:=GetLabel('L106');
    GetProtokolFrame.Label107.Caption:=GetLabel('L107');
    GetStatistikaFrame.Label108.Caption:=GetLabel('L108');
    GetProtokolFrame.Label109.Caption:=GetLabel('L109');
    GetOsnovenEkranFrame.Label110.Caption:=GetLabel('L110');
   // GetDrugiNastroikiFrame.Label121.Caption:=GetLabel('L121');
    GetMenuStokiFrame.Label123.Caption:=GetLabel('L123');
    //GetMenuStokiFrame.Label124.Caption:=GetLabel('L124');
//    GetMenuKasaFrame.LMDSimpleLabel1.Caption:=GetLabel('LMDSL1');
    GetMenuStokiFrame.LMDSimpleLabel2.Caption:=GetLabel('LMDSL2');
    GetDrugiNastroikiFrame.Label122.Caption:=GetLabel('L122');
    GetKlubniKartiFrame.Label125.Caption:=GetLabel('L125');
    //GetKlubniKartiFrame.Label126.Caption:=GetLabel('L126');
    //GetChipKartiFrame.Label128.Caption:=GetLabel('L128');
    GetKlubniKartiFrame.Label129.Caption:=GetLabel('L129');
    GetIzborNaPlashtaneFrame.Label130.Caption:=GetLabel('L130');
    GetMenuKasaFrame.Label6.Caption:=GetLabel('L6');
    GetMenuKasaFrame.LMDSimpleLabel3.Caption:=GetLabel('LMDSL3');
    GetMenuKasaFrame.LMDSimpleLabel4.Caption:=GetLabel('LMDSL4');
//    GetMenuKasaFrame.LMDSimpleLabel5.Caption:=GetLabel('LMDSL5');
  //  KasseLabel.Caption:=GetLabel('KL');
    GetMenuKasaFrame.Label111.Caption:=GetLabel('L111');
  //  GetChipKartiFrame.Label112.Caption:=GetLabel('L112');
    GetIzborNaPlashtaneFrame.Label113.Caption:=GetLabel('L113');
    GetSolariumiCeniFrame.Label114.Caption:=GetLabel('L114');
    GetSolariumiNastroikiFrame.Label115.Caption:=GetLabel('L115');
    GetSolariumiInfoFrame.Label116.Caption:=GetLabel('L116');
    GetSolariumiCeniFrame.Label117.Caption:=GetLabel('L117');
    GetIzborNaPlashtaneFrame.Label119.Caption:=GetLabel('L119');
    GetIzborNaPlashtaneFrame.Label127.Caption:=GetLabel('L127');
    //GetDrugiNastroikiFrame.Label120.Caption:=GetLabel('L120');
    GetKlubniKartiFrame.Label94.Caption:=GetLabel('L94');
    GetIzborNaVremeFrame.Label133.Caption:=GetLabel('L133');
  //  GetOsnovenEkranFrame.Label143.Caption:=GetLabel('L143');
    GetOsnovenEkranFrame.Label144.Caption:=GetLabel('L144');
    GetStatistikaFrame.Label147.Caption:=GetLabel('L147');
    GetStatistikaFrame.Label148.Caption:=GetLabel('L148');
    GetIzborNaPlashtaneFrame.Label149.Caption:=GetLabel('L149');
    GetOsnovniNastroikiFrame.Label58.Caption:=GetLabel('L58');
    //GetSolariumiCeniFrame.Label59.Caption:=GetLabel('L59');
    GetIzborNaPlashtaneFrame.Label60.Caption:=GetLabel('L60');
    GetIzborNaPlashtaneFrame.Label69.Caption:=GetLabel('L69');
    GetIzborNaPlashtaneFrame.Label70.Caption:=GetLabel('L70');
    GetIzborNaPlashtaneFrame.Label71.Caption:=GetLabel('L71');
    GetIzborNaPlashtaneFrame.Label72.Caption:=GetLabel('L72');
    GetSolariumiCeniFrame.Label73.Caption:=GetLabel('L73');
    GetSolariumiCeniFrame.Label93.Caption:=GetLabel('L93');
    GetSolariumiCeniFrame.Label118.Caption:=GetLabel('L118');
    GetSolariumiNastroikiFrame.Label131.Caption:=GetLabel('L131');
    GetSolariumiNastroikiFrame.Label132.Caption:=GetLabel('L132');
    GetOsnovniNastroikiFrame.Label74.Caption:=GetLabel('L74');
    GetOsnovniNastroikiFrame.Label134.Caption:=GetLabel('L134');
    GetOsnovniNastroikiFrame.Label135.Caption:=GetLabel('L135');
    GetChipKartiFrame.Label136.Caption:=GetLabel('L136');
    GetChipKartiFrame.Label137.Caption:=GetLabel('L137');
    GetChipKartiFrame.Label138.Caption:=GetLabel('L138');
    GetChipKartiFrame.Label139.Caption:=GetLabel('L139');
    GetChipKartiFrame.Label140.Caption:=GetLabel('L140');
    GetChipKartiFrame.Label141.Caption:=GetLabel('L141');
    GetSolariumiNastroikiFrame.Label151.Caption:=GetLabel('L151');
    GetSolariumiNastroikiFrame.Label152.Caption:=GetLabel('L152');
    GetSolariumiNastroikiFrame.Label153.Caption:=GetLabel('L153');
    //PopupMenu1.Items[0].Caption := GetMenuItem(14);
    N1.Caption:= GetMenuItem('N1');
    N2.Caption:= GetMenuItem('N2');
    //PopupMenu2: TPopupMenu;
    N3.Caption:= GetMenuItem('N3');
    N4.Caption:= GetMenuItem('N4');
    N5.Caption:= GetMenuItem('N5');
   // PopupMenu3: TPopupMenu;
    GetLogoEkranFrame.Label64.Caption:=GetLabel('L64');
    GetNachalnoUstanoviavaneFrame.Label81.Caption:=GetLabel('L81');
    GetNachalnoUstanoviavaneFrame.Label82.Caption:=GetLabel('L82');
    GetNachalnoUstanoviavaneFrame.Label83.Caption:=GetLabel('L83');
    GetNachalnoUstanoviavaneFrame.Label84.Caption:=GetLabel('L84');
    GetNachalnoUstanoviavaneFrame.Label85.Caption:=GetLabel('L85');
    GetNachalnoUstanoviavaneFrame.Label86.Caption:=GetLabel('L86');
    GetNachalnoUstanoviavaneFrame.Label87.Caption:=GetLabel('L87');
 //   GetMenuStokiFrame.Label88.Caption:=GetLabel('L88');
  //  GetChipKartiFrame.Label89.Caption:=GetLabel('L89');
   // GetSolariumiNastroikiFrame.Label90.Caption:=GetLabel('L90');
  //  GetSolariumiNastroikiFrame.Label106.Caption:=GetLabel('L106');
  //  GetDrugiNastroikiFrame.Label142.Caption:=GetLabel('L142');
  //  GetChipKartiFrame.Label145.Caption:=GetLabel('L145');
    GetIzborNaVremeFrame.Label146.Caption:=GetLabel('L146');
    GetStatistikaFrame.Label150.Caption:=GetLabel('L150');
    GetOsnovniNastroikiFrame.Label42.Caption:=GetLabel('L42');
    GetArhiviraneFrame.Label1000.Caption:=GetLabel('L1000');
    GetArhiviraneFrame.Label2.Caption:=GetLabel('L2');
    GetArhiviraneFrame.Label3.Caption:=GetLabel('L3');
    GetArhiviraneFrame.Label1.Caption:=GetLabel('L1');

    GetSolariumiNastroikiFrame.DBComboBox1.Text:=GetButtonText('DBCB1');
    GetSolariumiNastroikiFrame.DBComboBox3.Text:=GetButtonText('DBCB3');
    GetSolariumiNastroikiFrame.DBComboBox4.Text:=GetButtonText('DBCB4');
    GetSolariumiNastroikiFrame.DBComboBox5.Text:=GetButtonText('DBCB5');
    GetSolariumiNastroikiFrame.DBComboBox8.Text:=GetButtonText('DBCB8');
    GetSolariumiNastroikiFrame.LMDDBCheckBox1.Caption:=GetButtonText('LMDCB1');
//    GetProtokolFrame.GetProtokolFrame.wwDBGrid2.ControlType.Names[0]:=GetButtonText('WWDBG2-0');
 //   GetMenuStokiFrame.wwDBGrid4.ControlType.Names[0]:=GetButtonText('WWDBG4-0');
//    GetFirmiISluziteliFrame.LMDButton2.Caption:=GetButtonText('LMDB2');
//    GetChipKartiFrame.LMDButton3.caption:=GetButtonText('LMDB3');
//    LMDButton4.Caption:=GetButtonText('LMDB4');
//    GetKlubniKartiFrame.wwDBGrid6.ControlType.Names[0]:=GetButtonText('WWDBG6-0');
//    GetKlubniKartiFrame.GetKlubniKartiFrame.wwDBGrid7.ControlType.Names[0]:=GetButtonText('WWDBG7-0');
    GetIzborNaPlashtaneFrame.AdvComboBox1.Text:=GetButtonText('ADVCB1');
    GetKlubniKartiFrame.LMDButton5.Caption:=GetButtonText('LMDB5');
    GetKlubniKartiFrame.LMDButton6.Caption:=GetButtonText('LMDB6');
    GetKlubniKartiFrame.LMDButton7.Caption:=GetButtonText('LMDB7');
    GetKlubniKartiFrame.LMDButton8.Caption:=GetButtonText('LMDB8');
    GetIzborNaPlashtaneFrame.AdvComboBox2.Text:=GetButtonText('ADVCB2');
//    GetChipKartiFrame.GetChipKartiFrame.wwDBGrid5.ControlType.Names[0]:=GetButtonText('WWDBG5-0');
    GetChipKartiFrame.NuliraneChipCartaButton.Caption:=GetButtonText('LMDB9');

    GetChipKartiFrame.NovKlientButton.Caption:=GetButtonText('LMDB6');
    GetOsnovniNastroikiFrame.LMDButton10.Caption:=GetButtonText('LMDB10');
    GetOsnovniNastroikiFrame.LMDButton12.Caption:=GetButtonText('LMDB12');
    GetOsnovniNastroikiFrame.LMDButton13.Caption:=GetButtonText('LMDB13');
    GetOsnovniNastroikiFrame.LMDButton14.Caption:=GetButtonText('LMDB14');
//    GetFirmiISluziteliFrame.LMDButton1.Caption:=GetButtonText('LMDB1');
    GetOsnovniNastroikiFrame.LMDButton15.Caption:=GetButtonText('LMDB15');

    GetStatistikaFrame.StatistikaBox1.Caption:=GetButtonText('SB1');
    GetSolariumiNastroikiFrame.LMDButton16.Caption:=GetButtonText('LMDB16');
    GetSolariumiNastroikiFrame.LMDButton17.Caption:=GetButtonText('LMDB17');

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
         if i < GetProtokolFrame.wwDBGrid2.FieldCount then GetProtokolFrame.wwDBGrid2.Fields[i].DisplayLabel
            :=GetButtonText('Plashtania'+IntToStr(i));
 //        if i < KARTIALL.Fields.Count then KARTIALL.Fields.Fields[i].DisplayLabel
 //           :=GetButtonText('KARTIALL'+IntToStr(i));
 //        if i < solariumspr.Fields.Count then solariumspr.Fields.Fields[i].DisplayLabel
 //           :=GetButtonText('solariumspr'+IntToStr(i));
 //        if i < stokispr.Fields.Count then stokispr.Fields.Fields[i].DisplayLabel
 //           :=GetButtonText('stokispr'+IntToStr(i));
 //        if i < CHIPKARTI.Fields.Count then CHIPKARTI.Fields.Fields[i].DisplayLabel
 //           :=GetButtonText('CHIPKARTI'+IntToStr(i));
         if i < GetOsnovniNastroikiFrame.wwDBGrid1.FieldCount then GetOsnovniNastroikiFrame.wwDBGrid1.Fields[i].DisplayLabel
            :=GetButtonText('personal1'+IntToStr(i));

         if i < GetMenuStokiFrame.wwDBGrid3.FieldCount then GetMenuStokiFrame.wwDBGrid3.Fields[i].DisplayLabel
            :=GetButtonText('KARTI'+IntToStr(i));
         if i < GetMenuKasaFrame.KasaGrid.FieldCount then GetMenuKasaFrame.KasaGrid.Fields[i].DisplayLabel
            :=GetButtonText('STOKITE'+IntToStr(i));
            //DM.sol1.DataSets[1].Fields[1].DisplayName
         if i < GetChipKartiFrame.wwDBGrid5.FieldCount then GetChipKartiFrame.wwDBGrid5.Fields[i].DisplayLabel
            :=GetButtonText('QKLIENTI'+IntToStr(i));
         if i < GetKlubniKartiFrame.wwDBGrid7.FieldCount then GetKlubniKartiFrame.wwDBGrid7.Fields[i].DisplayLabel
            :=GetButtonText('QKARTI'+IntToStr(i));
         if i < GetMenuKasaFrame.wwDBGrid9.FieldCount  then GetMenuKasaFrame.wwDBGrid9.Fields[i].DisplayLabel
            :=GetButtonText('SDELKA'+IntToStr(i));
         if i < DayTotal.Fields.Count then DayTotal.Fields.Fields[i].DisplayLabel
            :=GetButtonText('DayTotal'+IntToStr(i));
         if i < GetStatistikaFrame.wwDBGrid10.FieldCount  then GetStatistikaFrame.wwDBGrid10.Fields[i].DisplayLabel
            :=GetButtonText('QStatistika'+IntToStr(i));

       end;
   end;

     with Form1 do // QReportKlienti
    begin
     QRLabel1.Caption:=  GetLabel('QRF1L1');
     QRLabel2.Caption:= GetLabel('QRF1L2');
     QRLabel3.Caption:= GetLabel('QRF1L3');
     QRLabel4.Caption:=  GetLabel('QRF1L4');
     QRLabel5.Caption:= GetLabel('QRF1L5');
     QRLabel6.Caption:= GetLabel('QRF1L6');
     QRLabel7.Caption:= GetLabel('QRF1L7');
     QRLabel8.Caption:= GetLabel('QRF1L8');
     QRLabel9.Caption:= GetLabel('QRF1L9');
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
    QRLabel6.Caption:= GetLabel('QRF3L6');
    QRLabel7.Caption:= GetLabel('QRF3L7');
    QRLabel8.Caption:= GetLabel('QRF3L8');
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
    Label2.Caption:= GetLabel('RFL2');
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

    SaveLabel('L4',  GetIzborNaVremeFrame.Label4.Caption);
    SaveLabel('L5',GetIzborNaVremeFrame.Label5.Caption);
    SaveLabel('L7',GetIzborNaVremeFrame.Label7.Caption);
    SaveLabel('L10',GetIzborNaVremeFrame.Label10.Caption);
    SaveLabel('L11',GetIzborNaVremeFrame.Label11.Caption);
    SaveLabel('L12',  GetMenuFrame.Label12.Caption);
    SaveLabel('L13',  GetMenuFrame.Label13.Caption);
    SaveLabel('L14',  GetMenuFrame.Label14.Caption);
    SaveLabel('L15',  GetMenuFrame.Label15.Caption);
    SaveLabel('L16',  GetMenuFrame.Label16.Caption);
    SaveLabel('L17',  GetMenuFrame.Label17.Caption);
    SaveLabel('L18',  GetMenuFrame.Label18.Caption);
    SaveLabel('L19',  GetMenuFrame.Label19.Caption);
    SaveLabel('L20',  GetMenuFrame.Label20.Caption);
    SaveLabel('L21',  GetMenuFrame.Label21.Caption);
    SaveLabel('L22',  GetMenuFrame.Label22.Caption);
    SaveLabel('L23',  GetMenuFrame.Label23.Caption);
    SaveLabel('L24',  GetMenuFrame.Label24.Caption);
    SaveLabel('L25',  GetIzborNaPlashtaneFrame.Label25.Caption);
    SaveLabel('L26',  GetIzborNaPlashtaneFrame.Label26.Caption);
    SaveLabel('L27',  GetIzborNaPlashtaneFrame.Label27.Caption);
    //SaveLabel('L28',  GetSolariumiCeniFrame.Label28.Caption);
    SaveLabel('L29',  GetIzborNaPlashtaneFrame.Label29.Caption);
    SaveLabel('L31',  GetSolariumiNastroikiFrame.Label31.Caption);
    SaveLabel('L32',  GetSolariumiCeniFrame.Label32.Caption);
    //SaveLabel('L33',  GetIzborNaVremeFrame.Label33.Caption);
    SaveLabel('L34',  GetSolariumiNastroikiFrame.Label34.Caption);
    SaveLabel('L35',  GetSolariumiNastroikiFrame.Label35.Caption);
    SaveLabel('L36',  GetSolariumiNastroikiFrame.Label36.Caption);
    SaveLabel('L37',  GetSolariumiNastroikiFrame.Label37.Caption);
    SaveLabel('L38',  GetSolariumiNastroikiFrame.Label38.Caption);
    SaveLabel('L39',  GetSolariumiNastroikiFrame.Label39.Caption);
    SaveLabel('L41',  GetSolariumiNastroikiFrame.Label41.Caption);
    SaveLabel('L43',  GetSolariumiNastroikiFrame.Label43.Caption);
    SaveLabel('L44',  GetSolariumiNastroikiFrame.Label44.Caption);
    SaveLabel('L45',  GetSolariumiNastroikiFrame.Label45.Caption);
    //SaveLabel('L40',  GetIzborNaVremeFrame.Label40.Caption);
    SaveLabel('L46',  GetSolariumiInfoFrame.Label46.Caption);
    SaveLabel('L47',  GetIzborNaVremeFrame.Label47.Caption);
    SaveLabel('L48',  GetSolariumiCeniFrame.Label48.Caption);
    SaveLabel('L49',  GetSolariumiCeniFrame.Label49.Caption);
    SaveLabel('L50',  GetSolariumiCeniFrame.Label50.Caption);
    SaveLabel('L53',  GetSolariumiCeniFrame.Label53.Caption);
    SaveLabel('L51',  GetSolariumiNastroikiFrame.Label51.Caption);
    SaveLabel('L54',  GetSolariumiInfoFrame.Label54.Caption);
    SaveLabel('L55',  GetSolariumiInfoFrame.Label55.Caption);
    SaveLabel('L61',  GetSolariumiNastroikiFrame.Label61.Caption);
    SaveLabel('L66',  GetSolariumiInfoFrame.Label66.Caption);
    SaveLabel('L67',  GetSolariumiNastroikiFrame.Label67.Caption);
    SaveLabel('L68',  GetStatistikaFrame.Label68.Caption);
    SaveLabel('L75',  GetNachalnoUstanoviavaneFrame.Label75.Caption);
    SaveLabel('L76',  GetNachalnoUstanoviavaneFrame.Label76.Caption);
    SaveLabel('L77',  GetNachalnoUstanoviavaneFrame.Label77.Caption);
    SaveLabel('L78',  GetNachalnoUstanoviavaneFrame.Label78.Caption);
    SaveLabel('L79',  GetNachalnoUstanoviavaneFrame.Label79.Caption);
    SaveLabel('L80',  GetNachalnoUstanoviavaneFrame.Label80.Caption);
    SaveLabel('L91',  GetOsnovenEkranFrame.Label91.Caption);
    SaveLabel('L92',  GetOsnovenEkranFrame.Label92.Caption);
    SaveLabel('L95',  GetOsnovniNastroikiFrame.Label95.Caption);
    SaveLabel('L96',  GetSolariumiNastroikiFrame.Label96.Caption);
    SaveLabel('L30',  GetSolariumiNastroikiFrame.Label30.Caption);
    SaveLabel('L56',  GetSolariumiInfoFrame.Label56.Caption);
    SaveLabel('L97',  GetSolariumiCeniFrame.Label97.Caption);
    SaveLabel('L98',  GetDrugiNastroikiFrame.Label98.Caption);
    SaveLabel('L52',  GetProtokolFrame.Label52.Caption);
    SaveLabel('L99',  GetDrugiNastroikiFrame.Label99.Caption);
    SaveLabel('L100',  GetDrugiNastroikiFrame.Label100.Caption);
    SaveLabel('L101',  GetDrugiNastroikiFrame.Label101.Caption);
    SaveLabel('L102',  GetDrugiNastroikiFrame.Label102.Caption);
    SaveLabel('L103',  GetIzborNaPlashtaneFrame.Label103.Caption);
    SaveLabel('L104',  GetIzborNaPlashtaneFrame.Label104.Caption);
    SaveLabel('L105',  GetIzborNaPlashtaneFrame.Label105.Caption);
    SaveLabel('L107',  GetProtokolFrame.Label107.Caption);
    SaveLabel('L108',  GetStatistikaFrame.Label108.Caption);
    SaveLabel('L109',  GetProtokolFrame.Label109.Caption);
    SaveLabel('L110',  GetOsnovenEkranFrame.Label110.Caption);
    //SaveLabel('L121',  GetDrugiNastroikiFrame.Label121.Caption);
    SaveLabel('L123',  GetMenuStokiFrame.Label123.Caption);
    //SaveLabel('L124',  GetMenuStokiFrame.Label124.Caption);
    //SaveLabel('LMDSL1',  GetMenuKasaFrame.LMDSimpleLabel1.Caption);
    SaveLabel('LMDSL2',  GetMenuStokiFrame.LMDSimpleLabel2.Caption);
    SaveLabel('L122',  GetDrugiNastroikiFrame.Label122.Caption);
    SaveLabel('L125',  GetKlubniKartiFrame.Label125.Caption);
    //SaveLabel('L126',  GetKlubniKartiFrame.Label126.Caption);
    //SaveLabel('L128',  GetChipKartiFrame.Label128.Caption);
    SaveLabel('L129',  GetKlubniKartiFrame.Label129.Caption);
    SaveLabel('L130',  GetIzborNaPlashtaneFrame.Label130.Caption);
    SaveLabel('L6',  GetMenuKasaFrame.Label6.Caption);
    SaveLabel('LMDSL3',  GetMenuKasaFrame.LMDSimpleLabel3.Caption);
    SaveLabel('LMDSL4',  GetMenuKasaFrame.LMDSimpleLabel4.Caption);
    //SaveLabel('LMDSL5',  GetMenuKasaFrame.LMDSimpleLabel5.Caption);
    //SaveLabel('KL',  KasseLabel.Caption);
    SaveLabel('L111',  GetMenuKasaFrame.Label111.Caption);
    //SaveLabel('L112',  GetChipKartiFrame.Label112.Caption);
    SaveLabel('L113',  GetIzborNaPlashtaneFrame.Label113.Caption);
    SaveLabel('L114',  GetSolariumiCeniFrame.Label114.Caption);
    SaveLabel('L115',  GetSolariumiNastroikiFrame.Label115.Caption);
    SaveLabel('L116',  GetSolariumiInfoFrame.Label116.Caption);
    SaveLabel('L117',  GetSolariumiCeniFrame.Label117.Caption);
    SaveLabel('L119',  GetIzborNaPlashtaneFrame.Label119.Caption);
    SaveLabel('L127',  GetIzborNaPlashtaneFrame.Label127.Caption);
//    SaveLabel('L120',  GetDrugiNastroikiFrame.Label120.Caption);
    SaveLabel('L94',  GetKlubniKartiFrame.Label94.Caption);
    SaveLabel('L133',  GetIzborNaVremeFrame.Label133.Caption);
    SaveLabel('L143',  GetOsnovenEkranFrame.Label143.Caption);
    SaveLabel('L144',  GetOsnovenEkranFrame.Label144.Caption);
    SaveLabel('L147',  GetStatistikaFrame.Label147.Caption);
    SaveLabel('L148',  GetStatistikaFrame.Label148.Caption);
    SaveLabel('L149',  GetIzborNaPlashtaneFrame.Label149.Caption);
    SaveLabel('L58',  GetOsnovniNastroikiFrame.Label58.Caption);
    SaveLabel('L59',  GetSolariumiCeniFrame.Label59.Caption);
    SaveLabel('L60',  GetIzborNaPlashtaneFrame.Label60.Caption);
    SaveLabel('L69',  GetIzborNaPlashtaneFrame.Label69.Caption);
    SaveLabel('L70',  GetIzborNaPlashtaneFrame.Label70.Caption);
    SaveLabel('L71',  GetIzborNaPlashtaneFrame.Label71.Caption);
    SaveLabel('L72',  GetIzborNaPlashtaneFrame.Label72.Caption);
    SaveLabel('L73',  GetSolariumiCeniFrame.Label73.Caption);
    SaveLabel('L93',  GetSolariumiCeniFrame.Label93.Caption);
    SaveLabel('L118',  GetSolariumiCeniFrame.Label118.Caption);
    SaveLabel('L131',  GetSolariumiNastroikiFrame.Label131.Caption);
    SaveLabel('L132',  GetSolariumiNastroikiFrame.Label132.Caption);
    SaveLabel('L74',  GetOsnovniNastroikiFrame.Label74.Caption);
    SaveLabel('L134',  GetOsnovniNastroikiFrame.Label134.Caption);
    SaveLabel('L135',  GetOsnovniNastroikiFrame.Label135.Caption);
    SaveLabel('L136',  GetChipKartiFrame.Label136.Caption);
    SaveLabel('L137',  GetChipKartiFrame.Label137.Caption);
    SaveLabel('L138',  GetChipKartiFrame.Label138.Caption);
    SaveLabel('L139',  GetChipKartiFrame.Label139.Caption);
    SaveLabel('L140',  GetChipKartiFrame.Label140.Caption);
    SaveLabel('L141',  GetChipKartiFrame.Label141.Caption);
    //PopupMenu1.Items[0].Caption ) GetMenuItem(14,;
    SaveMenu('N1',  N1.Caption) ;
    SaveMenu('N2',  N2.Caption) ;
    //PopupMenu2: TPopupMenu;
    SaveMenu('N3',  N3.Caption) ;
    SaveMenu('N4',  N4.Caption) ;
    SaveMenu('N5',  N5.Caption) ;
   // PopupMenu3: TPopupMenu;
    SaveLabel('L64',  GetLogoEkranFrame.Label64.Caption);
    SaveLabel('L81',  GetNachalnoUstanoviavaneFrame.Label81.Caption);
    SaveLabel('L82',  GetNachalnoUstanoviavaneFrame.Label82.Caption);
    SaveLabel('L83',  GetNachalnoUstanoviavaneFrame.Label83.Caption);
    SaveLabel('L84',  GetNachalnoUstanoviavaneFrame.Label84.Caption);
    SaveLabel('L85',  GetNachalnoUstanoviavaneFrame.Label85.Caption);
    SaveLabel('L86',  GetNachalnoUstanoviavaneFrame.Label86.Caption);
    SaveLabel('L87',  GetNachalnoUstanoviavaneFrame.Label87.Caption);
    SaveLabel('L88',  GetMenuStokiFrame.Label88.Caption);
    //SaveLabel('L89',  GetChipKartiFrame.Label89.Caption);
    //SaveLabel('L90',  GetSolariumiNastroikiFrame.Label90.Caption);
    //SaveLabel('L106',  GetSolariumiNastroikiFrame.Label106.Caption);
    //SaveLabel('L142',  GetDrugiNastroikiFrame.Label142.Caption);
    // SaveLabel('L145',  GetChipKartiFrame.Label145.Caption);
    SaveLabel('L146',  GetIzborNaVremeFrame.Label146.Caption);
    SaveLabel('L150',  GetStatistikaFrame.Label150.Caption);
    SaveLabel('L42',  GetOsnovniNastroikiFrame.Label42.Caption);
    SaveLabel('L1000',  GetArhiviraneFrame.Label1000.Caption);
    SaveLabel('L2',  GetArhiviraneFrame.Label2.Caption);
    SaveLabel('L3',  GetArhiviraneFrame.Label3.Caption);
    SaveLabel('L1',  GetArhiviraneFrame.Label1.Caption);

    SaveButton('DBCB1', GetSolariumiNastroikiFrame.DBComboBox1.Text);
    SaveButton('DBCB3', GetSolariumiNastroikiFrame.DBComboBox3.Text);
    SaveButton('DBCB4', GetSolariumiNastroikiFrame.DBComboBox4.Text);
    SaveButton('DBCB5', GetSolariumiNastroikiFrame.DBComboBox5.Text);
    SaveButton('DBCB8', GetSolariumiNastroikiFrame.DBComboBox8.Text);
    SaveButton('LMDCB1', GetSolariumiNastroikiFrame.LMDDBCheckBox1.Caption);
    //SaveButton('WWDBG2-0', GetProtokolFrame.GetProtokolFrame.wwDBGrid2.ControlType.Names[1]);
    //SaveButton('WWDBG4-0', GetMenuStokiFrame.wwDBGrid4.ControlType.Names[1]);
    //SaveButton('LMDB2', GetFirmiISluziteliFrame.LMDButton2.Caption);
    //SaveButton('LMDB3', GetChipKartiFrame.LMDButton3.caption);
    //SaveButton('LMDB4', LMDButton4.Caption);
    //SaveButton('WWDBG6-0', GetKlubniKartiFrame.wwDBGrid6.ControlType.Names[1]);
    //SaveButton('WWDBG7-0', GetKlubniKartiFrame.GetKlubniKartiFrame.wwDBGrid7.ControlType.Names[1]);
    SaveButton('ADVCB1', GetIzborNaPlashtaneFrame.AdvComboBox1.Text);
    //SaveButton('WWDBG8-0', GetSolariumiCeniFrame.wwDBGrid8.ControlType.Names[1]);
    //SaveButton('WWDBG9-0', GetMenuKasaFrame.GetMenuKasaFrame.wwDBGrid9.ControlType.Names[1]);
    SaveButton('LMDB5', GetKlubniKartiFrame.LMDButton5.Caption);
    SaveButton('LMDB6', GetKlubniKartiFrame.LMDButton6.Caption);
    SaveButton('LMDB7', GetKlubniKartiFrame.LMDButton7.Caption);
    SaveButton('LMDB8', GetKlubniKartiFrame.LMDButton8.Caption);
    SaveButton('ADVCB2', GetIzborNaPlashtaneFrame.AdvComboBox2.Text);
    //SaveButton('WWDBG5-0', GetChipKartiFrame.GetChipKartiFrame.wwDBGrid5.ControlType.Names[1]);
    //SaveButton('WWIB1', wwIButton1.Caption);
    SaveButton('LMDB9', GetChipKartiFrame.NuliraneChipCartaButton.Caption);
    SaveButton('LMDB1', GetChipKartiFrame.NovKlientButton.Caption);
    SaveButton('LMDB10', GetOsnovniNastroikiFrame.LMDButton10.Caption);
    SaveButton('LMDB12', GetOsnovniNastroikiFrame.LMDButton12.Caption);
    SaveButton('LMDB13', GetOsnovniNastroikiFrame.LMDButton13.Caption);
    SaveButton('LMDB14', GetOsnovniNastroikiFrame.LMDButton14.Caption);
    //SaveButton('LMDB1', GetFirmiISluziteliFrame.LMDButton1.Caption);
    SaveButton('LMDB15', GetOsnovniNastroikiFrame.LMDButton15.Caption);
    //SaveButton('WWDBG1-0', GetOsnovniNastroikiFrame.GetOsnovniNastroikiFrame.wwDBGrid1.ControlType.Names[1]);
    //SaveButton('WWIB2', wwIButton2.Caption);
    //SaveButton('WWDBG10-0', GetStatistikaFrame.GetStatistikaFrame.wwDBGrid10.ControlType.Names[1]);
    SaveButton('SB1', GetStatistikaFrame.StatistikaBox1.Caption);
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
     SaveLabel('QRF1L1' ,QRLabel1.Caption ) ;
     SaveLabel('QRF1L2' ,QRLabel2.Caption ) ;
     SaveLabel('QRF1L3' ,QRLabel3.Caption ) ;
     SaveLabel('QRF1L4' ,QRLabel4.Caption ) ;
     SaveLabel('QRF1L5' ,QRLabel5.Caption ) ;
     SaveLabel('QRF1L6' ,QRLabel6.Caption ) ;
     SaveLabel('QRF1L7' ,QRLabel7.Caption ) ;
     SaveLabel('QRF1L8' ,QRLabel8.Caption ) ;
     SaveLabel('QRF1L9' ,QRLabel9.Caption ) ;
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
     SaveLabel('QRF3L6',QRLabel6.Caption);
     SaveLabel('QRF3L7',QRLabel7.Caption);
     SaveLabel('QRF3L8',QRLabel8.Caption);
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
     SaveLabel('RFL2',Label2.Caption);
     SaveLabel('RFL5',Label5.Caption);
     SaveLabel('RFL3',Label3.Caption);
     SaveLabel('RFL4',Label4.Caption);
     SaveLabel('RFP1',Panel1.Caption);
     SaveLabel('RFP2',Panel2.Caption);
    end;
    SaveLabel('RFFM',RefillForm.caption);
  end;

end.
