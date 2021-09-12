module Web.View.Games.New where

import Web.View.Prelude

data NewView = NewView { game :: Game, friends :: [User] }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={GamesAction}>Games</a></li>
                <li class="breadcrumb-item active">New Game</li>
            </ol>
        </nav>
        <h1>New Game</h1>
        {renderForm game friends}
        <script>
          new SlimSelect({select: '#game_players'})
        </script>
    |]

renderForm :: (?context :: ControllerContext) => Game -> [User] -> Html
renderForm game friends = do
  formFor' game (pathTo CreateGameAction) [hsx|
    {(selectField #kit (allEnumValues @Kit))}
    <label>Players</label>
    <div class="form-group" id="form-group-game_players">
      <select name="players" id="game_players" class="form-control" multiple style="padding: 0; border: none">
        {forEach friends renderUserOption}
      </select>
    </div>
    {submitButton}
|]


renderUserOption :: (?context :: ControllerContext) => User -> Html
renderUserOption user
  | get #id user == get #id currentUser =[hsx|
  <option value={get #id user |> tshow} selected data-mandatory="true">{get #username user}</option>
|]
  | otherwise = [hsx|
  <option value={get #id user |> tshow}>{get #username user}</option>
|]

forCurrent :: (?context :: ControllerContext) => User -> Text
forCurrent u
  | get #id u == get #id currentUser = [hsx||]
  | otherwise = [hsx||]
