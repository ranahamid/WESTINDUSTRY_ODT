pageextension 50030 "PMRoleCenter" extends "Job Project Manager RC"
{
    actions
    {
        addlast(Embedding)
        {

            action("Field Ticket")
            {
                RunObject = page "ODT Field Tickets";
                ApplicationArea = All;
            }
        }
    }
}