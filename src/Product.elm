module Product exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as Decode exposing (Decoder, field)
import Variant
import Image


type alias Product =
    { id : Int
    , name : String
    , description : String
    , images : List Image.Image
    , variants : List Variant.Variant
    }


productDecoder : Decoder Product
productDecoder =
    Decode.map5 Product
        (field "id" Decode.int)
        (field "name" Decode.string)
        (field "description" Decode.string)
        (field "images" Image.imagesDecoder)
        (field "variants" Variant.variantsDecoder)


getInventory : (Result Http.Error (List Product) -> msg) -> String -> Cmd msg
getInventory msg url =
    Decode.list productDecoder
        |> Http.get url
        |> Http.send msg


viewProduct : Product -> Html msg
viewProduct product =
    li []
        [ h2 []
            [ span [] [ text "Product #" ]
            , span [] [ text (toString product.id) ]
            ]
        , Image.viewImageList product.images
        , p [] [ text product.description ]
        , Variant.viewVariantList product.variants
        ]


viewProductList : List Product -> Html msg
viewProductList products =
    let
        listOfProducts =
            List.map viewProduct products
    in
        ul [] listOfProducts
