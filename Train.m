% function [ converge, factors ] = Train( matrixes , R , iteration , descentRate , logfile )
function [ converge, factors ] = Train( matrixes , param )

%% input paramater:
% matrixes : array of type Matrix
% R : size of factor , e.g. 10 20 100 500...
% iteration : iteration times      
% descentRate : descent rate used in gradient descent algorithm e.g. 0.001 0.0001
% logfile : path of logfile 

%% return value
% converge : 1 for converge ,0 for not converged
% factors : array of factor matrix 

%% initilize
iteration=param.iteration;
R=param.R;
descentRate=param.descentRate;
factorNorm=param.factorNorm;
normWeight=param.normWeight;
logfile=param.logfile;



fp=fopen(strcat(logfile,'.txt'),'a');
nFactor=0;		% number of factor
nMatrix=length(matrixes);		% number of matrix
% factors=sym('factors');			% factor matrix 
converge=0;

%% initilize number of factors(number of different dimensions)
for i=1:nMatrix
	if nFactor < matrixes(i).UIdx
		nFactor = matrixes(i).UIdx;
	end	
	if nFactor < matrixes(i).VIdx
		nFactor = matrixes(i).VIdx;
	end
end

if nFactor~=length(normWeight);
	disp('regweight and factors must be same-lengthed');
	return 
end

%% initilize size of factors
sizeFactor=-1*ones(nFactor,1);
for i=1:nMatrix
	[m n]=size(matrixes(i).data);
	if sizeFactor(matrixes(i).UIdx)==-1
		sizeFactor(matrixes(i).UIdx)=m;
	else
		if sizeFactor(matrixes(i).UIdx)~=m
			disp('error!!same dimension in different matrix must be equal')
			return
		end
	end
	if sizeFactor(matrixes(i).VIdx)==-1
		sizeFactor(matrixes(i).VIdx)=n;
	else
		if sizeFactor(matrixes(i).VIdx)~=n
			disp('error!!same dimension in different matrix must be equal')
			return
		end
	end
end

%% initilize random factor matrix
factors = initilizeFactor(sizeFactor,R);

%% begin loop

times=0;
losshis=0; % loss history
% descentRate=0.0001;
while times < iteration
	times=times+1;
% 	descentRate=0.001;
% 	if times<3
% 		descentRate=0.001;
% 	else
% 		if times<50
% 			descentRate=0.001;
% 		else
% 			if times<80
% 				descentRate=0.0005;
% 			else
% 				descentRate=0.00025;
% 			end
% 		end
% 	end

	if times==20 || times==40 || times==60 || times==80 || times==100 || times==120 || times==140 || times==160 || times==180 || times==200
		save(strcat(logfile,strcat((int2str(times)),'.mat')));
	end
		
	%% set descent rate 
	if times>2
		if losshis(times-1)>losshis(times-2)
			descentRate=descentRate*0.8;
		end
		if isnan(losshis(times-1))
			return
		end
	end

	fprintf(1,'%d: rate:%f\n',times,descentRate);
	fprintf(fp,'%d: rate:%f\n',times,descentRate);
	
	%% calculate loss
	loss1=zeros(nMatrix,1);
	for i=1:nMatrix
		uindex=matrixes(i).UIdx;
		vindex=matrixes(i).VIdx;
		loss1(i)=matrixes(i).weight*matrixes(i).getLoss(factors{uindex},factors{vindex});
		fprintf(fp,'%d ',loss1(i));
		fprintf(1,'%d ',loss1(i));
	end
	
	loss2=zeros(nFactor,1);
	for i=1:nFactor
		loss2(i)=normWeight(i)*factorNorm(i).getNorm(factors{i});
		fprintf(fp,'%d ',loss2(i));
		fprintf(1,'%d ',loss2(i));
	end
	
	fprintf(fp,'\n');
	fprintf(1,'\n');
% 	disp(loss);
	losshis(times)=sum(loss1)+sum(loss2);
	
	%% allocate gradient space
	gradient=cell(nFactor,1);
	for i=1:nFactor
		gradient{i}=zeros(sizeFactor(i),R);
	end
	%% calculate gradient 
	for i=1:nMatrix
		uindex=matrixes(i).UIdx;

		vindex=matrixes(i).VIdx;
		[gradientU gradientV]=matrixes(i).getGradient(factors{uindex},factors{vindex});
		gradient{uindex}=gradient{uindex}+matrixes(i).weight*gradientU;
		fprintf(1,'%d:matrix %d gradU:%d\n',uindex,i,norm(matrixes(i).weight*gradientU));
		fprintf(fp,'%d:matrix %d gradU:%d\n',uindex,i,norm(matrixes(i).weight*gradientU));
		gradient{vindex}=gradient{vindex}+matrixes(i).weight*gradientV;
		fprintf(1,'%d:matrix %d gradV:%d\n',vindex,i,norm(matrixes(i).weight*gradientV));
		fprintf(fp,'%d:matrix %d gradV:%d\n',vindex,i,norm(matrixes(i).weight*gradientV));
	end 
	
	% gradient of norm
	for i=1:nFactor
		grad=factorNorm(i).getGradient(factors{i});
		gradient{i}=gradient{i}+normWeight(i)*grad;
		
		fprintf(1,'factor %d grad:%d\n',i,norm(normWeight(i)*grad));
		fprintf(fp,'factor %d grad:%d\n',i,norm(normWeight(i)*grad));
	end
	%% update factor matrix
	for i=1:nFactor
		factors{i}=factors{i}-descentRate*gradient{i};
	end
end

fclose(fp);
converge=1;
end



