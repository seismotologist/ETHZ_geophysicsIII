aziList = 0:10:360;
for iazi = 1:numel(aziList)
    view([view0(1)+aziList(iazi) view0(2)])
    pause(.2)

    drawnow
    
    % Capture the plot as an image
    frame      = getframe(hf);
    im         = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    
    % Write to the GIF File
    if iazi==1; imwrite(imind,cm,gifName,'gif','DelayTime',dtgif, 'Loopcount',inf);
    else        imwrite(imind,cm,gifName,'gif','DelayTime',dtgif,'WriteMode','append');
    end
end