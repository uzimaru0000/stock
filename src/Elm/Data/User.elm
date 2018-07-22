module Data.User exposing (User)

import Json.Decode as JD
import Json.Encode as JE
import Data.Common exposing (..)


type alias User =
    { uid : Uid
    , name : String
    , iconUrl : Maybe String
    }


decoder : JD.Decoder User
decoder =
    JD.map3 User
        (JD.field "uid" JD.string)
        (JD.field "name" JD.string)
        (JD.field "iconUrl" <| JD.nullable JD.string)


encoder : User -> JE.Value
encoder user =
    JE.object
        [ ( "uid", JE.string user.uid )
        , ( "name", JE.string user.name )
        , ( "iconUrl", user.iconUrl |> Maybe.map JE.string |> Maybe.withDefault JE.null )
        ]
