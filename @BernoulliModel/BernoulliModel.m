classdef BernoulliModel < Model
	
	properties
	end
	
	methods(Static)
		%% X=1/(1+e^-U*V')
		function X=getMatrix(U,V)
			X=1./(1+exp(-U*V'));
		end
		%% loss = sum(Y*log(Y/X)+(1-Y)log((1-Y)/(1-X)))
		% calculate loss
		function loss=getLoss(Y,W,U,V)
			X=BernoulliModel.getMatrix(U,V);
			t=1-Y;
			error1=Y.*log(Y./X);
			error2=t.*log(t./(1-X));
			error1(isnan(error1))=0;
			error2(isnan(error2))=0;
			error=error1+error2;
% 			W=Y;
% 			W(W~=0)=1;
			error=error.*W;
			loss=sum(sum(error));
		end
		%% calculate gradient
		function [gradientU,gradientV] = getGradient(Y,W,U,V)
			X=BernoulliModel.getMatrix(U,V);
% 			gradientU=(X-Y)*V;
% 			gradientV=(X-Y)'*U;
% 			W=Y;
% 			W(W~=0)=1;
			gradientU=(W.*(X-Y))*V;
			gradientV=(W.*(X-Y))'*U;
		end
		%% get rand factor
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

