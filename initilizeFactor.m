function [ factors ] = initilizeFactor( sizeFactor,R,randfun )
if nargin<3
	randfun=@randn;
end

N=length(sizeFactor);
factors=cell(N,1);
for i=1:N
	factors{i}=randfun(sizeFactor(i),R);
% 	factors{i}=factors{i}/norm(factors{i});
	for j=1:R
		factors{i}(:,j)=factors{i}(:,j)/norm(factors{i}(:,j));
	end
end

for i=1:N
% 	factors{i}=(-0.001/2)*ones(sizeFactor(i),R)+0.001*rand(sizeFactor(i),R);
end

% for i=1:N
% 	factors{i}=sqrt(4*0.17823/R)*rand(sizeFactor(i),R);
% end


end

