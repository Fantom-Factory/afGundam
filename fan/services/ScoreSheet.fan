
@Js @NoDoc
class ScoreSheet {
	
	Int score

	static const Int droneHit				:=  200
	static const Int droneDestroyed 		:=  400
	
	static const Int asteroid32Hit 			:=  200 
	static const Int asteroid32Destroyed 	:=  300 
	static const Int asteroid64Hit 			:=  150 
	static const Int asteroid64Destroyed 	:=  400 
	static const Int asteroid96Hit 			:=  100 
	static const Int asteroid96Destroyed 	:=  500
	
	static const Int spikyPodHit		 	:=  300 
	static const Int spikyPodDestroyed	 	:=  600 
	static const Int podSpikeDestroyed	 	:=  400
	
	static const Int fatPodHit 				:=  500 
	static const Int fatPodDestroyed 		:= 3000 
	static const Int fatPodSporeDestroyed	:=  150
	
	static const Int powerUpHit 			:=  200 
	static const Int powerUpCollected		:=  500 
	
	
	
	Void reset() {
		score = 0
	}
	
	Void add(Int toAdd) {
		score += toAdd
	}	
}
