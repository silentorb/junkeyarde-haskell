{-# LANGUAGE ForeignFunctionInterface #-}
import Data.Char
import Foreign.C.Types
import System.Process
getHiddenChar = fmap (chr.fromEnum) c_getch
foreign import ccall unsafe "conio.h getch"
  c_getch :: IO CInt

clear = system "cls"

data Id = Int

data Resource = Resource {
  value :: Int
  max :: Int
}

data Creature = Creature {
  id :: Id
  name :: [Char]
  health :: Resource
  energy :: Resource
}

data Game = Game {
  turn :: Int
  creature :: [Creature]
  player :: Int
}

create_creature
create_player = create_creature

new_game = Game 1 [create_player]
update_game previous =
game_loop = do
  clear
  putStrLn "The JunkeYarde"
  putStrLn "?"
  command <- c_getch
  if command == 113
  then putStrLn "Now leaving the JunkeYarde"
  else game_loop

main = do
  putStrLn "Welcome to the JunkeYarde"
  game_loop
