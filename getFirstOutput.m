function first = getFirstOutput(varargin)
    if length(varargin)<=15
        [first, ~, ~] = calculation(varargin{:}); 
    else 
         if length(varargin)<=25
            [first, ~, ~] = calculation_3smoke(varargin{:});
         else
            [first, ~, ~] = calculation_3missle(varargin{:});
         end
    end
end