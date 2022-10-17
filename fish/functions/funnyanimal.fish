function funnyanimal
  for i in (seq 1 $argv);
    set ANIMAL (cat ~/Projects/FunnyAnimal/animals.txt | sort -R | tail -1);
    set ADJECTIVE (cat ~/Projects/FunnyAnimal/adjectives.txt | sort -R | tail -1);
    echo $ADJECTIVE$ANIMAL;
  end;
end
