classdef NormalModel < Model
	
	properties
	end
	
	methods(Static)
		%% X=U*V'
		function X=getMatrix(U,V)
			X=U*V';
		end
		%% X=U*V 
		%% loss=sum(0.5*(Y-X)^2)
		% calculate loss
		function loss=getLoss(Y,W,U,V)
			l=Y-U*V';
% 			W=Y;
% 			W(W~=0)=1;
			l=l.*W;
			loss=0.5*sum(sum(l.^2));
		end
		%% calculate gradient
		function [gradientU,gradientV] = getGradient(Y,W,U,V)
			X=NormalModel.getMatrix(U,V);
% 			W=Y;
% 			W(W~=0)=1;
% 			gradientU=((X-Y).*W)*V;
% 			gradientV=((X-Y).*W)'*U;
			gradientU=((X-Y))*V;
			gradientV=((X-Y))'*U;
		end
% 		%%
% 		function [U,V] = getRandomFactor(Y,r)
% 			[m n]=size(Y);
% 			avg=mean(mean(M));
% 			U=rand(m,r)*2*sqrt(avg/r);
% 			V=rand(r,n)*2*sqrt(avg/r);
% 		end
	end
	
end

