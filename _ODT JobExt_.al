tableextension 50000 "ODT JobExt" extends Job //MyTargetTableId
{
  fields
  {
    field(50000;"ODT AFE";Text[50])
    {
      Caption = 'AFE';
      DataClassification = ToBeClassified;
    }
    field(50001;"ODT Business Unit";Text[50])
    {
      Caption = 'Business Unit';
      DataClassification = ToBeClassified;
    }
    field(50002;"ODT Cost Centre";Code[50])
    {
      Caption = 'Cost Centre';
      DataClassification = ToBeClassified;
    }
    field(50003;"ODT Client File";Text[50])
    {
      Caption = 'Client File';
      DataClassification = ToBeClassified;
    }
    field(50004;"ODT GL";Text[50])
    {
      Caption = 'GL';
      DataClassification = ToBeClassified;
    }
    field(50005;"ODT Major";Text[50])
    {
      Caption = 'Major';
      DataClassification = ToBeClassified;
    }
    field(50006;"ODT Minor";Text[50])
    {
      Caption = 'Minor';
      DataClassification = ToBeClassified;
    }
    field(50007;"ODT MSA";Text[50])
    {
      Caption = 'MSA';
      DataClassification = ToBeClassified;
    }
    field(50008;"ODT MSO";Text[50])
    {
      Caption = 'MSO';
      DataClassification = ToBeClassified;
    }
    field(50009;"ODT Purchase Order";Code[50])
    {
      Caption = 'Purchase Order';
      DataClassification = ToBeClassified;
    }
    field(50010;"ODT Service Order";Code[50])
    {
      Caption = 'Service Order';
      DataClassification = ToBeClassified;
    }
    field(50011;"ODT Job Type";Code[50])
    {
      Caption = 'Job Type';
      DataClassification = ToBeClassified;
    }
    field(50012;"ODT Land Surveyor";Text[50])
    {
      Caption = 'Land Surveyor';
      DataClassification = ToBeClassified;
    }
    field(50013;"ODT Date Received";Date)
    {
      Caption = 'Date Received';
      DataClassification = ToBeClassified;
    }
    field(50014;"ODT Originator";Text[50])
    {
      Caption = 'Originator';
      DataClassification = ToBeClassified;
    }
    field(50015;"ODT Location";Code[50])
    {
      Caption = 'Location';
      DataClassification = ToBeClassified;
    }
    field(50016;"ODT Contract No.";Text[50])
    {
      Caption = 'Contract No.';
      DataClassification = ToBeClassified;
    }
    field(50017;"ODT Project Instructions";Text[250])
    {
      Caption = 'Project Instructions';
      DataClassification = ToBeClassified;
    }
    field(50018;"ODT Work Order";Text[50])
    {
      Caption = 'Work Order';
      DataClassification = ToBeClassified;
    }
    field(50019;"ODT WBS";Text[50])
    {
      Caption = 'WBS';
      DataClassification = ToBeClassified;
    }
    field(50020;"ODT Shortcut Dimension 3 Code";Code[20])
    {
      Caption = 'Shortcut Dimesion 3';
      CaptionClass = '1,2,3';
      DataClassification = ToBeClassified;
      TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3), Blocked=CONST(FALSE));

      trigger OnValidate()begin
        ValidateShortcutDimCode(3, "ODT Shortcut Dimension 3 Code");
      end;
    }
    field(50030;"ODT Job LSDs";Integer)
    {
      Caption = 'Job LSDs';
      // DataClassification = ToBeClassified;
      FieldClass = FlowField;
      CalcFormula = count("ODT Job LSD" where("Job No."=FIELD("No.")));
    }
    field(50031;"ODT Main Contact";Text[100])
    {
      Caption = 'Main Contact';
      DataClassification = ToBeClassified;
    //TableRelation = Contact.Name;
    }
    field(50032;"ODT Field Rep";Text[100])
    {
      Caption = 'Field Rep';
      DataClassification = ToBeClassified;

      // TableRelation = Contact.Name;
      trigger OnLookup()begin
        IF("Bill-to Customer No." <> '') AND Cont.GET("ODT Field Rep No.")THEN Cont.SETRANGE("Company No.", Cont."Company No.")
        ELSE IF Cust.GET("Bill-to Customer No.")THEN BEGIN
            IF ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, "Bill-to Customer No.")THEN Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.");
          END
          ELSE
            Cont.SETFILTER("Company No.", '<>%1', '''');
        IF "ODT Field Rep No." <> '' THEN IF Cont.GET("ODT Field Rep No.")THEN;
        IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
          xRec:=Rec;
          VALIDATE("ODT Field Rep No.", Cont."No.");
        END;
      end;
      trigger OnValidate()begin
        IF Cont.GET("ODT Field Rep No.")then "ODT Field Rep":=Cont.Name;
      end;
    }
    field(50033;"ODT Contact";Text[100])
    {
      Caption = 'Contact';
      DataClassification = ToBeClassified;
    //TableRelation = Contact.Name;
    }
    field(50034;"ODT Main Contact No.";Code[20])
    {
      Caption = 'Main Contact No.';
      DataClassification = ToBeClassified;

      //TableRelation = Contact.Name;
      trigger OnLookup()begin
        IF("Bill-to Customer No." <> '') AND Cont.GET("ODT Main Contact No.")THEN Cont.SETRANGE("Company No.", Cont."Company No.")
        ELSE IF Cust.GET("Bill-to Customer No.")THEN BEGIN
            IF ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, "Bill-to Customer No.")THEN Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.");
          END
          ELSE
            Cont.SETFILTER("Company No.", '<>%1', '''');
        IF "ODT Main Contact No." <> '' THEN IF Cont.GET("ODT Main Contact No.")THEN;
        IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
          xRec:=Rec;
          VALIDATE("ODT Main Contact No.", Cont."No.");
        END;
      end;
      trigger OnValidate()begin
        IF Cont.GET("ODT Main Contact No.")then "ODT Main Contact":=Cont.Name;
      end;
    }
    field(50035;"ODT Field Rep No.";Code[20])
    {
      Caption = 'Field Rep No.';
      DataClassification = ToBeClassified;

      //TableRelation = Contact.Name;
      trigger OnLookup()begin
        IF("Bill-to Customer No." <> '') AND Cont.GET("ODT Field Rep No.")THEN Cont.SETRANGE("Company No.", Cont."Company No.")
        ELSE IF Cust.GET("Bill-to Customer No.")THEN BEGIN
            IF ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, "Bill-to Customer No.")THEN Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.");
          END
          ELSE
            Cont.SETFILTER("Company No.", '<>%1', '''');
        IF "ODT Field Rep No." <> '' THEN IF Cont.GET("ODT Field Rep No.")THEN;
        IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
          xRec:=Rec;
          VALIDATE("ODT Field Rep No.", Cont."No.");
        END;
      end;
      trigger OnValidate()begin
        IF Cont.GET("ODT Field Rep No.")then "ODT Field Rep":=Cont.Name;
      end;
    }
    field(50036;"ODT Contact No.";Code[20])
    {
      Caption = 'Contact No.';
      DataClassification = ToBeClassified;

      //TableRelation = Contact.Name;
      trigger OnLookup()begin
        IF("Bill-to Customer No." <> '') AND Cont.GET("ODT Contact No.")THEN Cont.SETRANGE("Company No.", Cont."Company No.")
        ELSE IF Cust.GET("Bill-to Customer No.")THEN BEGIN
            IF ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, "Bill-to Customer No.")THEN Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.");
          END
          ELSE
            Cont.SETFILTER("Company No.", '<>%1', '''');
        IF "ODT Contact No." <> '' THEN IF Cont.GET("ODT Contact No.")THEN;
        IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN BEGIN
          xRec:=Rec;
          VALIDATE("ODT Contact No.", Cont."No.");
        END;
      end;
      trigger OnValidate()begin
        IF Cont.GET("ODT Contact No.")then "ODT Contact":=Cont.Name;
      end;
    }
  }
  var Cont: Record Contact;
  Cust: Record Customer;
  ContBusinessRelation: Record "Contact Business Relation";
}
