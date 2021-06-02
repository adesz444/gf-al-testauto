tableextension 50100 "Customer Ext." extends Customer
{
    fields
    {
        field(50100; "Shoe Size"; Integer)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("Shoe Size" < 35) or ("Shoe Size" > 50) then
                    FieldError("Shoe Size", ShoeSizeErr);
            end;
        }
        field(50101; "Present Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Present;

            trigger OnValidate()
            var
                Present: Record Present;
            begin
                // This code is commented out so a test can fail when the user deletes the Present Code
                // if "Present Code" = '' then begin
                //     "Present Description" := '';
                //     exit;
                // end;

                if Present.Get("Present Code") then
                    "Present Description" := Present.Description;

            end;
        }
        field(50102; "Present Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    var
        ShoeSizeErr: Label 'must be between 36 and 49';
}