function [ loss1,loss2,rmse ] = Test( file )

% clear;
load(file);
load('binarymovielen');
loss1=BernoulliModel.getLoss(train,train~=0,factors{4},factors{2});
loss2=BernoulliModel.getLoss(test,test~=0,factors{4},factors{2});

trainMatrix=BernoulliModel.getMatrix(factors{4},factors{2});
% trainMatrix=round(trainMatrix);
[m n]=size(trainMatrix);

num=sum(sum(test~=0));
num1=0;
s=0;

for i=1:m
	for j=1:n
		if test(i,j)~=0
			if test(i,j)~=0
				s=s+(trainMatrix(i,j)-test(i,j)).^2;
				num1=num1+1;
			end
		end
	end
end

rmse=sqrt(s/num);

end

