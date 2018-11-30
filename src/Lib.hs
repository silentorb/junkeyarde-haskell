module Lib where

import           Commands
import           Data.Char
import qualified Data.Map        as Map
import           Foreign.C.Types
import           GameTypes
import           Input
import           Simulation
import           System.Process

clear = system "cls"

data AppMode
  = AppActive
  | AppQuit
  deriving (Eq, Ord, Show, Read, Bounded, Enum)

gameLoop game nextId = do
  clear
  putStrLn "The JunkeYarde"
  putStrLn ("Turn " ++ (show (turn game)))
  putStr "Testing\n\nAnd Still testing"
  putStrLn "?"
  command <- userInput
  if command == CommandQuit
    then return ()
    else gameLoop (update game command) nextId

lib = do
  putStrLn "Welcome to the JunkeYarde"
  let (game, nextId) = newGame 1
  gameLoop game nextId
  putStrLn "Now leaving the JunkeYarde"
