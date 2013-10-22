
module AlaSDR.Modem.Analog.QuadratureDetector (

	quadratureDetector

) where

import Data.Array.Accelerate as Acc
import Data.Array.Accelerate.Math.Complex as Acc

productConj :: Acc (Array DIM1 (Complex Float)) -> Acc (Array DIM1 (Complex Float))
productConj zs =
	Acc.zipWith (*) 
		zs
		(Acc.map Acc.conj (Acc.tail zs))


quadratureDetector :: Acc (Array DIM1 (Complex Float)) -> Acc (Array DIM1 Float)
quadratureDetector zs 
	= Acc.map Acc.phase (productConj zs)
