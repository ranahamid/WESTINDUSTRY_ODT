report 50003 "ODT Sales Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Src/REP50003_SalesInvoice3.rdl';
    Caption = 'Sales - Invoice';

    dataset
    {
        dataitem("Sales Invoice Header";
        "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            column(No_SalesInvHeader;
            "No.")
            {
            }
            dataitem("Sales Invoice Line";
            "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                dataitem(SalesLineComments;
                "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Invoice"), "Print On Invoice" = CONST(true));

                    trigger OnAfterGetRecord();
                    begin
                        with TempSalesInvoiceLine do begin
                            INIT;
                            "Document No." := "Sales Invoice Header"."No.";
                            "Line No." := HighestLineNo + 10;
                            HighestLineNo := "Line No.";
                        end;
                        if STRLEN(Comment) <= MAXSTRLEN(TempSalesInvoiceLine.Description) then begin
                            TempSalesInvoiceLine.Description := Comment;
                            TempSalesInvoiceLine."Description 2" := '';
                        end
                        else begin
                            SpacePointer := MAXSTRLEN(TempSalesInvoiceLine.Description) + 1;
                            while (SpacePointer > 1) and (Comment[SpacePointer] <> ' ') do SpacePointer := SpacePointer - 1;
                            if SpacePointer = 1 then SpacePointer := MAXSTRLEN(TempSalesInvoiceLine.Description) + 1;
                            TempSalesInvoiceLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                            TempSalesInvoiceLine."Description 2" := COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesInvoiceLine."Description 2"));
                        end;
                        TempSalesInvoiceLine.INSERT;
                    end;
                }
                trigger OnAfterGetRecord();
                begin
                    TempSalesInvoiceLine := "Sales Invoice Line";
                    TempSalesInvoiceLine.INSERT;
                    TempSalesInvoiceLineAsm := "Sales Invoice Line";
                    TempSalesInvoiceLineAsm.INSERT;
                    IF (TempSalesInvoiceLine."Job No." <> '') AND ("Sales Invoice Header"."ODT Job No." = '') then "Sales Invoice Header"."ODT Job No." := TempSalesInvoiceLine."Job No.";
                    HighestLineNo := "Line No.";
                end;

                trigger OnPreDataItem();
                begin
                    TempSalesInvoiceLine.RESET;
                    TempSalesInvoiceLine.DELETEALL;
                    TempSalesInvoiceLineAsm.RESET;
                    TempSalesInvoiceLineAsm.DELETEALL;
                end;
            }
            dataitem("Sales Comment Line";
            "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Invoice"), "Print On Invoice" = CONST(true), "Document Line No." = CONST(0));

                column(DisplayAdditionalFeeNote;
                DisplayAdditionalFeeNote)
                {
                }
                trigger OnAfterGetRecord();
                begin
                    with TempSalesInvoiceLine do begin
                        INIT;
                        "Document No." := "Sales Invoice Header"."No.";
                        "Line No." := HighestLineNo + 1000;
                        HighestLineNo := "Line No.";
                    end;
                    if STRLEN(Comment) <= MAXSTRLEN(TempSalesInvoiceLine.Description) then begin
                        TempSalesInvoiceLine.Description := Comment;
                        TempSalesInvoiceLine."Description 2" := '';
                    end
                    else begin
                        SpacePointer := MAXSTRLEN(TempSalesInvoiceLine.Description) + 1;
                        while (SpacePointer > 1) and (Comment[SpacePointer] <> ' ') do SpacePointer := SpacePointer - 1;
                        if SpacePointer = 1 then SpacePointer := MAXSTRLEN(TempSalesInvoiceLine.Description) + 1;
                        TempSalesInvoiceLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                        TempSalesInvoiceLine."Description 2" := COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesInvoiceLine."Description 2"));
                    end;
                    TempSalesInvoiceLine.INSERT;
                end;

                trigger OnPreDataItem();
                begin
                    with TempSalesInvoiceLine do begin
                        INIT;
                        "Document No." := "Sales Invoice Header"."No.";
                        "Line No." := HighestLineNo + 1000;
                        HighestLineNo := "Line No.";
                    end;
                    TempSalesInvoiceLine.INSERT;
                end;
            }
            dataitem(CopyLoop;
            "Integer")
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop;
                "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    column(CompanyInfo2Picture;
                    CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture;
                    CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInformationPicture;
                    CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyAddress1;
                    CompanyAddress[1])
                    {
                    }
                    column(CompanyAddress2;
                    CompanyAddress[2])
                    {
                    }
                    column(CompanyAddress3;
                    CompanyAddress[3])
                    {
                    }
                    column(CompanyAddress4;
                    CompanyAddress[4])
                    {
                    }
                    column(CompanyAddress5;
                    CompanyAddress[5])
                    {
                    }
                    column(CompanyAddress6;
                    CompanyAddress[6])
                    {
                    }
                    column(CopyTxt;
                    CopyTxt)
                    {
                    }
                    column(BillToAddress1;
                    BillToAddress[1])
                    {
                    }
                    column(BillToAddress2;
                    BillToAddress[2])
                    {
                    }
                    column(BillToAddress3;
                    BillToAddress[3])
                    {
                    }
                    column(BillToAddress4;
                    BillToAddress[4])
                    {
                    }
                    column(BillToAddress5;
                    BillToAddress[5])
                    {
                    }
                    column(BillToAddress6;
                    BillToAddress[6])
                    {
                    }
                    column(BillToAddress7;
                    BillToAddress[7])
                    {
                    }
                    column(ShipmentMethodDescription;
                    ShipmentMethod.Description)
                    {
                    }
                    column(ShptDate_SalesInvHeader;
                    "Sales Invoice Header"."Shipment Date")
                    {
                    }
                    column(DueDate_SalesInvHeader;
                    "Sales Invoice Header"."Due Date")
                    {
                    }
                    column(PaymentTermsDescription;
                    PaymentTerms.Description)
                    {
                    }
                    column(ShipToAddress1;
                    ShipToAddress[1])
                    {
                    }
                    column(ShipToAddress2;
                    ShipToAddress[2])
                    {
                    }
                    column(ShipToAddress3;
                    ShipToAddress[3])
                    {
                    }
                    column(ShipToAddress4;
                    ShipToAddress[4])
                    {
                    }
                    column(ShipToAddress5;
                    ShipToAddress[5])
                    {
                    }
                    column(ShipToAddress6;
                    ShipToAddress[6])
                    {
                    }
                    column(ShipToAddress7;
                    ShipToAddress[7])
                    {
                    }
                    column(BilltoCustNo_SalesInvHeader;
                    "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(ExtDocNo_SalesInvHeader;
                    "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(OrderDate_SalesInvHeader;
                    "Sales Invoice Header"."Order Date")
                    {
                    }
                    column(OrderNo_SalesInvHeader;
                    "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(SalesPurchPersonName;
                    SalesPurchPerson.Name)
                    {
                    }
                    column(DocumentDate_SalesInvHeader;
                    "Sales Invoice Header"."Document Date")
                    {
                    }
                    column(CompanyAddress7;
                    CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress8;
                    CompanyAddress[8])
                    {
                    }
                    column(BillToAddress8;
                    BillToAddress[8])
                    {
                    }
                    column(ShipToAddress8;
                    ShipToAddress[8])
                    {
                    }
                    column(TaxRegNo;
                    TaxRegNo)
                    {
                    }
                    column(TaxRegLabel;
                    TaxRegLabel)
                    {
                    }
                    column(DocumentText;
                    DocumentText)
                    {
                    }
                    column(CopyNo;
                    CopyNo)
                    {
                    }
                    column(CustTaxIdentificationType;
                    FORMAT(Cust."Tax Identification Type"))
                    {
                    }
                    column(BillCaption;
                    BillCaptionLbl)
                    {
                    }
                    column(ToCaption;
                    ToCaptionLbl)
                    {
                    }
                    column(ShipViaCaption;
                    ShipViaCaptionLbl)
                    {
                    }
                    column(ShipDateCaption;
                    ShipDateCaptionLbl)
                    {
                    }
                    column(DueDateCaption;
                    DueDateCaptionLbl)
                    {
                    }
                    column(TermsCaption;
                    TermsCaptionLbl)
                    {
                    }
                    column(CustomerIDCaption;
                    CustomerIDCaptionLbl)
                    {
                    }
                    column(PONumberCaption;
                    PONumberCaptionLbl)
                    {
                    }
                    column(PODateCaption;
                    PODateCaptionLbl)
                    {
                    }
                    column(OurOrderNoCaption;
                    OurOrderNoCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption;
                    SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption;
                    ShipCaptionLbl)
                    {
                    }
                    column(InvoiceNumberCaption;
                    InvoiceNumberCaptionLbl)
                    {
                    }
                    column(InvoiceDateCaption;
                    InvoiceDateCaptionLbl)
                    {
                    }
                    column(PageCaption;
                    PageCaptionLbl)
                    {
                    }
                    column(TaxIdentTypeCaption;
                    TaxIdentTypeCaptionLbl)
                    {
                    }
                    column(ShowWorkDescription;
                    ShowWorkDescription)
                    {
                    }
                    column(Header_FieldRep;
                    Job."ODT Field Rep")
                    {
                    }
                    column(Header_JobNo;
                    "Sales Invoice Header"."ODT Job No.")
                    {
                    }
                    column(Header_JobDesc;
                    "Sales Invoice Header"."ODT Job Description")
                    {
                    }
                    column(Header_CustomerName;
                    "Sales Invoice Header"."Bill-to Name")
                    {
                    }
                    column(Header_AFE; "Sales Invoice Header"."ODT AFE")
                    {
                    }
                    column(Header_InvoiceDescription; "Sales Invoice Header"."InvoiceDescription")
                    {
                    }

                    column(Header_JobNumber; "Sales Invoice Header"."JobNumber")
                    {
                    }


                    column(Header_BusinessUnit;
                    "Sales Invoice Header"."ODT Business Unit")
                    {
                    }
                    column(Header_ClientFile;
                    "Sales Invoice Header"."ODT Client File")
                    {
                    }
                    column(Header_Major;
                    "Sales Invoice Header"."ODT Major")
                    {
                    }
                    column(Header_Minor;
                    "Sales Invoice Header"."ODT Minor")
                    {
                    }
                    column(Header_PM;
                    User."Full Name")
                    {
                    }
                    column(Header_CC;
                    "Sales Invoice Header"."ODT Cost Centre")
                    {
                    }
                    column(Header_GL;
                    "Sales Invoice Header"."ODT GL")
                    {
                    }
                    column(Header_MSA;
                    "Sales Invoice Header"."ODT MSA")
                    {
                    }
                    column(Header_MSO;
                    "Sales Invoice Header"."ODT MSO")
                    {
                    }
                    column(Header_PO;
                    "Sales Invoice Header"."ODT Purchase Order")
                    {
                    }
                    column(Header_SO;
                    "Sales Invoice Header"."ODT Service Order")
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

                    column(JobHeader13;
                    JobHeader[13])
                    {
                    }
                    column(JobHeader14;
                    JobHeader[14])
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
                    column(JobHeaderLabels13;
                    JobHeaderLabels[13])
                    {
                    }
                    column(JobHeaderLabels14;
                    JobHeaderLabels[14])
                    {
                    }
                    dataitem(SalesInvLine;
                    "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        column(AmountExclInvDisc;
                        AmountExclInvDisc)
                        {
                        }
                        column(TempSalesInvoiceLineNo;
                        TempSalesInvoiceLine."No.")
                        {
                        }
                        column(TempSalesInvoiceLineUOM;
                        TempSalesInvoiceLine."Unit of Measure")
                        {
                        }
                        column(OrderedQuantity;
                        OrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(TempSalesInvoiceLineQty;
                        TempSalesInvoiceLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(UnitPriceToPrint;
                        UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(LowDescriptionToPrint;
                        LowDescriptionToPrint)
                        {
                        }
                        column(HighDescriptionToPrint;
                        HighDescriptionToPrint)
                        {
                        }
                        column(TempSalesInvoiceLineDocNo;
                        TempSalesInvoiceLine."Document No.")
                        {
                        }
                        column(TempSalesInvoiceLineLineNo;
                        TempSalesInvoiceLine."Line No.")
                        {
                        }
                        column(TaxLiable;
                        TaxLiable)
                        {
                        }
                        column(TempSalesInvoiceLineAmtTaxLiable;
                        TempSalesInvoiceLine.Amount - TaxLiable)
                        {
                        }
                        column(TempSalesInvoiceLineAmtAmtExclInvDisc;
                        TempSalesInvoiceLine.Amount - AmountExclInvDisc)
                        {
                        }
                        column(TempSalesInvoiceLineAmtInclVATAmount;
                        TempSalesInvoiceLine."Amount Including VAT" - TempSalesInvoiceLine.Amount)
                        {
                        }
                        column(TempSalesInvoiceLineAmtInclVAT;
                        TempSalesInvoiceLine."Amount Including VAT")
                        {
                        }
                        column(TotalTaxLabel;
                        TotalTaxLabel)
                        {
                        }
                        column(BreakdownTitle;
                        BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel1;
                        BreakdownLabel[1])
                        {
                        }
                        column(BreakdownAmt1;
                        BreakdownAmt[1])
                        {
                        }
                        column(BreakdownAmt2;
                        BreakdownAmt[2])
                        {
                        }
                        column(BreakdownLabel2;
                        BreakdownLabel[2])
                        {
                        }
                        column(BreakdownAmt3;
                        BreakdownAmt[3])
                        {
                        }
                        column(BreakdownLabel3;
                        BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt4;
                        BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel4;
                        BreakdownLabel[4])
                        {
                        }
                        column(ItemDescriptionCaption;
                        ItemDescriptionCaptionLbl)
                        {
                        }
                        column(UnitCaption;
                        UnitCaptionLbl)
                        {
                        }
                        column(OrderQtyCaption;
                        OrderQtyCaptionLbl)
                        {
                        }
                        column(QuantityCaption;
                        QuantityCaptionLbl)
                        {
                        }
                        column(UnitPriceCaption;
                        UnitPriceCaptionLbl)
                        {
                        }
                        column(TotalPriceCaption;
                        TotalPriceCaptionLbl)
                        {
                        }
                        column(SubtotalCaption;
                        SubtotalCaptionLbl)
                        {
                        }
                        column(InvoiceDiscountCaption;
                        InvoiceDiscountCaptionLbl)
                        {
                        }
                        column(TotalCaption;
                        TotalCaption)
                        {
                        }
                        column(AmountSubjecttoSalesTaxCaption;
                        AmountSubjecttoSalesTaxCaption)
                        {
                        }
                        column(AmountExemptfromSalesTaxCaption;
                        AmountExemptfromSalesTaxCaption)
                        {
                        }
                        dataitem(AsmLoop;
                        "Integer")
                        {
                            DataItemTableView = SORTING(Number);

                            column(TempPostedAsmLineUOMCode;
                            GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                                //DecimalPlaces = 0:5;
                                //DecimalPlaces = '0:5';
                            }
                            column(TempPostedAsmLineQuantity;
                            TempPostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineDesc;
                            BlanksForIndent + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostedAsmLineNo;
                            BlanksForIndent + TempPostedAsmLine."No.")
                            {
                            }
                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then
                                    TempPostedAsmLine.FINDSET
                                else begin
                                    TempPostedAsmLine.NEXT;
                                    TaxLiable := 0;
                                    AmountExclInvDisc := 0;
                                    TempSalesInvoiceLine.Amount := 0;
                                    TempSalesInvoiceLine."Amount Including VAT" := 0;
                                end;
                            end;

                            trigger OnPreDataItem();
                            begin
                                CLEAR(TempPostedAsmLine);
                                SETRANGE(Number, 1, TempPostedAsmLine.COUNT);
                            end;
                        }
                        trigger OnAfterGetRecord();
                        begin
                            OnLineNumber := OnLineNumber + 1;
                            with TempSalesInvoiceLine do begin
                                if OnLineNumber = 1 then
                                    FIND('-')
                                else
                                    NEXT;
                                OrderedQuantity := 0;
                                if "Sales Invoice Header"."Order No." = '' then
                                    OrderedQuantity := Quantity
                                else
                                    if OrderLine.GET(1, "Sales Invoice Header"."Order No.", "Line No.") then
                                        OrderedQuantity := OrderLine.Quantity
                                    else begin
                                        ShipmentLine.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
                                        ShipmentLine.SETRANGE("Order Line No.", "Line No.");
                                        if ShipmentLine.FIND('-') then
                                            repeat
                                                OrderedQuantity := OrderedQuantity + ShipmentLine.Quantity;
                                            until 0 = ShipmentLine.NEXT;
                                    end;
                                DescriptionToPrint := Description + ' ' + "Description 2";
                                if Type = 0 then begin
                                    "No." := '';
                                    "Unit of Measure" := '';
                                    Amount := 0;
                                    "Amount Including VAT" := 0;
                                    "Inv. Discount Amount" := 0;
                                    Quantity := 0;
                                    //end else
                                    //     if Type = Type::"G/L Account" then
                                    //         "No." := '';
                                end
                                else BEGIN
                                    // if Type = Type::"G/L Account" THEN begin
                                    //    GLAcct.GET("No.");
                                    //    DescriptionToPrint := GLAcct.Name; 
                                    // END;
                                    CASE Type of
                                        TYPE::"G/L Account":
                                            BEGIN
                                                IF NOT GLAcct.GET("No.") THEN CLEAR(GLAcct);
                                                DescriptionToPrint := GLAcct.Name;
                                            END;
                                        TYPE::Item:
                                            BEGIN
                                                IF NOT Item.GET("No.") then CLEAR(Item);
                                                DescriptionToPrint := Item.Description;
                                            END;
                                        TYPE::Resource:
                                            BEGIN
                                                IF NOT Resource.GET("No.") then CLEAR(Resource);
                                                DescriptionToPrint := Resource.Name;
                                            END;
                                    END;
                                END;
                                if "No." = '' then begin
                                    HighDescriptionToPrint := DescriptionToPrint;
                                    LowDescriptionToPrint := '';
                                end
                                else begin
                                    HighDescriptionToPrint := '';
                                    LowDescriptionToPrint := DescriptionToPrint;
                                end;
                                if Amount <> "Amount Including VAT" then
                                    TaxLiable := Amount
                                else
                                    TaxLiable := 0;
                                AmountExclInvDisc := Amount + "Inv. Discount Amount";
                                if Quantity = 0 then
                                    UnitPriceToPrint := 0 // so it won't print
                                else
                                    UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity, 0.00001);
                            end;
                            CollectAsmInformation(TempSalesInvoiceLine);
                        end;

                        trigger OnPreDataItem();
                        begin
                            //CurrReport.CREATETOTALS(TaxLiable,AmountExclInvDisc,TempSalesInvoiceLine.Amount,TempSalesInvoiceLine."Amount Including VAT");
                            NumberOfLines := TempSalesInvoiceLine.COUNT;
                            SETRANGE(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                        end;
                    }
                    dataitem(LineFee;
                    "Integer")
                    {
                        DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = FILTER(1 ..));

                        column(LineFeeCaptionLbl;
                        TempLineFeeNoteOnReportHist.ReportText)
                        {
                        }
                        trigger OnAfterGetRecord();
                        begin
                            if not DisplayAdditionalFeeNote then CurrReport.BREAK;
                            if Number = 1 then begin
                                if not TempLineFeeNoteOnReportHist.FINDSET then CurrReport.BREAK
                            end
                            else
                                if TempLineFeeNoteOnReportHist.NEXT = 0 then CurrReport.BREAK;
                        end;
                    }
                    dataitem(WorkDescriptionLines;
                    "Integer")
                    {
                        DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = FILTER(1 .. 99999));

                        column(WorkDescriptionLineNumber;
                        Number)
                        {
                        }
                        column(WorkDescriptionLine;
                        WorkDescriptionLine)
                        {
                        }
                        trigger OnPreDataItem();
                        begin
                            IF NOT ShowWorkDescription THEN CurrReport.BREAK;
                            //RH
                            // TempBlobWorkDescription.Blob := "Sales Invoice Header"."Work Description";//RH
                            // TempBlobWorkDescription.StartReadingTextLines(TEXTENCODING::UTF8);//RH

                            TempBlobWorkDescription.CreateInStream(InStr);
                            Result := InStr.Read("Sales Invoice Header"."Work Description");
                        end;

                        trigger OnAfterGetRecord();
                        begin
                            // IF NOT TempBlobWorkDescription.MoreTextLines THEN CurrReport.BREAK; //RH
                            // WorkDescriptionLine := TempBlobWorkDescription.ReadTextLine;//RH

                            IF NOT InStr.EOS() THEN CurrReport.BREAK;
                            TempBlobWorkDescription.CreateInStream(InStr);
                            Result := InStr.ReadText(WorkDescriptionLine);

                        end;

                        trigger OnPostDataItem()
                        begin
                            CLEAR(TempBlobWorkDescription);
                        end;
                    }
                }
                trigger OnAfterGetRecord();
                begin
                    //CurrReport.PAGENO := 1;
                    if CopyNo = NoLoops then begin
                        if not CurrReport.PREVIEW then SalesInvPrinted.RUN("Sales Invoice Header");
                        CurrReport.BREAK;
                    end;
                    CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        CLEAR(CopyTxt)
                    else
                        CopyTxt := Text000;
                end;

                trigger OnPreDataItem();
                begin
                    NoLoops := 1 + ABS(NoCopies) + Customer."Invoice Copies";
                    if NoLoops <= 0 then NoLoops := 1;
                    CopyNo := 0;
                end;
            }
            trigger OnAfterGetRecord();
            begin
                if PrintCompany then
                    if RespCenter.GET("Responsibility Center") then begin
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    end;
                // CurrReport.LANGUAGE := Language.GetLanguageID("Language Code"); //RH
                CurrReport.LANGUAGE := Lang.GetLanguageIdOrDefault("Language Code");
                if "Salesperson Code" = '' then
                    CLEAR(SalesPurchPerson)
                else
                    SalesPurchPerson.GET("Salesperson Code");
                if not Customer.GET("Bill-to Customer No.") then begin
                    CLEAR(Customer);
                    "Bill-to Name" := Text009;
                    "Ship-to Name" := Text009;
                end;
                DocumentText := USText000;
                if "Prepayment Invoice" then DocumentText := USText001;
                User.RESET;
                User.SETRANGE("User Name", "Sales Invoice Header"."ODT Project Manager");
                IF (NOT User.FINDFIRST) OR (User."Full Name" = '') THEN User."Full Name" := "Sales Invoice Header"."ODT Project Manager";
                IF NOT Job.GET("ODT Job No.") then CLEAR(Job);
                FormatAddress.SalesInvBillTo(BillToAddress, "Sales Invoice Header");
                //ODTKB : 2019-07-26 : BEGIN
                BillToAddress[1] := "Sales Invoice Header"."Bill-to Address";
                BillToAddress[2] := "Sales Invoice Header"."Bill-to City" + ' ' + "Sales Invoice Header"."Bill-to Country/Region Code" + ' ' + "Sales Invoice Header"."Bill-to Post Code";
                BillToAddress[3] := 'Attn: ' + "Sales Invoice Header"."Bill-to Contact";
                //ODTKB : END
                FormatAddress.SalesInvShipTo(ShipToAddress, ShipToAddress, "Sales Invoice Header");
                FtMgt.PostedSalesInvJobInfo(JobHeader, JobHeaderLabels, Job, "Sales Invoice Header");
                if "Payment Terms Code" = '' then
                    CLEAR(PaymentTerms)
                else
                    PaymentTerms.GET("Payment Terms Code");
                if "Shipment Method Code" = '' then
                    CLEAR(ShipmentMethod)
                else
                    ShipmentMethod.GET("Shipment Method Code");
                if "Currency Code" = '' then begin
                    GLSetup.TESTFIELD("LCY Code");
                    TotalCaption := STRSUBSTNO(TotalCaptionTxt, GLSetup."LCY Code");
                    AmountExemptfromSalesTaxCaption := STRSUBSTNO(AmountExemptfromSalesTaxCaptionTxt, GLSetup."LCY Code");
                    AmountSubjecttoSalesTaxCaption := STRSUBSTNO(AmountSubjecttoSalesTaxCaptionTxt, GLSetup."LCY Code");
                end
                else begin
                    TotalCaption := STRSUBSTNO(TotalCaptionTxt, "Currency Code");
                    AmountExemptfromSalesTaxCaption := STRSUBSTNO(AmountExemptfromSalesTaxCaption, "Currency Code");
                    AmountSubjecttoSalesTaxCaption := STRSUBSTNO(AmountSubjecttoSalesTaxCaption, "Currency Code");
                end;
                GetLineFeeNoteOnReportHist("No.");
                if LogInteraction then
                    if not CurrReport.PREVIEW then begin
                        if "Bill-to Contact No." <> '' then
                            SegManagement.LogDocument(4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code", "Campaign No.", "Posting Description", '')
                        else
                            SegManagement.LogDocument(4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", '');
                    end;
                //<ODTTM>
                CALCFIELDS("Work Description");
                ShowWorkDescription := "Work Description".HASVALUE;
                //<ODTTM>
                CLEAR(BreakdownTitle);
                CLEAR(BreakdownLabel);
                CLEAR(BreakdownAmt);
                TotalTaxLabel := Text008;
                TaxRegNo := '';
                TaxRegLabel := '';
                if "Tax Area Code" <> '' then begin
                    TaxArea.GET("Tax Area Code");
                    case TaxArea."Country/Region" of
                        TaxArea."Country/Region"::US:
                            TotalTaxLabel := Text005;
                        TaxArea."Country/Region"::CA:
                            begin
                                TotalTaxLabel := Text007;
                                TaxRegNo := CompanyInformation."VAT Registration No.";
                                TaxRegLabel := CompanyInformation.FIELDCAPTION("VAT Registration No.");
                            end;
                    end;
                    SalesTaxCalc.StartSalesTaxCalculation;
                    if TaxArea."Use External Tax Engine" then
                        SalesTaxCalc.CallExternalTaxEngineForDoc(DATABASE::"Sales Invoice Header", 0, "No.")
                    else begin
                        SalesTaxCalc.AddSalesInvoiceLines("No.");
                        SalesTaxCalc.EndSalesTaxCalculation("Posting Date");
                    end;
                    SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                    BrkIdx := 0;
                    PrevPrintOrder := 0;
                    PrevTaxPercent := 0;
                    with TempSalesTaxAmtLine do begin
                        RESET;
                        SETCURRENTKEY("Print Order", "Tax Area Code for Key", "Tax Jurisdiction Code");
                        if FIND('-') then
                            repeat
                                if ("Print Order" = 0) or ("Print Order" <> PrevPrintOrder) or ("Tax %" <> PrevTaxPercent) then begin
                                    BrkIdx := BrkIdx + 1;
                                    if BrkIdx > 1 then begin
                                        if TaxArea."Country/Region" = TaxArea."Country/Region"::CA then
                                            BreakdownTitle := Text006
                                        else
                                            BreakdownTitle := Text003;
                                    end;
                                    if BrkIdx > ARRAYLEN(BreakdownAmt) then begin
                                        BrkIdx := BrkIdx - 1;
                                        BreakdownLabel[BrkIdx] := Text004;
                                    end
                                    else
                                        BreakdownLabel[BrkIdx] := STRSUBSTNO("Print Description", "Tax %");
                                end;
                                BreakdownAmt[BrkIdx] := BreakdownAmt[BrkIdx] + "Tax Amount";
                            until NEXT = 0;
                    end;
                    if BrkIdx = 1 then begin
                        CLEAR(BreakdownLabel);
                        CLEAR(BreakdownAmt);
                    end;
                end;
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
                    Caption = 'Options';

                    field(NoCopies; NoCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Number of Copies';
                        ToolTip = 'Specifies the number of copies of each document (in addition to the original) that you want to print.';

                        ;
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Company Address';
                        ToolTip = 'Specifies if your company address is printed at the top of the sheet, because you do not use pre-printed paper. Leave this check box blank to omit your company''s address.';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if you want to record the related interactions with the involved contact person in the Interaction Log Entry table.';
                    }
                    field(DisplayAsmInfo; DisplayAssemblyInformation)
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Show Assembly Components';
                    }
                    field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Additional Fee Note';
                        ToolTip = 'Specifies if you want notes about additional fees to be shown on the document.';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit();
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage();
        begin
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnInitReport();
    begin
        GLSetup.GET;
    end;

    trigger OnPreReport();
    begin
        ShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        if not CurrReport.USEREQUESTPAGE then InitLogInteraction;
        CompanyInformation.GET;
        SalesSetup.GET;
        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo3.GET;
                    CompanyInfo3.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                end;
        end;
        if PrintCompany then
            FormatAddress.Company(CompanyAddress, CompanyInformation)
        else
            CLEAR(CompanyAddress);
    end;

    var
        Lang: Codeunit Language;
        InStr: InStream;
        OutStr: OutStream;
        TaxLiable: Decimal;
        OrderedQuantity: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Customer: Record Customer;
        OrderLine: Record "Sales Line";
        ShipmentLine: Record "Sales Shipment Line";
        TempSalesInvoiceLine: Record "Sales Invoice Line" temporary;
        TempSalesInvoiceLineAsm: Record "Sales Invoice Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        TempSalesTaxAmtLine: Record "Sales Tax Amount Line" temporary;
        TaxArea: Record "Tax Area";
        Cust: Record Customer;
        TempPostedAsmLine: Record "Posted Assembly Line" temporary;
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        GLSetup: Record "General Ledger Setup";
        CompanyAddress: array[8] of Text[50];
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text;
        DescriptionToPrint: Text[210];
        HighDescriptionToPrint: Text[210];
        LowDescriptionToPrint: Text[210];
        PrintCompany: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        SalesInvPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddress: Codeunit "Format Address";
        SalesTaxCalc: Codeunit "Sales Tax Calculate";
        SegManagement: Codeunit SegManagement;
        LogInteraction: Boolean;
        Text000: Label 'COPY';
        TaxRegNo: Text;
        TaxRegLabel: Text;
        TotalTaxLabel: Text;
        BreakdownTitle: Text;
        BreakdownLabel: array[4] of Text;
        BreakdownAmt: array[4] of Decimal;
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Tax:';
        Text009: Label 'VOID INVOICE';
        DocumentText: Text[20];
        USText000: Label 'INVOICE';
        USText001: Label 'PREPAYMENT REQUEST';
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        BillCaptionLbl: Label 'Bill';
        ToCaptionLbl: Label 'To:';
        ShipViaCaptionLbl: Label 'Ship Via';
        ShipDateCaptionLbl: Label 'Ship Date';
        DueDateCaptionLbl: Label 'Due Date';
        TermsCaptionLbl: Label 'Terms';
        CustomerIDCaptionLbl: Label 'Customer ID';
        PONumberCaptionLbl: Label 'P.O. Number';
        PODateCaptionLbl: Label 'P.O. Date';
        OurOrderNoCaptionLbl: Label 'Our Order No.';
        SalesPersonCaptionLbl: Label 'SalesPerson';
        ShipCaptionLbl: Label 'Ship';
        InvoiceNumberCaptionLbl: Label 'Invoice Number:';
        InvoiceDateCaptionLbl: Label 'Invoice Date:';
        PageCaptionLbl: Label 'Page:';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
        ItemDescriptionCaptionLbl: Label 'Item/Description';
        UnitCaptionLbl: Label 'Unit';
        OrderQtyCaptionLbl: Label 'Order Qty';
        QuantityCaptionLbl: Label 'Quantity';
        UnitPriceCaptionLbl: Label 'Unit Price';
        TotalPriceCaptionLbl: Label 'Total Price';
        SubtotalCaptionLbl: Label 'Subtotal:';
        InvoiceDiscountCaptionLbl: Label 'Invoice Discount:';
        TotalCaptionTxt: Label 'Total %1:';
        AmountSubjecttoSalesTaxCaptionTxt: Label 'Amount Subject to Sales Tax %1';
        AmountExemptfromSalesTaxCaptionTxt: Label 'Amount Exempt from Sales Tax %1';
        TotalCaption: Text;
        AmountSubjecttoSalesTaxCaption: Text;
        AmountExemptfromSalesTaxCaption: Text;
        DisplayAdditionalFeeNote: Boolean;
        ShowWorkDescription: Boolean;
        WorkDescriptionLine: Text;

        TempBlobWorkDescription: Codeunit "Temp Blob";
        Result: Integer;



        User: Record User;
        Job: Record Job;
        FTMgt: Codeunit "ODT Field Ticket Management";
        JobHeader: array[14] of Text[2000];
        JobHeaderLabels: array[14] of Text[2000];
        GLAcct: Record "G/L Account";
        Resource: record Resource;
        Item: record Item;

    [Scope('Cloud')]
    procedure InitLogInteraction();
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    [Scope('Cloud')]
    procedure CollectAsmInformation(TempSalesInvoiceLine: Record "Sales Invoice Line" temporary);
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        TempPostedAsmLine.DELETEALL;
        if not DisplayAssemblyInformation then exit;
        if not TempSalesInvoiceLineAsm.GET(TempSalesInvoiceLine."Document No.", TempSalesInvoiceLine."Line No.") then exit;
        SalesInvoiceLine.GET(TempSalesInvoiceLineAsm."Document No.", TempSalesInvoiceLineAsm."Line No.");
        if SalesInvoiceLine.Type <> SalesInvoiceLine.Type::Item then exit;
        with ValueEntry do begin
            SETCURRENTKEY("Document No.");
            SETRANGE("Document No.", SalesInvoiceLine."Document No.");
            SETRANGE("Document Type", "Document Type"::"Sales Invoice");
            SETRANGE("Document Line No.", SalesInvoiceLine."Line No.");
            SETRANGE("Applies-to Entry", 0);
            if not FINDSET then exit;
        end;
        repeat
            if ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") then
                if ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" then begin
                    SalesShipmentLine.GET(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    if SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) then begin
                        PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                        if PostedAsmLine.FINDSET then
                            repeat
                                TreatAsmLineBuffer(PostedAsmLine);
                            until PostedAsmLine.NEXT = 0;
                    end;
                end;
        until ValueEntry.NEXT = 0;
    end;

    [Scope('Cloud')]
    procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line");
    begin
        CLEAR(TempPostedAsmLine);
        TempPostedAsmLine.SETRANGE(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SETRANGE("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SETRANGE("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SETRANGE(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SETRANGE("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        if TempPostedAsmLine.FINDFIRST then begin
            TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
            TempPostedAsmLine.MODIFY;
        end
        else begin
            CLEAR(TempPostedAsmLine);
            TempPostedAsmLine := PostedAsmLine;
            TempPostedAsmLine.INSERT;
        end;
    end;

    [Scope('Cloud')]
    procedure GetUOMText(UOMCode: Code[10]): Text[10];
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.GET(UOMCode) then exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    [Scope('Cloud')]
    procedure BlanksForIndent(): Text[10];
    begin
        exit(PADSTR('', 2, ' '));
    end;

    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20]);
    var
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
    begin
        TempLineFeeNoteOnReportHist.DELETEALL;
        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeaderNo);
        if not CustLedgerEntry.FINDFIRST then exit;
        if not Customer.GET(CustLedgerEntry."Customer No.") then exit;
        LineFeeNoteOnReportHist.SETRANGE("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SETRANGE("Language Code", Customer."Language Code");
        if LineFeeNoteOnReportHist.FINDSET then begin
            repeat
                TempLineFeeNoteOnReportHist.INIT;
                TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
                TempLineFeeNoteOnReportHist.INSERT;
            until LineFeeNoteOnReportHist.NEXT = 0;
        end
        else begin
            // LineFeeNoteOnReportHist.SETRANGE("Language Code", Language.GetUserLanguage); // RH
            LineFeeNoteOnReportHist.SETRANGE("Language Code", Lang.GetUserLanguageCode());
            if LineFeeNoteOnReportHist.FINDSET then
                repeat
                    TempLineFeeNoteOnReportHist.INIT;
                    TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
                    TempLineFeeNoteOnReportHist.INSERT;
                until LineFeeNoteOnReportHist.NEXT = 0;
        end;
    end;
}
