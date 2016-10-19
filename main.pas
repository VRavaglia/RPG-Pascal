program rpg;
uses crt,potraits,setup,math,menus;


var

	classes_info:cinfo_type;
	monsters_info:enemy_type;



procedure draw_hp_enemy(enemy:enemy_type;enemyid:Integer;monsterhp:Real);
var
		i: Real;
begin
	writeln();
	TextColor(Yellow);
	write(enemy[enemyid].name);
	TextColor(White);
	write(' HP: ');
	write(monsterhp:5:0, '/');
	write(enemy[enemyid].hp:5:0);
	writeln();
	write('|');

	i := 0;
	TextColor(Green);
	while i < enemy[enemyid].hp do
	begin
		if i <= (monsterhp) then
		begin
			write('#');
		end
		else
		begin
			write(' ');
		end;
		i:= i + enemy[enemyid].hp/34;
	end;
	TextColor(White);
	write('|');
	writeln();
end;

procedure draw_hp_bar(var character:cinfo_type;charid:Integer);
var
		i: Real;
begin
	character[charid].max_hp := max_hp(character,charid);
	writeln();
	write('Your HP: ');
	write(character[charid].hp:5:0, '/');
	write(character[charid].max_hp:5:0);
	writeln();
	write('|');

	i := 0;
	TextColor(Green);
	while i < character[charid].max_hp do
	begin
		if i <= (character[charid].hp) then
		begin
			write('#');
		end
		else
		begin
			write(' ');
		end;
		i:= i + character[charid].max_hp/34;
	end;
	TextColor(White);
	write('|');
	writeln();

end;

procedure draw_mp_bar(var character:cinfo_type;charid:Integer);
var
		i: Real;
begin
	character[charid].max_mp := max_mp(character,charid);
	writeln();
	write('Your MP: ');
	write(character[charid].mp:5:0, '/');
	write(character[charid].max_mp:5:0);
	writeln();
	write('|');

	i := 0;
	TextColor(Blue);
	while i < character[charid].max_mp do
	begin
		if i <= (character[charid].mp) then
		begin
			write('#');
		end
		else
		begin
			write(' ');
		end;
		i:= i + character[charid].max_mp/34;
	end;
	TextColor(White);
	write('|');
	writeln();

end;

{=========================================================}


procedure battle(var character:cinfo_type;charid:Integer;enemy:enemy_type;enemyid:Integer);
var
	monsterhp,damage,periodic_damage: Real;
	option,periodic_damage_turns: Integer;
	exit:Boolean;
begin
	monsterhp := enemy[enemyid].hp;
	periodic_damage_turns := 0;
	periodic_damage := 0;
	repeat
		clrscr;
		writeln('You encountered a ',enemy[enemyid].name,'...');
		draw_enemy(enemyid);
		writeln();
		writeln();
		writeln('What will you do');
		writeln();
		writeln('1 to Battle...');
		writeln('2 to Run like a coward!');
		option:= read_number_input();

	until(option = 2) or (option = 1);

	if option = 1 then
	begin

		repeat
			clrscr;
			writeln('You encountered a ',enemy[enemyid].name,'...');
			writeln();			
			writeln();
			draw_enemy(enemyid);
			writeln();
			draw_hp_enemy(enemy,enemyid,monsterhp);
			writeln();
			draw_hp_bar(character,charid);
			draw_mp_bar(character,charid);
			writeln();
			writeln('What will you do');
			writeln();
			writeln('1 to Attack');
			write('2 to use ');
			TextColor(Magenta);
			write(character[charid].skill1_name);
			TextColor(White);
			writeln();
			write('3 to use ');
			TextColor(Magenta);
			write(character[charid].skill2_name);
			TextColor(White);
			writeln();
			writeln();
			exit := false;
			repeat
				option := read_number_input();
				case option of
					1: begin

						damage := calculate_damage(character,charid,0,0);
						write('You attaked dealing ');
						TextColor(Red);
						write(damage:5:1);
						TextColor(White);
						write(' damage !');
						writeln();
						monsterhp := monsterhp - damage;
						exit := true;
					end;
					2: begin
						case charid of
							1: begin
								exit := skill1_archer_function(character,periodic_damage,periodic_damage_turns,1);
							end;
						end;
					end;
				end;
			until exit;


			{periodic damage}
			if periodic_damage_turns > 0 then
			begin
				write('You dealt ');
				TextColor(Red);
				write(periodic_damage:5:1);
				TextColor(White);
				write(' periodic damage!');
				writeln();
				writeln();
				monsterhp := monsterhp - periodic_damage;
				Inc(periodic_damage_turns,-1);
			end;

			{monster damage}
			character[charid].hp := character[charid].hp - enemy[enemyid].base_dmg;
			TextColor(Yellow);
			write(enemy[enemyid].name);
			TextColor(White);
			write(' damaged you for ');
			TextColor(Red);
			write(enemy[enemyid].base_dmg:5:1);
			TextColor(White);
			write(' damage!');
			writeln();
			writeln();
			writeln('Press any key to continue...');
			writeln();
			readkey;


			{kill}
			if monsterhp <= 0 then
			begin
				writeln('You killed the ',enemy[enemyid].name,' and earned ',enemy[enemyid].xp,' xp!');
				character[charid].xp := character[charid].xp + enemy[enemyid].xp;
				writeln('Now you have ',character[charid].xp,' xp!');
				writeln('Press any key to continue...');
				writeln();
				readkey;
			end;
			if character[charid].hp <= 0 then
			begin
				writeln('You died!');
				writeln('Press any key to continue...');
				writeln();
				readkey;
			end;

		until(character[charid].hp <= 0) or (monsterhp <= 0);
	end;

end;


var
	class_chosen,kill,i: Integer;

begin
	writeln();

	{================setup===============}
	classes_setup(classes_info);
	monster_setup(monsters_info);
	{====================================}


	class_chosen := select_class_menu();
	if class_chosen <> 4 then
	begin
		draw_character(class_chosen);
		writeln();
		writeln('You selected the ',classes_info[class_chosen].name,'.');
		writeln('Press any key to continue....');
		readkey;
		writeln('How many porings do you want to kill?');
		readln(kill);
		for i := 1 to kill do
		begin
			battle(classes_info,class_chosen,monsters_info,1);
		end;	
	end;

	//character_menu_main();
end.