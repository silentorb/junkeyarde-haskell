module Simulation where

import Commands

type Id = Int

data Resource = Resource {
  value :: Int,
  max :: Int
}

resource value = Resource value value

data Character = Character {
  id' :: Id,
  name :: [Char],
  faction :: Id,
  health :: Resource,
  energy :: Resource
}

data Game = Game {
  turn :: Int,
  characters :: [Character],
  playerId :: Id
}

--player :: Game :: Character
--player = filter

data Attack = Attack {
  attacker :: Id,
  target :: Id,
  amount :: Int
}

heroFaction = 0
enemyFaction = 1

createPlayer id' = (Character id' "Player" heroFaction (resource 10) (resource 10), id' + 1)

newGame nextId =
  let (player, nextId) = createPlayer nextId
  in (Game 1 [player] (id' player), nextId)

--sumBy summer = foldl (+ summer) 0
sumBy accessor = foldl (\acc a -> acc + accessor a) 0

applyAttacksToCharacter :: [Attack] -> Character -> Character
applyAttacksToCharacter attacks character =
  let applicableAttacks = filter (\a -> (id' character) == target a) attacks
  in character {
--    health = (health character) { value = (value (health character)) - foldl (\acc a -> acc + amount a) 0 applicableAttacks }
    health = (health character) { value = (value (health character)) - sumBy (amount) applicableAttacks }
  }

updateGame :: Game -> UserCommand -> Game
updateGame game command =
  game {
    turn = (turn game) + 1
  }
