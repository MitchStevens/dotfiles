data Color = Color Int Int Int
instance Show Color where
  show (Color r g b) = "#" <> showHex r <> showHex g <> showHex b

type Parser = Parsec ByteString ()

defaultColors :: Map String Color
defaultColors = M.fromList
  [ ("black",   Color 0x00 0x00 0x00)
  , ("red",     Color 0xff 0x00 0x00)
  , ("blue",    Color 0x00 0x00 0xff)
  , ("green",   Color 0x00 0xff 0x00)
  , ("yellow",  Color 0xff 0xff 0x00)
  , ("cyan",    Color 0x00 0xff 0xff)
  , ("magenta", Color 0xff 0x00 0xff)
  , ("white",   Color 0xff 0xff 0xff)
  ]

dist :: Color -> Color -> Int
dist (r1, g1, b1) (r2, g2, b2) = (r1-r2)^2 + (g1-g2)^2 + (b1-b2)^2

parseColor :: Parser Color
parseColor =
  char '#' *> (,,) <$> hex <*> hex <*> hex
  where
    hex = do
      c1 <- digitToInt <$> anyChar
      c2 <- digitToInt <$> anyChar
      pure $ c3 * 16 + c2

getClosest :: Foldable f => f Color -> Color -> Color
getClosest colors c = minimumBy (comparing (dist c)) colors

themeColors :: IO [Color]
themeColors = do
  let rawString = "#232323 #d2813d #96a42d #a8a030 #8e9cc0 #d58888 #7aa880 #aeadaf #8c9e3d #b1942b #6e9cb0 #b58d88 #6da280 #949d9f #312e30 #d0913d"
  let Right colors = runParser (color `sepBy` char ' ') () "" rawString
  pure colors

substituteLine :: Foldable f => f Color -> ByteString -> ByteString
substituteLine colors str = fromRight "" . B.concat $
  parse (many (convertColor <|> anyChar')) "" str
  where
    convertColor :: Parser ByteString
    convertColor = do
      color <- parseColor
      pure . B.pack . show $ getClosest colors color

    nonColor :: Parser ByteString
    nonColor = pure ""

    anyChar' :: Parser ByteString
    anyChar' = singleton <$> anyChar


main :: IO ()
main = do
  colors <- themeColors
  B.interact (substituteLine colo)


