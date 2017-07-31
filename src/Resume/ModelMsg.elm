module Resume.ModelMsg exposing (..)

import Material
import Animation exposing (px)
import Animation.Messenger


type alias Model =
    { chosenCard : Info
    , mdl : Material.Model
    , style : TransitionStyles
    }


type alias TransitionStyle =
    { card : Animation.State
    , text : Animation.Messenger.State Msg
    }


type alias TransitionStyles =
    { intize : TransitionStyle
    }


type Msg
    = TeachMsg TeachJob
    | ShowMore Info
    | MdlMsg (Material.Msg Msg)
    | FancyAnim
    | SwitchText
    | Animate Animation.Msg


initModel : Model
initModel =
    { chosenCard = None
    , mdl = Material.model
    , style =
        TransitionStyles
            { card =
                Animation.style
                    [ Animation.height <| Animation.px 210
                    ]
            , text =
                Animation.style
                    [ Animation.opacity 1.0
                    ]
            }
    }


type Info
    = None
    | School Int
    | Work
    | Skills
    | Teach TeachJob


type TeachJob
    = AllT
    | BackHome
    | Intize
    | SI
    | Galaren
