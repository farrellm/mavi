module Kit.Azul where

import Generated.Types -- (Kit (..))
import IHP.ModelSupport
import Web.Types

data AzulState = AzulState
    { players :: [Id User]
    }
