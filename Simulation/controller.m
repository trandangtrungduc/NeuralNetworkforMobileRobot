function [v_left v_right] = controller(x)
A = forward(x');
    if (A(1)>0.9&&A(2)>0.9)
        v_left = 200;
        v_right = 200;
    elseif (A(1)<0.9&&A(2)>0.9)
        v_left = 0.5*200;
        v_right = 0.9*200;
    else
        v_left = 0.9*200;
        v_right = 0.5*200;
    end
    v_left=v_left/40;
    v_right=v_right/40;
end
% function [v_left v_right] = controller(x)
% A = forward(x');
%     if (A(1)>0.9&&A(2)>0.9)
%         v_left = 1;
%         v_right = 1;
%     elseif (A(1)<0.9&&A(2)>0.9)
%         v_left = 0.5;
%         v_right = 0.9;
%     else
%         v_left = 0.9;
%         v_right = 0.5;
%     end
%     v_left=v_left*pi/6;
%     v_right=v_right*pi/6;
% end