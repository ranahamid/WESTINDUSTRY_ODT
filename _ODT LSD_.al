table 50001 "ODT LSD"
{
  Caption = 'LSD';
  DataCaptionFields = "LSD Code", "LSD Format Code";
  DrillDownPageID = "ODT LSD List";
  LookupPageID = "ODT LSD List";

  fields
  {
    field(1;"LSD Format Code";Code[20])
    {
      NotBlank = true;
      TableRelation = "ODT LSD Format".Code;
    }
    field(2;"LSD Code";Code[50])
    {
      NotBlank = true;

      trigger OnValidate();
      var LSD: Record "ODT LSD";
      TEXT001: Label 'LSD %1 already exists.';
      lLSD: Code[50];
      begin
        //TESTFIELD("From LSD Format");
        if "LSD Code" <> '' then LSDFormats.ValidateFormat("LSD Format Code", "LSD Code");
        //NB03.87+ Check that new LSD Code entered is unique.
        lLSD:="LSD Code";
        LSD.RESET;
        LSD.SETRANGE("LSD Code", lLSD);
        if LSD.FINDFIRST then ERROR(TEXT001, lLSD);
      //NB03.87-
      end;
    }
    field(3;Type;Enum "ODT LSD Type")
    {
      Caption = 'Type';
    }
    // field(4;"SUR Dispatch Requests";Integer)
    // {
    //     CalcFormula = Count(Table50300 WHERE (Field60=FIELD("LSD Code")));
    //     FieldClass = FlowField;
    // }
    // field(5;"DH Dispatch Requests";Integer)
    // {
    //     CalcFormula = Count(Table50300 WHERE (Field70=FIELD("LSD Code")));
    //     FieldClass = FlowField;
    // }
    field(6;"Surface LSD";Code[50])
    {
      TableRelation = "ODT LSD"."LSD Code" WHERE(Type=CONST(Surface));

      trigger OnValidate();
      var SurfaceLSD: Record "ODT LSD";
      begin
        //<NB03.87>
        if Type = Type::Downhole then begin
          SurfaceLSD.RESET;
          SurfaceLSD.SETRANGE(Type, Type::Surface);
          SurfaceLSD.SETRANGE("LSD Code", "Surface LSD");
          if SurfaceLSD.FINDFIRST then "Surface LSD Format":=SurfaceLSD."LSD Format Code"
          else
            "Surface LSD Format":='';
        end;
        if "Surface LSD" = '' then CLEAR("Surface LSD Format");
      //</NB03.87>
      end;
    }
    field(7;"Surface LSD Format";Code[20])
    {
      Editable = false;
      TableRelation = "ODT LSD Format".Code;
    }
    field(10;"No. of Downhole LSD";Integer)
    {
      CalcFormula = Count("ODT LSD" WHERE(Type=CONST(Downhole), "Surface LSD"=FIELD("LSD Code"), "Surface LSD Format"=FIELD("LSD Format Code")));
      FieldClass = FlowField;
    }
    // field(11;"Used as Load LSD";Integer)
    // {
    //     CalcFormula = Count(Table50300 WHERE (Field90=FIELD("LSD Code")));
    //     FieldClass = FlowField;
    // }
    // field(12;"Used as Delivery LSD";Integer)
    // {
    //     CalcFormula = Count(Table50300 WHERE (Field100=FIELD("LSD Code")));
    //     FieldClass = FlowField;
    // }
    // field(13;"Used as Charge LSD";Integer)
    // {
    //     CalcFormula = Count(Table50300 WHERE (Field80=FIELD("LSD Code")));
    //     FieldClass = FlowField;
    // }
    field(11;"Bottom Hole";Code[50])
    {
      Caption = 'Bottom Hole';
      Editable = false;
    //TableRelation = "ODT LSD Format".Code;
    }
    field(12;Start;Code[50])
    {
      Caption = 'Start';
      Editable = false;
    //TableRelation = "ODT LSD Format".Code;
    }
    field(13;Path;Code[50])
    {
      Caption = 'Path';
      Editable = false;
    //TableRelation = "ODT LSD Format".Code;
    }
    field(14;"ODT End";Code[50])
    {
      Caption = 'End';
      Editable = false;
    //TableRelation = "ODT LSD Format".Code;
    }
  }
  keys
  {
    key(Key1;"LSD Format Code", "LSD Code", Type, "Surface LSD")
    {
    }
    key(Key2;"LSD Code")
    {
    }
    key(Key3;"Surface LSD", "Surface LSD Format")
    {
    }
  }
  fieldgroups
  {
    fieldgroup(DrillDown;"LSD Code", "LSD Format Code")
    {
    }
  }
  trigger OnDelete();
  begin
    CheckWhereUsed("LSD Format Code", "LSD Code");
  end;
  trigger OnInsert();
  begin
    TESTFIELD("LSD Format Code");
    //<NB03.87>
    if Type = Type::Surface then begin
      "Surface LSD":="LSD Code";
      "Surface LSD Format":="LSD Format Code";
    end;
  //</NB03.87>
  end;
  var LSDFormats: Record "ODT LSD Format";
  local procedure CheckWhereUsed(LSDFormat: Code[10];
  LSDCode: Code[100]);
  var // Dispatch : Record Table50300;
  lLSD: Record "ODT LSD";
  LSDUsed: Boolean;
  TEXT001: Label 'LSD ''%1'' is used in a Dispatch Request and cannot be deleted.';
  begin
    LSDUsed:=false;
    lLSD.RESET;
    lLSD.SETRANGE("LSD Format Code", LSDFormat);
    lLSD.SETRANGE("LSD Code", LSDCode);
    if lLSD.FIND('-')then begin
      //   lLSD.CALCFIELDS(lLSD."SUR Dispatch Requests",lLSD."DH Dispatch Requests",lLSD."Used as Load LSD",lLSD."Used as Delivery LSD",lLSD."Used as Charge LSD");
      //   if lLSD."SUR Dispatch Requests" <> 0 then
      //     LSDUsed := true
      //   else if lLSD."DH Dispatch Requests" <> 0 then
      //     LSDUsed := true
      //   else if lLSD."Used as Load LSD" <> 0 then
      //     LSDUsed := true
      //   else if lLSD."Used as Delivery LSD" <> 0 then
      //     LSDUsed := true
      //   else if lLSD."Used as Charge LSD" <> 0 then
      //     LSDUsed := true;
      if LSDUsed then ERROR(TEXT001, LSDCode);
    end;
  end;
}
