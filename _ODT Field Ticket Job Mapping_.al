table 50003 "ODT Field Ticket Job Mapping"
{
  fields
  {
    field(10;"Field Ticket No.";Code[20])
    {
      trigger OnValidate()begin
        IF "Field Ticket No." <> xRec."Field Ticket No." THEN BEGIN
          JobsSetup.GET;
          NoSeriesMgt.TestManual(JobsSetup."ODT Field Ticket Nos.");
          "No. Series":='';
        END;
      end;
    }
    field(15;"No. Series";Code[20])
    {
    }
    field(20;"Job No.";Code[20])
    {
      //TableRelation = Job."No." WHERE ("Bill-to Customer No." = FIELD ("Bill-to Customer No."));
      TableRelation = Job."No." WHERE(Status=const(Open));

      trigger OnValidate();
      var Job: Record Job;
      JobJnl: Record "Job Journal Line";
      TEXT001: Label 'You cannot change the Job No. when there are Job Journal Lines created for the Field Ticket.';
      JobTaskLine: Record "Job Task";
      begin
        JobJnl.SETRANGE("Job No.", xRec."Job No.");
        JobJnl.SETRANGE("ODT Field Ticket No.", "Field Ticket No.");
        JobJnl.SETFILTER("No.", '<>%1', '');
        if JobJnl.FIND('-')then ERROR(TEXT001);
        if Job.GET("Job No.")then begin
          //IF "SUR LSD Format" = '' THEN
          //  "SUR LSD Format" := Job."SUR LSD Format";
          //IF "DH LSD Format" = '' THEN
          //  "DH LSD Format" := Job."DH LSD Format";
          //IF "From DH LSD" = '' THEN
          //  "From DH LSD" := Job."From DH LSD";
          //IF "From SUR LSD" = '' THEN
          // "From SUR LSD" := Job."From SUR LSD";
          //IF "To DH LSD" = '' THEN
          //  "To DH LSD" := Job."To DH LSD";
          //IF "To SUR LSD" = '' THEN
          //  "To SUR LSD" := Job."To SUR LSD";
          //IF "Rig No." = '' THEN
          //  "Rig No." := Job."Rig No.";
          //IF "AFE No." = '' THEN
          // "AFE No." := Job."AFE No.";
          "Bill-to Customer No.":=Job."Bill-to Customer No.";
          "Project Manager":=Job."Project Manager";
          "Job Description":=Job.Description;
          "ODT AFE":=Job."ODT AFE";
          "ODT Business Unit":=Job."ODT Business Unit";
          "ODT Cost Centre":=Job."ODT Cost Centre";
          "ODT Client File":=Job."ODT Client File";
          "ODT GL":=Job."ODT GL";
          "ODT Major":=Job."ODT Major";
          "ODT Minor":=Job."ODT Minor";
          "ODT MSA":=Job."ODT MSA";
          "ODT MSO":=Job."ODT MSO";
          "ODT Purchase Order":=Job."ODT Purchase Order";
          "ODT Service Order":=Job."ODT Service Order";
          // "ODT Land Surveyor" := Job."ODT Land Surveyor";
          // "ODT Date Received" := Job."ODT Date Received";
          // "ODT Originator" := Job."ODT Originator";
          // "ODT Location" := Job."ODT Location";
          // "ODT Internal Notes" := Job."ODT Internal Notes";
          // "ODT Project Instructions" := Job."ODT Project Instructions";
          // "ODT Job LSDs" := Job."ODT Job LSDs";
          // if "Rental Order No."='' then
          //     "Rental Order No.":=Job."Sales Order No.";     //<NE02.01/>
          //NB03.58+ ODTJR Add i2x Fields
          // if "Company Code" = '' then
          //     "Company Code" := Job."Company Code";
          // if "Department/Attention To" = '' then
          //     "Department/Attention To" := Job."Department/Attention To";
          // if "Plant Code" = '' then
          //     "Plant Code" := Job."Plant Code";
          // if "Approver ID" = '' then
          //     "Approver ID" := Job."Approver ID";
          // if Requisitioner = '' then
          //     Requisitioner  := Job.Requisitioner;
          // if "Work Order No."  = '' then
          //     "Work Order No."  := Job."Work Order No.";
          // if "Reviewer ID"  = '' then
          //     "Reviewer ID"  := Job."Reviewer ID";
          // if "Activity Code"  = '' then
          //     "Activity Code"  := Job."Activity Code";
          // if "Billing LSD"  = '' then
          //     "Billing LSD"  := Job."Billing LSD";
          // if "Company Code"  = '' then
          //     "Company Code"  := Job."Company Code";
          // if "Company Code" = '' then
          //     "Company Code"  := Job."Company Code";
          // if "Billing LSD Format"  = '' then
          //     "Billing LSD Format"  := Job."Billing LSD Format";
          // if "Customer G/L Account Code"  = '' then
          //     "Customer G/L Account Code"  := Job."Customer G/L Account Code";
          // if "Summary Description" = '' then
          //     "Summary Description"  := Job."Summary Description";
          if "Bill-to Contact" = '' then "Bill-to Contact":=Job."Bill-to Contact";
        // "Reference Field Type"  := Job."Reference Field Type";
        // if "Reference Field No." = '' then
        //     "Reference Field No."  := Job."Reference Field No.";
        //NB03.58-
        end;
      end;
    }
    field(21;"Job Task No.";Code[50])
    {
      Caption = 'Job Task No.';
      DataClassification = ToBeClassified;
      TableRelation = "Job Task"."Job Task No." WHERE("Job No."=FIELD("Job No."), "ODT Closed"=const(FALSE));

      trigger OnValidate();
      var JobTask: Record "Job Task";
      begin
        JobTask.GET("Job No.", "Job Task No.");
        JobTask.TESTFIELD("Job Task Type", JobTask."Job Task Type"::Posting);
        JobTask.TESTFIELD("ODT Closed", FALSE);
      end;
    }
    field(25;"Bill-to Customer No.";Code[20])
    {
      TableRelation = Customer;

      trigger OnValidate();
      var Customer: Record Customer;
      Job: Record Job;
      JobSetup: Record "Jobs Setup";
      FTJM: Record "ODT Field Ticket Job Mapping";
      JobJnl: Record "Job Journal Line";
      TEXT001: Label '"You cannot change the Bill-to Customer when there are Job Journal Lines created for the Field Ticket. "';
      begin
        //NB04.04+ ODTJR Change
        //IF "Job No." <> '' THEN
        //  ERROR('You can not change the Bill-to Customer No. for an existing Job.'); //NB04.04
        //NB04.04-
        JobJnl.SETRANGE("Job No.", "Job No.");
        JobJnl.SETRANGE("ODT Field Ticket No.", "Field Ticket No.");
        JobJnl.SETFILTER("No.", '<>%1', '');
        if JobJnl.FIND('-')then ERROR(TEXT001);
        JobSetup.GET;
        if "Dispatch ID" <> '' then CheckDispatchCust("Dispatch ID");
        if MODIFY then;
      end;
    }
    field(30;"SUR LSD Format";Code[10])
    {
      Description = 'NB03.27';
      TableRelation = "ODT LSD Format";

      trigger OnValidate();
      var Job: Record Job;
      begin
        VALIDATE("From DH LSD");
        VALIDATE("From SUR LSD");
      //NB03.45-->
      // if "Job No." <> '' then begin
      //   Job.GET("Job No.");
      //   Job."SUR LSD Format" := "SUR LSD Format";
      //   Job.MODIFY;
      // end;
      //<--NB03.45
      end;
    }
    field(40;"From SUR LSD";Code[50])
    {
      Caption = 'Load Location';
      Description = 'Load Location';
      TableRelation = "ODT LSD"."LSD Code";

      trigger OnValidate();
      begin
      //TESTFIELD("From LSD Format");
      //IF "From SUR LSD" <> '' THEN
      //LSDFormats.ValidateFormat("SUR LSD Format", "From SUR LSD");
      //NB03.45-->
      // if "Job No." <> '' then begin
      //   Job.GET("Job No.");
      //   Job."From SUR LSD" := "From SUR LSD";
      //   Job.MODIFY;
      // end;
      //<--NB03.45
      end;
    }
    field(50;"To SUR LSD";Code[50])
    {
      Caption = 'Surface Location';
      Description = 'Surface Location';
      TableRelation = "ODT LSD"."LSD Code" WHERE(Type=CONST(Surface));

      trigger OnValidate();
      var LSD: Record "ODT LSD";
      begin
        //TESTFIELD("To LSD Format");
        if "To SUR LSD" <> '' then begin
          //LSDFormats.ValidateFormat("SUR LSD Format", "To SUR LSD");//NB03.27 line removed
          //LSDFormats.ValidateFormat("SUR LSD Format", "To SUR LSD");//NB03.27
          LSD.RESET;
          LSD.SETRANGE("LSD Code", "To SUR LSD");
          if LSD.FINDFIRST then "SUR LSD Format":=LSD."LSD Format Code"
          else
            CLEAR("SUR LSD Format");
        end
        else
          CLEAR("To DH LSD");
      //NB03.45-->
      // if "Job No." <> '' then begin
      //   Job.GET("Job No.");
      //   Job."To SUR LSD" := "To SUR LSD";
      //   Job.MODIFY;
      // end;
      //<--NB03.45
      end;
    }
    field(60;"DH LSD Format";Code[10])
    {
      Description = 'NB03.27';
      TableRelation = "ODT LSD Format";

      trigger OnValidate();
      begin
        VALIDATE("To DH LSD");
        VALIDATE("To SUR LSD");
      //NB03.45-->
      // if "Job No." <> '' then begin
      //   Job.GET("Job No.");
      //   Job."DH LSD Format" := "DH LSD Format";
      //   Job.MODIFY;
      // end;
      //<--NB03.45
      end;
    }
    field(70;"From DH LSD";Code[50])
    {
      Caption = 'Delivery Location';
      Description = 'Delivery Location';
      TableRelation = "ODT LSD"."LSD Code";

      trigger OnValidate();
      begin
      //TESTFIELD("From LSD Format");
      //IF "From DH LSD" <> '' THEN
      //LSDFormats.ValidateFormat("DH LSD Format", "From DH LSD");//NB03.27 line removed
      //LSDFormats.ValidateFormat("DH LSD Format", "From DH LSD");//NB03.27
      //NB03.45-->
      // if "Job No." <> '' then begin
      //   Job.GET("Job No.");
      //   Job."From DH LSD" := "From DH LSD";
      //   Job.MODIFY;
      // end;
      //<--NB03.45
      end;
    }
    field(80;"To DH LSD";Code[50])
    {
      Caption = 'Downhole Location';
      Description = 'Downhole Location';
      TableRelation = "ODT LSD"."LSD Code" WHERE(Type=CONST(Downhole), "Surface LSD"=FIELD("To SUR LSD"));

      trigger OnValidate();
      var LSD: Record "ODT LSD";
      begin
        //TESTFIELD("To LSD Format");
        //IF "To DH LSD" <> '' THEN
        //LSDFormats.ValidateFormat("DH LSD Format", "To DH LSD");
        LSD.RESET;
        LSD.SETRANGE("LSD Code", "To DH LSD");
        if LSD.FINDFIRST then "DH LSD Format":=LSD."LSD Format Code"
        else
          CLEAR("DH LSD Format");
      //NB03.45-->
      // if "Job No." <> '' then begin
      //   Job.GET("Job No.");
      //   Job."To DH LSD" := "To DH LSD";
      //   Job.MODIFY;
      // end;
      //<--NB03.45
      end;
    }
    field(90;"Rig No.";Text[30])
    {
      trigger OnValidate();
      begin
      //NB03.45-->
      // if "Job No." <> '' then begin
      //   Job.GET("Job No.");
      //   Job."Rig No." := "Rig No.";
      //   Job.MODIFY;
      // end;
      //<--NB03.45
      end;
    }
    field(100;"AFE No.";Code[30])
    {
      trigger OnValidate();
      begin
      //NB03.45-->
      // if "Job No." <> '' then begin
      //   Job.GET("Job No.");
      //   Job.VALIDATE("AFE No.","AFE No.");
      //   Job.MODIFY;
      // end;
      //<--NB03.45
      end;
    }
    field(110;"Field Ticket Date";Date)
    {
    }
    field(120;"Reference Field Type";Option)
    {
      OptionMembers = " ", "Cost Code", "Attn:", "PO#";

      trigger OnValidate();
      begin
      //NB03.45-->
      // if "Job No." <> '' then begin
      //   Job.GET("Job No.");
      //   Job."Reference Field Type" := "Reference Field Type";
      //   Job.MODIFY;
      // end;
      //<--NB03.45
      end;
    }
    field(130;"Reference Field No.";Text[50])
    {
      trigger OnValidate();
      begin
      //NB03.45-->
      // if "Job No." <> '' then begin
      //   Job.GET("Job No.");
      //   Job."Reference Field No." := "Reference Field No.";
      //   Job.MODIFY;
      // end;
      //<--NB03.45
      end;
    }
    // field(140; "Rental Order No."; Code[20])
    // {
    //     Description = 'NE02.01';
    //     TableRelation = "Sales Header"."No." WHERE ("Bill-to Customer No." = FIELD ("Bill-to Customer No."));
    // }
    field(150;"Bill To Customer Name";Text[50])
    {
      CalcFormula = Lookup(Customer.Name WHERE("No."=FIELD("Bill-to Customer No.")));
      FieldClass = FlowField;
    }
    field(160;"Document Type";Option)
    {
      CalcFormula = Lookup("Job Planning Line Invoice"."Document Type" WHERE("Job No."=FIELD("Job No."), "Job Task No."=FIELD("Field Ticket No.")));
      FieldClass = FlowField;
      OptionMembers = " ", Invoice, "Credit Memo", "Posted Invoice", "Posted Credit Memo";
    }
    field(170;"Document No.";Code[20])
    {
      CalcFormula = Lookup("Job Planning Line Invoice"."Document No." WHERE("Job No."=FIELD("Job No."), "Job Task No."=FIELD("Field Ticket No.")));
      FieldClass = FlowField;
    }
    field(180;"Created by User ID";Code[20])
    {
      Editable = false;
    }
    field(190;"Field Ticket Type";Option)
    {
      OptionCaption = 'General,Water Hauling,LEM';
      OptionMembers = General, "Water Hauling", LEM;
    }
    field(200;"Service Date";Date)
    {
    }
    field(210;"Currency Code";Code[10])
    {
      Caption = 'Currency Code';
      TableRelation = Currency;
    }
    field(220;"Superintendent Name";Text[50])
    {
      Caption = 'Currency Code';
      TableRelation = Currency;
    }
    field(230;"Truck Number";Code[20])
    {
    }
    field(240;"Truck Capacity";Text[50])
    {
    }
    field(250;"Driver Name";Text[50])
    {
    }
    field(260;Status;Option)
    {
      OptionCaption = 'Open,Pending Approval,Approved,Rejected';
      OptionMembers = Open, "Pending Approval", Approved, Rejected;
    }
    field(270;"Created Date Time";DateTime)
    {
    }
    field(280;"Last Modified By";Code[20])
    {
    }
    field(290;"Last Modified Date Time";DateTime)
    {
    }
    field(300;"Posted By";Code[20])
    {
    }
    field(310;"Posted Date Time";DateTime)
    {
    }
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
    field(50011;"ODT Job No.";Code[20])
    {
      Caption = 'Job No.';
      DataClassification = ToBeClassified;
      TableRelation = Job."No." WHERE(Status=const(Open));
    }
    field(50012;"ODT Job Description";Text[100])
    {
      Caption = 'Job No.';
      DataClassification = ToBeClassified;
    }
    field(50044;"Billing LSD Format";Code[10])
    {
      Description = 'NB03.58';
      TableRelation = "ODT LSD Format";

      trigger OnValidate();
      begin
        VALIDATE("Billing LSD");
      end;
    }
    field(50045;"Customer G/L Account Code";Code[20])
    {
      Description = 'NB03.58';
    }
    field(50046;"Plant Code";Code[20])
    {
      Description = 'NB03.58';
    }
    field(50047;"Approver ID";Code[20])
    {
      Description = 'NB03.58';
    }
    field(50048;"Department/Attention To";Code[50])
    {
      Description = 'NB03.58';
    // TableRelation = Table50033.Field2 WHERE (Field1=FIELD("Bill-to Customer No."));
    }
    field(50049;"Description of Work";Text[150])
    {
      Caption = 'Description of Work';
      Description = 'NB03.58';
    }
    field(50050;Requisitioner;Code[20])
    {
      Description = 'NB03.58';
    }
    field(50051;"Work Order No.";Code[20])
    {
      Description = 'NB03.58';
    }
    field(50052;"Reviewer ID";Code[20])
    {
      Description = 'NB03.58';
    }
    field(50053;"Activity Code";Code[20])
    {
      Description = 'NB03.58';
    }
    field(50054;"Billing LSD";Code[50])
    {
      Description = 'NB03.58';
      TableRelation = "ODT LSD"."LSD Code";

      trigger OnValidate();
      var LSD: Record "ODT LSD";
      begin
        //IF "Billing LSD" <> '' THEN
        // LSDFormats.ValidateFormat("Billing LSD Format", "Billing LSD");
        LSD.RESET;
        LSD.SETRANGE("LSD Code", "Billing LSD");
        if LSD.FINDFIRST then "Billing LSD Format":=LSD."LSD Format Code";
      end;
    }
    field(50055;"Company Code";Code[20])
    {
      Description = 'NB03.58';
    // TableRelation = Table50034.Field2 WHERE (Field1=FIELD("Bill-to Customer No."));
    }
    field(50056;"Bill-to Contact";Text[50])
    {
      Caption = 'Contact';
      Description = 'NB03.58';
    }
    field(50057;"Dispatch ID";Code[20])
    {
      Description = 'NB03.75';

      // TableRelation = Table50300.Field1;
      trigger OnValidate();
      var JobJnl: Record "Job Journal Line";
      JobTask: Record "Job Task";
      // Dispatch : Record Table50300;
      UpdateDispatch: Boolean;
      ChangeDispatch: Label 'Changing Dispatch ID will update the LSD fields. Continue?';
      // DispatchCard : Page Page50300;
      // DispatchData : Record Table50300;
      TEXT001: Label 'Dispatch cannot be found.';
      FTJM: Record "ODT Field Ticket Job Mapping";
      begin
      // UpdateDispatch := DIALOG.CONFIRM(ChangeDispatch,true);
      // if UpdateDispatch then begin
      //     if xRec."Dispatch ID" <> "Dispatch ID" then begin
      //         if "Rental Order No."=''then begin
      //         FTJM.RESET;
      //         FTJM.SETRANGE("Dispatch ID","Dispatch ID");
      //         if FTJM.FINDFIRST then
      //            VALIDATE("Job No.", FTJM."Job No.")
      //         else
      //            VALIDATE("Job No.",'');
      //         end;
      //         //JobJnl.SETRANGE("Job No.","Job No.");
      //         JobJnl.SETRANGE("Field Ticket No.","Field Ticket No.");
      //         JobJnl.SETRANGE("Dispatch ID",xRec."Dispatch ID");
      //         if JobJnl.FIND('-') then
      //           repeat
      //             JobJnl."Dispatch ID" := "Dispatch ID";
      //             JobJnl.MODIFY;
      //           until JobJnl.NEXT = 0;
      //JobTask.SETRANGE("Job No.","Job No.");
      // JobTask.SETRANGE("Job Task No.","Field Ticket No.");
      // JobTask.SETRANGE("Dispatch ID",xRec."Dispatch ID");
      // if JobTask.FIND('-') then
      //   repeat
      //     JobTask."Dispatch ID" := "Dispatch ID";
      //     JobTask.MODIFY;
      //   until JobTask.NEXT = 0;
      //       if "Dispatch ID" <> '' then begin
      //         Dispatch.GET("Dispatch ID");
      //         "SUR LSD Format" := Dispatch."Surface Format";
      //         "From SUR LSD" := Dispatch."Load Location";
      //         "To SUR LSD" := Dispatch."Surface Location";
      //         "DH LSD Format" := Dispatch."Downhole Format";
      //         "From DH LSD" := Dispatch."Delivery Location";
      //         "To DH LSD" := Dispatch."Downhole Location";
      //         if Dispatch.Customer <> '' then begin
      //            //IF "Bill-to Customer No." <> '' THEN  //NB04.04 Update Bill-to Cust. when Dispatch is changed
      //            if "Rental Order No." = '' then
      //              "Bill-to Customer No." := Dispatch.Customer;
      //         end else begin
      //           DispatchData.RESET;
      //           DispatchData.SETRANGE("No.",Dispatch."No.");
      //           DispatchCard.SETRECORD(DispatchData);
      //           DispatchCard.SETTABLEVIEW(DispatchData);
      //           DispatchCard.LOOKUPMODE(true);
      //           if DispatchCard.RUNMODAL = ACTION::LookupOK then begin
      //             DispatchCard.GETRECORD(DispatchData);
      //             "Dispatch ID" := DispatchData."No.";
      //             //IF "Bill-to Customer No." = '' THEN
      //                //VALIDATE("Bill-to Customer No.",DispatchData.Customer);
      //             if "Rental Order No." = '' then
      //                 "Bill-to Customer No." := DispatchData.Customer;
      //             "SUR LSD Format" := DispatchData."Surface Format";
      //             "From SUR LSD" := DispatchData."Load Location";
      //             "To SUR LSD" := DispatchData."Surface Location";
      //             "DH LSD Format" := DispatchData."Downhole Format";
      //             "From DH LSD" := DispatchData."Delivery Location";
      //             "To DH LSD" := DispatchData."Downhole Location";
      //           end else begin
      //             ERROR(TEXT001);
      //           end;
      //         end;
      //       end;
      //       end else begin
      //         CLEAR("SUR LSD Format");
      //         CLEAR("From SUR LSD");
      //         CLEAR("To SUR LSD");
      //         CLEAR("DH LSD Format");
      //         CLEAR("From DH LSD");
      //         CLEAR("To DH LSD");
      //       end;
      // end else
      //   ERROR('Change discarded. Hit F5 to Refresh data.');
      end;
    }
    field(50058;"AFE Filter";Code[30])
    {
    }
    field(50059;"Project Manager";Code[50])
    {
      Caption = 'Purchase Order';
      DataClassification = ToBeClassified;
      Editable = FALSE;
    }
    field(50060;"Job Description";Text[100])
    {
      Caption = 'Job Description';
      DataClassification = ToBeClassified;
    }
    field(50061;Description;Text[100])
    {
      Caption = 'Description';
      DataClassification = ToBeClassified;
    }
    field(50062;"Description 2";Text[100])
    {
      Caption = 'Description 2';
      DataClassification = ToBeClassified;
    }
    field(50063;"Description 3";Text[100])
    {
      Caption = 'Description 3';
      DataClassification = ToBeClassified;
    }
    field(50064;"Description 4";Text[100])
    {
      Caption = 'Description 4';
      DataClassification = ToBeClassified;
    }
    field(50065;"Description 5";Text[100])
    {
      Caption = 'Description 5';
      DataClassification = ToBeClassified;
    }
    field(50066;"Description 6";Text[100])
    {
      Caption = 'Description 6';
      DataClassification = ToBeClassified;
    }
    field(50067;"Description 7";Text[100])
    {
      Caption = 'Description 7';
      DataClassification = ToBeClassified;
    }
    field(50068;"Crem Member 1";Text[50])
    {
      Caption = 'Crew Member 1';
      DataClassification = ToBeClassified;
    }
    field(50069;"Crem Member 2";Text[50])
    {
      Caption = 'Crew Member 2';
      DataClassification = ToBeClassified;
    }
    field(50070;"Crem Member 3";Text[50])
    {
      Caption = 'Crew Member 3';
      DataClassification = ToBeClassified;
    }
    field(50071;"Description 8";Text[100])
    {
      Caption = 'Description 8';
      DataClassification = ToBeClassified;
    }
  }
  keys
  {
    key(Key1;"Field Ticket No.")
    {
    }
  }
  fieldgroups
  {
    fieldgroup(DropDown;"Field Ticket No.", "Field Ticket Date", "Bill To Customer Name", "AFE No.")
    {
    }
  }
  trigger OnInsert();
  begin
    IF Rec.GetFilter("Job No.") <> '' then "Job No.":=Rec.GetFilter("Job No.");
    IF "Field Ticket No." = '' THEN BEGIN
      JobsSetup.GET;
      JobsSetup.TESTFIELD("ODT Field Ticket Nos.");
      NoSeriesMgt.InitSeries(JobsSetup."ODT Field Ticket Nos.", xRec."No. Series", TODAY, "Field Ticket No.", "No. Series");
    END;
    "Created by User ID":=USERID; //NB03.57 2017-04-13
    //<NB04.10 2019-04-24 start insert>
    "Created Date Time":=CREATEDATETIME(WORKDATE, TIME);
    // DispatchSetup.GET;
    // "SUR LSD Format" := DispatchSetup."Default SUR LSD Format";
    // "DH LSD Format" := DispatchSetup."Default DH LSD Format";
    //</NB04.10 2019-04-24 end insert>
    IF Rec.GetFilter("Job No.") <> '' then Validate("Job No.");
  end;
  trigger OnModify();
  begin
    //  UpdateJob; //NB03.58
    //  UpdateOpenDocs; //NB03.58
    UpdateFT; //NB03.58
    //<NB04.10 2019-04-24 start insert>
    "Last Modified By":=USERID;
    "Last Modified Date Time":=CREATEDATETIME(WORKDATE, TIME);
  //</NB04.10 2019-04-24 end insert>
  end;
  trigger OnRename();
  var // TicketLineAllocation : Record Table50024;
  FTLine: Record "ODT FT Job Mapping Lines";
  // TicketLineAllocation2 : Record Table50024;
  FTLine2: Record "ODT FT Job Mapping Lines";
  begin
    FTLine.RESET;
    FTLine.SETRANGE("Field Ticket No.", xRec."Field Ticket No.");
    if FTLine.FINDSET then repeat FTLine2:=FTLine;
        FTLine2.RENAME("Field Ticket No.", FTLine2."Line No.");
        FTLine2.VALIDATE("Job No.", FT."Job No.");
        FTLine2.MODIFY;
      until FTLine.NEXT = 0;
  // TicketLineAllocation.RESET;
  // //TicketLineAllocation.SETRANGE(Type, TicketLineAllocation.Type::"Job Journal");
  // //Field Ticket No.,Field Ticket Line No.,Line No.
  // TicketLineAllocation.SETRANGE("Field Ticket No.",xRec."Field Ticket No.");
  // repeat
  //   TicketLineAllocation2 := TicketLineAllocation;
  //   TicketLineAllocation2.RENAME("Field Ticket No.",TicketLineAllocation2."Field Ticket Line No.",TicketLineAllocation2."Line No.");
  //   TicketLineAllocation2.MODIFY;
  // until FTLine.NEXT = 0;
  end;
  var LSDFormats: Record "ODT LSD Format";
  "--NB03.45": Integer;
  Job: Record Job;
  // DispatchSetup : Record Table50006;
  SH: Record "Sales Header";
  FT: Record "ODT Field Ticket Job Mapping";
  JobsSetup: Record "Jobs Setup";
  NoSeriesMgt: Codeunit NoSeriesManagement;
  FieldTicketJobMapping: Record "ODT Field Ticket Job Mapping";
  procedure CompanyName(): Text[50];
  var Customer: Record Customer;
  begin
    if Customer.GET("Bill-to Customer No.")then exit(Customer.Name)
    else
      exit('');
  end;
  local procedure UpdateJob();
  var JobCard: Record Job;
  begin
  // if JobCard.GET("Job No.") then begin
  //    JobCard."Billing LSD Format" := "Billing LSD Format";
  //    JobCard."Company Code" := "Company Code";
  //    JobCard."Customer G/L Account Code" := "Customer G/L Account Code";
  //    JobCard."Plant Code" := "Plant Code";
  //    JobCard."Approver ID" := "Approver ID";
  //    JobCard."Summary Description"  := "Summary Description";
  //    JobCard.Requisitioner  := Requisitioner;
  //    JobCard."Work Order No."  := "Work Order No.";
  //    JobCard."Reviewer ID"  := "Reviewer ID";
  //    JobCard."Activity Code"  := "Activity Code";
  //    JobCard."Billing LSD"  := "Billing LSD";
  //    JobCard."Company Code"  := "Company Code";
  //    JobCard."Department/Attention To"  := "Department/Attention To";
  //    //JobCard."Field Ticket No." := "Field Ticket No.";
  //    //JobCard."SUR LSD Format" := "SUR LSD Format";
  //    //JobCard."From SUR LSD" := "From SUR LSD";
  //    //JobCard."To SUR LSD" := "To SUR LSD";
  //    //JobCard."DH LSD Format" := "DH LSD Format";
  //    //JobCard."From DH LSD" := "From DH LSD";
  //    //JobCard."To DH LSD" := "To DH LSD";
  //    JobCard."Rig No." := "Rig No.";
  //    JobCard."AFE No." := "AFE No.";
  //    JobCard."Reference Field Type" := "Reference Field Type";
  //    JobCard."Reference Field No." := "Reference Field No.";
  //    JobCard."Bill-to Contact" := "Bill-to Contact";
  //  JobCard."Last Modified By" := USERID;
  //  JobCard."Last Date Modified" := TODAY;
  //  JobCard.MODIFY;
  // end
  end;
  local procedure UpdateOpenDocs();
  begin
  // SH.RESET;
  // SH.SETRANGE("Job No.","Job No.");
  // if SH.FIND('-') then begin
  //   repeat
  //     SH."Billing LSD Format" := "Billing LSD Format";
  //     SH."Company Code" := "Company Code";
  //     SH."Customer G/L Account Code" := "Customer G/L Account Code";
  //     SH."Plant Code" := "Plant Code";
  //     SH."Approver ID" := "Approver ID";
  //     SH."Summary Description"  := "Summary Description";
  //     SH.Requisitioner  := Requisitioner;
  //     SH."Work Order No."  := "Work Order No.";
  //     SH."Reviewer ID"  := "Reviewer ID";
  //     SH."Activity Code"  := "Activity Code";
  //     SH."Billing LSD"  := "Billing LSD";
  //     SH."Company Code"  := "Company Code";
  //     SH."Department/Attention To"  := "Department/Attention To";
  //     //SH."Field Ticket No." := "Field Ticket No.";
  //     //SH."SUR LSD Format" := "SUR LSD Format";
  //     //SH."From SUR LSD" := "From SUR LSD";
  //     //SH."To SUR LSD" := "To SUR LSD";
  //     //SH."DH LSD Format" := "DH LSD Format";
  //     //SH."From DH LSD" := "From DH LSD";
  //     //SH."To DH LSD" := "To DH LSD";
  //     SH."Rig No." := "Rig No.";
  //     SH."AFE No." := "AFE No.";
  //     SH."Reference Field Type" := "Reference Field Type";
  //     SH."Reference Field No." := "Reference Field No.";
  //     SH."Bill-to Contact" := "Bill-to Contact";
  //     SH.MODIFY;
  //   until SH.NEXT = 0;
  // end;
  end;
  local procedure UpdateFT();
  begin
    FT.RESET;
    FT.SETRANGE("Job No.", "Job No.");
    FT.SETFILTER("Field Ticket No.", '<>%1', "Field Ticket No.");
    if FT.FIND('-')then begin
      repeat FT."Billing LSD Format":="Billing LSD Format";
        FT."Company Code":="Company Code";
        FT."Customer G/L Account Code":="Customer G/L Account Code";
        FT."Plant Code":="Plant Code";
        FT."Approver ID":="Approver ID";
        FT."Description of Work":="Description of Work";
        FT.Requisitioner:=Requisitioner;
        FT."Work Order No.":="Work Order No.";
        FT."Reviewer ID":="Reviewer ID";
        FT."Activity Code":="Activity Code";
        FT."Billing LSD":="Billing LSD";
        FT."Company Code":="Company Code";
        FT."Department/Attention To":="Department/Attention To";
        //FT."SUR LSD Format" := "SUR LSD Format";
        //FT."From SUR LSD" := "From SUR LSD";
        //FT."To SUR LSD" := "To SUR LSD";
        //FT."DH LSD Format" := "DH LSD Format";
        //FT."From DH LSD" := "From DH LSD";
        //FT."To DH LSD" := "To DH LSD";
        FT."Rig No.":="Rig No.";
        FT."AFE No.":="AFE No.";
        FT."Reference Field Type":="Reference Field Type";
        FT."Reference Field No.":="Reference Field No.";
        FT."Bill-to Contact":="Bill-to Contact";
        FT.MODIFY;
      until FT.NEXT = 0;
      FT."Dispatch ID":="Dispatch ID"; //NB03.75
    end;
  end;
  local procedure UpdateJobJnls(JobNo: Code[20];
  JobTaskNo: Code[20]);
  begin
  end;
  local procedure CheckDispatchCust(DispatchID: Code[20]);
  var // DispatchData : Record Table50300;
  // DispatchCard : Page Page50300;
  begin
  // DispatchData.RESET;
  // DispatchData.SETRANGE("No.",DispatchID);
  // DispatchCard.SETRECORD(DispatchData);
  // DispatchCard.SETTABLEVIEW(DispatchData);
  // DispatchCard.LOOKUPMODE(true);
  // if DispatchCard.RUNMODAL = ACTION::LookupOK then begin
  //   DispatchCard.GETRECORD(DispatchData);
  //   "Dispatch ID" := DispatchData."No.";
  //   //IF "Bill-to Customer No." = '' THEN
  //      VALIDATE("Bill-to Customer No.",DispatchData.Customer);
  //   "SUR LSD Format" := DispatchData."Surface Format";
  //   "From SUR LSD" := DispatchData."Load Location";
  //   "To SUR LSD" := DispatchData."Surface Location";
  //   "DH LSD Format" := DispatchData."Downhole Format";
  //   "From DH LSD" := DispatchData."Delivery Location";
  //   "To DH LSD" := DispatchData."Downhole Location";
  // end else
  //    "Dispatch ID":='';
  end;
  procedure ActionUpdate(ActionString: Text);
  var // SalesLine : Record "Sales Line";
  // SalesHeader : Record "Sales Header";
  // CustBillingReq : Record Table50000;
  // MultiInvoiceMgt : Codeunit Codeunit50001;
  begin
    // //NB04.10 2019-04-24
    case ActionString of 'Open': begin
      Status:=Status::Open;
    end;
    'Pending Approval': begin
      Status:=Status::"Pending Approval";
    end;
    'Approved': begin
      Status:=Status::Approved;
    end;
    'Rejected': begin
      Status:=Status::Rejected;
    end;
    end;
    MODIFY;
  // IF "Sent Status" = "Sent Status"::Approved THEN BEGIN
  //     "Approved By" := USERID;
  //     "Approved Date" := TODAY;
  // END ELSE
  //     IF "Sent Status" = "Sent Status"::Sent THEN BEGIN
  //         "Sent By" := USERID;
  //         "Sent Date" := TODAY;
  //     END;
  // MODIFY;
  end;
  procedure AssistEdit(OldRec: Record "ODT Field Ticket Job Mapping"): Boolean;
  begin
    WITH FieldTicketJobMapping DO BEGIN
      COPY(Rec);
      JobsSetup.GET;
      JobsSetup.TESTFIELD("ODT Field Ticket Nos.");
      IF NoSeriesMgt.SelectSeries(JobsSetup."ODT Field Ticket Nos.", OldRec."No. Series", "No. Series")THEN BEGIN
        NoSeriesMgt.SetSeries("Field Ticket No.");
        Rec:=FieldTicketJobMapping;
        EXIT(TRUE);
      END;
    END;
  end;
}
