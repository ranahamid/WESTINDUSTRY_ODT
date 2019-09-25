table 50004 "ODT FT Job Mapping Lines"
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
        InitRoundingPrecision;
        "Unit Price":=ROUND(CurrExchRate.ExchangeAmtLCYToFCY("Posting Date", "Currency Code", "Unit Price (LCY)", "Currency Factor"), 0.01);
        //UpdateAllAmounts;
        "Total Price (LCY)":=Quantity * "Unit Price (LCY)";
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
      trigger OnValidate();
      begin
        if "Service Start Date" > "Service End Date" then "Service End Date":="Service Start Date";
      end;
    }
    field(21;"Service End Date";Date)
    {
      trigger OnValidate();
      begin
        if "Service Start Date" > "Service End Date" then MESSAGE(Text001, FIELDCAPTION("Service End Date"), FIELDCAPTION("Service Start Date"));
      end;
    }
    // field(22;"Service Code";Code[20])
    // {
    //     TableRelation = Table50035.Field2 WHERE (Field1=FIELD("Bill-to Customer No."));
    //     trigger OnValidate();
    //     var
    //         ServCode : Record Table50035;
    //     begin
    //         if ServCode.GET("Bill-to Customer No.","Service Code")then begin
    //           VALIDATE(Description,ServCode.Description);
    //           VALIDATE("Unit Price",ServCode.Price);
    //         end;
    //     end;
    // }
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
    field(33;"Work Type Code";Code[10])
    {
      Caption = 'Work Type Code';
      Description = 'JobJnl';
      TableRelation = "Work Type";

      trigger OnValidate();
      begin
      //TESTFIELD(Type,Type::Resource);
      //VALIDATE("Line Discount %",0);
      //IF ("Work Type Code" = '') AND (xRec."Work Type Code" <> '') THEN BEGIN
      //  Res.GET("No.");
      //  "Unit of Measure Code" := Res."Base Unit of Measure";
      //  VALIDATE("Unit of Measure Code");
      //END;
      //IF WorkType.GET("Work Type Code") THEN
      //  IF WorkType."Unit of Measure Code" <> '' THEN BEGIN
      //    "Unit of Measure Code" := WorkType."Unit of Measure Code";
      //    IF ResUnitofMeasure.GET("No.","Unit of Measure Code") THEN
      //      "Qty. per Unit of Measure" := ResUnitofMeasure."Qty. per Unit of Measure";
      //  END ELSE BEGIN
      //    Res.GET("No.");
      //    "Unit of Measure Code" := Res."Base Unit of Measure";
      //    VALIDATE("Unit of Measure Code");
      //  END;
      //VALIDATE(Quantity);
      end;
    }
    field(34;Type;Option)
    {
      Caption = 'Type';
      OptionCaption = 'Resource,Item,G/L Account';
      OptionMembers = Resource, Item, "G/L Account";

      trigger OnValidate();
      begin
        VALIDATE("No.", '');
      end;
    }
    field(35;"No.";Code[20])
    {
      TableRelation = IF(Type=CONST(Resource))Resource
      ELSE IF(Type=CONST(Item))Item
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
        if("No." = '')then begin // OR ("No." <> xRec."No.") THEN BEGIN
          Description:='';
          "Unit of Measure Code":='';
          UpdateDimensions;
          exit;
        //  "Qty. per Unit of Measure" := 1;
        //  "Variant Code" := '';
        //  "Work Type Code" := '';
        //  DeleteAmounts;
        //  "Cost Factor" := 0;
        //  "Applies-to Entry" := 0;
        //  "Applies-from Entry" := 0;
        //  CheckedAvailability := FALSE;
        //  "Job Planning Line No." := 0;
        //  IF "No." = '' THEN BEGIN
        //    UpdateDimensions;
        //    EXIT;
        //  END
        end;
        CASE Type OF Type::Resource: CopyFromResource;
        Type::Item: CopyFromItem;
        Type::"G/L Account": CopyFromGLAccount;
        END;
        //VALIDATE(Quantity);
        UpdateDimensions;
        GetFTHeader;
        "Job No.":=FT."Job No.";
        IF "Job Task No." = '' THEN "Job Task No.":=FT."Job Task No.";
        Res.RESEt;
        Res.SETRANGE("Time Sheet Owner User ID", USERID);
        IF NOT Res.ISEMPTY then IF Res.FINDFIRST then begin
            "Employee No.":=Res."No.";
            Employee:=Res.Name;
          End;
        JobJnlTemplate.RESET;
        JobJnlTemplate.SETRANGE("Page ID", 201);
        JobJnlTemplate.SETRANGE(Recurring, false);
        if JobJnlTemplate.FINDFIRST then "Source Code":=JobJnlTemplate."Source Code";
        case Type of Type::Resource: begin
          Res.GET("No.");
          Res.TESTFIELD(Blocked, false);
          Description:=Res.Name;
          //"Description 2" := Res."Name 2";
          "Resource Group No.":=Res."Resource Group No.";
          //"Gen. Prod. Posting Group" := Res."Gen. Prod. Posting Group";
          //VALIDATE("Unit of Measure Code", Res."Base Unit of Measure");
          //IF "Time Sheet No." = '' THEN
          //  Res.TESTFIELD("Use Time Sheet",FALSE);
          GetUnitCost;
        end;
        Type::Item: begin
          Item.GET("No.");
          Item.TESTFIELD(Blocked, false);
          Description:=Item.Description;
          //      "Description 2" := Item."Description 2";
          //      GetJob;
          //      IF Job."Language Code" <> '' THEN
          //        GetItemTranslation;
          //      "Posting Group" := Item."Inventory Posting Group";
          //      "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
          //VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
          GetUnitCost;
        end;
        Type::"G/L Account": begin
          GLAcc.GET("No.");
          GLAcc.CheckGLAcc;
          GLAcc.TESTFIELD("Direct Posting", true);
          Description:=GLAcc.Name;
          //      "Gen. Bus. Posting Group" := GLAcc."Gen. Bus. Posting Group";
          //      "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
          "Unit of Measure Code":='';
          //      "Direct Unit Cost (LCY)" := 0;
          //      "Unit Cost (LCY)" := 0;
          "Unit Price":=0;
        end;
        //NB01.00 2012-06-05 ODTRJ Start
        //Type::"Fixed Asset":
        //    begin
        // FixedAsset.GET("No.");
        // Description := FixedAsset.Description;
        //      "Posting Group" := FixedAsset."FA Posting Group";
        // FixedAsset.TESTFIELD("Gen. Prod. Posting Group");
        //      "Gen. Prod. Posting Group" := FixedAsset."Gen. Prod. Posting Group";
        // "Unit of Measure Code" := '';
        //      "Direct Unit Cost (LCY)" := 0;
        //      "Unit Cost (LCY)" := 0;
        // "Unit Price" := 0;
        //NB02.05+
        // FASetup.GET;
        //   FASetup.TESTFIELD("Default FA Rental Terms");
        //   "Rental Terms" := FASetup."Default FA Rental Terms";
        //VALIDATE("Unit Price",CalcFAUnitPrice("No.","Rental Terms","Posting Date",Rec));
        // VALIDATE("Unit of Measure Code","Rental Terms");   //ODTJR
        //NB02.05-
        //end;
        //NB01.00 2012-06-05 ODTRJ End
        end;
        VALIDATE(Quantity);
        UpdateDimensions;
        IF "Employee No." <> '' then VALIDATE("Employee No.");
      //NB03.58+
      // if ServCode.GET("Bill-to Customer No.","Service Code")then begin
      //   VALIDATE(Description,ServCode.Description);
      //   VALIDATE("Unit Price",ServCode.Price);
      // end;
      //NB03.58-
      end;
    }
    field(40;Quantity;Decimal)
    {
      trigger OnValidate();
      begin
        FindPriceAndDiscount(Rec, 10); //CurrFieldNo
        "Line Discount Amount":=(Quantity * "Unit Price") * ("Line Discount %" / 100);
        "Line Amount":=(Quantity * "Unit Price") - "Line Discount Amount";
        "Total Cost":=Quantity * "Unit Cost";
      end;
    }
    field(50;"Unit of Measure Code";Code[10])
    {
      Description = 'tablerelation';

      trigger OnLookup();
      var ItemUnitOfMeasure: Record "Item Unit of Measure";
      ResourceUnitOfMeasure: Record "Resource Unit of Measure";
      UnitOfMeasure: Record "Unit of Measure";
      Resource: Record Resource;
      "Filter": Text;
      begin
        case Type of Type::Item: begin
          ItemUnitOfMeasure.SETRANGE("Item No.", "No.");
          if PAGE.RUNMODAL(0, ItemUnitOfMeasure) = ACTION::LookupOK then VALIDATE("Unit of Measure Code", ItemUnitOfMeasure.Code);
        end;
        Type::Resource: begin
          ResourceUnitOfMeasure.SETRANGE("Resource No.", "No.");
          //      IF "Job Planning Line No." <> 0 THEN BEGIN
          //        Filter := Resource.GetUnitOfMeasureFilter("No.","Unit of Measure Code");
          //        ResourceUnitOfMeasure.SETFILTER(Code,Filter);
          //      END;
          if PAGE.RUNMODAL(0, ResourceUnitOfMeasure) = ACTION::LookupOK then VALIDATE("Unit of Measure Code", ResourceUnitOfMeasure.Code);
        end;
        else if PAGE.RUNMODAL(0, UnitOfMeasure) = ACTION::LookupOK then VALIDATE("Unit of Measure Code", UnitOfMeasure.Code);
        end;
      end;
      trigger OnValidate();
      begin
        Validate(Quantity);
      end;
    }
    field(60;"Unit Price";Decimal)
    {
      DecimalPlaces = 2: 2;

      trigger OnValidate();
      begin
        "Line Discount Amount":=(Quantity * "Unit Price") * ("Line Discount %" / 100);
        "Line Amount":=(Quantity * "Unit Price") - "Line Discount Amount";
        "Unit Price (LCY)":=ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Unit Price", "Currency Factor"), 0.01);
        "Total Price (LCY)":=(Quantity * "Unit Price (LCY)") - "Line Discount Amount";
      end;
    }
    field(65;"Currency Code";Code[10])
    {
      Caption = 'Currency Code';
      TableRelation = Currency;

      trigger OnValidate();
      begin
        UpdateCurrencyFactor;
      end;
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
        ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
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
        ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
      // NB01.00 2012-09-27 ODTRJ Start Default Unit Allocationm
      /*TicketLineAllocation.RESET;
                TicketLineAllocation.SETRANGE(Type, TicketLineAllocation.Type::"Job Journal");
                TicketLineAllocation.SETRANGE("Journal Template Name", "Journal Template Name");
                TicketLineAllocation.SETRANGE("Journal Batch Name", "Journal Batch Name");
                TicketLineAllocation.SETRANGE("Journal Line No.", "Line No.");
                IF TicketLineAllocation.FINDFIRST THEN
                  TicketLineAllocation.DELETEALL(FALSE);
                
                TicketLineAllocation.RESET;
                TicketLineAllocation.Type := TicketLineAllocation.Type::"Job Journal";
                TicketLineAllocation."Journal Template Name" := "Journal Template Name";
                TicketLineAllocation."Journal Batch Name" := "Journal Batch Name";
                TicketLineAllocation."Journal Line No." := "Line No.";
                TicketLineAllocation."Line No." := 10000;
                
                IF Type = Type::Resource THEN BEGIN
                  TicketLineAllocation."Unit Type" := TicketLineAllocation."Unit Type"::Resource;
                  //NB02.06+
                  IF Resource.GET("Shortcut Dimension 2 Code") AND NOT Resource."Leased Operator" THEN
                   EXIT;
                  //NB02.06-
                END;
                
                IF Type = Type::"Fixed Asset" THEN BEGIN
                  TicketLineAllocation."Unit Type" := TicketLineAllocation."Unit Type"::"Fixed Asset";
                  //NB02.06+
                  IF FA.GET("Shortcut Dimension 2 Code") AND NOT FA."3rd Party" THEN
                    EXIT;
                  //NB02.06-
                END;
                
                TicketLineAllocation."Unit No." := "Shortcut Dimension 2 Code";
                TicketLineAllocation.Description := Description;
                TicketLineAllocation.Amount := "Total Price";
                TicketLineAllocation.Default := TRUE;
                TicketLineAllocation."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
                TicketLineAllocation."Document No." := "Document No.";
                TicketLineAllocation."Posting Date" := "Posting Date";
                
                TicketLineAllocation.INSERT;
                // NB01.00 2012-09-27 ODTRJ End
                */
      //NB03.58+
      // if ServCode.GET("Bill-to Customer No.","Service Code")then begin
      //   VALIDATE(Description,ServCode.Description);
      //   VALIDATE("Unit Price",ServCode.Price);
      // end;
      // //NB03.58-
      end;
    }
    // field(230;"Rental Terms";Code[20])
    // {
    //     Caption = 'Rental Terms';
    //     TableRelation = Table23001301.Field10;
    //     trigger OnValidate();
    //     begin
    //         //NB02.05+
    //         TESTFIELD(Type,Type::"Fixed Asset");
    //         //VALIDATE("Unit Price",CalcFAUnitPrice("No.","Rental Terms","Posting Date",Rec));
    //         //NB02.05-
    //         VALIDATE("Unit of Measure Code","Rental Terms");
    //     end;
    // }
    field(240;"Job No.";Code[20])
    {
      Caption = 'Job No.';
      TableRelation = Job;

      trigger OnValidate();
      var Cust: Record Customer;
      JobTaskLine: Record "Job Task";
      begin
        if "Job No." = '' then begin
          VALIDATE("Currency Code", '');
          VALIDATE("Job Task No.", '');
          CreateDim(DATABASE::Job, "Job No.", DimMgt.TypeToTableID2(Type), "No.", DATABASE::"Resource Group", "Resource Group No.");
          exit;
        end;
        GetJob;
        Job.TestBlocked;
        Job.TESTFIELD("Bill-to Customer No.");
        Cust.GET(Job."Bill-to Customer No.");
        VALIDATE("Job Task No.", '');
        "Customer Price Group":=Job."Customer Price Group";
        VALIDATE("Currency Code", Job."Currency Code");
        CreateDim(DATABASE::Job, "Job No.", DimMgt.TypeToTableID2(Type), "No.", DATABASE::"Resource Group", "Resource Group No.");
        VALIDATE("Country/Region Code", Cust."Country/Region Code");
        //NB05.38 ODTJR
        "Bill-to Customer No.":=Job."Bill-to Customer No.";
      //"AFE #" := Job."AFE No."; //NB03.75
      //<NB04.10 2019-05-14 start insert>
      //GetFTHeader;
      //JobTaskLine.RESET;
      //if not JobTaskLine.GET("Job No.", "Field Ticket No.") then begin
      //    JobTaskLine.RESET;
      //    JobTaskLine.VALIDATE("Job No.", "Job No.");
      //    JobTaskLine.VALIDATE("Job Task No.", "Field Ticket No.");
      //   JobTaskLine."Sales Order No.":=FT."Rental Order No.";
      //   JobTaskLine."Dispatch ID" := FT."Dispatch ID";
      //    JobTaskLine.INSERT(true);
      //end;
      //if "Job Task No." <> "Field Ticket No." then
      //    VALIDATE("Job Task No.", "Field Ticket No.");
      //</NB04.10 2019-05-14 end insert>
      end;
    }
    field(250;"Job Task No.";Code[20])
    {
      Caption = 'Job Task No.';
      TableRelation = "Job Task"."Job Task No." WHERE("Job No."=FIELD("Job No."), "ODT Closed"=const(FALSE));

      trigger OnValidate();
      var JobTask: Record "Job Task";
      begin
        if("Job Task No." = '') or (("Job Task No." <> xRec."Job Task No.") and (xRec."Job Task No." <> ''))then begin
          //VALIDATE("No.", ''); standard
          VALIDATE("No."); //custom
          exit;
        end;
        TESTFIELD("Job No.");
        JobTask.GET("Job No.", "Job Task No.");
        JobTask.TESTFIELD("Job Task Type", JobTask."Job Task Type"::Posting);
        JobTask.TESTFIELD("ODT Closed", FALSE);
        "Line Type":=JobTask."ODT Line Type";
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
        //<NB03.57 2017-04-13 start insert>
        if(FieldTicketJobMapping.GET("Field Ticket No.")) and (FieldTicketJobMapping."Field Ticket Date" <> 0D)then begin
          StartDate:=CALCDATE('CM+1D-1M', "Posting Date");
          EndDate:=CALCDATE('CM', "Posting Date");
          if(FieldTicketJobMapping."Field Ticket Date" < StartDate) or (FieldTicketJobMapping."Field Ticket Date" > EndDate)then ERROR(TextDateError, FieldTicketJobMapping."Field Ticket Date");
        end;
        //</NB03.57 2017-04-13 end insert>
        //VALIDATE("Document Date","Posting Date");
        if "Currency Code" <> '' then UpdateCurrencyFactor;
      //  UpdateAllAmounts;
      //END
      end;
    }
    field(280;"Customer Price Group";Code[10])
    {
      Caption = 'Customer Price Group';
      TableRelation = "Customer Price Group";

      trigger OnValidate();
      begin
      ////////IF (Type = Type::Item) AND ("No." <> '') THEN
      ////////  UpdateAllAmounts;
      end;
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
        CreateDim(DATABASE::"Resource Group", "Resource Group No.", DATABASE::Job, "Job No.", DimMgt.TypeToTableID2(Type), "No.");
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
        //UpdateAllAmounts;
        "Line Discount Amount":=(Quantity * "Unit Price") * ("Line Discount %" / 100);
        "Line Amount":=(Quantity * "Unit Price") - "Line Discount Amount";
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
    field(1010;"Currency Factor";Decimal)
    {
      Caption = 'Currency Factor';
      DecimalPlaces = 0: 15;
      Editable = false;
      MinValue = 0;

      trigger OnValidate();
      begin
        if("Currency Code" = '') and ("Currency Factor" <> 0)then FIELDERROR("Currency Factor", STRSUBSTNO(Text002, FIELDCAPTION("Currency Code")));
      //UpdateAllAmounts;
      end;
    }
    field(1011;"Unit Cost";Decimal)
    {
      Caption = 'Unit Cost';
      AutoFormatType = 2;
      AutoFormatExpression = "Currency Code";
      Editable = true;
      MinValue = 0;

      trigger OnValidate();
      begin
        "Total Cost":=Quantity * "Unit Cost";
      //GetUnitCost;  
      //UpdateAllAmounts;
      end;
    }
    field(50012;"Allocation Line Count";Integer)
    {
      Description = 'JobJnl fix flowfield';
      Editable = false;
      Enabled = false;
      FieldClass = Normal;
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

      trigger OnValidate()begin
        GetUnitCost;
        //UpdateDimensions();
        DefDim.RESET;
        DefDim.SETRANGE("Table ID", 156);
        DefDim.SETRANGE("No.", "Employee No.");
        DefDim.SETRANGE("Dimension Code", 'REGION'); //quick dev before training
        IF DefDim.FINDFirst then VALIDATE("Shortcut Dimension 1 Code", DefDim."Dimension Value Code");
        Res.GET("Employee No.");
        Employee:=Res.Name;
      end;
    }
    field(50033;"Employee";Text[100])
    {
      Caption = 'Employee';
      DataClassification = ToBeClassified;
      Editable = FALSE;
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
  trigger OnDelete();
  begin
  //TicketLineAllocation.RESET;
  //TicketLineAllocation.SETRANGE(Type, TicketLineAllocation.Type::"Job Journal");
  //TicketLineAllocation.SETRANGE("Journal Template Name", "Journal Template Name");
  //TicketLineAllocation.SETRANGE("Journal Batch Name", "Journal Batch Name");
  //TicketLineAllocation.SETRANGE("Journal Line No.", "Line No.");
  //IF TicketLineAllocation.FINDFIRST THEN
  //  TicketLineAllocation.DELETEALL;
  end;
  trigger OnInsert();
  begin
    GetFTHeader;
    FT.TESTFIELD("Job No.");
    //VALIDATE("Job No.", FT."Job No.");
    ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
    ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
  // TicketLineAllocation.RESET;
  // TicketLineAllocation.SETRANGE(Type, TicketLineAllocation.Type::"1");
  // TicketLineAllocation.SETRANGE("Field Ticket No.","Field Ticket No.");
  // //TicketLineAllocation.SETRANGE("Journal Template Name", "Journal Template Name");
  // //TicketLineAllocation.SETRANGE("Journal Batch Name", "Journal Batch Name");
  // TicketLineAllocation.SETRANGE("Field Ticket Line No.", "Line No.");
  // if TicketLineAllocation.FINDFIRST then
  //   TicketLineAllocation.DELETEALL(false);
  // TicketLineAllocation.RESET;
  // TicketLineAllocation.Type := TicketLineAllocation.Type::"1";
  // //TicketLineAllocation."Journal Template Name" := "Journal Template Name";
  // //TicketLineAllocation."Journal Batch Name" := "Journal Batch Name";
  // //TicketLineAllocation."Journal Line No." := "Line No.";
  // TicketLineAllocation."Field Ticket No." := "Field Ticket No.";
  // TicketLineAllocation."Field Ticket Line No." := "Line No.";
  // TicketLineAllocation."Line No." := 10000;
  // if Type = Type::Resource then begin
  //   TicketLineAllocation."Unit Type" := TicketLineAllocation."Unit Type"::"1";
  //   //NB02.06+
  //   if Resource.GET("Shortcut Dimension 2 Code") and not Resource."Leased Operator" then
  //    exit;
  //   //NB02.06-
  // end;
  // if Type = Type::"Fixed Asset" then begin
  //   TicketLineAllocation."Unit Type" := TicketLineAllocation."Unit Type"::"0";
  //   //NB02.06+
  //   if FA.GET("Shortcut Dimension 2 Code") and not FA."3rd Party" then
  //     exit;
  //   //NB02.06-
  // end;
  // TicketLineAllocation."Unit No." := "Shortcut Dimension 2 Code";
  // TicketLineAllocation.Description := Description;
  // TicketLineAllocation.Amount := "Line Amount";
  // TicketLineAllocation.Default := true;
  // //TicketLineAllocation."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
  // //TicketLineAllocation."Document No." := "Document No.";
  // TicketLineAllocation."Posting Date" := "Posting Date";
  // TicketLineAllocation."Post Liability" := true;
  // TicketLineAllocation.INSERT;
  end;
  trigger OnModify();
  begin
  /*  //ODTJR Temporarily comment our for testing.
        CASE "Charge Type" OF
          "Charge Type"::Labour:
            BEGIN
              TESTFIELD("Driver Name");
              TESTFIELD("License Number");
              TESTFIELD("AFE No.");
              TESTFIELD("Cost Center");
              TESTFIELD(Major);
              TESTFIELD(Minor);
            END;
          "Charge Type"::Equipment:
            BEGIN
              TESTFIELD("Equip ID");
              TESTFIELD("AFE No.");
              TESTFIELD("Cost Center");
              TESTFIELD(Major);
              TESTFIELD(Minor);
            END;
          "Charge Type"::Material:
            BEGIN
              TESTFIELD("AFE No.");
              TESTFIELD("Cost Center");
              TESTFIELD(Major);
              TESTFIELD(Minor);
            END;
        END;
        */
  // TicketLineAllocation.RESET;
  // TicketLineAllocation.SETRANGE(Type, TicketLineAllocation.Type::"1");
  // TicketLineAllocation.SETRANGE("Field Ticket No.","Field Ticket No.");
  // //TicketLineAllocation.SETRANGE("Journal Template Name", "Journal Template Name");
  // //TicketLineAllocation.SETRANGE("Journal Batch Name", "Journal Batch Name");
  // TicketLineAllocation.SETRANGE("Field Ticket Line No.", "Line No.");
  // TicketLineAllocation.SETRANGE(Default, true);
  // if TicketLineAllocation.FINDFIRST then begin
  //   if (xRec."Shortcut Dimension 2 Code" = TicketLineAllocation."Unit No.") then begin
  //        if Type = Type::Resource then begin
  //         TicketLineAllocation."Unit Type" := TicketLineAllocation."Unit Type"::"1";
  //         //NB02.06+
  //         if Resource.GET("Shortcut Dimension 2 Code") and not Resource."Leased Operator" then
  //          exit;
  //         //NB02.06-
  //        end;
  //       if Type = Type::"Fixed Asset" then begin
  //         TicketLineAllocation."Unit Type" := TicketLineAllocation."Unit Type"::"0";
  //         //NB02.06+
  //         if FA.GET("Shortcut Dimension 2 Code") and not FA."3rd Party" then
  //           exit;
  //         //NB02.06-
  //       end;
  //     TicketLineAllocation.Amount := "Line Amount";
  //     TicketLineAllocation."Unit No." := "Shortcut Dimension 2 Code";
  //     TicketLineAllocation.Description := Description;
  //     TicketLineAllocation.Amount := "Line Amount";
  //     //TicketLineAllocation."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
  //     //TicketLineAllocation."Document No." := "Document No.";
  //     TicketLineAllocation."Posting Date" := "Posting Date";
  //     TicketLineAllocation."Post Liability" := true;
  //     TicketLineAllocation.MODIFY;
  //   end;
  // end;
  end;
  var LSDFormats: Record "ODT LSD Format";
  "--NB03.45": Integer;
  Job: Record Job;
  // DispatchSetup : Record Table50006;
  SH: Record "Sales Header";
  FT: Record "ODT Field Ticket Job Mapping";
  Text001: Label '%1 must be later than %2.';
  CurrExchRate: Record "Currency Exchange Rate";
  DimMgt: Codeunit DimensionManagement;
  JobJnlTemplate: Record "Job Journal Template";
  Item: Record Item;
  Resource: Record Resource;
  FA: Record "Fixed Asset";
  UnitAmountRoundingPrecision: Decimal;
  AmountRoundingPrecision: Decimal;
  UnitAmountRoundingPrecisionFCY: Decimal;
  AmountRoundingPrecisionFCY: Decimal;
  // TicketLineAllocation : Record Table50024;
  CurrencyDate: Date;
  Text002: Label 'cannot be specified without %1';
  procedure InitType();
  begin
    Type:=xRec.Type;
  end;
  procedure InitNewLine();
  begin
    Type:=xRec.Type;
    GetFTHeader;
    VALIDATE("Job No.", FT."Job No.");
  end;
  local procedure GetFTHeader();
  begin
    FT.GET("Field Ticket No.");
  end;
  procedure GetJob();
  begin
    TESTFIELD("Job No.");
    if "Job No." <> Job."No." then Job.GET("Job No.");
  end;
  procedure ValidateShortcutDimCode(FieldNumber: Integer;
  var ShortcutDimCode: Code[20]);
  begin
    DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
  end;
  procedure LookupShortcutDimCode(FieldNumber: Integer;
  var ShortcutDimCode: Code[20]);
  begin
    DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
    DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
  end;
  procedure ShowShortcutDimCode(var ShortcutDimCode: array[8]of Code[20]);
  begin
    DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
  end;
  procedure ShowDimensions();
  begin
  //"Dimension Set ID" :=
  //  DimMgt.EditDimensionSet("Dimension Set ID",STRSUBSTNO('%1 %2 %3',"Journal Template Name","Journal Batch Name","Line No."));
  //DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
  end;
  procedure UpdateDimensions();
  var DimensionSetIDArr: array[10]of Integer;
  begin
    // IF "Employee No." <> '' THEN
    //     CreateDim(
    //         DimMgt.TypeToTableID2(Type::Resource), "Employee No.",
    //         DATABASE::Job, "Job No.",
    //         DATABASE::"Resource Group", "Resource Group No.")
    // ELSE
    CreateDim(DimMgt.TypeToTableID2(Type), "No.", DATABASE::Job, "Job No.", DATABASE::"Resource Group", "Resource Group No.");
    //NB02.08+
    // if Type = Type::"Fixed Asset" then
    //     CreateDim(
    //       DimMgt.TypeToTableID2(Type), "No.",
    //       DATABASE::Job, "Job No.",
    //       DATABASE::"Fixed Asset", "No.");
    //NB02.08-
    if("Job Task No." <> '') AND ("Employee No." = '')then begin //don't override dimensions from Employee
      DimensionSetIDArr[1]:="Dimension Set ID";
      DimensionSetIDArr[2]:=DimMgt.CreateDimSetFromJobTaskDim("Job No.", "Job Task No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
      DimensionSetIDArr[3]:=CreateDimForHigherPriorities(DATABASE::Job);
      "Dimension Set ID":=DimMgt.GetCombinedDimensionSetID(DimensionSetIDArr, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end end;
  procedure CreateDim(Type1: Integer;
  No1: Code[20];
  Type2: Integer;
  No2: Code[20];
  Type3: Integer;
  No3: Code[20]);
  var TableID: array[10]of Integer;
  No: array[10]of Code[20];
  begin
    TableID[1]:=Type1;
    No[1]:=No1;
    TableID[2]:=Type2;
    No[2]:=No2;
    TableID[3]:=Type3;
    No[3]:=No3;
    "Shortcut Dimension 1 Code":='';
    "Shortcut Dimension 2 Code":='';
    "Dimension Set ID":=DimMgt.GetDefaultDimID(TableID, No, "Source Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);
  end;
  local procedure CreateDimForHigherPriorities(PriorityTableID: Integer): Integer;
  var TableID: array[10]of Integer;
  No: array[10]of Code[20];
  begin
    if GetTableIDsForHigherPriorities(TableID, No, PriorityTableID)then exit(DimMgt.GetDefaultDimID(TableID, No, "Source Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0));
  end;
  local procedure GetTableIDsForHigherPriorities(var TableID: array[10]of Integer;
  var No: array[10]of Code[20];
  PriorityTableID: Integer)Result: Boolean;
  var DefaultDimensionPriority: Record "Default Dimension Priority";
  DimTableIDs: array[3]of Integer;
  InitialPriority: Integer;
  i: Integer;
  j: Integer;
  begin
    DimTableIDs[1]:=DATABASE::Job;
    DimTableIDs[2]:=DimMgt.TypeToTableID2(Type);
    DimTableIDs[3]:=DATABASE::"Resource Group";
    CLEAR(TableID);
    CLEAR(No);
    if DefaultDimensionPriority.GET("Source Code", PriorityTableID)then InitialPriority:=DefaultDimensionPriority.Priority;
    DefaultDimensionPriority.SETRANGE("Source Code", "Source Code");
    DefaultDimensionPriority.SETFILTER(Priority, '<=%1', InitialPriority);
    i:=1;
    for j:=1 to 3 do begin
      DefaultDimensionPriority.Priority:=0;
      DefaultDimensionPriority.SETRANGE("Table ID", DimTableIDs[j]);
      if((InitialPriority = 0) or DefaultDimensionPriority.FINDFIRST) and ((DefaultDimensionPriority.Priority < InitialPriority) or ((DefaultDimensionPriority.Priority = InitialPriority) and (DimTableIDs[j] < PriorityTableID)))then begin
        Result:=true;
        TableID[i]:=DimTableIDs[j];
        case TableID[i]of DATABASE::Job: No[i]:="Job No.";
        DATABASE::"Resource Group": No[i]:="Resource Group No.";
        DimMgt.TypeToTableID2(Type): No[i]:="No.";
        end;
        i+=1;
      end;
    end;
    exit(Result);
  end;
  local procedure UpdateCurrencyFactor();
  begin
    if "Currency Code" <> '' then begin
      if "Posting Date" = 0D then CurrencyDate:=WORKDATE
      else
        CurrencyDate:="Posting Date";
      "Currency Factor":=CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
    end
    else
      "Currency Factor":=0;
  end;
  procedure GetUnitCost();
  begin
    InitRoundingPrecision;
    IF((Type = Type::Item) AND Item.GET("No.")) AND ("Employee No." = '')THEN BEGIN
      "Unit Cost (LCY)":=ROUND(Item."Unit Cost" * 1, UnitAmountRoundingPrecision);
      "Unit Cost":=ROUND(CurrExchRate.ExchangeAmtLCYToFCY("Posting Date", "Currency Code", "Unit Cost (LCY)", "Currency Factor"), UnitAmountRoundingPrecisionFCY);
    END
    ELSE IF(Type = Type::Resource) OR ("Employee No." <> '')THEN BEGIN
        ResCost.INIT;
        IF "Employee No." <> '' THEN ResCost.Code:="Employee No."
        ELSE
          ResCost.Code:="No.";
        ResCost."Work Type Code":="Work Type Code";
        CODEUNIT.RUN(CODEUNIT::"Resource-Find Cost", ResCost);
        //OnAfterResourceFindCost(Rec,ResCost);
        //"Direct Unit Cost (LCY)" := ROUND(ResCost."Direct Unit Cost" * "Qty. per Unit of Measure",UnitAmountRoundingPrecision);
        //RetrievedCost := ResCost."Unit Cost" * "Qty. per Unit of Measure";
        "Direct Unit Cost (LCY)":=ROUND(ResCost."Direct Unit Cost" * 1, UnitAmountRoundingPrecision);
        RetrievedCost:=ResCost."Unit Cost";
        "Unit Cost":=ROUND(CurrExchRate.ExchangeAmtLCYToFCY("Posting Date", "Currency Code", RetrievedCost, "Currency Factor"), UnitAmountRoundingPrecisionFCY);
        "Unit Cost (LCY)":=ROUND(RetrievedCost, UnitAmountRoundingPrecision);
      END
      ELSE
        "Unit Cost (LCY)":=ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "Unit Cost", "Currency Factor"), UnitAmountRoundingPrecision);
  end;
  Procedure FindPriceAndDiscount(var FTLine: Record "ODT FT Job Mapping Lines";
  CalledByFieldNo: Integer);
  var TempJobJnlLine: Record "Job Journal Line" temporary;
  begin
    IF("No." <> '')THEN BEGIN
      TempJobJnlLine.INIT;
      TempJobJnlLine.VALIDATE("Job No.", "Job No.");
      TempJobJnlLine.VALIDATE("Job Task No.", "Job Task No.");
      TempJobJnlLine.VALIDATE("ODT Field Ticket No.", "Field Ticket No.");
      TempJobJnlLine.VALIDATE(Type, Type);
      IF TempJobJnlLine.Type = TempJobJnlLine.Type::Resource THEN TempJobJnlLine."Time Sheet No.":='TEMP';
      TempJobJnlLine.VALIDATE("No.", "No.");
      //TempJobJnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
      //TempJobJnlLine.VALIDATE(Quantity, Quantity);
      //TempJobJnlLine.VALIDATE("Unit Price", "Unit Price");
      TempJobJnlLine.VALIDATE("Line Discount %", "Line Discount %");
      IF TempJobJnlLine."Unit of Measure Code" <> "Unit of Measure Code" THEN TempJobJnlLine.VALIDATE("Unit of Measure Code", "Unit of Measure Code");
      TempJobJnlLine."AFE #":="AFE No.";
      TempJobJnlLine."Document No.":="Field Ticket No.";
      TempJobJnlLine."ODT Cost Center":="Cost Center";
      TempJobJnlLine.INSERT;
      //SalesPriceCalcMgt.FindJobJnlLinePrice(TempJobJnlLine, CalledByFieldNo);
      //IF Type <> Type::"G/L Account" THEN
      // PurchPriceCalcMgt.FindJobJnlLinePrice(TempJobJnlLine, CalledByFieldNo)
      //ELSE BEGIN
      // Because the SalesPriceCalcMgt.FindJobJnlLinePrice function also retrieves costs for G/L Account,
      // cost and total cost need to get updated again.
      //UpdateUnitCost;
      //UpdateTotalCost;
      //END;
      "Unit Price":=TempJobJnlLine."Unit Price";
    END;
  end;
  Local procedure InitRoundingPrecision()begin
    IF(AmountRoundingPrecision = 0) OR (UnitAmountRoundingPrecision = 0) OR (AmountRoundingPrecisionFCY = 0) OR (UnitAmountRoundingPrecisionFCY = 0)THEN BEGIN
      CLEAR(Currency);
      Currency.InitRoundingPrecision;
      AmountRoundingPrecision:=Currency."Amount Rounding Precision";
      UnitAmountRoundingPrecision:=Currency."Unit-Amount Rounding Precision";
      IF "Currency Code" <> '' THEN BEGIN
        Currency.GET("Currency Code");
        Currency.TESTFIELD("Amount Rounding Precision");
        Currency.TESTFIELD("Unit-Amount Rounding Precision");
      END;
      AmountRoundingPrecisionFCY:=Currency."Amount Rounding Precision";
      UnitAmountRoundingPrecisionFCY:=Currency."Unit-Amount Rounding Precision";
    END;
  end;
  Local procedure CopyFromResource()begin
    Resource.GET("No.");
    Resource.CheckResourcePrivacyBlocked(FALSE);
    Resource.TESTFIELD(Blocked, FALSE);
    Description:=Resource.Name;
    //"Description 2" := Resource."Name 2";
    "Resource Group No.":=Resource."Resource Group No.";
    //"Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
    VALIDATE("Unit of Measure Code", Resource."Base Unit of Measure");
  //IF "Time Sheet No." = '' THEN
  //  Resource.TESTFIELD("Use Time Sheet",FALSE);
  end;
  Local procedure CopyFromItem()begin
    GetItem;
    Item.TESTFIELD(Blocked, FALSE);
    Description:=Item.Description;
    //"Description 2" := Item."Description 2";
    // GetJob;
    // IF Job."Language Code" <> '' THEN
    // GetItemTranslation;
    //"Posting Group" := Item."Inventory Posting Group";
    //"Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
    VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
  end;
  Local procedure CopyFromGLAccount()begin
    GLAcc.GET("No.");
    GLAcc.CheckGLAcc;
    GLAcc.TESTFIELD("Direct Posting", TRUE);
    Description:=GLAcc.Name;
    //"Gen. Bus. Posting Group" := GLAcc."Gen. Bus. Posting Group";
    //"Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
    "Unit of Measure Code":='';
    "Direct Unit Cost (LCY)":=0;
    "Unit Cost (LCY)":=0;
    "Unit Price":=0;
  end;
  Local procedure GetItem()begin
    TESTFIELD("No.");
    IF "No." <> Item."No." THEN Item.GET("No.");
  end;
  LOCAL procedure GetSKU(): Boolean begin
    // IF (SKU."Location Code" = "Location Code") AND
    //     (SKU."Item No." = "No.") AND
    //     (SKU."Variant Code" = "Variant Code")
    //     THEN
    // EXIT(TRUE);
    // IF SKU.GET("Location Code","No.","Variant Code") THEN
    //     EXIT(TRUE);
    EXIT(FALSE);
  end;
  var ResCost: Record "Resource Cost";
  RetrievedCost: Decimal;
  SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
  PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
  Currency: Record Currency;
  GLAcc: Record "G/L Account";
  SKU: Record "Stockkeeping Unit";
  Res: Record Resource;
  DefDim: Record "Default Dimension";
}
