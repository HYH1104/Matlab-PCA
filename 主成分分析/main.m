warning off
imgsize=[300 300];
[fn,pn,~]=uigetfile('*.*','ѡ��ͼƬ');%ѡ��ͼƬ
imgA=imread([pn,fn]);%��ȡԭʼͼ��
img1 = imresize(imgA,imgsize, 'bilinear');%˫���Բ�ֵ�����ı�ͼƬ��С
img1=rgb2gray(img1);%��ɫͼ��װ��Ϊ�Ҷ�ֵͼ��
img1=im2double(img1);%��ɫͼ��װ��Ϊ��ֵͼ��
[h,l]=size(img1);
gj=reshape(img1,[h*l,1]);
gj=zscore(gj); %���ݱ�׼��
r=corrcoef(gj); %�������ϵ������
%�����������ϵ������������ɷַ�����x����Ϊr�����������������ɷֵ�ϵ�� 
[x,~,z]=pcacov(r); %yΪr������ֵ��zΪ�������ɷֵĹ����� 
f=repmat(sign(sum(x)),size(x,1),1); %������xͬά����Ԫ��Ϊ��1�ľ��� 
x=x.*f; %�޸����������������ţ�ÿ�����������������з����͵ķ��ź���ֵ 
df=gj*x(:,1); %����������ɷֵĵ÷� 
tf=df*z(1)/100; %�����ۺϵ÷� 
% [stf,ind]=sort(tf,'descend'); %�ѵ÷ְ��մӸߵ��͵Ĵ������� 

[fn,pn,fi]=uigetfile('*.*','ѡ��ͼƬ');%ѡ��ͼƬ
imgB=imread([pn,fn]);%��ȡԭʼͼ��
img2 = imresize(imgB,imgsize, 'bilinear');%˫���Բ�ֵ�����ı�ͼƬ��С
img2=rgb2gray(img2);%��ɫͼ��װ��Ϊ�Ҷ�ֵͼ��
img2=im2double(img2);%��ɫͼ��װ��Ϊ��ֵͼ��
[h,l]=size(img2);
gj=reshape(img2,[h*l,1]);
gj=zscore(gj); %���ݱ�׼��
r=corrcoef(gj); %�������ϵ������
%�����������ϵ������������ɷַ�����x����Ϊr�����������������ɷֵ�ϵ�� 
[x,y,z]=pcacov(r); %yΪr������ֵ��zΪ�������ɷֵĹ����� 
f=repmat(sign(sum(x)),size(x,1),1); %������xͬά����Ԫ��Ϊ��1�ľ��� 
x=x.*f; %�޸����������������ţ�ÿ�����������������з����͵ķ��ź���ֵ 
df=gj*x(:,1); %����������ɷֵĵ÷� 
tf1=df*z(1)/100; %�����ۺϵ÷�
for i=1:h*l
xsd=norm(abs(log(tf(i,1)))-abs(log(tf1(i,1)))); %��ѵ����������ƥ��
end
figure
subplot(121), imshow(imgA, []);title('��һ����ѡͼƬ')%��ʾ����ϵ��
subplot(122), imshow(imgB, []);title('�ڶ�����ѡͼƬ')%��ʾˮƽϸ�ڷ���
fprintf("������ѡͼƬ���Ϊ��%d\n",xsd);