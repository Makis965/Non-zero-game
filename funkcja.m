function [eql] = funkcja(P1,P2)
    eql = {}; 
    for i = 1:length(P1)
        if any(size(P1{i}) == 1)

            min_p2 = min(P2{i}); %because game is based only on player 2 choice
                                 %we're looking for his minima

            ind_p2 = find(P2{i}==min_p2); %minima id of the second player define 
                                          %the id cost of the first player as
            cost_p1 = P1{i}(ind_p2);      %well
            cost_p2 = min(P2{i});                  
            eql = {eql;[cost_p1 cost_p2]};
        else
            min_p1 = min(P1{i}); %transpose, because by default indexing moves across the columns
            p1_eq_array = [];
            for id = 1:length(min_p1)
                ind_p1 = find(P1{i}(:,id)==min_p1(id)); %P1 strategies are defined on rows
                p1_eq_array = [p1_eq_array; [ind_p1 (ones(1,length(ind_p1))*id)']];
                %zapisywac indeks i numer iteracji: indeks = kolumna a
                %numer iteracji wiersz (do wektora)
            end
            min_p2 = min(P2{i}'); 
            p2_eq_array = [];
            for id = 1:length(min_p2)
                ind_p2 = find(P2{i}(:,id)==min_p2(:,id));
                p2_eq_array = [p2_eq_array; [ind_p2 (ones(1,length(ind_p2))*id)']];
                %P2 strategies are defined on columns
                %zapisywac indeks i numer iteracji: indeks = wiersz a
                %numer iteracji kolumna (do wektora)
            end

            equalibrium = find(ismember(p2_eq_array,p1_eq_array, 'rows'));
            P1_out = P1{i}(p2_eq_array(equalibrium(1)),p2_eq_array(equalibrium(1)));
            P2_out = P2{i}(p2_eq_array(equalibrium(1)),p2_eq_array(equalibrium(1)));
            eql{i+1} = [P1_out P2_out];
            % porównać wektory list, jeżeli któryś się równa to mamy
            % równowagę 
        end
    end
end