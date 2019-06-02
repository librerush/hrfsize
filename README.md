# hrfsize

## Simple Haskell library for determining size of file in human readable format


Example:

```haskell

import System.HrfSize (determineFileSize)

main :: IO ()
main = determineFileSize "/path/to/file" >>= print

```
