import Text.ParserCombinators.ReadP
import System.Environment

data Weight = Kilograms Float | Pounds Float

instance Show Weight where
  show weight = case weight of
    Kilograms x -> show x ++ "kg"
    Pounds x -> show x ++ "lbs"

parseFloat :: ReadP Float
parseFloat = read <$> 
  many1 (satisfy (\c -> digit c || c == '.'))
  where digit c = '0' <= c && c <= '9'

parseUnit :: Float -> ReadP Weight
parseUnit x = option (Kilograms x) $
  (Kilograms x <$ string "kg")
  <++ (Pounds x <$ string "lbs")
  <++ (Pounds x <$ string "lb")

parseWeight :: ReadP Weight
parseWeight = (parseFloat >>= parseUnit) <* eof

convert :: Weight -> Weight
convert weight = case weight of
  Kilograms k -> Pounds (k / conversionRate)
  Pounds p -> Kilograms (p * conversionRate)
  where conversionRate = 0.45359237 -- pounds to kilos

main :: IO ()
main = do
  [arg1] <- getArgs
  case readP_to_S parseWeight arg1 of
    [(weight, _)] -> print (convert weight)
    xs -> print xs
