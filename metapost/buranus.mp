prologues := 3;
outputtemplate := "%j%c.eps";

u = 1pt;

path punctum;
punctum=(0,0){right rotated 20}..{right rotated 70}(u,0.5u);

path tractulus;
tractulus=(0,0)..(3u,0)..(6u,0.5u);

path stropha;
stropha=(0,0)..(1.5u,3u)..(0,6u);

path substropha;
substropha=(0,0)..(1.5u,-2u)..(0,-4u);

path virga;
virga=(0,0)--(-9u,-12u)--(-7.5u,-11u);

path pes_loop;
pes_loop=(3u,5u)..(0,5u/3)..(3u,0)..(6u,5u/3);

path pes;
pes=pes_loop&((6u,5u/3)..(9u,11u)..(12u,15u));

path clivis_hor;
clivis_hor=(0,0)..(0.75[0,10.5u],3u)..(10.5u,3u);

path clivis_end;
clivis_end=clivis_hor&(virga shifted (point 1000 of clivis_hor - point 0 of virga));

path clivis_end_liquescent;
clivis_end_liquescent=clivis_end&(substropha shifted (point 1000 of clivis_end - point 0 of substropha));

path torculus;
torculus=pes&(clivis_end shifted (point 1000 of pes - point 0 of clivis_end));

path torculus_liquescent;
torculus_liquescent=pes&(clivis_end_liquescent shifted (point 1000 of pes - point 0 of clivis_end_liquescent));

path porrectus_end;
porrectus_end=clivis_hor&((10.5u,3u)--(4.5u,-5u){point 1 of virga}..{-(point 1 of virga)}(12u,-6u)--(15u,-2u));

path liquescence_loop;
liquescence_loop=reverse pes_loop rotated 180;

path cuoricino;
cuoricino=(0,0)--(2u,-2u)..(6u,0)..(9u,-2u)..(6u,-8u);

path virga_liq;
virga_liq=reverse virga&(liquescence_loop shifted (point 1000 of reverse virga - point 0 of liquescence_loop));

path oriscus;
oriscus=((0,0){down rotated 45}..(2u,-2u)..{up rotated -45}(4.5u,0)--(7.5u,-2u));

path reversed_oriscus;
reversed_oriscus=((0,0){right rotated 30}..(4.5u,2u)..{right rotated -30}(7.5u,0)--(9u,u));

path pes_liquescent;
pes_liquescent=pes&(liquescence_loop shifted (point 1000 of pes - point 0 of liquescence_loop));

path epiphonus;
epiphonus=(2u,4.5u)..(0,2u)..(3u,0)..{right rotated 60}(7.5u,4.5u);

path episema;
episema=(0,0)--(6u,0);

path short_stroke;
short_stroke=(0,0)--(6u,u);

path stroke;
stroke=(0,0)--(18u,3u);

path ancus_loop;
ancus_loop=(0,0)..(7.5u,0)..(7.5u,-7.5u);

path mystery_loop;
mystery_loop=(0,0)..(4.5u,3u)..(9u,-3u);

path connector;
connector=(0,0)--(6u,4u);

beginfig(1);
% Punctum
% pu
draw punctum withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(2);
% Tractulus
% tr
draw tractulus withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(3);
% Stropha
% st
draw stropha withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(4);
% Distropha
% ds
draw stropha withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(5);
% Tristropha
% ts
draw stropha withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(6);
% Virga
% vi
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(7);
% Virga liquescent
% vi)
draw virga_liq withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(8);
% Special virga (?)
% vi*
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw mystery_loop withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(9);
% Virga strata
% vs
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(10);
% Pressus maior
% pr
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(11);
% Pressus maior + stropha
% pr!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (15u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(12);
% Virga + oriscus + punctum (separated form) (?)
% vi!or!pu
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted (3u,-3u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (6u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(13);
% Virga strata + 2 subpuncta
% vssu2
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (6u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (9u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(14);
% Virga strata + 2 subpuncta + stropha
% vssu2!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (6u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (9u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (15u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(15);
% Virga liquescent + 1 subpunctum
% vi)su1
draw virga_liq withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (9u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(16);
% Virga liquescent + 2 subpuncta
% vi)su2
draw virga_liq withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (9u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (12u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(17);
% Virga + 1 subpunctum + substropha
% visu2-
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (6u,-12u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(18);
% Virga + 3 subpuncta
% visu3
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (7.5u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (12u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(19);
% Virga + 2 subpuncta + substropha
% visu3-
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (7.5u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (12u,-12u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(20);
% Virga + 3 subpuncta + stropha
% visu3!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (7.5u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (12u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (18u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(21);
% Virga + 4 subpuncta
% visu4
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (7u,-8u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (11u,-10u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(22);
% Virga + 3 subpuncta + epiphonus (?)
% visu3°
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (7u,-8u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (11u,-10u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw epiphonus shifted (16.5u,-12u) withpen pencircle xscaled 4u yscaled 1u rotated 45;
endfig;

beginfig(23);
% Virga + 3 subpuncta + substropha
% visu4-
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (7u,-8u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (11u,-10u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (15u,-12u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(24);
% Virga + 5 subpuncta
% visu5
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (2u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (10u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (14u,-10.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(25);
% Virga with stroke
% vi/
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw short_stroke shifted (-9u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(26);
% Virga liquescent with stroke
% vi)/
draw virga_liq withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw short_stroke shifted (-9u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(27);
% Virga + 2 subpuncta + substropha + stropha
% visu3-!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (7.5u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (12u,-12u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (18u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(28);
% Epiphonus
% ep
draw epiphonus withpen pencircle xscaled 4u yscaled 1u rotated 45;
endfig;

beginfig(29);
% Epiphonus + 1 prepunctum
% eppp1
draw epiphonus withpen pencircle xscaled 4u yscaled 1u rotated 45;
draw punctum shifted (-6u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(30);
% Pes
% pe
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(31);
% Pes liquescent
% pe)
draw pes_liquescent withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(32);
% Pes + 2 subpuncta
% pesu2
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(33);
% Pes + 1 subpunctum + substropha
% pesu2-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (18u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(34);
% Pes + 2 subpuncta + stropha
% pesu2!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (24u, 6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(35);
% Pes + 3 subpuncta
% pesu3
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(36);
% Pes + 2 subpuncta + substropha
% pesu3-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (21u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(37);
% Pes + 3 subpuncta + substropha
% pesu4-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,4u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,2u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (24u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(38);
% Pes + 3 subpuncta + stropha
% pesu3!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (27u,6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(39);
% Pes + 2 subpuncta + substropha + stropha
% pesu3-!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (21u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (27u,6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(40);
% Pes + 1 prepunctum
% pepp1
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-6u, 0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(41);
% Pes liquescent + 1 prepunctum
% pe)pp1
draw pes_liquescent withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-6u, 0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(42);
% Pes + porrectus
% pe!po
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw porrectus_end shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(43);
% Pes + oriscus
% pe!or
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(44);
% Pes + pressus minor
% pe!pm
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(45);
% Ancus
% an
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw ancus_loop withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(46);
% Clivis
% cl
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(47);
% Clivis liquescent
% cl)
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end_liquescent withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(48);
% Clivis episemata (?)
% cl-
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw episema shifted (10.5u,3u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(49);
% Clivis with stroke
% cl/
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stroke shifted (-9u,-4.5u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(50);
% Clivis + stropha
% cl!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (15u,-3u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(51);
% Clivis + 2 prepuncta
% clpp2
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u, -21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(52);
% Clivis + 2 subpuncta
% clsu2
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (9u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (13.5u, -12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(53);
% Clivis + 2 subpuncta + stropha
% clsu2!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (9u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (13.5u, -12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (25.5u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(54);
% Torculus
% to
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(55);
% Torculus + oriscus
% to!or
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw connector shifted (point 1000 of torculus) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted ((6u,4u) + (point 1000 of torculus)) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(56);
% Torculus + pressus minor
% to!pm
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw connector shifted (point 1000 of torculus) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted ((6u,4u) + (point 1000 of torculus)) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (24u, 3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(57);
% Porrectus
% po
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw porrectus_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(58);
% Porrectus liquescent
% po)
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw porrectus_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw liquescence_loop shifted (20.5u,-1u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(59);
% Quilisma 2 loops
% qi
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(60);
% Quilisma 2 loops liquescent
% qi)
draw pes_liquescent withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(61);
% Quilisma 2 loops + clivis
% qi!cl
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(62);
% Quilisma 2 loops + clivis + 1 subpunctum
% qi!clsu1
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(63);
% Quilisma 2 loops + clivis + 2 subpuncta
% qi!clsu2
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(64);
% Quilisma 2 loops + 1 prepunctum + clivis + 1 subpunctum + stropha
% qipp1!clsu1!st
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (27u,9u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(65);
% Quilisma 2 loops + 1 prepunctum + clivis
% qipp1!cl
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(66);
% Quilisma 2 loops + clivis + stropha
% qi!cl!st
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (27u,9u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(67);
% Quilisma 2 loops + 1 prepunctum + clivis + stropha
% qipp1!cl!st
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (27u,9u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(68);
% Quilisma 2 loops + porrectus
% qi!po
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw porrectus_end shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(69);
% Quilisma 2 loops + 1 prepunctum + clivis + oriscus
% qipp1!cl!or
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw liquescence_loop shifted (point 1000 of torculus - point 0 of liquescence_loop) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(70);
% Quilisma 2 loops + oriscus
% qi!or
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted (12u,15u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(71);
% Quilisma 2 loops + pressus maior
% qi!pr
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted (12u,15u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(72);
% Quilisma 2 loops + oriscus liquescent
% qi!or)
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw cuoricino shifted (12u,15u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(73);
% Quilisma 2 loops + oriscus liquescent + 1 subpunctum
% qi!or)su1
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw cuoricino shifted (12u,15u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (18u,u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(74);
% Quilisma 2 loops + oriscus liquescent + 1 prepunctum + 1 substropha
% qi!or)-pp1
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw cuoricino shifted (12u,15u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw substropha shifted (18u,3u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(75);
% Quilisma 2 loops + 1 prepunctum
% qipp1
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(76);
% Quilisma 2 loops + 2 subpuncta
% qisu2
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(77);
% Quilisma 2 loops + 1 prepunctum + 2 subpuncta
% qipp1su2
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(78);
% Quilisma 2 loops + 1 subpunctum + substropha
% qisu2-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (18u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(79);
% Quilisma 2 loops + 1 prepunctum + 1 subpunctum + substropha
% qipp1su2-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (18u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(80);
% Quilisma 2 loops + 2 subpuncta + stropha
% qisu2!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (24u,6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(81);
% Quilisma 2 loops + 1 prepunctum + 2 subpuncta + stropha
% qipp1su2!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (24u,6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(82);
% Quilisma 2 loops + 3 subpuncta
% qisu3
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(83);
% Quilisma 2 loops + 2 subpuncta + substropha
% qisu3-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (21u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(84);
% Quilisma 2 loops + 1 prepunctum + 2 subpuncta + substropha
% qipp1su3-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (21u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(85);
% Quilisma 2 loops + 3 subpuncta + substropha
% qisu4-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,4u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,2u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (24u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(86);
% Quilisma 2 loops + ancus + 2 subpuncta
% qi!ansu2
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw ancus_loop shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,0u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(87);
% Quilisma 3 loops
% ql
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(88);
% Quilisma 3 loops liquescent
% ql)
draw pes_liquescent withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(89);
% Quilisma 3 loops + ancus
% ql!an
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw ancus_loop shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(90);
% Quilisma 3 loops + clivis
% ql!cl
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(91);
% Quilisma 3 loops + clivis liquescent
% ql!cl)
draw torculus_liquescent withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(92);
% Quilisma 3 loops + 1 prepunctum + clivis
% qlpp1!cl
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(93);
% Quilisma 3 loops + 1 prepunctum + clivis + 2 subpuncta
% qlpp1!clsu2
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(94);
% Quilisma 3 loops + clivis + oriscus
% ql!cl!or
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw liquescence_loop shifted (point 1000 of torculus - point 0 of liquescence_loop) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(95);
% Quilisma 3 loops + clivis + 1 subpunctum
% ql!clsu1
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (19.5u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(96);
% Quilisma 3 loops + clivis + stropha
% ql!cl!st
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (27u,9u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(97);
% Quilisma 3 loops + 1 prepunctum + clivis + stropha
% qlpp1!cl!st
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (27u,9u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(98);
% Quilisma 3 loops + porrectus
% ql!po
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw porrectus_end shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(99);
% Quilisma 3 loops + 1 prepunctum + porrectus
% qlpp1!po
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw porrectus_end shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(100);
% Quilisma 3 loops + oriscus
% ql!or
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(101);
% Quilisma 3 loops + oriscus liquescent
% ql!or)
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw cuoricino shifted (12u,15u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(102);
% Quilisma 3 loops + pressus maior
% ql!pr
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted point 1000 of pes shifted (0,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(103);
% Quilisma 3 loops + oriscus liquescent + 1 subpunctum
% ql!or)su1
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw cuoricino shifted (12u,15u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (20u,u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(104);
% Quilisma 3 loops + 2 subpuncta
% qlsu2
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(105);
% Quilisma 3 loops + 1 prepunctum + 2 subpuncta
% qlpp1su2
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(106);
% Quilisma 3 loops + 1 subpunctum + substropha
% qlsu2-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (18u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(107);
% Quilisma 3 loops + 3 subpuncta
% qlsu3
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(108);
% Quilisma 3 loops + 2 subpuncta + substropha
% qlsu3-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (21u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(109);
% Quilisma 3 loops + 1 prepunctum + 2 subpuncta + substropha
% qlpp1su3-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (21u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(110);
% Quilisma 3 loops + 2 subpuncta + stropha
% qlsu2!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (24u,6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(111);
% Quilisma 3 loops + 1 prepunctum + 2 subpuncta + stropha
% qlpp1su2!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (24u,6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(112);
% Quilisma 3 loops + 1 prepunctum + 2 subpuncta + substropha
% qlpp1su4-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,4u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,2u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (24u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(113);
% Quilisma 3 loops + 1 prepunctum
% qlpp1
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(114);
% Quilisma 4 loops
% qs
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-18u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(115);
% Quilisma 4 loops + 3 subpuncta
% qssu3
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-18u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(116);
% Climacus
% ci
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(117);
% Climacus with stroke
% ci/
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw short_stroke shifted (-9u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(118);
% Climacus + epiphonus (?)
% ci°
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw epiphonus shifted (10.5u,-12u) withpen pencircle xscaled 4u yscaled 1u rotated 45;
endfig;

beginfig(119);
% Climacus + stropha
% ci!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (12u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(120);
% Climacus + stropha + pressus minor
% ci!st!pm
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (12u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw reversed_oriscus shifted (12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (18u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(121);
% Climacus + 2 prepuncta
% cipp2
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-12u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u,-21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(122);
% Climacus + 2 prepuncta + stropha
% cipp2!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (12u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u,-21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(123);
% Scandicus
% sc
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u,-21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(124);
% Scandicus liquescent
% sc)
draw virga_liq withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u,-21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(125);
% Scandicus with tractulus as middle note
% sc-
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw tractulus shifted (-15u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u,-21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(126);
% Scandicus with tractulus as middle note + quilisma 3 loops
% sc-!ql
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw tractulus shifted (-12u,-4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

bye