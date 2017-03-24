import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode



-- Model

type alias Model =
  { counter: Int }



-- Update

type Msg
  =  GetData (Result Http.Error Int)
  | Get
  | Set

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case Debug.log "Err: " msg of
    GetData (Ok value)->
      (Model value , Cmd.none)

    GetData (Err _) ->
      (Model 999, Cmd.none)

    Get ->
      (model, getCounter)

    Set ->
      (model, setCounter)




-- View

view : Model -> Html Msg
view model =
  div []
    [
    button [ onClick Get ] [ text "Get" ]
    , div [] [ text (toString model.counter) ]
    , button [ onClick Set ] [ text "Set" ]
    ]

-- Method

decodeREST : Decode.Decoder Int
decodeREST = Decode.at ["data"] Decode.int

getCounter : Cmd Msg
getCounter =
  let
    url = "http://localhost:3000/counter"
  in
    Http.send GetData (Http.get url decodeREST)

setCounter : Cmd Msg
setCounter =
  let
    url = "http://localhost:3000/counter/1"
  in
    Http.send GetData (Http.request
      { method = "PUT"
      , headers = [Http.header "Access-Control-Allow-Origin" "http:localhost:3000"]
      , url = url
      , body = Http.emptyBody
      , expect = Http.expectJson decodeREST
      , timeout = Nothing
      , withCredentials = False
      })


main =
  Html.program
    { init = (Model 0, Cmd.none)
    , view = view
    , update = update
    , subscriptions = \x -> Sub.none }
