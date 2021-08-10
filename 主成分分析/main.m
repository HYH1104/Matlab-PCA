warning off
imgsize=[300 300];
[fn,pn,~]=uigetfile('*.*','选择图片');%选择图片
imgA=imread([pn,fn]);%读取原始图像
img1 = imresize(imgA,imgsize, 'bilinear');%双线性插值方法改变图片大小
img1=rgb2gray(img1);%彩色图像装化为灰度值图像
img1=im2double(img1);%彩色图像装化为二值图像
[h,l]=size(img1);
gj=reshape(img1,[h*l,1]);
gj=zscore(gj); %数据标准化
r=corrcoef(gj); %计算相关系数矩阵
%下面利用相关系数矩阵进行主成分分析，x的列为r的特征向量，即主成分的系数 
[x,~,z]=pcacov(r); %y为r的特征值，z为各个主成分的贡献率 
f=repmat(sign(sum(x)),size(x,1),1); %构造与x同维数的元素为±1的矩阵 
x=x.*f; %修改特征向量的正负号，每个特征向量乘以所有分量和的符号函数值 
df=gj*x(:,1); %计算各个主成分的得分 
tf=df*z(1)/100; %计算综合得分 
% [stf,ind]=sort(tf,'descend'); %把得分按照从高到低的次序排列 

[fn,pn,fi]=uigetfile('*.*','选择图片');%选择图片
imgB=imread([pn,fn]);%读取原始图像
img2 = imresize(imgB,imgsize, 'bilinear');%双线性插值方法改变图片大小
img2=rgb2gray(img2);%彩色图像装化为灰度值图像
img2=im2double(img2);%彩色图像装化为二值图像
[h,l]=size(img2);
gj=reshape(img2,[h*l,1]);
gj=zscore(gj); %数据标准化
r=corrcoef(gj); %计算相关系数矩阵
%下面利用相关系数矩阵进行主成分分析，x的列为r的特征向量，即主成分的系数 
[x,y,z]=pcacov(r); %y为r的特征值，z为各个主成分的贡献率 
f=repmat(sign(sum(x)),size(x,1),1); %构造与x同维数的元素为±1的矩阵 
x=x.*f; %修改特征向量的正负号，每个特征向量乘以所有分量和的符号函数值 
df=gj*x(:,1); %计算各个主成分的得分 
tf1=df*z(1)/100; %计算综合得分
for i=1:h*l
xsd=norm(abs(log(tf(i,1)))-abs(log(tf1(i,1)))); %与训练样本进行匹配
end
figure
subplot(121), imshow(imgA, []);title('第一次所选图片')%显示近似系数
subplot(122), imshow(imgB, []);title('第二次所选图片')%显示水平细节分量
fprintf("两次所选图片误差为：%d\n",xsd);