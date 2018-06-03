{-# LANGUAGE ForeignFunctionInterface #-}
import Data.Char
import Foreign.C.Types
import System.Process
import qualified Data.Map as Map
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

data Character = Character {
  characterId :: Id,
  name :: [Char],
  health :: Resource,
  energy :: Resource
}

data Game = Game {
  turn :: Int,
  characters :: [Character],
  playerId :: Int
}

--player :: Game :: Character
--player = filter

data Attack = Attack {
  attacker :: Int,
  target :: Int,
  amount :: Int
}

data UserCommand =
  CommandQuit |
  CommandAttack
  deriving (Eq, Ord, Show, Read, Bounded, Enum)

data AppMode =
  AppActive |
  AppQuit
  deriving (Eq, Ord, Show, Read, Bounded, Enum)

inputMap = Map.fromList [
    (97, CommandAttack), -- 'a'
    (113, CommandQuit) -- 'q'
  ]

invalidInput :: IO UserCommand
invalidInput = do
  putStrLn "Invalid Input"
  userInput

userInput :: IO UserCommand
userInput = do
  keyPress <- c_getch
  let command = Map.lookup keyPress inputMap
  case command of
    Just n -> return n
    Nothing -> invalidInput

createPlayer id' = (Character id' "Player" (createResource 10) (createResource 10), id' + 1)

newGame nextId =
  let (player, nextId) = createPlayer nextId
  in (Game 1 [player] (characterId player), nextId)

processInput :: Game -> UserCommand -> ([Attack], AppMode)
processInput game CommandAttack = ([()], AppActive)
processInput game CommandQuit = ([], AppQuit)

--sumBy summer = foldl (+ summer) 0

applyAttacksToCharacter :: [Attack] -> Character -> Character
applyAttacksToCharacter attacks character =
  let applicableAttacks = filter (\a -> (characterId character) == target a) attacks
  in character {
    health = (health character) { value = (value (health character)) - foldl (\acc a -> acc + amount a) 0 applicableAttacks }
--    health = (health character) { value = (value (health character)) - sumBy (amount) applicableAttacks }
  }

updateGame :: Game -> [Attack] -> Game
updateGame game attacks =
  game {
    turn = (turn game) + 1
  }

--depictGame :: game
--depictGame game =

gameLoop game nextId = do
  clear
  putStrLn "The JunkeYarde"
  putStrLn ("Turn " ++ (show (turn game)))
  putStrLn "?"
  command <- userInput
  let (attacks, appMode) = processInput game command
  if appMode == AppQuit
  then return ()
  else gameLoop (updateGame game attacks) nextId

main = do
  putStrLn "Welcome to the JunkeYarde"
  let (game, nextId) = newGame 1
  gameLoop game nextId
  putStrLn "Now leaving the JunkeYarde"
