classdef Jogo < handle
    properties
        table;
        posEnemy;
        posPlayer;
        placar;
    end
    methods
        function obj = Jogo()
            obj.table = zeros(2,2);
            obj.posEnemy = [1,randi(2), randi(3)];
            obj.posPlayer = [2,randi(2)];
            obj.table(obj.posEnemy(1), obj.posEnemy(2)) = 1;
            obj.table(obj.posPlayer(1), obj.posPlayer(2)) = 1;
            obj.placar = 0;
        end 
        function Move(obj,tipo,move)
            if(tipo == 1)
                obj.posEnemy(1) = obj.posEnemy(1) + 1;
                %{
                if (obj.posEnemy(3) == 1)
                    if (obj.posEnemy(2) > 1)
                        obj.posEnemy(2) =  obj.posEnemy(2) - 1;
                    end
                else
                   if(obj.posEnemy(3) == 2)
                       if (obj.posEnemy(2) < 4)
                           obj.posEnemy(2) =  obj.posEnemy(2) + 1;
                       end
                   end
                end
                %}
            else
                if (move == 1) 
                    if (obj.posPlayer(2) > 1)
                        obj.posPlayer(2) =  obj.posPlayer(2) - 1;
                    end
                else
                    if(move == 2)
                        if (obj.posPlayer(2) < 2)
                            obj.posPlayer(2) =  obj.posPlayer(2) + 1;
                        end
                    end
                end
            end
        end
        function MoveEnemy(obj)
            obj.Move(1,0);
            if(obj.posEnemy(1) > 2)
                obj.posEnemy(1) = 1;
                obj.posEnemy(2) = randi(2);
                obj.posEnemy(3) = randi(3);
            end 
        end
        
        function MovePlayer(obj,move)
            obj.Move(2,move);
        end
        
        function Update(obj)
            obj.table = zeros(2,2);
            obj.table(obj.posEnemy(1),obj.posEnemy(2)) = 1;
            obj.table(obj.posPlayer(1), obj.posPlayer(2)) = 1;
            if(obj.posEnemy(1) == obj.posPlayer(1))
                if(obj.posEnemy(2) ==  obj.posPlayer(2))
                    beep;
                    obj.placar  = obj.placar - 3;
                else
                    obj.placar = obj.placar + 1;
                end
            end
        end
        
        function Draw(obj)
            disp(obj.table);
            %disp(obj.placar);
        end
    end
end 