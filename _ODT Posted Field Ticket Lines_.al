table 50006 "ODT Posted Field Ticket Lines"
{
  fields
  {
    field(10;"Field Ticket No.";Code[20])
    {
    }
    field(12;"Direct Unit Cost (LCY)";Decimal)
    {
      AutoFormatType = 2;
      Caption = 'Direct Unit Cost ($)';
      Description = 'JobJnl';
      MinValue = 0;
    }
    field(13;"Unit Cost (LCY)";Decimal)
    {
      AutoFormatType = 2;
      Caption = 'Unit Cost ($)';
      Description = 'JobJnl';
      Editable = false;
      MinValue = 0;

      trigger OnValidate();
      begin
      //IF (Type = Type::Item) AND
      //   Item.GET("No.") AND
      //   (Item."Costing Method" = Item."Costing Method"::Standard)
      //THEN
      //  UpdateAllAmounts
      //ELSE BEGIN
      //  InitRoundingPrecisions;
      //  "Unit Cost" := ROUND(
      //      CurrExchRate.ExchangeAmtLCYToFCY(
      //        "Posting Date","Currency Code",
      //        "Unit Cost (LCY)","Currency Factor"),
      //      UnitAmountRoundingPrecisionFCY);
      //  UpdateAllAmounts;
      //END;
      end;
    }
    field(14;"Total Cost (LCY)";Decimal)
    {
      AutoFormatType = 1;
      Caption = 'Total Cost ($)';
      Description = 'JobJnl';
      Editable = false;
    }
    field(15;"Line No.";Integer)
    {
    }
    field(16;PO;Code[20])
    {
    }
    field(17;"PO Line No.";Integer)
    {
    }
    field(18;"Unit Price (LCY)";Decimal)
    {
      AutoFormatType = 2;
      Caption = 'Unit Price ($)';
      Description = 'JobJnl';
      Editable = false;

      trigger OnValidate();
      begin
      //InitRoundingPrecisions;
      //"Unit Price" := ROUND(
      //    CurrExchRate.ExchangeAmtLCYToFCY(
      //      "Posting Date","Currency Code",
      //      "Unit Price (LCY)","Currency Factor"),
      //    UnitAmountRoundingPrecisionFCY);
      //UpdateAllAmounts;
      end;
    }
    field(19;"Total Price (LCY)";Decimal)
    {
      AutoFormatType = 1;
      Caption = 'Total Price ($)';
      Description = 'JobJnl';
      Editable = false;
    }
    field(20;"Service Start Date";Date)
    {
    }
    field(21;"Service End Date";Date)
    {
    }
    field(22;"Service Code";Code[20])
    {
      // TableRelation = Table50035.Field2 WHERE (Field1=FIELD("Bill-to Customer No."));
      trigger OnValidate();
      var // ServCode : Record Table50035;
      begin
      end;
    }
    field(25;Description;Text[100])
    {
    }
    field(30;"Location Code";Code[10])
    {
      Caption = 'Location Code';
      TableRelation = Location WHERE("Use As In-Transit"=CONST(false));

      trigger OnValidate();
      var PurchSetup: Record "Purchases & Payables Setup";
      Vend: Record Vendor;
      begin
      end;
    }
    field(34;Type;Option)
    {
      Caption = 'Type';
      OptionCaption = 'Resource,Item,G/L Account';
      OptionMembers = Resource, Item, "G/L Account";
    }
    field(35;"No.";Code[20])
    {
      TableRelation = IF(Type=CONST(Resource))Resource
      ELSE IF(Type=CONST(Item))Item WHERE(Type=CONST(Inventory))
      ELSE IF(Type=CONST("G/L Account"))"G/L Account";

      //ELSE
      //IF (Type = CONST ("Fixed Asset")) "Fixed Asset";
      trigger OnValidate();
      var Res: Record Resource;
      Item: Record Item;
      GLAcc: Record "G/L Account";
      FixedAsset: Record "Fixed Asset";
      FASetup: Record "FA Setup";
      // ServCode : Record Table50035;
      begin
      end;
    }
    field(40;Quantity;Decimal)
    {
    }
    field(50;"Unit of Measure Code";Code[10])
    {
      Description = 'tablerelation';
    }
    field(60;"Unit Price";Decimal)
    {
      DecimalPlaces = 2: 2;
    }
    field(65;"Currency Code";Code[10])
    {
      Caption = 'Currency Code';
      Editable = false;
      TableRelation = Currency;
    }
    field(70;"Charge Type";Option)
    {
      OptionCaption = 'Labour,Equipment,Material';
      OptionMembers = Labour, Equipment, Material;
    }
    field(80;"AFE No.";Code[30])
    {
      Description = 'Page';
    }
    field(90;"Cost Center";Code[20])
    {
      Description = 'Page';
    }
    field(100;Major;Text[30])
    {
      Description = 'Page';
    }
    field(110;Minor;Text[30])
    {
      Description = 'Page';
    }
    field(120;"Hours Worked Unit";Decimal)
    {
    }
    field(125;"Hours Worked Subunit";Decimal)
    {
    }
    field(130;Volume;Decimal)
    {
    }
    field(140;"Charge By";Text[30])
    {
    }
    field(150;"Disposal Ticket";Text[30])
    {
    }
    field(160;"Disposal Location";Text[50])
    {
    }
    field(170;Payload;Text[50])
    {
    }
    field(180;"Gauge Start Unit";Decimal)
    {
    }
    field(185;"Gauge Start Subunit";Decimal)
    {
    }
    field(190;"Gauge Finish Unit";Decimal)
    {
    }
    field(195;"Gauge Finish Subunit";Decimal)
    {
    }
    field(200;"License Number";Text[30])
    {
      Description = 'Page';
    }
    field(210;"Crew Member";Text[50])
    {
      Description = 'Page';
    }
    field(215;"Dimension Set ID";Integer)
    {
      Caption = 'Dimension Set ID';
      Editable = false;
      TableRelation = "Dimension Set Entry";

      trigger OnLookup();
      begin
      //ShowDimensions;
      end;
    }
    field(219;"Shortcut Dimension 1 Code";Code[20])
    {
      CaptionClass = '1,2,1';
      Caption = 'Shortcut Dimension 1 Code';
      TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

      trigger OnValidate();
      begin
      //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
      end;
    }
    field(220;"Shortcut Dimension 2 Code";Code[20])
    {
      CaptionClass = '1,2,2';
      Caption = 'Shortcut Dimension 2 Code';
      TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

      trigger OnValidate();
      var // JnlLineAllocation : Record Table50000;
      FA: Record "Fixed Asset";
      // ServCode : Record Table50035;
      begin
      end;
    }
    // field(230;"Rental Terms";Code[20])
    // {
    //     Caption = ='Rental Terms';
    //     TableRelation = Table23001301.Field10;
    // }
    field(240;"Job No.";Code[20])
    {
      Caption = 'Job No.';
      TableRelation = Job;

      trigger OnValidate();
      var Cust: Record Customer;
      begin
      end;
    }
    field(250;"Job Task No.";Code[20])
    {
      Caption = 'Job Task No.';
      TableRelation = "Job Task"."Job Task No." WHERE("Job No."=FIELD("Job No."));

      trigger OnValidate();
      var JobTask: Record "Job Task";
      begin
      end;
    }
    field(260;"Bill-to Customer No.";Code[20])
    {
      Editable = false;
    }
    field(270;"Posting Date";Date)
    {
      Caption = 'Posting Date';

      trigger OnValidate();
      var FieldTicketJobMapping: Record "ODT Field Ticket Job Mapping";
      StartDate: Date;
      EndDate: Date;
      TextDateError: Label 'Posting Date must be within the same month of Field Ticket Date %1.';
      begin
      end;
    }
    field(280;"Customer Price Group";Code[10])
    {
      Caption = 'Customer Price Group';
      TableRelation = "Customer Price Group";
    }
    field(290;"Country/Region Code";Code[10])
    {
      Caption = 'Country/Region Code';
      TableRelation = "Country/Region";
    }
    field(300;"Driver Name";Text[50])
    {
      Description = 'Page';
    }
    field(310;"Resource Group No.";Code[20])
    {
      Caption = 'Resource Group No.';
      Editable = false;
      TableRelation = "Resource Group";

      trigger OnValidate();
      begin
      //CreateDim(
      //  DATABASE::"Resource Group","Resource Group No.",
      //  DATABASE::Job,"Job No.",
      //  DimMgt.TypeToTableID2(Type),"No.");
      end;
    }
    field(320;"Source Code";Code[10])
    {
      Caption = 'Source Code';
      Editable = false;
      TableRelation = "Source Code";
    }
    field(950;"Time Sheet No.";Code[20])
    {
      Caption = 'Time Sheet No.';
      Editable = false;
      TableRelation = "Time Sheet Header";
    }
    field(951;"Time Sheet Line No.";Integer)
    {
      Caption = 'Time Sheet Line No.';
      Editable = false;
      TableRelation = "Time Sheet Line"."Line No." WHERE("Time Sheet No."=FIELD("Time Sheet No."));
    }
    field(952;"Time Sheet Date";Date)
    {
      Caption = 'Time Sheet Date';
      Editable = false;
      TableRelation = "Time Sheet Detail".Date WHERE("Time Sheet No."=FIELD("Time Sheet No."), "Time Sheet Line No."=FIELD("Time Sheet Line No."));
    }
    field(1001;"Total Cost";Decimal)
    {
      AutoFormatExpression = "Currency Code";
      AutoFormatType = 1;
      Caption = 'Total Cost';
      Description = 'JobJnl';
      Editable = false;
    }
    field(1003;"Line Type";Option)
    {
      Caption = 'Line Type';
      Description = 'JobJnl';
      //OptionCaption = ' ,Schedule,Contract,Both Schedule and Contract';
      //OptionMembers = " ",Schedule,Contract,"Both Schedule and Contract";
      OptionCaption = ' ,Budget,Billable,Both Budget and Billable';
      OptionMembers = " ", Budget, Billable, "Both Budget and Billable";

      trigger OnValidate();
      begin
      //IF "Job Planning Line No." <> 0 THEN
      //  ERROR(Text006,FIELDCAPTION("Line Type"),FIELDCAPTION("Job Planning Line No."));
      end;
    }
    field(1006;"Line Discount %";Decimal)
    {
      Caption = 'Line Discount %';
      DecimalPlaces = 0: 5;
      Description = 'JobJnl';
      MaxValue = 100;
      MinValue = 0;

      trigger OnValidate();
      begin
      ////UpdateAllAmounts;
      //"Line Discount Amount" := (Quantity * "Unit Price") * ("Line Discount %"/100);
      //"Line Amount" := (Quantity * "Unit Price")- "Line Discount Amount";
      end;
    }
    field(1007;"Line Discount Amount";Decimal)
    {
      AutoFormatExpression = "Currency Code";
      AutoFormatType = 1;
      Caption = 'Line Discount Amount';
      Description = 'JobJnl';
      Editable = false;
    }
    field(1009;"Line Amount";Decimal)
    {
      AutoFormatExpression = "Currency Code";
      AutoFormatType = 1;
      Caption = 'Line Amount';

      trigger OnValidate();
      begin
      //UpdateAllAmounts;
      end;
    }
    field(50012;"Allocation Line Count";Integer)
    {
      Description = 'JobJnl fix flowfield';
      Editable = false;
      Enabled = false;
    }
    field(50031;"Allocated Amount";Decimal)
    {
      Description = 'JobJnl fix flowfield';
      Enabled = false;
    }
    field(50032;"Employee No.";Code[20])
    {
      Caption = 'Employee No.';
      DataClassification = ToBeClassified;
      TableRelation = Resource where(Type=const(Person), Blocked=Const(FALSE));
    }
    field(50033;"Employee";Text[100])
    {
      Caption = 'Employee';
      DataClassification = ToBeClassified;
      TableRelation = Resource.Name where(Type=const(Person), Blocked=Const(False));
    }
  }
  keys
  {
    key(Key1;"Field Ticket No.", "Line No.")
    {
    }
  }
  fieldgroups
  {
    fieldgroup(DropDown;"Field Ticket No.", Minor, "Disposal Ticket", Major)
    {
    }
  }
  var LSDFormats: Record "ODT LSD Format";
  "--NB03.45": Integer;
  Job: Record Job;
  JobSetup: Record "Jobs Setup";
  SH: Record "Sales Header";
  FT: Record "ODT Field Ticket Job Mapping";
  Text001: Label '%1 must be later than %2.';
  DimMgt: Codeunit DimensionManagement;
  procedure InitType();
  begin
  end;
  local procedure GetFTHeader();
  begin
  end;
  procedure GetJob();
  begin
  end;
  procedure ValidateShortcutDimCode(FieldNumber: Integer;
  var ShortcutDimCode: Code[20]);
  begin
  end;
  procedure LookupShortcutDimCode(FieldNumber: Integer;
  var ShortcutDimCode: Code[20]);
  begin
  end;
  procedure ShowShortcutDimCode(var ShortcutDimCode: array[8]of Code[20]);
  begin
  end;
  procedure ShowDimensions();
  begin
  end;
  local procedure CalcFAUnitPrice(FA: Code[20];
  RentalTerms: Code[10];
  PostingDate: Date;
  FTLines: Record "ODT FT Job Mapping Lines"): Decimal;
  var // RentalPrice : Record Table23001302;
  FixedAsset: Record "Fixed Asset";
  begin
  end;
}
