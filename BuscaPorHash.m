function pos = buscaPorHash( qsa, s, a )
    if(length(qsa) > 0)
        for i = 1 : length(qsa)
            %if(isequal(qsa(i).s, s) && (qsa(i).a == a))
            if((immse(qsa(i).s, s) < 100) && (qsa(i).a == a))
                pos = i;
                break;
            end;
        end;

        if(i == length(qsa))
            pos = 0;
        end;
    else
        pos = 0;
    end;
end
