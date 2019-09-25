tableextension 50002 "ODT JobJnlLineExt" extends "Job Journal Line" //MyTargetTableId
{
  fields
  {
    field(50000;"ODT Field Ticket No.";Code[20])
    {
      trigger OnLookup();
      var JobTaskLine: Record "Job Task";
      JobSetup: Record "Jobs Setup";
      FieldTicketJobMapping: Record "ODT Field Ticket Job Mapping";
      JobMapping: Page "ODT Field Ticket Job Mapping";
      JJLine: Record "Job Journal Line";
      begin
        //<NB04.10 2019-05-02 start delete from OnLookup>
        if "ODT Field Ticket No." <> '' then begin
          FieldTicketJobMapping.RESET;
          FieldTicketJobMapping.GET("ODT Field Ticket No.");
          COMMIT;
          CLEAR(JobMapping);
          JobMapping.SETRECORD(FieldTicketJobMapping);
          JobMapping.RUNMODAL;
          COMMIT;
          FieldTicketJobMapping.GET("ODT Field Ticket No.");
          if FieldTicketJobMapping."Job No." = '' then begin
            FieldTicketJobMapping.DELETE;
            "ODT Field Ticket No.":='';
            exit;
          end
          else
          begin
            // JobTaskLine.RESET;
            // if not JobTaskLine.GET(FieldTicketJobMapping."Job No.", "ODT Field Ticket No.") then begin
            //     JobTaskLine.RESET;
            //     JobTaskLine.VALIDATE("Job No.", FieldTicketJobMapping."Job No.");
            //     JobTaskLine.VALIDATE("Job Task No.", "ODT Field Ticket No.");
            //     JobTaskLine.INSERT(true);
            // end;
            if "Line Type" = "Line Type"::" " then VALIDATE("Line Type", "Line Type"::"Both Budget and Billable");
            // if "Job No." <> FieldTicketJobMapping."Job No." then
            //     VALIDATE("Job No.", FieldTicketJobMapping."Job No.");
            // if "Job Task No." <> "ODT Field Ticket No." then
            //     VALIDATE("Job Task No.", "ODT Field Ticket No.");
            "SUR LSD Format":=FieldTicketJobMapping."SUR LSD Format";
            "DH LSD Format":=FieldTicketJobMapping."DH LSD Format";
            "From DH LSD":=FieldTicketJobMapping."From DH LSD";
            "To DH LSD":=FieldTicketJobMapping."To DH LSD";
            "From SUR LSD":=FieldTicketJobMapping."From SUR LSD";
            "To SUR LSD":=FieldTicketJobMapping."To SUR LSD";
            "Rig No.":=FieldTicketJobMapping."Rig No.";
            "AFE #":=FieldTicketJobMapping."AFE No.";
            "Field Ticket Date":=FieldTicketJobMapping."Field Ticket Date";
            VALIDATE("Posting Date", FieldTicketJobMapping."Field Ticket Date");
            "ODT Reference Field Type":=FieldTicketJobMapping."Reference Field Type";
            "ODT Reference Field No.":=FieldTicketJobMapping."Reference Field No.";
            //"Sales Order No." := FieldTicketJobMapping."Rental Order No.";           //<NE02.01/>
            JJLine.RESET;
            JJLine.SETRANGE("ODT Field Ticket No.", "ODT Field Ticket No.");
            if JJLine.FINDFIRST then begin
              repeat if not((JJLine."Journal Template Name" = "Journal Template Name") and (JJLine."Journal Batch Name" = "Journal Batch Name") and (JJLine."Line No." = "Line No."))then begin
                  with JJLine do begin
                    // if "Job No." <> FieldTicketJobMapping."Job No." then
                    //     VALIDATE("Job No.", FieldTicketJobMapping."Job No.");
                    // if "Job Task No." <> "ODT Field Ticket No." then
                    //     VALIDATE("Job Task No.", "ODT Field Ticket No.");
                    "SUR LSD Format":=FieldTicketJobMapping."SUR LSD Format";
                    "DH LSD Format":=FieldTicketJobMapping."DH LSD Format";
                    "From DH LSD":=FieldTicketJobMapping."From DH LSD";
                    "To DH LSD":=FieldTicketJobMapping."To DH LSD";
                    "From SUR LSD":=FieldTicketJobMapping."From SUR LSD";
                    "To SUR LSD":=FieldTicketJobMapping."To SUR LSD";
                    "Rig No.":=FieldTicketJobMapping."Rig No.";
                    "AFE #":=FieldTicketJobMapping."AFE No.";
                    VALIDATE("Posting Date", FieldTicketJobMapping."Field Ticket Date");
                    "ODT Reference Field Type":=FieldTicketJobMapping."Reference Field Type";
                    "ODT Reference Field No.":=FieldTicketJobMapping."Reference Field No.";
                    "Field Ticket Date":=FieldTicketJobMapping."Field Ticket Date";
                    //"Sales Order No." := FieldTicketJobMapping."Rental Order No.";               //<NE02.01/>
                    // "Dispatch ID" := FieldTicketJobMapping."Dispatch ID"; //NB03.75
                    MODIFY;
                  end;
                end;
              until JJLine.NEXT = 0;
            end;
          end;
        end;
      //<NB04.10 2019-05-02 end insert>
      end;
      trigger OnValidate();
      var JobTaskLine: Record "Job Task";
      JobSetup: Record "Jobs Setup";
      FieldTicketJobMapping: Record "ODT Field Ticket Job Mapping";
      JobMapping: Page "ODT Field Ticket Job Mapping";
      OriginalResourceNo: Code[20];
      DispatchSetup: Record "Jobs Setup";
      begin
        //NE01.00
        if "ODT Field Ticket No." <> '' then begin
          FieldTicketJobMapping.RESET;
          if FieldTicketJobMapping.GET("ODT Field Ticket No.")then begin
            if FieldTicketJobMapping."Job No." <> '' then begin
              if "Line Type" = "Line Type"::" " then VALIDATE("Line Type", "Line Type"::"Both Budget and Billable");
              // if "Job No." <> FieldTicketJobMapping."Job No." then
              //     VALIDATE("Job No.", FieldTicketJobMapping."Job No.");
              // if "Job Task No." <> "ODT Field Ticket No." then
              //     VALIDATE("Job Task No.", "ODT Field Ticket No.");
              "SUR LSD Format":=FieldTicketJobMapping."SUR LSD Format";
              "DH LSD Format":=FieldTicketJobMapping."DH LSD Format";
              "From DH LSD":=FieldTicketJobMapping."From DH LSD";
              "To DH LSD":=FieldTicketJobMapping."To DH LSD";
              "From SUR LSD":=FieldTicketJobMapping."From SUR LSD";
              "To SUR LSD":=FieldTicketJobMapping."To SUR LSD";
              "Rig No.":=FieldTicketJobMapping."Rig No.";
              "AFE #":=FieldTicketJobMapping."AFE No.";
              "ODT Reference Field Type":=FieldTicketJobMapping."Reference Field Type";
              "ODT Reference Field No.":=FieldTicketJobMapping."Reference Field No.";
              "Field Ticket Date":=FieldTicketJobMapping."Field Ticket Date";
              // "Dispatch ID" := FieldTicketJobMapping."Dispatch ID"; //NB03.75
              VALIDATE("Posting Date", FieldTicketJobMapping."Field Ticket Date");
              exit;
            end;
          end
          else
          begin
            FieldTicketJobMapping.INIT;
            FieldTicketJobMapping."Field Ticket No.":="ODT Field Ticket No.";
            DispatchSetup.GET;
            // FieldTicketJobMapping."SUR LSD Format" := DispatchSetup."Default SUR LSD Format";
            // FieldTicketJobMapping."DH LSD Format" := DispatchSetup."Default DH LSD Format";
            FieldTicketJobMapping.INSERT(true);
          end;
          COMMIT;
          CLEAR(JobMapping);
          JobMapping.SETRECORD(FieldTicketJobMapping);
          JobMapping.RUNMODAL;
          COMMIT;
          FieldTicketJobMapping.GET("ODT Field Ticket No.");
          if FieldTicketJobMapping."Job No." = '' then begin
            FieldTicketJobMapping.DELETE;
            "ODT Field Ticket No.":='';
            exit;
          end
          else
          begin
            JobTaskLine.RESET;
            // if not JobTaskLine.GET(FieldTicketJobMapping."Job No.", "ODT Field Ticket No.") then begin
            //     JobTaskLine.RESET;
            //JobTaskLine.VALIDATE("Job No.", FieldTicketJobMapping."Job No.");
            //JobTaskLine.VALIDATE("Job Task No.", "ODT Field Ticket No.");
            // JobTaskLine."Sales Order No.":=FieldTicketJobMapping."Rental Order No.";   //<NE02.01/>
            // JobTaskLine."Dispatch ID" := FieldTicketJobMapping."Dispatch ID"; //NB03.75
            //JobTaskLine.INSERT(true);
            //end;
            if "Line Type" = "Line Type"::" " then VALIDATE("Line Type", "Line Type"::"Both Budget and Billable");
            //if "Job No." <> FieldTicketJobMapping."Job No." then
            //    VALIDATE("Job No.", FieldTicketJobMapping."Job No.");
            //if "Job Task No." <> "ODT Field Ticket No." then
            //    VALIDATE("Job Task No.", "ODT Field Ticket No.");
            "SUR LSD Format":=FieldTicketJobMapping."SUR LSD Format";
            "DH LSD Format":=FieldTicketJobMapping."DH LSD Format";
            "From DH LSD":=FieldTicketJobMapping."From DH LSD";
            "To DH LSD":=FieldTicketJobMapping."To DH LSD";
            "From SUR LSD":=FieldTicketJobMapping."From SUR LSD";
            "To SUR LSD":=FieldTicketJobMapping."To SUR LSD";
            "Rig No.":=FieldTicketJobMapping."Rig No.";
            "AFE #":=FieldTicketJobMapping."AFE No.";
            "ODT Reference Field Type":=FieldTicketJobMapping."Reference Field Type";
            "ODT Reference Field No.":=FieldTicketJobMapping."Reference Field No.";
            "Field Ticket Date":=FieldTicketJobMapping."Field Ticket Date";
            //"Sales Order No." := FieldTicketJobMapping."Rental Order No.";        //<NE02.01/>
            VALIDATE("Posting Date", FieldTicketJobMapping."Field Ticket Date");
          //  "Dispatch ID" := FieldTicketJobMapping."Dispatch ID"; //NB03.75
          end;
        end;
      end;
    }
    field(50001;"SUR LSD Format";Code[20])
    {
      TableRelation = "ODT LSD Format";

      trigger OnValidate();
      begin
        VALIDATE("To SUR LSD");
        VALIDATE("From SUR LSD");
      end;
    }
    field(50002;"From SUR LSD";Code[50])
    {
      trigger OnValidate();
      begin
        //TESTFIELD("From LSD Format");
        if "From SUR LSD" <> '' then LsdFormats.ValidateFormat("SUR LSD Format", "From SUR LSD");
      end;
    }
    field(50003;"To SUR LSD";Code[50])
    {
      trigger OnValidate();
      begin
        //TESTFIELD("To LSD Format");
        if "To SUR LSD" <> '' then LsdFormats.ValidateFormat("SUR LSD Format", "To SUR LSD");
      end;
    }
    field(50004;"DH LSD Format";Code[20])
    {
      TableRelation = "ODT LSD Format";

      trigger OnValidate();
      begin
        VALIDATE("To DH LSD");
        VALIDATE("From DH LSD");
      end;
    }
    field(50005;"From DH LSD";Code[50])
    {
      trigger OnValidate();
      begin
        //TESTFIELD("From LSD Format");
        if "From DH LSD" <> '' then LsdFormats.ValidateFormat("DH LSD Format", "From DH LSD");
      end;
    }
    field(50006;"To DH LSD";Code[50])
    {
      trigger OnValidate();
      begin
        //TESTFIELD("To LSD Format");
        if "To DH LSD" <> '' then LsdFormats.ValidateFormat("DH LSD Format", "To DH LSD");
      end;
    }
    field(50007;"Rig No.";Text[30])
    {
    }
    field(50008;"AFE #";Code[30])
    {
      Editable = false;
    }
    field(50009;"Field Ticket Date";Date)
    {
      trigger OnValidate();
      var FieldTicketJobMapping: Record "ODT Field Ticket Job Mapping";
      StartDate: Date;
      EndDate: Date;
      TextDateError: Label 'Field Ticket Date must be within the same month of Field Ticket Date %1 in the card setup.';
      begin
        VALIDATE("Posting Date"); //NB03.57 2017-04-13
        //<NB03.57 2017-04-13 start insert>
        if(FieldTicketJobMapping.GET("ODT Field Ticket No.")) and (FieldTicketJobMapping."Field Ticket Date" <> 0D)then begin
          StartDate:=CALCDATE('CM+1D-1M', "Field Ticket Date");
          EndDate:=CALCDATE('CM', "Field Ticket Date");
          if(FieldTicketJobMapping."Field Ticket Date" < StartDate) or (FieldTicketJobMapping."Field Ticket Date" > EndDate)then ERROR(TextDateError, FieldTicketJobMapping."Field Ticket Date");
        end;
      //</NB03.57 2017-04-13 end insert>
      end;
    }
    field(50010;"Rental Start Date - Invoice";Date)
    {
    }
    field(50011;"Rental End Date - Invoice";Date)
    {
    }
    // // field(50012;"Allocation Line Count";Integer)
    // // {
    // //     CalcFormula = Count(Table50000 WHERE (Field10=CONST(1),
    // //                                           Field20=FIELD("Journal Template Name"),
    // //                                           Field30=FIELD("Journal Batch Name"),
    // //                                           Field40=FIELD("Line No.")));
    // //     Editable = false;
    // //     FieldClass = FlowField;
    // // }
    // field(50015;"Rental Terms";Code[20])
    // {
    //     CaptionML = ENU='Rental Terms',
    //                 ENC='Rental Terms';
    //     Description = 'NB02.05';
    //     TableRelation = Table23001301.Field10;
    //     trigger OnValidate();
    //     begin
    //         //NB02.05+
    //         TESTFIELD(Type,Type::"Fixed Asset");
    //         VALIDATE("Unit Price",CalcFAUnitPrice("No.","Rental Terms","Posting Date",Rec));
    //         //NB02.05-
    //         VALIDATE("Unit of Measure Code","Rental Terms");   //ODTJR
    //     end;
    // }
    field(50020;"ODT Reference Field Type";Option)
    {
      OptionMembers = " ", "Cost Code", "Attn:", "PO#";
    }
    field(50021;"ODT Reference Field No.";Text[50])
    {
    }
    field(50030;"ODT Sales Order No.";Code[20])
    {
      Description = 'NE02.01';
    }
    // field(50031;"Allocated Amount";Decimal)
    // {
    //     CalcFormula = Sum(Table50000.Field80 WHERE (Field10=CONST(1),
    //                                                 Field20=FIELD("Journal Template Name"),
    //                                                 Field40=FIELD("Line No."),
    //                                                 Field30=FIELD("Journal Batch Name")));
    //     Description = 'NB02.10';
    //     FieldClass = FlowField;
    // }
    // field(50032;"Service Code";Code[30])
    // {
    //     Description = 'NB05.38';
    //     TableRelation = Table50035.Field2 WHERE (Field1=FIELD("Bill-to Customer No."));
    //     trigger OnValidate();
    //     var
    //         ServCode : Record Table50035;
    //     begin
    //         if ServCode.GET("Bill-to Customer No.","Service Code")then
    //           VALIDATE(Description,ServCode.Description);
    //           VALIDATE("Unit Price (LCY)",ServCode.Price);
    //     end;
    // }
    field(50032;"ODT Employee No.";Code[20])
    {
      Caption = 'Employee No.';
      DataClassification = ToBeClassified;
      TableRelation = Resource where(Type=const(Person), Blocked=Const(FALSE));

      trigger OnValidate()begin
        DefDim.RESET;
        DefDim.SETRANGE("Table ID", 156);
        DefDim.SETRANGE("No.", "ODT Employee No.");
        DefDim.SETRANGE("Dimension Code", 'REGION'); //quick dev before training
        IF DefDim.FINDFirst then VALIDATE("Shortcut Dimension 1 Code", DefDim."Dimension Value Code");
      end;
    }
    field(50033;"ODT Bill-to Customer No.";Code[20])
    {
      Description = 'NB05.38';
      Editable = false;
    }
    field(50034;"ODT Cost Center";Code[20])
    {
      Description = 'NB03.58';
    }
    field(50035;"ODT Field Ticket Line No.";Integer)
    {
      Caption = 'Field Ticket Line No.';
      Description = 'NB03.58';
    }
  }
  var LsdFormats: Record "ODT LSD Format";
  DefDim: Record "Default Dimension";
}
