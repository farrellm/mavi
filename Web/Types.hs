module Web.Types where

import Generated.Types
import IHP.LoginSupport.Types
import IHP.ModelSupport
import IHP.Prelude
import IHP.View.Form (CanSelect (..))

data WebApplication = WebApplication deriving (Eq, Show)

data StaticController = WelcomeAction deriving (Eq, Show, Data)

instance HasNewSessionUrl User where
    newSessionUrl _ = "/NewSession"

type instance CurrentUserRecord = User

data SessionsController
    = NewSessionAction
    | CreateSessionAction
    | DeleteSessionAction
    deriving (Eq, Show, Data)

data GameController
    = GamesAction
    | NewGameAction
    | ShowGameAction {gameId :: !(Id Game)}
    | CreateGameAction
    | EditGameAction {gameId :: !(Id Game)}
    | UpdateGameAction {gameId :: !(Id Game)}
    | DeleteGameAction {gameId :: !(Id Game)}
    deriving (Eq, Show, Data)

data UsersController
    = UsersAction
    | NewUserAction
    | ShowUserAction {userId :: !(Id User)}
    | CreateUserAction
    | EditUserAction {userId :: !(Id User)}
    | UpdateUserAction {userId :: !(Id User)}
    | DeleteUserAction {userId :: !(Id User)}
    deriving (Eq, Show, Data)

instance CanSelect User where
    type SelectValue User = Id User
    selectValue = get #id
    selectLabel = get #username

instance CanSelect Kit where
    type SelectValue Kit = Kit
    selectValue value = value

    selectLabel CantStop = "Can't Stop"
    selectLabel v = tshow v

data GameWithPlayers = GameWithPlayers
    { kit :: Kit
    , players :: [User]
    }
