module Action ( Action(..) ) where

data Action
  = Player1Scored
  | Player2Scored
  | Quit
  deriving (Eq, Ord, Read, Show)
