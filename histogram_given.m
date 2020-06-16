 function h = histogram_given(hmin, hmax, nbins, x)
% Computes the histogram of input vector xinput
% Usage: result = histogram(minedge, maxedge, Nbins, xinput)

if(isvector(x) == 0)
    error('Input not a vector')
elseif(hmin >= hmax)
    error('Problem with bin edges')
elseif(nbins <= 0)
    error('Problem with number of bins')
else
    dh = (hmax - hmin)/(nbins);     % delta-h: bin spacing
    h = zeros(nbins, 1);            % initialize histogram result
    
    for k=1:length(x)
        if(x(k) <= hmin)            % if lower than range,
            h(1) = h(1) + 1;        % increment lowest bin
        elseif(x(k) >= hmax)        % if higher than range,
            h(nbins) = h(nbins) + 1;    % increment highest bin
        else
            j = floor((x(k) - hmin)/dh);    % find closest bin
            h(j+1) = h(j+1) + 1;            % increment that count
        end
    end
    % normalize to unit area like a PDF
    h = h./(length(x).*dh);
end
