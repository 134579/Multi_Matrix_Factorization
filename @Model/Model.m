classdef Model
	%UNTITLED Summary of this class goes here
	%   Detailed explanation goes here
	
	properties
	end
	
	methods(Abstract=true,Static)
		%% X=U*V'
		% U must be m*r
		% V must be n*r
		% X must be m*n
		X = getMatrix(U,V);
		loss = getLoss(Y,W,U,V);
		[gradientU,gradientV] = getGradient(Y,W,U,V);
% 		[U,V] = getRandomFactor(M,r);
	end
	
end

