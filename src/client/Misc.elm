module Misc exposing (..)

import List
import String
import Date exposing (Date)
import Html
import Html.Events
import Json.Decode


{-| ref: <https://github.com/rtfeldman/elm-spa-example/blob/4213d8cb6fe4d72f82b7cdd5bc43f64fab99ad12/src/Util.elm>
-}
(=>) : a -> b -> ( a, b )
(=>) =
    (,)


{-| Html 'onkeydown' event
-}
onKeyDown : (Int -> msg) -> Html.Attribute msg
onKeyDown tagger =
    Html.Events.on "keydown" (Json.Decode.map tagger Html.Events.keyCode)


{-| Convert String to Int; If there are any errors, just return the default value
-}
toIntDefault : Int -> String -> Int
toIntDefault default str =
    case String.toInt str of
        Ok int ->
            int

        Err _ ->
            default


{-| Build url with List of querystring parameters
-}
urlWithQuery : String -> List ( String, String ) -> String
urlWithQuery url params =
    String.join "?"
        [ url
        , String.join "&"
            (List.map
                (\( key, value ) -> key ++ "=" ++ value)
                params
            )
        ]


{-| Convert Int to two digit String
-}
twoDigit : Int -> String
twoDigit num =
    let
        str =
            toString num

        length =
            String.length str
    in
        if length <= 1 then
            String.padLeft 2 '0' str
        else
            String.right 2 str


{-| Format date in "Thu Jan 01 1970 08:00:00"
-}
formatDate : Date -> String
formatDate date =
    String.join " "
        [ toString <| Date.dayOfWeek date
        , toString <| Date.month date
        , twoDigit <| Date.day date
        , toString <| Date.year date
        , String.join
            ":"
            [ twoDigit <| Date.hour date
            , twoDigit <| Date.minute date
            , twoDigit <| Date.second date
            ]
        ]
