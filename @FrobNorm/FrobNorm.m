classdef FrobNorm < Norm
	%FROBNORM Summary of this class goes here
	%   Detailed explanation goes here
	
	properties
	end
	
	methods(Static)
		function norm = getNorm(M)
			a=M.^2;
			norm=0.5*sum(sum(a));
		end
		function gradient = getGradient(M)
			gradient=M;
		end
	end
	
end

