codeunit 50200 "MyTests"
{
    Subtype = Test;

    var
        LibrarySales: Codeunit "Library - Sales";
        LibraryRandom: Codeunit "Library - Random";
        Assert: Codeunit Assert;
        ShoeSizeErr: Label 'must be between 36 and 49';
        PresentDescription: Text;

    [Test]
    procedure FillPresentDescriptionOnCustomer()
    var
        Customer: Record Customer;
        Present: Record Present;
    begin
        // [Feature Presents]
        // [SCENARIO 1] Fill Present Description field on customer when selecting a present code

        InitTestCase();

        // [GIVEN] Customer exists
        LibrarySales.CreateCustomer(Customer);

        // [GIVEN] Present exists
        CreatePresent(Present);

        // [WHEN] Validate Present Code
        Customer.Validate("Present Code", Present.Code);

        // [THEN] Present Description is the same on the customer then the present
        Assert.AreEqual(Present.Description, Customer."Present Description", 'Present Description and Customer Present Description are not equal.');
    end;

    [Test]
    procedure DeletePresentDescriptionWhenDeletePresentCodeOnCustomer()
    var
        Customer: Record Customer;
        Present: Record Present;
        CustomerCard: TestPage "Customer Card";
    begin
        // [Feature Presents]
        // [SCENARIO 1] Present Description should be empty after the user deletes the Present Code on Customer

        InitTestCase();

        // [GIVEN] Customer exists
        LibrarySales.CreateCustomer(Customer);

        // [GIVEN] Present exists
        CreatePresent(Present);

        // [GIVEN] Present set on Customer
        CustomerCard.OpenEdit();
        CustomerCard.GoToRecord(Customer);
        CustomerCard."Present Code".SetValue(Present.Code);
        Assert.AreEqual(Present.Description, CustomerCard."Present Description".Value, 'Present Description and Customer Present Description are not equal.');

        // [WHEN] User deletes Present Code
        CustomerCard."Present Code".SetValue('');

        // [THEN] Present Description is empty on customer
        Assert.AreEqual('', CustomerCard."Present Description".Value, 'Present Description is not empty on Customer, but it should be');
    end;

    [Test]
    [HandlerFunctions('DescriptionMessageHandler')]
    procedure ShowPresentDescription()
    var
        Present: Record Present;
        Presents: TestPage Presents;
    begin
        // [Feature Presents]
        // [SCENARIO 3] Present Description shows in message on Present list

        InitTestCase();

        // [GIVEN] Present exists
        CreatePresent(Present);
        PresentDescription := Present.Description;

        // [WHEN] User press action on Present List
        Presents.OpenView();
        Presents.GoToRecord(Present);
        Presents.ShowDescription.Invoke();

        // [THEN] correct message shows
        // message check in DescriptionMessageHandler
    end;

    [Test]
    procedure ErrorWhenSelectingInvalidShoeSizeOnCustomer()
    var
        Customer: Record Customer;
        NewSize: Integer;
        ExpectedError: Text;
    begin

        // [Feature Shoes]
        // [SCENARIO 4] Error occurs when a user selects invalid shoe size on Customer

        InitTestCase();

        // [GIVEN] Customer exists
        LibrarySales.CreateCustomer(Customer);

        // [WHEN] Selecting invalid shoe size
        NewSize := LibraryRandom.RandIntInRange(0, 34);
        asserterror Customer.Validate("Shoe Size", NewSize);

        // [THEN] Error occurs
        ExpectedError := Customer.FieldCaption("Shoe Size") + ' ' + ShoeSizeErr + ' in Customer No.=''' + Customer."No." + '''.';
        Assert.ExpectedError(ExpectedError);
    end;

    [MessageHandler]
    procedure DescriptionMessageHandler(Msg: Text[1024])
    begin
        Assert.AreEqual(PresentDescription, Msg, 'Present Description is not correct in message');
    end;

    local procedure InitTestCase()
    begin
        LibraryRandom.Init();
        PresentDescription := '';
    end;

    local procedure CreatePresent(var Present: Record Present)
    begin
        Present.Init();
        Present.Code := LibraryRandom.RandText(20);
        Present.Description := LibraryRandom.RandText(100);
        if Present.Insert() then;
    end;
}