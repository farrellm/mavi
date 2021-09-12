module Web.View.Games.Show where

import Web.View.Prelude

data ShowView = ShowView {game :: Game}

instance View ShowView where
    html ShowView{..} =
        [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={GamesAction}>Games</a></li>
                <li class="breadcrumb-item active">Show Game</li>
            </ol>
        </nav>
        <h1>Show Game</h1>
        <p>{game}</p>
    |]
