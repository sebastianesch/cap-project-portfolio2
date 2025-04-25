using ProjectsService as service from '../../srv/projects-service';

annotate service.Projects with @(
    UI.HeaderInfo                 : {
        TypeName      : '{i18n>project}',
        TypeNamePlural: '{i18n>projects}',
        Title         : {Value: name},
        Description   : {Value: type_code}
    },
    UI.FieldGroup #GeneratedGroup1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: name,
            },
            {
                $Type: 'UI.DataField',
                Value: startDate,
            },
            {
                $Type: 'UI.DataField',
                Value: endDate,
            },
            {
                $Type: 'UI.DataField',
                Value: type_code,
            },
        ],
    },
    UI.FieldGroup #Description    : {
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type: 'UI.DataField',
            Value: description,
        }, ]
    },
    UI.FieldGroup #Customer       : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: customer_ID,
            },
            {
                $Type: 'UI.DataField',
                Value: customer.industry,
            },
            {
                $Type: 'UI.DataField',
                Value: customer.country,
            }
        ]
    },
    UI.Facets                     : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : '{i18n>generalInformation}',
            Target: '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'Description',
            Label : '{i18n>description}',
            Target: '@UI.FieldGroup#Description',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'Customer',
            Label : '{i18n>customer}',
            Target: '@UI.FieldGroup#Customer',
        },
    ],
    UI.SelectionFields            : [
        startDate,
        endDate,
        customer_ID,
        type_code
    ],
    UI.PresentationVariant        : {
        $Type         : 'UI.PresentationVariantType',
        SortOrder     : [{Property: name}],
        Visualizations: ['@UI.LineItem']
    },
    UI.LineItem                   : [
        {
            $Type            : 'UI.DataField',
            Value            : name,
            ![@UI.Importance]: #High
        },
        {
            $Type            : 'UI.DataField',
            Value            : customer_ID,
            ![@UI.Importance]: #High

        },
        {
            $Type: 'UI.DataField',
            Value: type_code,

        },
        {
            $Type: 'UI.DataField',
            Value: description,
        },
        {
            $Type: 'UI.DataField',
            Value: startDate,
        },
        {
            $Type: 'UI.DataField',
            Value: endDate,
        },
    ],
);

annotate service.Projects with @(
    Common.SideEffects #Customer: {
        SourceProperties: [customer_ID],
        TargetEntities  : [customer]
    }
);

annotate service.Projects with {
    ID @UI.Hidden @UI.HiddenFilter;
    type @(
        Common : {
            Text: type.name,
            TextArrangement : #TextOnly,
            ValueListWithFixedValues : true,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'ProjectTypes',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        LocalDataProperty : type_code,
                        ValueListProperty : 'code'
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'name'
                    }
                ]
            }
        }
    );
    customer @(
        Common : {
            Text: customer.name,
            TextArrangement : #TextOnly,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'Customers',
                SearchSupported : true,
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : customer_ID,
                        ValueListProperty : 'ID'
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'name'
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'industry'
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'country'
                    }
                ]
            }
        }
    );
    description @(UI.MultiLineText);
};

annotate service.Customers with {
    ID @UI.Hidden @UI.HiddenFilter @Common.Text: name;
};

annotate service.ProjectTypes with {
    code @UI.Hidden @UI.HiddenFilter @Common.Text: name;
};