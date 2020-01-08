pageextension 50025 SalesInvoiceListExt extends "Sales Invoice List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sell-to Customer Name")
        {
            field("JobNumber"; JobNumber)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Job Number';
                Caption = 'Job No.';
                Editable = false;
            }
        }
    }
    actions
    {
    }
}
