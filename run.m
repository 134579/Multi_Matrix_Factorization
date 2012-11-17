clear;
load binarymovielen;
result=fopen('result.txt','a');
% matrix(1)=Matrix(train,(train~=0),PoissonModel,[1 2]);
% matrix(1)=Matrix(moviekey,1,BernoulliModel,[1 2]);
% matrix(1)=Matrix(train,(train~=0),NormalModel,[1 2]);

%%


weight=[1 0.1 5 10];

matrix(1)=Matrix(moviegenre,1,BernoulliModel,[1 2]);
matrix(2)=Matrix(moviekey,1,BernoulliModel,[3 2]);
matrix(3)=Matrix(userprofile,1,BernoulliModel,[4 5]);
matrix(4)=Matrix(train,(train~=0),BernoulliModel,[4 2]);

for k=1:4
	matrix(k).weight=weight(k);
end

w=[0.1 10];

% for i=1:5
% 	for j=1:2
		param=Param();
		param.iteration=203;
		param.R=10;
		param.descentRate=0.0015;
		param.factorNorm=[FrobNorm FrobNorm FrobNorm FrobNorm FrobNorm];
% 		normWeight=[1 1 1 1 1];
% 		normWeight(i)=w(j);
		normWeight=[10 10 10 10 10];
		param.normWeight=normWeight;
		file=mat2str(normWeight);
		param.logfile=file;

		success=Train(matrix,param);
% 		success=1;
		if success==1
			fprintf(result,'%s %d\n',file,param.R);
			[loss1,loss2,rmse]=Test(strcat(file,'20.mat'));
			fprintf(result,'20:%f %f %d\n',loss1,loss2,rmse);
			[loss1,loss2,rmse]=Test(strcat(file,'40.mat'));
			fprintf(result,'40:%f %f %d\n',loss1,loss2,rmse);
			[loss1,loss2,rmse]=Test(strcat(file,'60.mat'));
			fprintf(result,'60:%f %f %d\n',loss1,loss2,rmse);
			[loss1,loss2,rmse]=Test(strcat(file,'80.mat'));
			fprintf(result,'80:%f %f %d\n',loss1,loss2,rmse);
			[loss1,loss2,rmse]=Test(strcat(file,'100.mat'));
			fprintf(result,'100:%f %f %d\n',loss1,loss2,rmse);
			[loss1,loss2,rmse]=Test(strcat(file,'120.mat'));
			fprintf(result,'120:%f %f %d\n',loss1,loss2,rmse);
			[loss1,loss2,rmse]=Test(strcat(file,'140.mat'));
			fprintf(result,'140:%f %f %d\n',loss1,loss2,rmse);
			[loss1,loss2,rmse]=Test(strcat(file,'160.mat'));
			fprintf(result,'160:%f %f %d\n',loss1,loss2,rmse);
			[loss1,loss2,rmse]=Test(strcat(file,'180.mat'));
			fprintf(result,'180:%f %f %d\n',loss1,loss2,rmse);
			[loss1,loss2,rmse]=Test(strcat(file,'200.mat'));
			fprintf(result,'200:%f %f %d\n',loss1,loss2,rmse);
		end
% 	end
% end
fclose(result);

% %% single
% weight=1;
% 
% matrix(1)=Matrix(train,(train~=0),PoissonModel,[1 2]);
% matrix(1).weight=weight;
% 
% % for i=1:5
% % 	for j=1:2
% 		param=Param();
% 		param.iteration=203;
% 		param.R=10;
% 		param.descentRate=0.001;
% 		param.factorNorm=[FrobNorm FrobNorm];
% % 		normWeight=[1 1 1 1 1];
% % 		normWeight(i)=w(j);
% 		normWeight=[10 10];
% 		param.normWeight=normWeight;
% 		file=mat2str(normWeight);
% 		param.logfile=file;
% 
% 		success=Train(matrix,param);
% 		if success==1
% 			fprintf(result,'%s %d\n',file,param.R);
% 			[loss1,loss2,rmse]=Test(strcat(file,'20.mat'));
% 			fprintf(result,'20:%f %f %d\n',loss1,loss2,rmse);
% 			[loss1,loss2,rmse]=Test(strcat(file,'40.mat'));
% 			fprintf(result,'40:%f %f %d\n',loss1,loss2,rmse);
% 			[loss1,loss2,rmse]=Test(strcat(file,'60.mat'));
% 			fprintf(result,'60:%f %f %d\n',loss1,loss2,rmse);
% 			[loss1,loss2,rmse]=Test(strcat(file,'80.mat'));
% 			fprintf(result,'80:%f %f %d\n',loss1,loss2,rmse);
% 			[loss1,loss2,rmse]=Test(strcat(file,'100.mat'));
% 			fprintf(result,'100:%f %f %d\n',loss1,loss2,rmse);
% 			[loss1,loss2,rmse]=Test(strcat(file,'120.mat'));
% 			fprintf(result,'120:%f %f %d\n',loss1,loss2,rmse);
% 			[loss1,loss2,rmse]=Test(strcat(file,'140.mat'));
% 			fprintf(result,'140:%f %f %d\n',loss1,loss2,rmse);
% 			[loss1,loss2,rmse]=Test(strcat(file,'160.mat'));
% 			fprintf(result,'160:%f %f %d\n',loss1,loss2,rmse);
% 			[loss1,loss2,rmse]=Test(strcat(file,'180.mat'));
% 			fprintf(result,'180:%f %f %d\n',loss1,loss2,rmse);
% 			[loss1,loss2,rmse]=Test(strcat(file,'200.mat'));
% 			fprintf(result,'200:%f %f %d\n',loss1,loss2,rmse);
% 		end
% % 	end
% % end
% fclose(result);
%%
% 
% weight(:,:)=[1 1 1 1];
% for i=1:4
% 	for j=1:4
% 		if i==1 && j==1
% 			continue;
% 		end
% 		weight=[1 1 1 1];
% 		weight(i)=w(j);
% 		
% 		matrix(1)=Matrix(moviegenre,1,BernoulliModel,[1 2]);
% 		matrix(2)=Matrix(moviekey,1,BernoulliModel,[3 2]);
% 		matrix(3)=Matrix(userprofile,1,BernoulliModel,[4 5]);
% 		matrix(4)=Matrix(train,(train~=0),PoissonModel,[4 2]);
% 		for k=1:4
% 			matrix(k).weight=weight(k);
% 		end
% 		file=mat2str(weight);
% 		success=Train(matrix,500,210,0.0002/norm(weight),file);
% 		if success==1
% 			fprintf(result,'%s\n',file);
% 			[loss1,loss2,loss3]=Test(strcat(file,'50.mat'));
% 			fprintf(result,'%f %f %d\n',loss1,loss2,loss3);
% 			[loss1,loss2,loss3]=Test(strcat(file,'100.mat'));
% 			fprintf(result,'%f %f %d\n',loss1,loss2,loss3);
% 			[loss1,loss2,loss3]=Test(strcat(file,'150.mat'));
% 			fprintf(result,'%f %f %d\n',loss1,loss2,loss3);
% 			[loss1,loss2,loss3]=Test(strcat(file,'200.mat'));
% 			fprintf(result,'%f %f %d\n',loss1,loss2,loss3);
% 		end
% 	end
% end
% fclose(result);
