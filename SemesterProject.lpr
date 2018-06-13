program SemesterProject;
uses Crt,sysutils;
//gl,lg=>game level variable ; //br=>board row variable  ;//bc=>board column variable  ; //place=>row or column number
//mc=>matrix column variable ; //mr=>matrix row variable ;//ep=>element location       ; //pl=>place location
var gameLevel:array[1..5]of string=('1: beginner','2: intermediate','3: advanced','4: professional','5: surprise');
    board:array[1..100, 1..100] of integer;
    matrix:array[1..100, 1..100] of string;
    flag,ff: string;
    element,boardSize,place,exit,randomRow,randomColumn,userPoint,pcPoint,finish,gl,lg,br,bc,mr,mc,k,el,pl,c,rr,rc,j,i,a,b:integer;
begin
randomize(); TextColor(yellow);
 repeat
  writeln('Welcome! ',' Please enter the board size (between 4 and 10):'); writeln;
  readln(boardSize);writeln;
  while (boardsize<4) or (boardsize>11) or (boardsize mod 2 = 1) do
   begin
    writeln('Please enter the values between 4 and 10');
    readln(boardSize);writeln;
   end;
  writeln('Please enter the level of game by entering 1,2,3,4 or 5:'); writeln;
  for gl:=1 to 5 do//writeln() game leves
   writeln(gameLevel[gl]);
  writeln; readln(lg); writeln;
  while lg>5 do
   begin
    writeln('Please select the correct answer !');writeln;
    readln(lg);writeln;
   end;
  //reset the board array
  for bc := 1 to boardSize do
   begin
      for br := 1 to boardSize do
       board[br,bc]:=0
   end;
  //create the board with random numbers
  for bc:=1 to (boardSize*boardSize) div 2 do
   begin
     for i:=1 to 2 do
       begin
         repeat
          a:=1+random(boardSize);
          b:=1+random(boardSize);
         until(board[a,b] =0);
         board[a,b]:=bc;
        end;
   end;
  //writeln board with numbers

  for mc := 1 to boardSize do
   begin
      for mr := 1 to boardSize do
        begin
         if board[mr,mc] div 10 <1 then
            begin
              Write('|',' ',board[mr, mc],'  ','|');
            end
          else
            Write('|',' ',board[mr, mc],' ','|');
        end;
      writeln();
   end;writeln;




   //writeln() * matrix
   for mc:= 1 to boardSize do
   begin
     for mr := 1 to boardSize do
      begin
        matrix[mr, mc] :='*';
      end;
   end;
  //writeln() the matrix
  for mc := 1 to boardSize do
   begin
      for mr := 1 to boardSize do
       begin
         Write('|',' ',matrix[mr, mc],' ',' ','|');
       end;writeln;
   end; writeln;
userPoint:=0; pcPoint:=0; finish:=0;
repeat
  //ask the row and element number from user
  k:=0;
  writeln('Player! It is your turn');  writeln();
  repeat
    k:=k+1;  writeln();
    writeln('Please enter the row and element number respectively:'); writeln();
    readln(place,element); writeln;
    //prevent the user errors
    while (place>boardSize) or (element>boardSize) or (place<1) or (element<1) do
     begin
       writeln('Please enter right locations!');
       writeln; readln(place,element); writeln();
     end;
    while (matrix[element,place]=' ') do
     begin
       writeln('These locations are selected. Please select another location!');
       writeln;readln(place,element); writeln;
     end;
    matrix[element,place]:=intToStr(board[element,place]);
    if k=1 then
     begin
          flag:=matrix[element,place];
          el:=element;
          pl:=place;
     end;
    //control the locaations in order to prevent selecting the same location
     while (k=2) and (element=el) and (place=pl)do
       begin
          writeln;writeln('Please enter right locations!');writeln;
          readln(place,element); writeln;
       end;
    //writeln() matrix with predicted elements
    for mc := 1 to boardSize do
     begin
        for mr := 1 to boardSize do
          begin
            if matrix[mr,mc]= '*'   then
              begin
                Write('|',' ',matrix[mr, mc],'  ','|');
              end
            else if board[mr,mc] div 10 <1 then
              begin
                Write('|',' ',matrix[mr, mc],'  ','|');
              end
            else if matrix[mr,mc]=' ' then
              Write('|',' ',matrix[mr, mc],'  ','|')
            else
              Write('|',' ',matrix[mr, mc],' ','|');
          end;
        writeln();
     end;
    if k=2 then
      begin
        //control the matrix elements in order to making selected elements ' ' or *
        if flag=matrix[element,place] then
          begin
             matrix[element,place]:=' ';
             matrix[el,pl]:=' ';
             userPoint:=userPoint+1;
          end
        else
          begin
              matrix[element,place]:='*';
              matrix[el,pl]:='*';
          end;
      end;
   until k=2;
   writeln();
   //Writeln() new version of matrix
   writeln;writeln('New version of table: ');writeln;
   for mc := 1 to boardSize do
    begin
       for mr := 1 to boardSize do
         begin
           if matrix[mr,mc]= '*'   then
             begin
               Write('|',' ',matrix[mr, mc],'  ','|');
             end
           else if board[mr,mc] div 10 <1 then
             begin
               Write('|',' ',matrix[mr, mc],'  ','|');
             end
           else if matrix[mr,mc]=' ' then
             Write('|',' ',matrix[mr, mc],'  ','|')
           else
             Write('|',' ',matrix[mr, mc],' ','|');
         end;
       writeln();
    end;
    writeln; writeln('Score of player : ', userPoint); writeln;

    if (userPoint=boardSize) AND  (pcPoint=boardSize) then
      begin
        finish:=1;
      end
    else
     begin
       Writeln('Computer is going to make a prediction...');
       delay(4000);
       // **Artificial Intelligence of the Computer
       c:=0; ff:='0';
      repeat
         c:=c+1;
         repeat
          randomRow:=random(boardSize)+1;
          randomColumn:=random(boardSize)+1;
         until (matrix[randomRow,randomColumn] <> ' ') and (matrix[randomRow,randomColumn] <> ff);
         //create flag for next control
         if c=1 then
           begin
             ff:=intToStr(board[randomRow,randomColumn]);
             rr:=randomRow;
             rc:=randomColumn;
           end; writeln;
           if lg=1 then
             begin
               for i:=1 to 4 do
                begin
                  for j:=1 to 1 do
                   begin
                     if (c=2) and (matrix[rr,rc]=intToStr(board[j,i])) then
                       begin
                         if (rr<>j) or (rc<>i) then
                           begin
                             randomRow:=j;
                             randomColumn:=i;
                           end;
                       end;
                   end;
                end;
             end
           else if lg=2 then
             begin
               for i:=1 to 4 do
                begin
                  for j:=1 to 2 do
                   begin
                     if (c=2) and (matrix[rr,rc]=intToStr(board[j,i])) then
                       begin
                         if (rr<>j) or (rc<>i) then
                           begin
                             randomRow:=j;
                             randomColumn:=i;
                           end;
                       end;
                   end;
                end;
             end
           else if lg=3 then
             begin
               for i:=1 to 4 do
                begin
                  for j:=1 to 3 do
                   begin
                     if (c=2) and (matrix[rr,rc]=intToStr(board[j,i])) then
                       begin
                         if (rr<>j) or (rc<>i) then
                           begin
                             randomRow:=j;
                             randomColumn:=i;
                           end;
                       end;
                   end;
                end;
             end
           else if lg=4 then
             begin
               for i:=1 to boardSize do
                begin
                  for j:=1 to boardSize do
                   begin
                     if (c=2) and (matrix[rr,rc]=intToStr(board[j,i])) then
                       begin
                        if (rr<>j) or (rc<>i) then
                           begin
                             randomRow:=j;
                             randomColumn:=i;
                           end;
                       end;
                   end;
                end;
             end
           else if lg=5 then
             begin
               for i:=1 to 4 do
                begin
                  for j:=1 to random(boardSize)+1 do
                   begin
                     if (c=2) and (matrix[rr,rc]=intToStr(board[j,i])) then
                       begin
                        if (rr<>j) or (rc<>i) then
                           begin
                             randomRow:=j;
                             randomColumn:=i;
                           end;
                       end;
                   end;
                end;
             end;
         matrix[randomRow,randomColumn]:=intToStr(board[randomRow,randomColumn]);
      //writeln() matrix with predicted elements
      for mc := 1 to boardSize do
       begin
          for mr := 1 to boardSize do
            begin
              if matrix[mr,mc]= '*'   then
                begin
                  Write('|',' ',matrix[mr, mc],'  ','|');
                end
              else if board[mr,mc] div 10 <1 then
                begin
                  Write('|',' ',matrix[mr, mc],'  ','|');
                end
              else if matrix[mr,mc]=' ' then
                Write('|',' ',matrix[mr, mc],'  ','|')
              else
                Write('|',' ',matrix[mr, mc],' ','|');
            end;
          writeln();
       end;
       until c=2;
      // control the matrix in order to  fill it with ' ' or *
       if ff=matrix[randomRow,randomColumn] then
        begin
           matrix[randomRow,randomColumn]:=' ';
           matrix[rr,rc]:=' ';
           pcPoint:=pcPoint+1;
         end
       else
        begin
          matrix[randomRow,randomColumn]:='*';
          matrix[rr,rc]:='*';
        end;
        //New version of table
        writeln; writeln('New version of table:');writeln;
        for mc := 1 to boardSize do
         begin
            for mr := 1 to boardSize do
              begin
                if matrix[mr,mc]= '*'   then
                  begin
                    Write('|',' ',matrix[mr, mc],'  ','|');
                  end
                else if board[mr,mc] div 10 <1 then
                  begin
                    Write('|',' ',matrix[mr, mc],'  ','|');
                  end
                else
                  Write('|',' ',matrix[mr, mc],'  ','|');
              end;
            writeln();
         end;
        writeln;writeln('Score of pc: ', pcPoint);writeln;
     end;
    if (userPoint=boardSize) AND  (pcPoint=boardSize) then
      begin
        finish:=1;
      end;
 until (userPoint>boardSize) or (pcPoint>boardSize)or (finish=1); writeln;
   if userPoint>pcPoint then
     begin
       writeln('Congrulations! You won the game!'); writeln;
       writeln('Your score is : ', userPoint);
       writeln;writeln('Score of pc: ',pcPoint);
     end
   else if userPoint=pcPoint then
     begin
       Writeln('Nobody won. Draw!');
       writeln;writeln('Your score is : ', userPoint);
       writeln;writeln('Score of pc: ',pcPoint);
     end
   else
     begin
       writeln('PC won the game!');
       writeln;writeln('Score of pc: ',pcPoint);
       writeln;writeln('Your score is : ', userPoint);
     end; writeln; writeln;
   //writeln() the board
  for mc := 1 to boardSize do
   begin
      for mr := 1 to boardSize do
        begin
          if board[mr,mc] div 10 <1 then
            begin
              Write('|',' ',board[mr, mc],' ',' ','|');
            end
          else
          begin
            Write('|',' ',board[mr, mc],' ','|');
          end;
        end; writeln;
   end; writeln;
   writeln('If you want continue the game please enter 1 ,otherwise enter 2');
   readln(exit); writeln();
 until exit=2;
end.
