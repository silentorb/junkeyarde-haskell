module GameTypes where

type Id = Int

data Resource = Resource
  { value :: Int
  , max   :: Int
  }

data Character = Character
  { id'     :: Id
  , name    :: String
  , faction :: Id
  , health  :: Resource
  , energy  :: Resource
  }

data Game = Game
  { turn       :: Int
  , characters :: [Character]
  , playerId   :: Id
  }

data Attack = Attack
  { attacker :: Id
  , target   :: Id
  , amount   :: Int
  }
