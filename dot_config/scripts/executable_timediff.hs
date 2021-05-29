import Text.Parsec

type Parser a = Parsec String () a
data TimeZone = UTC Int

($>) :: Functor f => f a -> b -> f b
fa $> b = fmap (const b) fa

parseInt :: Parser Int
parseInt = do
  sign <- option 1 (char '-' $> (-1))
  number <- read <$> many1 digit
  pure (sign * number)

timeZone :: Parser TimeZone
timeZone = utc
  where
    utc = "UTC" *> (UTC <$> parseInt)

main :: IO ()
main = pure ()
