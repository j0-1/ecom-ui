module Inventory exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Product
import Image


-- MODEL


type alias Model =
    { inventory : List Product.Product
    , alertMessage : Maybe String
    }


initialModel : Model
initialModel =
    { inventory = []
    , alertMessage = Nothing
    }



-- UPDATE


type Msg
    = NewInventory (Result Http.Error (List Product.Product))
    | CloseAlert


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CloseAlert ->
            ( { model | alertMessage = Nothing }, Cmd.none )

        NewInventory (Ok inventory) ->
            ( { model | inventory = inventory }, Cmd.none )

        NewInventory (Err error) ->
            ( { model | alertMessage = Just (httpErrorToMessage error) }, Cmd.none )


httpErrorToMessage : Http.Error -> String
httpErrorToMessage error =
    case error of
        Http.NetworkError ->
            "Is the server running?"

        Http.BadStatus response ->
            (toString response.status)

        Http.BadPayload message _ ->
            "Decoding Failed: " ++ message

        _ ->
            (toString error)



-- COMMANDS


apiHost : String
apiHost =
    "http://localhost:3000/api/v1"


getInventory : Cmd Msg
getInventory =
    Product.getInventory NewInventory (apiHost ++ "/inventory")



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ viewHeader "Inventory"
        , alert CloseAlert model.alertMessage
          --, div [ class "debug" ] [ text (toString model) ]
        , Product.viewProductList model.inventory
        , viewFooter
        ]


alert : msg -> Maybe String -> Html msg
alert msg alertMessage =
    case alertMessage of
        Just message ->
            div [ class "alert" ]
                [ span [ class "close", onClick msg ] [ text "X" ]
                , text message
                ]

        Nothing ->
            text ""


viewHeader : String -> Html Msg
viewHeader title =
    header []
        [ h1 [] [ text title ] ]


viewFooter : Html Msg
viewFooter =
    footer []
        [ a [ href "http://github.com" ] [ text "E-commerce API" ]
        , span [] [ text " | " ]
        , a [ href "http://github.com" ] [ text "Ecommerce UI" ]
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, getInventory )
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }
