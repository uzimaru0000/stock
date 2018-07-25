module Update exposing (..)

import Model exposing (..)
import Routing exposing (Route, parseLocation, routeToUrl)
import Navigation exposing (newUrl)
import Firebase exposing (..)
import PostListing.Model as PostListing
import PostListing.Update as PostListing
import Edit.Model as Edit
import Edit.Update as Edit
import Post.Model as Post
import Post.Update as Post
import Window exposing (height)
import Task


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, getPage model.pageState ) of
        ( LocationChange loc, _ ) ->
            setRoute (parseLocation loc) model

        ( RouteChange route, _ ) ->
            model ! [ newUrl <| routeToUrl route ]

        ( Login, _ ) ->
            model ! [ login () ]

        ( Logout, _ ) ->
            model ! [ logout () ]

        ( PostListInit data, _ ) ->
            case model.user of
                Just user ->
                    { model | pageState = Loaded (PostList <| PostListing.init user data) } ! []

                Nothing ->
                    model ! []

        ( CreateInit maybePost winHeight, _ ) ->
            { model | pageState = Loaded (Edit <| Edit.init maybePost winHeight) } ! []

        ( EditInit post, _ ) ->
            model ! [ Task.perform (CreateInit <| Just post) height ]

        ( PostInit post, _ ) ->
            { model | pageState = Loaded (PostView <| Post.init post) } ! []

        ( PostListingMsg subMsg, PostList oldModel ) ->
            subUpdate PostListing.update PostListingMsg subMsg PostList oldModel model

        ( EditMsg subMsg, Edit oldModel ) ->
            subUpdate Edit.update EditMsg subMsg Edit oldModel model

        ( PostMsg subMsg, PostView oldModel ) ->
            subUpdate Post.update PostMsg subMsg PostView oldModel model

        _ ->
            model ! []


subUpdate : (msg -> model -> ( model, Cmd msg )) -> (msg -> Msg) -> msg -> (model -> Page) -> model -> Model -> ( Model, Cmd Msg )
subUpdate updater msg subMsg page oldModel model =
    let
        ( newModel, cmd ) =
            updater subMsg oldModel
    in
        { model | pageState = Loaded (page newModel) } ! [ Cmd.map msg cmd ]


setRoute : Route -> Model -> ( Model, Cmd Msg )
setRoute route model =
    let
        transition cmd =
            ( { model | pageState = Transition (getPage model.pageState) }
            , cmd
            )
    in
        case route of
            Routing.Home ->
                if model.user /= Nothing then
                    transition <| postListInit ()
                else
                    { model | pageState = Loaded Home } ! []

            Routing.Post uid ->
                transition <| postInit uid

            Routing.Create ->
                transition <| Task.perform (CreateInit Nothing) height

            Routing.Edit uid ->
                transition <| editInit uid

            _ ->
                { model | pageState = Loaded NotFound } ! []
