# hrfsize

## Simple Haskell library for determining size of file in human readable format

[![Hackage](https://img.shields.io/hackage/v/hrfsize.svg?style=plastic)](https://hackage.haskell.org/package/hrfsize)

Example:

```haskell

import System.HrfSize (determineFileSize)

main :: IO ()
main = determineFileSize "/path/to/file" >>= print

```

## TODOs
- determine size of directories
