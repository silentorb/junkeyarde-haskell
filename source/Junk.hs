{-# LANGUAGE ForeignFunctionInterface #-}
import Data.Char
import Foreign.C.Types
import System.Process
getHiddenChar = fmap (chr.fromEnum) c_getch
foreign import ccall unsafe "conio.h getch"
  c_getch :: IO CInt

clear = system "cls"

type Id = Int

data Resource = Resource {
  value :: Int,
  max :: Int
}

createResource value = Resource value value

data Creature = Creature {
  creatureId :: Id,
  name :: [Char],
  health :: Resource,
  energy :: Resource
}

data Game = Game {
  turn :: Int,
  creatures :: [Creature],
  player :: Int
}

createPlayer `id = Creature `id "Player" (createResource 10) (createResource 10)

newGame nextId =
  let (player, nextId) = createPlayer nextId
  in (Game 1 [player] (creatureId player), nextId + 1)

gameLoop game nextId = do
  clear
  putStrLn "The JunkeYarde"
  putStrLn "?"
  command <- c_getch
  if command == 113 -- 'q'
  then putStrLn "Now leaving the JunkeYarde"
  else gameLoop game nextId

main = do
  putStrLn "Welcome to the JunkeYarde"
  let (game, nextId) = newGame 1
  gameLoop game nextId
