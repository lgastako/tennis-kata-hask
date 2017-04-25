module Game ( Game, execute, new ) where

import Data.Char ( toLower )
import System.IO ( hFlush, stdout )

import Action ( Action( Player1Scored
                      , Player2Scored
                      , Quit
                      )
              )
import Player ( Player( Player1, Player2 ) )

data Game = Empty
  deriving (Eq, Ord, Read, Show)

new :: Game
new = Empty

execute :: Game -> IO Game
execute game = do
  if over game
    then return game
    else do putStrLn $ "WE ARE DOING THE THINGS"
            action <- getAction
            putStr $ "action: " ++ show action
            return game -- TODO: finish me

over :: Game -> Bool
over game = False

getAction :: IO Action
getAction = do
  player <- askPlayerOrQuit
  return $ case player of
    Just Player1 -> Player1Scored
    Just Player2 -> Player2Scored
    Nothing      -> Quit

askPlayerOrQuit :: IO (Maybe Player)
askPlayerOrQuit = do
  putStr "Enter (1) or (2) when a player scores, or (Q) to quit >> "
  hFlush stdout
  response <- map toLower <$> getLine
  case response of
    "1"    -> return $ Just Player1
    "2"    -> return $ Just Player2
    "q"    -> return Nothing
    "quit" -> return Nothing
    _      -> askPlayerOrQuit
