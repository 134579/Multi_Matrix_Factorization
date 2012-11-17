classdef PoissonModel < Model
	
	properties
	end
	
	methods(Static)
		%% X=e^(U*V')
		function X=getMatrix(U,V)
			X=exp(U*V');
		end
		%% X=e^(U*V')
		%% loss=sum(Y*ln(Y/X)-Y+X)
		% calculate loss
		function loss=getLoss(Y,W,U,V)
% 			W=Y;
% 			W(W~=0)=1;
			X=PoissonModel.getMatrix(U,V);
			error1=Y.*log(Y./X);
			error1(isnan(error1))=0;
			error2=-Y+X;
			error=error1+error2;
 			error=error.*W;
			loss=sum(sum(error));
		end
		%% calculate gradient
		%% X=e^(U*V)
		%% gradientU=(X-Y)*V'
		%% gradientV=U'*(X-Y)
		function [gradientU,gradientV] = getGradient(Y,W,U,V)
			X=PoissonModel.getMatrix(U,V);
% 			W=Y;
% 			W(W~=0)=1;
			gradientU=(W.*(X-Y))*V;
			gradientV=(W.*(X-Y))'*U;
		end
% 		%% get rand factor
% 		function [U,V] = getRandomFactor(Y,r)
% 			[m n]=size(Y);
% 			logY=log(Y);
% 			logY(loy<0)=0;
% 			avg=mean(mean(logY));
% 			U=rand(m,r)*2*sqrt(avg/r);
% 			V=rand(r,n)*2*sqrt(avg/r);
% 		end
	end
	
end

