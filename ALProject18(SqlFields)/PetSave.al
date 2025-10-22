tableextension 53140 ItemPetSaveExt extends Item
{
    fields
    {
        field(53240; "PetSaveXferUoM"; Code[10])
        {
            Caption = 'PetSave Xfer UoM';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }

        field(53241; "PetSaveXferUnits"; Integer)
        {
            Caption = 'PetSave Xfer Units';
            DataClassification = ToBeClassified;
        }

        field(53242; "PetSave Dist Price"; Decimal)
        {
            Caption = 'PetSave Dist Price';
            DecimalPlaces = 0 : 2;
            DataClassification = ToBeClassified;
        }

        field(53243; "Disc% off PetSave Dist Price"; Decimal)
        {
            Caption = 'Disc% off PetSave Dist Price';
            DecimalPlaces = 0 : 5;
            DataClassification = ToBeClassified;
        }

        field(53244; "PetSave PROMO Dist Price"; Decimal)
        {
            Caption = 'PetSave PROMO Dist Price';
            DecimalPlaces = 0 : 2;
            DataClassification = ToBeClassified;
        }

        field(53245; "PetSave 5% above PROMO WP"; Decimal)
        {
            Caption = 'PetSave 5% above PROMO WP';
            DecimalPlaces = 0 : 2;
            DataClassification = ToBeClassified;
        }

        field(53246; "PetSave Promo Disc% Start Date"; Date)
        {
            Caption = 'PetSave Promo Disc% Start Date';
            DataClassification = ToBeClassified;
        }

        field(53247; "PetSave Promo Disc% End Date"; Date)
        {
            Caption = 'PetSave Promo Disc% End Date';
            DataClassification = ToBeClassified;
        }
    }
}

pageextension 53140 ItemCardPetSaveExt extends "Item Card"
{
    layout
    {
        addlast(Content)
        {
            group("🟪 PetSave Settings")
            {
                Caption = '🟪 PetSave Settings';


                field("PetSaveXferUoM"; Rec."PetSaveXferUoM") { ApplicationArea = All; }
                field("PetSaveXferUnits"; Rec."PetSaveXferUnits") { ApplicationArea = All; }

                field("PetSave Dist Price"; Rec."PetSave Dist Price") { ApplicationArea = All; }
                field("Disc% off PetSave Dist Price"; Rec."Disc% off PetSave Dist Price") { ApplicationArea = All; }
                field("PetSave PROMO Dist Price"; Rec."PetSave PROMO Dist Price") { ApplicationArea = All; }
                field("PetSave 5% above PROMO WP"; Rec."PetSave 5% above PROMO WP") { ApplicationArea = All; }

                field("PetSave Promo Disc% Start Date"; Rec."PetSave Promo Disc% Start Date") { ApplicationArea = All; }
                field("PetSave Promo Disc% End Date"; Rec."PetSave Promo Disc% End Date") { ApplicationArea = All; }
            }
        }
    }
}

page 53141 "Item PetSave API"
{
    PageType = API;
    Caption = 'Item PetSave API';
    APIPublisher = 'joe';
    APIGroup = 'ItemFieldsFromSQL';
    APIVersion = 'v1.0';
    EntityName = 'itemPetSave';
    EntitySetName = 'itemPetSaves';
    SourceTable = Item;
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    Extensible = false;

    // 是否允许改写（按需收紧）
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = false; // 通常不允许通过此 API 删除 Item

    layout
    {
        area(content)
        {
            // —— 主键/关键字段 ——
            field(id; Rec.SystemId)
            {
                Caption = 'SystemId';
                Editable = false;
            }
            field(no; Rec."No.")
            {
                Caption = 'No.';
            }

            // —— 53140 的自定义字段 ——（JSON 名已清理）
            field(petSaveXferUoM; Rec."PetSaveXferUoM")
            {
                Caption = 'PetSave Xfer UoM';
                // 注意：必须是已存在的 "Unit of Measure".Code，否则会校验失败
            }
            field(petSaveXferUnits; Rec."PetSaveXferUnits")
            {
                Caption = 'PetSave Xfer Units';
            }
            field(petSaveDistPrice; Rec."PetSave Dist Price")
            {
                Caption = 'PetSave Dist Price';
            }
            field(discOffPetSaveDistPrice; Rec."Disc% off PetSave Dist Price")
            {
                Caption = 'Disc% off PetSave Dist Price';
            }
            field(petSavePromoDistPrice; Rec."PetSave PROMO Dist Price")
            {
                Caption = 'PetSave PROMO Dist Price';
            }
            field(petSave5AbovePromoWP; Rec."PetSave 5% above PROMO WP")
            {
                Caption = 'PetSave 5% above PROMO WP';
            }
            field(promoDiscStartDate; Rec."PetSave Promo Disc% Start Date")
            {
                Caption = 'PetSave Promo Disc% Start Date';
            }
            field(promoDiscEndDate; Rec."PetSave Promo Disc% End Date")
            {
                Caption = 'PetSave Promo Disc% End Date';
            }
        }
    }

}
