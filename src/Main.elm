module Main exposing (..)

import Extra
import Material.Layout as Layout
import Model exposing (..)
import Navigation exposing (..)
import UpdateMsg exposing (..)
import UrlParser exposing (..)
import View exposing (..)


main : Program Never Model Msg
main =
    Navigation.program locFor
        { init =
            \location ->
                let
                    model =
                        init location
                in
                    ( { model
                        -- tab width of 240 is an empirical value
                        | mdl = Layout.setTabsWidth 240 model.mdl
                      }
                    , Layout.sub0 Mdl
                    )
        , view = view
        , update = update
        , subscriptions =
            \model ->
                Sub.batch
                    [ Layout.subs Mdl model.mdl
                    , Extra.subscriptions model.extraModel UpdateMsg.ExtraMsg
                    ]
        }


locFor : Location -> Msg
locFor location =
    parseHash route location
        |> GoTo


init : Location -> Model
init location =
    let
        tabID =
            case parseHash route location of
                Nothing ->
                    0

                Just (Tab index) ->
                    index
    in
        initModel tabID


route : Parser (Page -> a) a
route =
    oneOf
        [ UrlParser.map Tab (int)
        ]
