
module AlaSDR.Src.ByteString (

	listComplexF32be

) where

--http://www.haskell.org/haskellwiki/Dealing_with_binary_data
--http://stackoverflow.com/questions/16119184/lazy-binary-get

import Prelude as P
import Data.ByteString.Lazy as BL
import Data.Binary.Get
import Data.Binary.IEEE754
import Data.Array.Accelerate.Math.Complex

getComplexF32be :: Get (Complex Float)
getComplexF32be = do
	re <- getFloat32be
	im <- getFloat32be
	return (re, im)

listComplexF32be :: BL.ByteString -> [(Complex Float)]
listComplexF32be input
   | BL.null input = []
   | otherwise =
      let (w, rest, _) = runGetState getComplexF32be input 0
      in w : listComplexF32be rest

--main :: IO ()
--main = do
--    input <- BL.getContents
--    let zs = listComplexF32be input
--    print (P.take 10 zs)
