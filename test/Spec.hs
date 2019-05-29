import           System.HrfSize
import           Test.Tasty
import           Test.Tasty.HUnit

main :: IO ()
main = do
  f1 <- determineFileSize "/tmp/file1"
  f2 <- determineFileSize "/tmp/file2"
  defaultMain (tests [f1, f2])

-- | Creating files using
-- `head -c size /dev/urandom > /tmp/fileN`
tests :: [FileSize] -> TestTree
tests files = testGroup "determineFileSize"
  [ testCase "file1" $
      MiB 1.95 @?= head files
  , testCase "file2" $
      Bytes 99.0 @?= head (tail files)
  ]
