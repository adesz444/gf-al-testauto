pageextension 50100 "Customer Card Ext." extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            group(Shoes)
            {
                field("Shoe Size"; Rec."Shoe Size")
                {
                    ToolTip = 'Specifies the value of the Shoe Size field';
                    ApplicationArea = All;
                }
                field("Present Code"; Rec."Present Code")
                {
                    ToolTip = 'Specifies the value of the Present Code field';
                    ApplicationArea = All;
                }
                field("Present Description"; Rec."Present Description")
                {
                    ToolTip = 'Specifies the value of the Present Description field';
                    ApplicationArea = All;
                }
            }
        }
    }
}