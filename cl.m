clear
x = -5:0.1:5;
f = @(x) 1+(1+sin(x)-cos(x)).^2-(sin(2*x)-cos(2*x)-0.2).^2;
df = @(x) 2*(1+sin(x)-cos(x)).*(cos(x)+sin(x))-4*(sin(2*x)-cos(2*x)-0.2).*(cos(2*x)+sin(2*x));
plot(x,f(x))
grid on

#---------newton--------#
epsi = 0.0001;
first = -5;
k_newton = [0];
while (first < 5)
  x = first;
  delta = 1;
  while (delta>=epsi)
    x_new = x - f(x)/ df(x);
    delta = abs(x_new - x);
    x = x_new;
  end
  if ((min(abs(x-k_newton))>epsi) && (x <= 5) && (x >= -5))
    k_newton(end+1) = x;
  endif
  first += 0.1;
end
k_newton(2:end)

#---------fzero--------#
kzero = [0];
x_step = -5;
step = 0.1;
while (x_step < 5)
  x_find = fzero(f, x_step);
  if ((min(abs(x_find-kzero))>epsi) && (x_find <= 5) && (x_find >= -5))
    kzero(end+1) = x_find;
  endif
  x_step += step;
end
kzero(2:end)


#-----------------#

a = -4;
b = -2;
x_new = (a + b) / 2;
first = -2;
k_del = [0];
while (first < 5)
  x = first;
  delta = 1;
  while (delta>=epsi)
    x_new = (a + b) / 2;
    if (f(x_new) < 0)
        a = f(x_new);
    else b = f(x_new);
    endif;
    delta = abs(x_new - x);
    x = x_new;
  end
  if ((min(abs(x-k_del))>epsi) && (x <= 5) && (x >= -5))
    k_del(end+1) = x;
  endif
  first += 0.1;
  a += 1;
  b += 1;
end
%k_del(2:end)
