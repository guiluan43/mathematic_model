function first = getFirstOutput(varargin)
    if length(varargin)<=15
        [first, ~, ~] = calculation(varargin{:}); 
    else
        first = calculation_3smoke(varargin{:}); 
    end
end