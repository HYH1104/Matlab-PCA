function [y,stf,ind]=zhuchengfenfenxi(img)
[h,l]=size(img);
gj=reshape(img,[h*l,1]);
gj=zscore(gj); %���ݱ�׼��
r=corrcoef(gj); %�������ϵ������
%�����������ϵ������������ɷַ�����x����Ϊr�����������������ɷֵ�ϵ�� 
[x,y,z]=pcacov(r); %yΪr������ֵ��zΪ�������ɷֵĹ����� 
f=repmat(sign(sum(x)),size(x,1),1); %������xͬά����Ԫ��Ϊ��1�ľ��� 
x=x.*f; %�޸����������������ţ�ÿ�����������������з����͵ķ��ź���ֵ 
num=6; %numΪѡȡ�����ɷֵĸ���
df=gj*x(:,1:num); %����������ɷֵĵ÷� 
tf=df*z(1:num)/100; %�����ۺϵ÷� 
[stf,ind]=sort(tf,'descend'); %�ѵ÷ְ��մӸߵ��͵Ĵ������� 
stf=stf'; ind=ind';

