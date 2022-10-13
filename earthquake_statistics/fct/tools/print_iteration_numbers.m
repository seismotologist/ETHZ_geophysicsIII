function print_iteration_numbers(itr,ntr,printLevel)

%eins            = linspace(1e0,1e4,1e4);
tens             = linspace(1e1,1e4,1e3);
hundreds         = linspace(1e2,1e5,1e3);
thousands        = linspace(1e3,1e6,1e3);
tenthousands     = linspace(1e4,1e7,1e3);
hundredthousands = linspace(1e5,1e8,1e3);
millions         = linspace(1e6,1e9,1e3);

% EXAMPLE
% ni = 120;
% for ii=1:ni
%     print_iteration_numbers(ii,ni,'ones')
% end

%if nargin<4; o_printTime = false; end
if itr==1; tic; end


% Print hundreds on same line and start new line every 1,000th iteration 
if strcmp(printLevel,'hundredthousands')
    if ismember(itr,[1,hundredthousands,ntr]);
        %if ismember(itr,[1,thousands]); fprintf(1,sprintf('%16.4fs\n%i -- ',toc,ntr)); end
        if ismember(itr,[1,millions]); fprintf(1,sprintf('\n%i -- ',ntr)); end
        fprintf(1,sprintf('%i .. ',itr));
        if itr==ntr; fprintf(1,' done.\n'); end
    end

elseif strcmp(printLevel,'tenthousands')
    if ismember(itr,[1,tenthousands,ntr]);
        %if ismember(itr,[1,thousands]); fprintf(1,sprintf('%16.4fs\n%i -- ',toc,ntr)); end
        if ismember(itr,[1,hundredthousands]); fprintf(1,sprintf('\n%i -- ',ntr)); end
        fprintf(1,sprintf('%i .. ',itr));
        if itr==ntr; fprintf(1,' done.\n'); end
    end

elseif strcmp(printLevel,'thousands')
    if ismember(itr,[1,thousands,ntr]);
        %if ismember(itr,[1,thousands]); fprintf(1,sprintf('%16.4fs\n%i -- ',toc,ntr)); end
        if ismember(itr,[1,tenthousands]); fprintf(1,sprintf('\n%i -- ',ntr)); end
        fprintf(1,sprintf('%i .. ',itr));
        if itr==ntr; fprintf(1,' done.\n'); end
    end
    
    
elseif strcmp(printLevel,'hundreds')
    if ismember(itr,[1,hundreds,ntr]);
        %if ismember(itr,[1,thousands]); fprintf(1,sprintf('%16.4fs\n%i -- ',toc,ntr)); end
        if ismember(itr,[1,thousands]); fprintf(1,sprintf('\n%i -- ',ntr)); end
        fprintf(1,sprintf('%i .. ',itr));
        if itr==ntr; fprintf(1,' done.\n'); end
    end
    
    
% Print tens on same line and start new line every 100th iteration
elseif strcmp(printLevel,'tens')
    if ismember(itr,[1,tens,ntr]);
        %if ismember(itr,[1,hundreds]);  fprintf(1,sprintf('%16.4fs\n%i -- ',toc,ntr)); end
        if ismember(itr,[1,hundreds]); fprintf(1,sprintf('\n%i -- ',ntr)); end
        fprintf(1,sprintf('%i .. ',itr));
        if itr==ntr; fprintf(1,' done.\n'); end
    end
    
% Print singles on same line and start new line every 10th iteration 
elseif strcmp(printLevel,'ones')
        %if ismember(itr,[1,tens]); fprintf(1,sprintf('%16.4fs\n%i -- ',toc,ntr)); end
        if ismember(itr,[1,tens]); fprintf(1,sprintf('\n%i -- ',ntr)); end
        fprintf(1,sprintf('%i .. ',itr));
    end
end
