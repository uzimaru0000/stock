module Edit.Sub exposing (..)

import Window exposing (resizes)
import Edit.Model exposing (..)
import Firebase exposing (..)

subscriptions : Model -> Sub Msg
subscriptions model =
    [ resizes (.height >> ChangeSize)
    , successStorePost StoreSuccess
    ]
    |> Sub.batch