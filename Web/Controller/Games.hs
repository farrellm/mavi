module Web.Controller.Games where

import Data.Foldable (for_)
import Data.Functor ((<&>))
import Web.Controller.Prelude
import Web.View.Games.Index
import Web.View.Games.New
import Web.View.Games.Edit
import Web.View.Games.Show

instance Controller GameController where
    action GamesAction = do
        ensureIsUser
        games <- query @Game
          |> fetch
          >>= collectionFetchRelated #players
          <&> filter (elem (get #id currentUser) . (<&> get #userId) . get #players)
        users <- query @User |> fetch
        render IndexView { .. }

    action NewGameAction = do
        ensureIsUser
        let game = newRecord
        friends <- query @User |> fetch
        render NewView { .. }

    action ShowGameAction { gameId } = do
        game <- fetch gameId
        render ShowView { .. }

    action EditGameAction { gameId } = do
        ensureIsUser
        game <- fetch gameId
        render EditView { .. }

    action UpdateGameAction { gameId } = do
        ensureIsUser
        game <- fetch gameId
        game
            |> buildGame
            |> ifValid \case
                Left game -> render EditView { .. }
                Right game -> do
                    game <- game |> updateRecord
                    setSuccessMessage "Game updated"
                    redirectTo EditGameAction { .. }

    action CreateGameAction = do
        ensureIsUser
        let game = newRecord @Game
        game
            |> buildGame
            |> ifValid \case
                Left game -> do
                  friends <- query @User |> fetch
                  render NewView { .. }
                Right game -> do
                    game <- game |> createRecord
                    let gameId = get #id game
                    for_ (paramList @(Id User) "players") $ \userId ->
                      newRecord @Player
                        |> set #gameId gameId
                        |> set #userId userId
                        |> createRecord
                    setSuccessMessage "Game created"
                    redirectTo GamesAction

    action DeleteGameAction { gameId } = do
        game <- fetch gameId
        deleteRecord game
        setSuccessMessage "Game deleted"
        redirectTo GamesAction

buildGame game = game
    |> fill @'["kit"]
