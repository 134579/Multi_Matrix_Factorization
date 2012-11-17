classdef Param
	properties
		iteration; % number of iterations
		R; % size of factor matrix : ..*R
		descentRate; % descent rate used in gradient descent algorithm e.g. 0.001 0.0001
		factorNorm; % array of factor norm type
		normWeight; % regularization weight of each factor 
		logfile; % name of log file
	end
	
	methods
	end
	
end

