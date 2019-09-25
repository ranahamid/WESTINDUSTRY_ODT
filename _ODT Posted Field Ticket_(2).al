report 50001 "ODT Posted Field Ticket"
{
  // version NB04.10
  Caption = 'Field Ticket';
  // NB04.10 2019-05-01 ODTTM new report
  DefaultLayout = RDLC;
  RDLCLayout = './Src/REP50001_PostedFieldTicketLayout3.rdl';

  dataset
  {
  dataitem("Posted Field Ticket";
  "ODT Posted Field Ticket")
  {
  dataitem("ODT Posted Field Ticket Lines";
  "ODT Posted Field Ticket Lines")
  {
  DataItemLink = "Field Ticket No."=FIELD("Field Ticket No.");
  DataItemTableView = SORTING("Field Ticket No.", "Line No.");

  trigger OnAfterGetRecord();
  begin
    TempFieldTicketLine:="ODT Posted Field Ticket Lines";
    TempFieldTicketLine.INSERT;
  end;
  }
  dataitem(PageLoop;
  "Integer")
  {
  DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

  // trigger OnAfterGetRecord();
  // begin
  // end;
  column(CompanyInformationPicture;
  CompanyInformation.Picture)
  {
  }
  column(Header_No;
  "Posted Field Ticket"."Field Ticket No.")
  {
  }
  column(Header_FieldTicketDate;
  "Posted Field Ticket"."Field Ticket Date")
  {
  }
  column(Header_CustomerName;
  "Posted Field Ticket"."Bill To Customer Name")
  {
  }
  column(Header_Contact;
  "Posted Field Ticket"."Bill-to Contact")
  {
  }
  column(Header_AFE;
  Job."ODT AFE")
  {
  }
  column(Header_BusinessUnit;
  Job."ODT Business Unit")
  {
  }
  column(Header_ClientFile;
  Job."ODT Client File")
  {
  }
  column(Header_Major;
  Job."ODT Major")
  {
  }
  column(Header_Minor;
  Job."ODT Minor")
  {
  }
  column(Header_PM;
  User."Full Name")
  {
  }
  column(Header_CC;
  Job."ODT Cost Centre")
  {
  }
  column(Header_GL;
  Job."ODT GL")
  {
  }
  column(Header_MSA;
  Job."ODT MSA")
  {
  }
  column(Header_MSO;
  Job."ODT MSO")
  {
  }
  column(Header_PO;
  Job."ODT Purchase Order")
  {
  }
  column(Header_ServOrd;
  Job."ODT Service Order")
  {
  }
  column(Header_SummaryDesc;
  "Posted Field Ticket"."Description of Work")
  {
  }
  column(Header_JobNo;
  "Posted Field Ticket"."Job No.")
  {
  }
  column(Header_FieldRep;
  Job."ODT Field Rep")
  {
  }
  column(Header_JobDesc;
  "Posted Field Ticket"."Job Description")
  {
  }
  column(Header_Desc1;
  "Posted Field Ticket".Description)
  {
  }
  column(Header_Desc2;
  "Posted Field Ticket"."Description 2")
  {
  }
  column(Header_Desc3;
  "Posted Field Ticket"."Description 3")
  {
  }
  column(Header_Desc4;
  "Posted Field Ticket"."Description 4")
  {
  }
  column(Header_Desc5;
  "Posted Field Ticket"."Description 5")
  {
  }
  column(Header_Desc6;
  "Posted Field Ticket"."Description 6")
  {
  }
  column(Header_Desc7;
  "Posted Field Ticket"."Description 7")
  {
  }
  column(Header_Desc8;
  "Posted Field Ticket"."Description 8")
  {
  }
  column(Header_Crew1;
  "Posted Field Ticket"."Crem Member 1")
  {
  }
  column(Header_Crew2;
  "Posted Field Ticket"."Crem Member 2")
  {
  }
  column(Header_Crew3;
  "Posted Field Ticket"."Crem Member 3")
  {
  }
  column(TruckNo;
  TruckNo)
  {
  }
  column(TrailerNo;
  TrailerNo)
  {
  }
  column(Header_NoCaption;
  "Posted Field Ticket".FIELDCAPTION("Field Ticket No.") + ': ')
  {
  }
  column(Header_FieldTicketDateCaption;
  "Posted Field Ticket".FIELDCAPTION("Service Date") + ': ')
  {
  }
  column(Header_CustomerNameCaption;
  "Posted Field Ticket".FIELDCAPTION("Bill To Customer Name") + ': ')
  {
  }
  column(Header_ContactCaption;
  "Posted Field Ticket".FIELDCAPTION("Bill-to Contact") + ': ')
  {
  }
  column(Header_TruckCaption;
  TruckCaption)
  {
  }
  column(Header_TrailerCaption;
  TrailerCaption)
  {
  }
  column(Header_MonitorCaption;
  MonitorCaption)
  {
  }
  column(Header_SwamperCaption;
  SwamperCaption)
  {
  }
  column(Header_OperatorCaption;
  OperatorCaption)
  {
  }
  column(Header_DirectionsCaption;
  DirectionsCaption)
  {
  }
  column(ShowPrice;
  IncludePrice)
  {
  }
  column(CustomerAddress1;
  CustomerAddress[1])
  {
  }
  column(CustomerAddress2;
  CustomerAddress[2])
  {
  }
  column(CustomerAddress3;
  CustomerAddress[3])
  {
  }
  column(CustomerAddress4;
  CustomerAddress[4])
  {
  }
  column(CustomerAddress5;
  CustomerAddress[5])
  {
  }
  column(CustomerAddress6;
  CustomerAddress[6])
  {
  }
  column(RateCaption;
  RateCaption)
  {
  }
  column(AmountCaption;
  AmountCaption)
  {
  }
  column(JobHeader1;
  JobHeader[1])
  {
  }
  column(JobHeader2;
  JobHeader[2])
  {
  }
  column(JobHeader3;
  JobHeader[3])
  {
  }
  column(JobHeader4;
  JobHeader[4])
  {
  }
  column(JobHeader5;
  JobHeader[5])
  {
  }
  column(JobHeader6;
  JobHeader[6])
  {
  }
  column(JobHeader7;
  JobHeader[7])
  {
  }
  column(JobHeader8;
  JobHeader[8])
  {
  }
  column(JobHeader9;
  JobHeader[9])
  {
  }
  column(JobHeader10;
  JobHeader[10])
  {
  }
  column(JobHeader11;
  JobHeader[11])
  {
  }
  column(JobHeader12;
  JobHeader[12])
  {
  }
  column(JobHeaderLabels1;
  JobHeaderLabels[1])
  {
  }
  column(JobHeaderLabels2;
  JobHeaderLabels[2])
  {
  }
  column(JobHeaderLabels3;
  JobHeaderLabels[3])
  {
  }
  column(JobHeaderLabels4;
  JobHeaderLabels[4])
  {
  }
  column(JobHeaderLabels5;
  JobHeaderLabels[5])
  {
  }
  column(JobHeaderLabels6;
  JobHeaderLabels[6])
  {
  }
  column(JobHeaderLabels7;
  JobHeaderLabels[7])
  {
  }
  column(JobHeaderLabels8;
  JobHeaderLabels[8])
  {
  }
  column(JobHeaderLabels9;
  JobHeaderLabels[9])
  {
  }
  column(JobHeaderLabels10;
  JobHeaderLabels[10])
  {
  }
  column(JobHeaderLabels11;
  JobHeaderLabels[11])
  {
  }
  column(JobHeaderLabels12;
  JobHeaderLabels[12])
  {
  }
  dataitem(FieldTicketLine;
  "Integer")
  {
  DataItemTableView = SORTING(Number);

  column(Line_UnitType;
  TempFieldTicketLine.Type)
  {
  }
  column(Line_UnitID;
  TempFieldTicketLine."No.")
  {
  }
  column(Line_Quantity;
  TempFieldTicketLine.Quantity)
  {
  }
  column(Line_UnitPrice;
  TempFieldTicketLine."Unit Price")
  {
  }
  column(Line_Amount;
  TempFieldTicketLine."Line Amount")
  {
  }
  column(Line_Description;
  TempFieldTicketLine.Description)
  {
  }
  column(SubTotalAmt;
  SubTotalAmt)
  {
  }
  column(TotalDiscAmt;
  TotalDiscAmt)
  {
  }
  column(GrandTotal;
  GrandTotal)
  {
  }
  column(Line_UnitTypeCaption;
  TempFieldTicketLine.FIELDCAPTION(Type))
  {
  }
  column(Line_UnitIDCaption;
  TempFieldTicketLine.FIELDCAPTION("No."))
  {
  }
  column(Line_QuantityCaption;
  TempFieldTicketLine.FIELDCAPTION(Quantity))
  {
  }
  column(Line_UnitPriceCaption;
  TempFieldTicketLine.FIELDCAPTION("Unit Price"))
  {
  }
  column(Line_TimeReturnedCaption;
  TempFieldTicketLine.FIELDCAPTION("Total Price (LCY)"))
  {
  }
  column(Line_DescriptionCaption;
  TempFieldTicketLine.FIELDCAPTION(Description))
  {
  }
  trigger OnAfterGetRecord();
  begin
    OnLineNumber:=OnLineNumber + 1;
    with TempFieldTicketLine do begin
      if OnLineNumber = 1 then FIND('-')
      else
        NEXT;
      IF NOT IncludePrice THEN BEGIN
        TempFieldTicketLine."Line Amount":=0;
        TempFieldTicketLine."Line Discount Amount":=0;
        TempFieldTicketLine."Unit Price":=0;
      END
      ELSE
      BEGIN
        SubTotalAmt+=TempFieldTicketLine."Line Amount" + TempFieldTicketLine."Line Discount Amount";
        TotalDiscAmt+=TempFieldTicketLine."Line Discount Amount";
        GrandTotal+=TempFieldTicketLine."Line Amount";
      END;
      CASE TempFieldTicketLine.Type of TempFieldTicketLine.TYPE::"G/L Account": BEGIN
        IF NOT GLAcct.GET(TempFieldTicketLine."No.")THEN CLEAR(GLAcct);
        TempFieldTicketLine.Description:=GLAcct.Name;
      END;
      TempFieldTicketLine.TYPE::Item: BEGIN
        IF NOT Item.GET(TempFieldTicketLine."No.")then CLEAR(Item);
        TempFieldTicketLine.Description:=Item.Description;
      END;
      TempFieldTicketLine.TYPE::Resource: BEGIN
        IF NOT Resource.GET(TempFieldTicketLine."No.")then CLEAR(Resource);
        TempFieldTicketLine.Description:=Resource.Name;
      END;
      END;
    end;
  end;
  trigger OnPreDataItem();
  begin
    NumberofLines:=TempFieldTicketLine.COUNT;
    SETRANGE(Number, 1, NumberofLines);
    OnLineNumber:=0;
    SubTotalAmt:=0;
    TotalDiscAmt:=0;
    GrandTotal:=0;
  end;
  }
  }
  trigger OnAfterGetRecord();
  begin
    //CALCFIELDS("Contact Phone No.","Contact E-mail");
    IF NOT Job.GET("Job No.")then CLEAR(Job)
    ELSE
      FtMgt.JobInfo(JobHeader, JobHeaderLabels, Job);
    TempFieldTicketLine.DELETEALL; //<NB03.88/>
    User.RESET;
    User.SETRANGE("User Name", "Project Manager");
    IF(NOT User.FINDFIRST) OR (User."Full Name" = '')THEN User."Full Name":="Project Manager";
    "Posted Field Ticket".CALCFIELDS("Bill To Customer Name");
    //  User."Full Name" := "Project Manager";
    if Cust.GET("Bill-to Customer No.")then FormatAddress.Customer(CustomerAddress, Cust);
    IF IncludePrice THEN BEGIN
      RateCaption:='Rate';
      AmountCaption:='Amount';
    END
    ELSE
    begin
      RateCaption:='';
      AmountCaption:='';
    END;
  end;
  }
  }
  requestpage
  {
  SaveValues = true;

  layout
  {
    area(content)
    {
      group(Options)
      {
        Caption = 'Option';

        field(IncludePrice;IncludePrice)
        {
          ApplicationArea = All;
          Caption = 'Include Price';
        }
      }
    }
  }
  actions
  {
  }
  }
  labels
  {
  }
  trigger OnPreReport();
  begin
    CompanyInformation.GET;
    CompanyInformation.CALCFIELDS(Picture);
  end;
  var TruckCaption: Label '"Truck No.: "';
  TrailerCaption: Label '"Trailer No.: "';
  MonitorCaption: Label '"Monitors: "';
  SwamperCaption: Label '"Swamper: "';
  OperatorCaption: Label '"Operator: "';
  DirectionsCaption: Label '"Directions: "';
  CompanyInformation: Record "Company Information";
  TempFieldTicketLine: Record "ODT Posted Field Ticket Lines" temporary;
  TruckNo: Text[30];
  TrailerNo: Text[30];
  Monitors: Text[30];
  Swamper: Text[30];
  Operator: Text[30];
  OnLineNumber: Integer;
  NumberofLines: Integer;
  "***NB03.90***": Integer;
  IncludePrice: Boolean;
  loadDirection: Text;
  deliveryDirection: Text;
  Cust: Record Customer;
  CustomerAddress: array[8]of Text[50];
  FormatAddress: Codeunit "Format Address";
  JobJnlLine: Record "Job Journal Line";
  FTLine: Record "ODT Posted Field Ticket Lines";
  FTHeader: Record "ODT Posted Field Ticket";
  JobJnlBatch: Record "Job Journal Batch";
  JobJnlTemplate: Record "Job Journal Template";
  TimeSheetHeader: Record "Time Sheet Header";
  TimeSheetLine: Record "Time Sheet Line";
  TempTimeSheetLine: Record "Time Sheet Line" temporary;
  TimeSheetDetail: Record "Time Sheet Detail";
  ResourceNoFilter: Code[1024];
  JobNoFilter: Code[1024];
  JobTaskNoFilter: Code[1024];
  StartingDate: Date;
  EndingDate: Date;
  DateFilter: Text[30];
  Job: Record Job;
  JobTask: Record "Job Task";
  WorkTypes: Record "Work Type";
  User: Record User;
  ConvertResToItem: Boolean;
  Res: Record Resource;
  SubTotalAmt: decimal;
  TotalDiscAmt: decimal;
  GrandTotal: decimal;
  FullUserName: Text[100];
  RateCaption: Text[20];
  AmountCaption: Text[20];
  FTMgt: Codeunit "ODT Field Ticket Management";
  JobHeader: array[12]of Text[50];
  JobHeaderLabels: array[12]of Text[50];
  GLAcct: record "G/L Account";
  Resource: record Resource;
  Item: record Item;
}
