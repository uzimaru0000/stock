module Data.Common exposing (..)

import Json.Decode as JD
import Json.Encode as JE

type alias Uid =
    String


type alias UniqAsset a =
    { uid : Uid
    , asset : a
    }


decoder : JD.Decoder a -> JD.Decoder (UniqAsset a)
decoder assetDecoder =
    JD.map2 UniqAsset
        (JD.field "uid" JD.string)
        (JD.field "asset" assetDecoder)


encoder : (a -> JE.Value) -> UniqAsset a -> JE.Value
encoder assetEncoder value =
    JE.object
        [ ( "uid", JE.string value.uid )
        , ( "asset", assetEncoder value.asset )
        ]