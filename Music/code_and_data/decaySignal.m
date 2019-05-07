all_y = [];
for h = 0:31    
    x_a = h*256 + 1;    
    x_b = x_a + 127;    
    x_c = x_a + 255;
    y_a = 1/sqrt(h+1);    
    y_b = 0.9 * y_a;    
    y_c = y_a;        
    p = polyfit([x_a, x_b, x_c],[y_a, y_b, y_c],2);    
    x1 = x_a:x_c;    
    y1 = polyval(p,x1);        
    all_y = [all_y, y1]; 
end
plot(1:8192, all_y) 
title('decay function to multiply signal by')
decay_fun = all_y;

signal = synthNotes(8192,1000,1,32);
decay_signal = ones(size(signal)); 
for k = 1:8192    
    decay_signal(k) = signal(k)*decay_fun(k); 
end
 plot(decay_signal); 
 sound(decay_signal)