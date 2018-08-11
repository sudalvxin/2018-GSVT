%% Fixed point iteration for solving the following problem
% xn = arg min_{x>0} g_b(x) = f(x) + 0.5*(x-b)^2\,.
% f(x)=mu*(1-exp(-x/r));

function xn = FPI_laplace(b,mu,r)

e = 1e20;
ite =0;
if 1/(b+1) ==0
    disp('b is optimal')
    xn = b;
else
    x = b;
    while ite<10
       ite = ite+1; 
        x = b - mu/(r*(exp(x/r)));    % x = b-dg(x);
        if x<0
            xn = 0;
            break;
        end
        e = x-b + mu/(r*(exp(x/r)));
        if e < 1e-10
            xn = x;
            break;
        end
        xn = x;
    end 
end   

f1 = 0.5*b^2;  % f(0)
f2 = mu*(1-exp(-xn/r)) + 0.5*(xn-b)^2;

if f1 < f2
    xn = 0;
else
    xn = xn;
end