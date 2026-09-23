// Mantém a coluna numérica: NaN vira null e o traço fica apenas na formatação visual.
let
    Source = PreviousStep,
    CleanNumericValue = Table.TransformColumns(
        Source,
        {
            {
                "NumericValue",
                each if _ is number and Number.IsNaN(_) then null else _,
                type nullable number
            }
        }
    )
in
    CleanNumericValue
