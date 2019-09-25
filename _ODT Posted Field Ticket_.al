table 50005 "ODT Posted Field Ticket"
{
  fields
  {
    field(10;"Field Ticket No.";Code[20])
    {
    }
    field(20;"Job No.";Code[20])
    {
      TableRelation = Job."No." WHERE("Bill-to Customer No."=FIELD("Bill-to Customer No."));

      trigger OnValidate();
      var Job: Record Job;
      JobJnl: Record "Job Journal Line";
      TEXT001: Label 'You cannot change the Job No. when there are Job Journal Lines created for the Field Ticket.';
      begin
      end;
    }
    field(21;"Job Task No.";Code[50])
    {
      Caption = 'Job Task No.';
      DataClassification = ToBeClassified;
      TableRelation = "Job Task"."Job Task No." where("Job No."=field("Job No."));
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
      end;
    }
    field(30;"SUR LSD Format";Code[10])
    {
      Description = 'NB03.27';
      TableRelation = "ODT LSD Format";

      trigger OnValidate();
      var Job: Record Job;
      begin
      end;
    }
    field(40;"From SUR LSD";Code[50])
    {
      Caption = 'Load Location';
      Description = 'Load Location';
      TableRelation = "ODT LSD"."LSD Code";
    }
    field(50;"To SUR LSD";Code[50])
    {
      Caption = 'Surface Location';
      Description = 'Surface Location';
      TableRelation = "ODT LSD"."LSD Code" WHERE(Type=CONST(Surface));

      trigger OnValidate();
      var LSD: Record "ODT LSD";
      begin
      end;
    }
    field(60;"DH LSD Format";Code[10])
    {
      Description = 'NB03.27';
      TableRelation = "ODT LSD Format";
    }
    field(70;"From DH LSD";Code[50])
    {
      Caption = 'Delivery Location';
      Description = 'Delivery Location';
      TableRelation = "ODT LSD"."LSD Code";
    }
    field(80;"To DH LSD";Code[50])
    {
      Caption = 'Downhole Location';
      Description = 'Downhole Location';
      TableRelation = "ODT LSD"."LSD Code" WHERE(Type=CONST(Downhole), "Surface LSD"=FIELD("To SUR LSD"));

      trigger OnValidate();
      var LSD: Record "ODT LSD";
      begin
      end;
    }
    field(90;"Rig No.";Text[30])
    {
    }
    field(100;"AFE No.";Code[30])
    {
    }
    field(110;"Field Ticket Date";Date)
    {
    }
    field(120;"Reference Field Type";Option)
    {
      OptionMembers = " ", "Cost Code", "Attn:", "PO#";
    }
    field(130;"Reference Field No.";Text[50])
    {
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
    //TableRelation = Table50033.Field2 WHERE (Field1=FIELD("Bill-to Customer No."));
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
      end;
    }
    field(50055;"Company Code";Code[20])
    {
      Description = 'NB03.58';
    //TableRelation = Table50034.Field2 WHERE (Field1=FIELD("Bill-to Customer No."));
    }
    field(50056;"Bill-to Contact";Text[50])
    {
      Caption = 'Contact';
      Description = 'NB03.58';
    }
    // field(50057;"Dispatch ID";Code[20])
    // {
    //     Description = 'NB03.75';
    //     TableRelation = Table50300.Field1;
    //     trigger OnValidate();
    //     var
    //         JobJnl : Record "Job Journal Line";
    //         JobTask : Record "Job Task";
    //         Dispatch : Record Table50300;
    //         UpdateDispatch : Boolean;
    //         ChangeDispatch : Label 'Changing Dispatch ID will update the LSD fields. Continue?';
    //         DispatchCard : Page Page50300;
    //         DispatchData : Record Table50300;
    //         TEXT001 : Label 'Dispatch cannot be found.';
    //         FTJM : Record "Field Ticket Job Mapping";
    //     begin
    //     end;
    // }
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
      Caption = 'Description';
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
  var LSDFormats: Record "ODT LSD Format";
  "--NB03.45": Integer;
  Job: Record Job;
  JobSetup: Record "Jobs Setup";
  SH: Record "Sales Header";
  FT: Record "ODT Field Ticket Job Mapping";
  procedure CompanyName(): Text[50];
  var Customer: Record Customer;
  begin
  end;
  local procedure UpdateJob();
  var JobCard: Record Job;
  begin
  end;
  local procedure UpdateOpenDocs();
  begin
  end;
  local procedure UpdateFT();
  begin
  end;
  local procedure UpdateJobJnls(JobNo: Code[20];
  JobTaskNo: Code[20]);
  begin
  end;
  local procedure CheckDispatchCust(DispatchID: Code[20]);
  // var
  //     DispatchData : Record Table50300;
  //     DispatchCard : Page Page50300;
  begin
  end;
// procedure ActionUpdate(ActionString : Text);
// var
//     SalesLine : Record "Sales Line";
//     SalesHeader : Record "Sales Header";
//     CustBillingReq : Record Table50000;
//     MultiInvoiceMgt : Codeunit Codeunit50001;
// begin
// end;
}
