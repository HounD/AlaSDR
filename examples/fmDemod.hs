
import Data.Array.Accelerate as Acc
import Data.Array.Accelerate.Math.Complex as Acc
import Data.Array.Accelerate.CUDA as CUDA

import AlaSDR.Modem.Analog.QuadratureDetector as SDR
		

processAcc :: Array DIM1 (Complex Float) -> Acc (Array DIM1 Float)
processAcc zs
	= let
		zs' = use zs
	in SDR.quadratureDetector zs'

main :: IO ()
main = do 	
	let z = Acc.fromList (Z:.4) [(1.0,1.0), (1.0,1.0), (1.0,1.0), (1.0,1.0)] :: Array DIM1 (Complex Float)
	print (CUDA.run (processAcc z))
