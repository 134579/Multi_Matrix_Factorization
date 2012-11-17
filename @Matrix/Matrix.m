classdef Matrix
	
	properties
		% M=f(U*V')
		data		  % matrix data itself
		weight        % weight for loss 
		weightMatrix  % weight matrix for whether ignoring 0 elements in data matrix
		distributionModel
		UIdx		  % index of U
		VIdx		  % index of V
	end
	
	methods
		function obj=Matrix(M,W,model,factorIdx)
			obj.data=M;
			obj.weightMatrix=W;
			obj.distributionModel=model;
			obj.UIdx=factorIdx(1);
			obj.VIdx=factorIdx(2);
			obj.weight=1;
		end
		
		function loss=getLoss(obj,U,V)
			loss=obj.distributionModel.getLoss(obj.data,obj.weightMatrix,U,V);
		end
		
		function [gradientU,gradientV] = getGradient(obj,U,V)
			[gradientU,gradientV] = obj.distributionModel.getGradient(obj.data,obj.weightMatrix,U,V);
		end
		
	end
	
end

