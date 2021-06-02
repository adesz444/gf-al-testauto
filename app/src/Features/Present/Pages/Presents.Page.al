page 50100 "Presents"
{
    Caption = 'Presents';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Present;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ShowDescription)
            {
                ApplicationArea = All;
                Image = Description;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'It shows the description';

                trigger OnAction();
                begin
                    Message(Rec.Description);
                end;
            }
        }
    }
}