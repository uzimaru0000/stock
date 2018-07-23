module Data.User exposing (User)

import Json.Decode as JD
import Json.Encode as JE


type alias User =
    { name : String
    , iconUrl : Maybe String
    }


decoder : JD.Decoder User
decoder =
    JD.map2 User
        (JD.field "name" JD.string)
        (JD.field "iconUrl" <| JD.nullable JD.string)


encoder : User -> JE.Value
encoder user =
    JE.object
        [ ( "name", JE.string user.name )
        , ( "iconUrl", user.iconUrl |> Maybe.map JE.string |> Maybe.withDefault JE.null )
        ]
