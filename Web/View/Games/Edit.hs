module Web.View.Games.Edit where

import Web.View.Prelude

data EditView = EditView {game :: Game}

instance View EditView where
    html EditView{..} =
        [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={GamesAction}>Games</a></li>
                <li class="breadcrumb-item active">Edit Game</li>
            </ol>
        </nav>
        <h1>Edit Game</h1>
        {renderForm game}
    |]

renderForm :: Game -> Html
renderForm game =
    formFor
        game
        [hsx|
    {(textField #kit)}
    {submitButton}
|]
