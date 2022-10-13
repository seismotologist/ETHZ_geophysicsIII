classdef seiscat < handle
    %SEISCAT seismicity catalogue
    %   Version: 1.0
    %   Last update: 200323
    %   mmeier@caltech.edu
    
    % How to implement plotting defaults, e.g. zlim?
    
    properties
        
        lat             % ...
        lon             % ..
        z               % (not depth)
        m               % (not magnitude)
        rij             % Inter-event distances between events
        azref
        
        idxref          % List index of reference event
        
    end
    
    methods
        
        % Invoke object   -------------------------------------------------
        function obj = seiscat()
            
            obj.lat       = zeros(ntr,1,'single');
            obj.lon       = zeros(ntr,1,'single');
            obj.rij       = sparse(zeros(ntr,ntr,'single'));
            
            obj.prop        = struct;
            obj.idxref     = zeros(1,1);
        end
        
        
        % Compute inter-event distances
            % Plot general catalogue overview
            % ...
            

            
        % Select sub-catalog
        %         function ctlg = select_subcat(ctlg,useme)
        %             
        %             neq      = numel(ctlg.magnitude);
        %             fdnames  = fieldnames(ctlg);
        %             nentries = structfun(@numel,ctlg);
        %             fdnames  = fdnames(nentries==neq);
        %             nf       = numel(fdnames);
        %             
        %             for ifd = 1:nf
        %                 thisField        = fdnames{ifd};
        %                 ctlg.(thisField) = ctlg.(thisField)(useme);
        %             end
        
        
        % get_summary_strings
        %         m  = ctlg.magnitude;
        %         i4 = m>=4 & m<5; n4=sum(i4);
        %         i5 = m>=5 & m<6; n5=sum(i5);
        %         i6 = m>=6 & m<7; n6=sum(i6);
        %         i7 = m>=7 & m<8; n7=sum(i7);
        %         i8 = m>=8 & m<9; n8=sum(i8);
        %         i9 = m>=9;       n9=sum(i9);
        %         i6p = i6 |i7 |i8 |i9;
        %         
        %         fds      = regexp(fbasename,'/','split');
        %         basename = fds{end};
        %         ts       = datestr(min(ctlg.t0),'DD/mm/YYYY');
        %         te       = datestr(max(ctlg.t0),'DD/mm/YYYY');
        %         neq      = numel(m);
        %         tstring1 = sprintf('%s, %s-%s, %3.1f<m<%3.1f, n=%i',basename,ts,te,min(m),max(m), neq);
        %         tstring2 = ...

        
        end
    end
