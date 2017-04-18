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
    div [ class "variants" ]
        [ span [] [ text (toString variant.inventory_count) ]
        , span [] [ text " " ]
        , span [] [ text (toString variant.waist) ]
        , span [] [ text " " ]
        , span [] [ text (toString variant.length) ]
        , span [] [ text " " ]
        , span [] [ text variant.style ]
        ]


viewVariantList : List Variant -> Html msg
viewVariantList variants =
    let
        listOfVariants =
            List.map viewVariant variants
    in
        ul [] listOfVariants
