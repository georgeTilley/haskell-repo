import System.Random

data Move = Rock | Paper | Scissors deriving (Show, Eq)

instance Enum Move where
  fromEnum Rock = 0
  fromEnum Paper = 1
  fromEnum Scissors = 2
  toEnum 0 = Rock
  toEnum 1 = Paper
  toEnum 2 = Scissors

beats :: Move -> Move -> Bool
beats Rock Scissors = True
beats Paper Rock = True
beats Scissors Paper = True
beats _ _ = False

getPlayerMove :: IO Move
getPlayerMove = do
  putStrLn "Enter your move (rock, paper, or scissors):"
  input <- getLine
  case input of
    "rock" -> return Rock
    "paper" -> return Paper
    "scissors" -> return Scissors
    _ -> do
      putStrLn "Invalid move. Please try again."
      getPlayerMove

getComputerMove :: IO Move
getComputerMove = toEnum <$> randomRIO (0, 2)

playRound :: Move -> Move -> IO ()
playRound playerMove computerMove = do
  putStrLn $ "You chose: " ++ show playerMove
  putStrLn $ "Computer chose: " ++ show computerMove
  if playerMove `beats` computerMove
    then putStrLn "You win!"
    else if computerMove `beats` playerMove
      then putStrLn "Computer wins!"
      else putStrLn "It's a tie!"

main :: IO ()
main = do
  putStrLn "Welcome to Rock, Paper, Scissors!"
  playerMove <- getPlayerMove
  computerMove <- getComputerMove
  playRound playerMove computerMove
