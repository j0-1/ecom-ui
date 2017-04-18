module Image exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as Decode exposing (Decoder, field, list)


type alias Image =
    { url : String
    }


imagesDecoder : Decoder (List Image)
imagesDecoder =
    Decode.list imageDecoder


imageDecoder : Decoder Image
imageDecoder =
    Decode.map Image
        (field "url" Decode.string)


viewImage : Image -> Html msg
viewImage image =
    div [ class "images" ] [ img [ src image.url ] [ text image.url ] ]


viewImageList : List Image -> Html msg
viewImageList images =
    let
        listOfImages =
            List.map viewImage images
    in
        ul [] listOfImages
