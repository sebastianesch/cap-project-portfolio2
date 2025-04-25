using CustomersService as service from '../../srv/customers-service';

annotate service.Customers with @(
    UI.HeaderInfo                : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : '{i18n>customer}',
        TypeNamePlural: '{i18n>customers}',
        Title         : {Value: name},
        Description   : {Value: industry}
    },
    UI.PresentationVariant       : {
        $Type         : 'UI.PresentationVariantType',
        SortOrder     : [{Property: name}],
        Visualizations: ['@UI.LineItem']
    },
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: name,
            },
            {
                $Type: 'UI.DataField',
                Value: industry,
            },
            {
                $Type: 'UI.DataField',
                Value: country,
            },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'projects/@UI.PresentationVariant',
            Label : '{i18n>projects}',
            ID    : 'projects',
        },
    ],
    UI.LineItem                  : [
        {
            $Type            : 'UI.DataField',
            Value            : name,
            ![@UI.Importance]: #High,
        },
        {
            $Type: 'UI.DataField',
            Value: industry,
        },
        {
            $Type: 'UI.DataField',
            Value: country,
        },
    ],
);

annotate service.Projects with @(
    UI.HeaderInfo : {
        $Type : 'UI.HeaderInfoType',
        TypeName : '{i18n>project}',
        TypeNamePlural : '{i18n>projects}',
        Title: { Value : name },
        Description: { Value : type_code }
    },
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : name,
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : type_code,
        },
        {
            $Type : 'UI.DataField',
            Value : startDate,
        },
        {
            $Type : 'UI.DataField',
            Value : endDate,
        },
    ],
    UI.PresentationVariant : {
        $Type : 'UI.PresentationVariantType',
        SortOrder : [
            { Property : name }
        ],
        Visualizations : [ '@UI.LineItem' ]
    },
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Value : type_code,
            },
        ],
    },
    UI.FieldGroup #GeneratedGroup2 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : startDate,
            },
            {
                $Type : 'UI.DataField',
                Value : endDate,
            }
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : '{i18n>generalInformation}',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet2',
            Label : '{i18n>projectDates}',
            Target : '@UI.FieldGroup#GeneratedGroup2',
        },
    ],
);

annotate service.Projects with {
    type @(
        Common : {
            Text: type.name,
            TextArrangement : #TextOnly
        }
    );
};