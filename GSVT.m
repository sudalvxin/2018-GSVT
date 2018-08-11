%% The GSVT
% References:
% @inproceedings{DBLP:conf/aaai/LuZXYL15,
%   author    = {Canyi Lu and
%                Changbo Zhu and
%                Chunyan Xu and
%                Shuicheng Yan and
%                Zhouchen Lin},
%   title     = {Generalized Singular Value Thresholding},
%   booktitle = {Proceedings of the Twenty-Ninth {AAAI} Conference on Artificial Intelligence,
%                January 25-30, 2015, Austin, Texas, {USA.}},
%   pages     = {1805--1811},
% }

function X = GSVT(M,non_f,lambda,gamma)
%% Input:
% lambda: regualraization parameter;
% gamma: the parameter over regularizer;
% non_f: the selection of relaxation function
% non_f=1; ETP
% non_f =2;Geman
% non_f =3;laplace
% non_f =4;log
% non_f =5; Sp
%% Output: X: the shrinked matrix

[U S V] = svd(full(M),'econ');
S = diag(S);
r = gamma;
for i = 1:length(S)
    si = S(i);
    switch non_f
        case 1 % ETP
         sn(i)= FPI_ETP(si,lambda,r);   
        case 2 % Geman
         sn(i)= FPI_Geman(si,lambda,r); 
        case 3 % laplace
         sn(i)= FPI_laplace(si,lambda,r); 
        case 4 % LNN
         sn(i)= FPI_log(si,lambda,r); 
        case 5 % Sp
         sn(i)= FPI_Sp(si,lambda,r); 
    end
end
ind=find (sn>0);
if sn<1;
    X = zeros(size(M));
    disp(['The value of regualrization parameter is too large to shrink all singular values to zero.......'])
else
    svp=length(ind);
    Snew = sn(1:svp);
    X =  U(:,1:svp)*diag(Snew)*V(:,1:svp)';
end
