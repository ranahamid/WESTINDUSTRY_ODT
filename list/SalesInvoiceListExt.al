pageextension 50025 SalesInvoiceListExt extends "Sales Invoice List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Sell-to Customer Name")
        {
            field("Job Number"; JobNumber)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Job Number';
                Lookup = true;
                Caption = 'Job No.';
                Editable = false;
            }
        }
    }
    actions
    {
    }
}
