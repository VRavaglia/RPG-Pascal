Unit setup;


interface
  uses math;
  type
    cinfo_type = array[1 .. 3] of record

    name : String;
    max_mp: Real;
    mp: Real;
    base_mp: Real;
    max_hp: Real; 
    hp: Real;
    base_hp: Real;
    base_dmg: Real;
    xp: Longint;
    skill1_name: String;
    skill2_name: String;
    skill1: String;
    skill2: String;
    skill1_level:Integer;   
    skill2_level:Integer;
    end;
    
    enemy_type = array[1 .. 3] of record
    name : String;
    mp: Real;
    hp: Real;
    xp: Longint;
    base_dmg: Real;
    
    end;

  procedure classes_setup(var classes_info:cinfo_type);
  procedure monster_setup(var monsters_info:enemy_type);
  procedure skill_setup(var classes_info:cinfo_type);
  
  function calculate_level(character:cinfo_type;charid:Integer): Integer;
  function calculate_damage(character:cinfo_type;charid:Integer;item_damage:Real;skill_damage:Real): Real;
  function max_hp(character:cinfo_type;charid:Integer): Real;
  function max_mp(character:cinfo_type;charid:Integer): Real;

  function skill1_archer_function(classes_info:cinfo_type;var periodic_damage:Real;var periodic_damage_turns:Integer;skill_level:Integer):Boolean;  

implementation

  function calculate_level(character:cinfo_type;charid:Integer): Integer;
  var
    xp,i: Integer;
  begin
    xp := character[charid].xp;
    i := 1;
    while xp >= 0 do
    begin
      xp := xp - (i * 100); 
      i := i + 1;
           
    end;
    calculate_level := i - 1;
  end;

  procedure classes_setup(var classes_info:cinfo_type);
  begin
    classes_info[1].name := 'Acher';
    classes_info[1].max_hp := max_hp(classes_info,1);
    classes_info[1].hp := 20;
    classes_info[1].base_hp := 20;
    classes_info[1].max_mp := max_mp(classes_info,1);
    classes_info[1].mp := 20;
    classes_info[1].base_mp := 20;
    classes_info[1].base_dmg := 4;
    classes_info[1].xp := 0;
    classes_info[1].skill1_name := 'Arrow Rain';
    classes_info[1].skill2_name := 'Fire Arrow';
    classes_info[1].skill1_level := 1;
    classes_info[1].skill2_level := 0;

    classes_info[2].name := 'Mage';
    classes_info[2].max_hp := max_hp(classes_info,2);
    classes_info[2].hp := 10;
    classes_info[2].base_hp := 10;
    classes_info[2].max_mp := max_mp(classes_info,2);
    classes_info[2].mp := 30;
    classes_info[2].base_mp := 30;
    classes_info[2].base_dmg := 2;
    classes_info[2].xp := 0;
    classes_info[2].skill1_name := '';
    classes_info[2].skill2_name := '';
    classes_info[2].skill1_level := 0;
    classes_info[2].skill2_level := 0;

    classes_info[3].name := 'Warrior';
    classes_info[3].max_hp := max_hp(classes_info,3);
    classes_info[3].hp := 30;
    classes_info[3].base_hp := 30;
    classes_info[3].max_mp := max_mp(classes_info,3);
    classes_info[3].mp := 10;
    classes_info[3].base_mp := 10;
    classes_info[3].base_dmg := 3;
    classes_info[3].xp := 0;
    classes_info[3].skill1_name := '';
    classes_info[3].skill2_name := '';
    classes_info[3].skill1_level := 0;
    classes_info[3].skill2_level := 0;
  end;

  procedure monster_setup(var monsters_info:enemy_type);
  begin
    monsters_info[1].name := 'Poring';
    monsters_info[1].hp := 5;
    monsters_info[1].mp := 0;
    monsters_info[1].xp := 10;
    monsters_info[1].base_dmg := 4;
    monsters_info[2].name := 'Poporing';
    monsters_info[2].hp := 10;
    monsters_info[2].mp := 0;
    monsters_info[2].xp := 20;
    monsters_info[2].base_dmg := 3;
    monsters_info[3].name := 'Felipe S';
    monsters_info[3].hp := 20;
    monsters_info[3].mp := 10;
    monsters_info[3].xp := 40;
    monsters_info[3].base_dmg := 5;
  end;

  




  function max_hp(character:cinfo_type;charid:Integer): Real;
  begin
    max_hp := character[charid].base_hp  * power(1.1,(calculate_level(character,charid)-1));
  end;

  function max_mp(character:cinfo_type;charid:Integer): Real;
  begin
    max_mp := character[charid].base_mp  * power(1.1,(calculate_level(character,charid)-1));
  end;

  





  function skill1_archer_function(classes_info:cinfo_type;var periodic_damage:Real;var periodic_damage_turns:Integer;skill_level:Integer):Boolean;   
    begin
      if classes_info[1].mp >= (1 + classes_info[1].skill1_level) then
      begin
        periodic_damage := periodic_damage + (1 + classes_info[1].skill1_level);
        periodic_damage_turns := 3;
        classes_info[1].mp := classes_info[1].mp -(1 + classes_info[1].skill1_level); 
        skill1_archer_function := true;
      end
      else
      begin
        skill1_archer_function := false;
      end;
    end;

  function skill2_archer_function(classes_info:cinfo_type): String;
  begin
    skill2_archer_function := '';
  end;
  function skill1_mage_function(classes_info:cinfo_type): String;
  begin
    skill1_mage_function := '';
  end;
  function skill2_mage_function(classes_info:cinfo_type): String;
  begin
    skill2_mage_function := '';
  end;
  function skill1_warrior_function(classes_info:cinfo_type): String;
  begin
    skill1_warrior_function := '';
  end;
  function skill2_warrior_function(classes_info:cinfo_type): String;
  begin
    skill2_warrior_function := '';
  end;

  procedure skill_setup(var classes_info:cinfo_type);
  begin
    {classes_info[1].skill1 := skill1_archer_function(classes_info);}
    classes_info[1].skill2 := skill2_archer_function(classes_info);
    classes_info[2].skill1 := skill1_mage_function(classes_info);
    classes_info[2].skill2 := skill2_mage_function(classes_info);
    classes_info[3].skill1 := skill1_warrior_function(classes_info);
    classes_info[3].skill2 := skill2_warrior_function(classes_info);

  end;

  

  function calculate_damage(character:cinfo_type;charid:Integer;item_damage:real;skill_damage:real): Real;
  var
    damage: Real;
    lvldamage: Real;
  begin
    lvldamage := character[charid].base_dmg  * power(1.1,(calculate_level(character,charid)-1)); 
    damage := lvldamage + item_damage + skill_damage;
    calculate_damage:= damage;
  end;

  
 
end. 