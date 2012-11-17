classdef Norm
	properties
	end
	
	methods(Abstract=true,Static)
		norm = getNorm(M);
		gradient = getGradient(M);
	end
end

