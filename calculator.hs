-- Define a data type for arithmetic expressions
data Expr = Val Int | Add Expr Expr | Sub Expr Expr | Mul Expr Expr | Div Expr Expr

-- Evaluate an arithmetic expression
eval :: Expr -> Int
eval (Val n) = n
eval (Add e1 e2) = eval e1 + eval e2
eval (Sub e1 e2) = eval e1 - eval e2
eval (Mul e1 e2) = eval e1 * eval e2
eval (Div e1 e2) = eval e1 `div` eval e2  -- Perform integer division

-- Parse an arithmetic expression from a string
parseExpr :: String -> Expr
parseExpr = go . words
  where
    go ["+"] = Add (Val 0) (Val 0)
    go ["-"] = Sub (Val 0) (Val 0)
    go ["*"] = Mul (Val 0) (Val 0)
    go ["/"] = Div (Val 0) (Val 0)
    go [n] = Val (read n)
    go (x:"+":y:xs) = Add (Val (read x)) (go (y:xs))
    go (x:"-":y:xs) = Sub (Val (read x)) (go (y:xs))
    go (x:"*":y:xs) = Mul (Val (read x)) (go (y:xs))
    go (x:"/":y:xs) = Div (Val (read x)) (go (y:xs))

main :: IO ()
main = do
    putStrLn "Enter an arithmetic expression (e.g., 2 + 3 * 4):"
    input <- getLine
    let expr = parseExpr input
    putStrLn $ "Result: " ++ show (eval expr)
