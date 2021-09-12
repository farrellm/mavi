module Web.View.Games.Index where

import Web.View.Prelude

data IndexView = IndexView {games :: [Include "players" Game], users :: [User]}

instance View IndexView where
    html IndexView{..} =
        [hsx|
        <h1><a href={pathTo NewGameAction} class="btn btn-primary ml-1">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Game</th>
                        <th>Players</th>
                    </tr>
                </thead>
                <tbody>{forEach games (renderGame users)}</tbody>
            </table>
        </div>
    |]

renderGame :: [User] -> Include "players" Game -> Html
renderGame users game =
    let isPlayer u = elem (get #id u) (get #userId <$> get #players game)
        players = filter isPlayer users
     in [hsx|
    <tr>
        <td><a class="btn btn-info" href={ShowGameAction (get #id game)}>{get #kit game}</a></td>
        <td style="vertical-align: middle;">{forEach players renderPlayer}</td>
    </tr>
|]

renderPlayer :: User -> Html
renderPlayer user =
    [hsx| <div class="btn btn-secondary btn-sm ml-1 disabled">{get #username user}</div> |]
