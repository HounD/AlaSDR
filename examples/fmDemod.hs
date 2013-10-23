
import Data.Array.Accelerate as Acc
import Data.Array.Accelerate.Math.Complex as Acc
import Data.Array.Accelerate.CUDA as CUDA

import Data.ByteString.Lazy as BL

import AlaSDR.Modem.Analog.QuadratureDetector as SDR
import AlaSDR.Src.ByteString
		

processAcc :: Array DIM1 (Complex Float) -> Acc (Array DIM1 Float)
processAcc zs
	= let
		zs' = use zs
	in SDR.quadratureDetector zs'

main :: IO ()
main = do
	input <- BL.getContents
	let zs = listComplexF32be input
	let zs' = Acc.fromList (Z:.1000000) zs :: Array DIM1 (Complex Float)
	print (CUDA.run (processAcc zs'))
