module Variant exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as Decode exposing (Decoder, field, list)


type alias Variant =
    { waist : Int
    , length : Int
    , style : String
    , inventory_count : Int
    }


variantsDecoder : Decoder (List Variant)
variantsDecoder =
    Decode.list variantDecoder


variantDecoder : Decoder Variant
variantDecoder =
    Decode.map4 Variant
        (field "waist" Decode.int)
        (field "length" Decode.int)
        (field "style" Decode.string)
        (field "inventory_count" Decode.int)


viewVariant : Variant -> Html msg
viewVariant variant =
    tr []
        [ td [] [ text (toString variant.inventory_count) ]
        , td [] [ text (toString variant.waist) ]
        , td [] [ text (toString variant.length) ]
        , td [] [ text variant.style ]
        ]


viewVariantHeader : Html msg
viewVariantHeader =
    tr []
        [ th [] [ text "Inventory Count" ]
        , th [] [ text "Waist" ]
        , th [] [ text "Length" ]
        , th [] [ text "Style" ]
        ]


viewVariantList : List Variant -> Html msg
viewVariantList variants =
    let
        listOfVariants =
            List.map viewVariant variants

        variantsTable =
            viewVariantHeader :: listOfVariants
    in
        table [ class "variants" ] variantsTable
