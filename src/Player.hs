module Player ( Player(..) ) where

data Player
  = Player1
  | Player2
  deriving (Eq, Ord, Read, Show)
