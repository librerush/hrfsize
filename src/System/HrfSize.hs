{-# LANGUAGE ScopedTypeVariables #-}

module System.HrfSize
  ( determineFileSize
  , FileSize(..)
  , convertSize
  ) where

import           Control.Exception
import           System.IO         (FilePath, IOMode (ReadMode), hFileSize,
                                    withBinaryFile)

-- | IEC standard
data FileSize
  = Bytes !Double
  | KiB   !Double
  | MiB   !Double
  | GiB   !Double
  | TiB   !Double
  deriving (Show, Eq, Ord)

convertSize :: Double -> FileSize
convertSize size | size < 1024.0 = Bytes $ trunc size
                 | size < 1024.0 ^ (2 :: Int) =
                   KiB $ trunc $ size / 1024.0
                 | size < 1024.0 ^ (3 :: Int) =
                   MiB $ trunc $ size / 1024.0 ^ (2 :: Int)
                 | size < 1024.0 ^ (4 :: Int) =
                   GiB $ trunc $ size / 1024.0 ^ (3 :: Int)
                 | otherwise =
                   TiB $ trunc $ size / 1024.0 ^ (4 :: Int)
  where
    -- it's crazy method of truncating
    trunc n | length (dropWhile (/= '.') $ show n) > 3 =
      read parsePrecision :: Double
            | otherwise = n
      where
        parsePrecision = let (a, b) = span (/= '.') $ show n in
                             a ++ take 3 b

-- | Determines file's size
determineFileSize :: FilePath
                  -> IO (Maybe FileSize)
determineFileSize pathToFile = do
  fileInt <- try $ withBinaryFile pathToFile ReadMode hFileSize
  case fileInt of
    Left (err :: SomeException) -> pure $ Nothing
    Right r -> do
      let file = fromInteger r :: Double
      pure $ Just $ convertSize file
