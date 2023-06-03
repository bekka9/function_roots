%.................................................................%

clear
x = -5:0.1:5;
figure
hold on;
f = @(x) 1+(1+sin(x)-cos(x)).^2-(sin(2*x)-cos(2*x)-0.2).^2;
df = @(x) 2*(1+sin(x)-cos(x)).*(cos(x)+sin(x))-4*(sin(2*x)-cos(2*x)-0.2).*(cos(2*x)+sin(2*x));
plot(x,f(x))
grid on

#---------newton--------#
epsi = 0.0001;
first = -5;
k_newton = [0];
k_newton_y = [0];
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
    k_newton_y(end+1) = f(x);
  endif
  first += 0.1;
end
k_newton(2:end)


#---------fzero--------#
kzero = [0];
kzero_y = [0];
x_step = -5;
step = 0.1;
while (x_step < 5)
  x_find = fzero(f, x_step);
  if ((min(abs(x_find-kzero))>epsi) && (x_find <= 5) && (x_find >= -5))
    kzero(end+1) = x_find;
    kzero_y(end+1) = f(x_find);
  endif
  x_step += step;
end

kzero(2:end)


#--------dichotomy--------#

a = -4;
b = -3.99;
x_new = (a + b) / 2;
first = -4;
k_del = [0];
k_del_y = [0];
while (a < 5)
  x_new = (a + b) / 2;

  if (f(a)*f(b) < 0)
    a_ = a; b_= b;
    delta = 1;
    while (delta>=epsi)
      x_new = (a_ + b_) / 2;
      if (f(x_new) == 0)
        k_del(end+1) = x_new;
        k_del_y(end+1) = f(x_new);
      else
          if (f(x_new)*f(b_) < 0)
            a_ = x_new;
          else b_ = x_new;
          endif;
      endif
      x_new = (a_ + b_) / 2;
      delta = abs(x_new - b_);

    end
    k_del(end+1) = x_new;
    k_del_y(end+1) = f(x_new);

    endif

  a += 0.01;
  b += 0.01;
end

k_del(2:end)
%----------------------------------------------------------%


for i = 1:length(k_del)
  plot(k_del(i), k_del_y(i),'r')
end
for i = 1:length(kzero)
  plot(kzero(i), kzero_y(i), 'y')
end

for i = 1:length(k_newton_y)
  plot(k_newton(i), k_newton_y(i), 'g')
end

