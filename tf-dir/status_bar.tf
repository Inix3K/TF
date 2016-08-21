;; Status Bar


;  The default list of status fields is:

/def status_default = \
	/set status_height 1 %;\
	/status_add -c @more:8:Br :1 @world :1 @read:6 :1 @active:11 :1 @log:5 :1 @mail:6 :1 insert:6 :1 kbnum:4 :1 @clock:5

/def status_def1 = \
	/status_add -c @more:8:Br :1 @world :1 @read:6 :1 @active:11 :1 @log:5 :1 @mail:6 :1 insert:6 :1 kbnum:4 :1 @clock:5

/def status_hp = \
	/set status_height 1		%;\
	/status_add -c status_bar	%;\
	/status_add @world:10		%;\
	/status_add @clock:5

/def status_hp2 = \
	/set status_height 3		%;\
	/status_def1			%;\
	/status_add -c -r1 status_bar	%;\
	/status_add -c -r2 status_bar2

/def status_hp3 = \
        /set status_height 4            %;\
        /status_def1                    %;\
        /status_add -c -r1 status_bar   %;\
        /status_add -c -r2 status_bar2  %;\
        /status_add -c -r3 status_bar3

/def status_hp4 = \
        /set status_height 5            %;\
        /status_def1                    %;\
        /status_add -c -r1 status_bar   %;\
        /status_add -c -r2 status_bar2  %;\
        /status_add -c -r3 status_bar3  %;\
        /status_add -c -r4 status_bar4


/set mdef 100
/def status_graph = \
	/eval /set token %%{%{1}}									%;\
	/eval /set mtoken %%{%{2}}									%;\
	/if (regmatch("[\d\.]+",token) = 0)								\
		/status_egraph %1									%;\
	/else												\
		/if (token < mtoken*.1) /set status_graph __________					%;\
		/elseif (token < mtoken*.2) /set status_graph $(/echo -p @{Cbgred}_@{n}_________)	%;\
		/elseif (token < mtoken*.3) /set status_graph $(/echo -p @{Cbgred}__@{n}________)	%;\
		/elseif (token < mtoken*.4) /set status_graph $(/echo -p @{Cbgred}___@{n}_______)	%;\
		/elseif (token < mtoken*.5) /set status_graph $(/echo -p @{Cbgred}____@{n}______)	%;\
		/elseif (token < mtoken*.6) /set status_graph $(/echo -p @{Cbgyellow}_____@{n}_____)	%;\
		/elseif (token < mtoken*.7) /set status_graph $(/echo -p @{Cbgyellow}______@{n}____)	%;\
		/elseif (token < mtoken*.8) /set status_graph $(/echo -p @{Cbgyellow}_______@{n}___)	%;\
		/elseif (token < mtoken*.9) /set status_graph $(/echo -p @{Cbgcyan}________@{n}__)	%;\
		/elseif (token < mtoken) /set status_graph $(/echo -p @{Cbgcyan}_________@{n}_)		%;\
		/elseif (token >= mtoken) /set status_graph $(/echo -aCbggreen __________)		%;\
		/else /set status_graph !ERROR! 							%;\
		/endif											%;\
		/set %{1}_graph %status_graph								%;\
	/endif

/def status_graph_rev = \
	/eval /set token %%{%{1}}								%;\
	/eval /set mtoken %%{%{2}}								%;\
	/if (token < mtoken*.1) /set status_graph __________					%;\
	/elseif (token < mtoken*.2) /set status_graph $(/echo -p @{Cbggreen}_@{n}_________)	%;\
	/elseif (token < mtoken*.3) /set status_graph $(/echo -p @{Cbggreen}__@{n}________)	%;\
	/elseif (token < mtoken*.4) /set status_graph $(/echo -p @{Cbgcyan}___@{n}_______)	%;\
	/elseif (token < mtoken*.5) /set status_graph $(/echo -p @{Cbgcyan}____@{n}______)	%;\
	/elseif (token < mtoken*.6) /set status_graph $(/echo -p @{Cbgyellow}_____@{n}_____)	%;\
	/elseif (token < mtoken*.7) /set status_graph $(/echo -p @{Cbgyellow}______@{n}____)	%;\
	/elseif (token < mtoken*.8) /set status_graph $(/echo -p @{Cbgyellow}_______@{n}___)	%;\
	/elseif (token < mtoken*.9) /set status_graph $(/echo -p @{Cbgred}________@{n}__)	%;\
	/elseif (token < mtoken) /set status_graph $(/echo -p @{Cbgred}_________@{n}_)		%;\
	/elseif (token >= mtoken) /set status_graph $(/echo -aCbgred !!!!!!!!!!)		%;\
	/else /set status_graph !ERROR!								%;\
	/endif											 %;\
	/set %{1}_graph %status_graph

/def status_egraph = \
	/eval /set token %%{%{1}}									%;\
	/if ((substr(token,0,3) =~ "Dea")|(token =~ "")|(token =~ "none")|(token =~ "None"))		\
		/set status_graph __________								%;\
	/elseif ((substr(token,0,3) =~ "eme")|(token =~ "eme")|(token =~ "almost"))			\
		/set status_graph $(/echo -p @{Cbgred}_@{n}_________)					%;\
	/elseif ((substr(token,0,3) =~ "ble")|(token =~ "bleed"))					\
		/set status_graph  $(/echo -p @{Cbgyellow}____@{n}______)				%;\
	/elseif (substr(token,0,3) =~ "bru")								\
		/set status_graph $(/echo -p @{Cbgcyan}________@{n}__)					%;\
	/elseif ((substr(token,0,3) =~ "per")|(token =~ "healthy"))					\
		/set status_graph  $(/echo -aCbggreen __________)					%;\
	/else /set status_graph !ERROR!									%;\
	/endif												%;\
	/set %{1}_graph %status_graph

/def status_graph_per = \
        /eval /set token %%{%{1}}                                                             							%;\
        /eval /set mtoken %%{%{2}}                                                                      					%;\
        /if (regmatch("[\d\.]+",token) = 0)                                                             					\
                /status_egraph %1                                                                       					%;\
        /else                                                                                        						\
		/eval /set token_per $[token*100/mtoken]											%;\
                /if (token < mtoken*.1)														\
			/set status_graph $(/echo -aBCred -p _____@{u}$[substr(token_per,0,2)]\%@{n}___)					%;\
                /elseif (token < mtoken*.2)													\
			/set status_graph $(/echo -aBCred -p @{Cbgred}_@{n}___@{u}$[substr(token_per,0,2)]\%@{n}___)				%;\
                /elseif (token < mtoken*.3)													\
			/set status_graph $(/echo -aBCred -p @{Cbgred}__@{n}__@{u}$[substr(token_per,0,2)]\%@{n}___)				%;\
                /elseif (token < mtoken*.4)													\
			/set status_graph $(/echo -aBCred -p @{Cbgred}___@{n}_@{u}$[substr(token_per,0,2)]\%@{n}___)				%;\
                /elseif (token < mtoken*.5)													\
			/set status_graph $(/echo -aBCred -p @{Cbgred}____@{n}@{u}$[substr(token_per,0,2)]\%@{n}___)				%;\
                /elseif (token < mtoken*.6)													\
			/set status_graph $(/echo -aBCyellow -p @{Cbgyellow}____@{u}@{BCblack}$[substr(token_per,0,1)]@{n}@{u}$[substr(token_per,1,1)]\%___)%;\
                /elseif (token < mtoken*.7)													\
			/set status_graph $(/echo -aBCyellow -p @{Cbgyellow}____@{u}@{BCblack}$[substr(token_per,0,2)]@{n}@{u}\%@{n}___)	%;\
                /elseif (token < mtoken*.8)													\
			/set status_graph $(/echo -aBCyellow -p @{Cbgyellow}____@{u}@{BCblack}$[substr(token_per,0,2)]\%@{n}___)		%;\
                /elseif (token < mtoken*.9)													\
			/set status_graph $(/echo -aBCcyan -p @{Cbgcyan}____@{u}@{BCblack}$[substr(token_per,0,2)]\%@{n}@{Cbgcyan}_@{n}__)	%;\
                /elseif (token < mtoken)													\
			/set status_graph $(/echo -aBCcyan -p @{Cbgcyan}____@{u}@{BCblack}$[substr(token_per,0,2)]\%@{n}@{Cbgcyan}__@{n}_)	%;\
                /elseif (token >= mtoken)													\
			/set status_graph $(/echo -aBCgreen -aCbggreen -p ___@{u}@{BCblack}$[substr(token_per,0,3)]\%@{n}___)			%;\
                /else /set status_graph !ERROR!                                                         					%;\
                /endif                                                                                  					%;\
                /set %{1}_graph %status_graph                                                           					%;\
        /endif

/def status_graph_per2 = \
        /eval /set token %%{%{1}}                                                                                                       		        %;\
        /eval /set mtoken %%{%{2}}                                                                                                      		        %;\
        /if (regmatch("[\d\.]+",token) = 0)                                                                                             		        \
                /status_egraph %1                                                                                                       		        %;\
        /else                                                                                                                           		        \
                /eval /set token_per $[token*100.0/mtoken]                                                                              		        %;\
		/if (strlen(token_per)-strstr(token_per,".")-1 = 0)												\
			/eval /set token_per $[strcat(token_per,"00")]												%;\
		/elseif (strlen(token_per)-strstr(token_per,".")-1 = 1)												\
			/eval /set token_per $[strcat(token_per,"0")]												%;\
		/else																		\
			/eval /set token_per $[substr(token_per,0,strstr(token_per,".")+3)]									%;\
		/endif																		%;\
                /if (token < mtoken*.1)                                                                                                 		        \
                        /set status_graph $(/echo -aBCred -p ___@{u}$[substr(token_per,0,4)]\%__)								%;\
                /elseif (token < mtoken*.2)															\
                        /set status_graph $(/echo -aBCred -p @{Cbgred}_@{n}_@{u}$[substr(token_per,0,5)]\%__)							%;\
                /elseif (token < mtoken*.3)															\
                        /set status_graph $(/echo -aBCred -p @{Cbgred}__@{n}@{u}$[substr(token_per,0,5)]\%__)							%;\
                /elseif (token < mtoken*.4)															\
                        /set status_graph $(/echo -aBCred -p @{Cbgred}__@{u}@{BCblack}$[substr(token_per,0,1)]@{n}@{u}$[substr(token_per,1,4)]\%__)		%;\
                /elseif (token < mtoken*.5)															\
                        /set status_graph $(/echo -aBCred -p @{Cbgred}__@{u}@{BCblack}$[substr(token_per,0,2)]@{n}@{u}$[substr(token_per,2,3)]\%__)		%;\
                /elseif (token < mtoken*.6)															\
                        /set status_graph $(/echo -aBCyellow -p @{Cbgyellow}__@{u}@{BCblack}$[substr(token_per,0,3)]@{n}@{u}$[substr(token_per,3,2)]\%__)	%;\
                /elseif (token < mtoken*.7)															\
                        /set status_graph $(/echo -aBCyellow -p @{Cbgyellow}__@{u}@{BCblack}$[substr(token_per,0,4)]@{n}@{u}$[substr(token_per,4,1)]\%__)	%;\
                /elseif (token < mtoken*.8)															\
                        /set status_graph $(/echo -aBCyellow -p @{Cbgyellow}__@{u}@{BCblack}$[substr(token_per,0,5)]@{n}\%__)					%;\
                /elseif (token < mtoken*.9)															\
                        /set status_graph $(/echo -aBCcyan -p @{Cbgcyan}__@{u}@{BCblack}$[substr(token_per,0,5)]\%@{n}@{Cbgcyan}@{n}__)				%;\
                /elseif (token < mtoken)															\
                        /set status_graph $(/echo -aBCcyan -p @{Cbgcyan}__@{u}@{BCblack}$[substr(token_per,0,5)]\%@{n}@{Cbgcyan}_@{n}_)				%;\
                /elseif (token >= mtoken)															\
                        /set status_graph $(/echo -aBCgreen -aCbggreen -p _@{u}@{BCblack}$[substr(token_per,0,6)]\%__)						%;\
                /else /set status_graph !ERROR!															%;\
                /endif																		%;\
                /set %{1}_graph %status_graph															%;\
        /endif


/def status_color = \
	/eval /set token %%{%{1}}			%;\
	/eval /set mtoken %%{%{2}}			%;\
	/if (token < mtoken*.1)				\
		/set token $(/echo -aBCred %token)	%;\
	/elseif (token < mtoken*.2)			\
		/set token $(/echo -aCred %token)	%;\
	/elseif (token < mtoken*.5)			\
		/set token $(/echo -aCyellow %token)	%;\
	/elseif (token < mtoken*.8)			\
		/set token $(/echo -aCgreen %token)	%;\
	/elseif (token <= mtoken)			\
		/set token $(/echo -aBCgreen %token)	%;\
	/elseif (token > mtoken)			\
		/set token $(/echo -aBCcyan %token)	%;\
	/endif						%;\
	/set %1 %token
