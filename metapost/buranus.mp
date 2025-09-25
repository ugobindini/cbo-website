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

path torculus;
torculus=pes&(clivis_end shifted (point 1000 of pes - point 0 of clivis_end));

path porrectus_end;
porrectus_end=clivis_hor&((10.5u,3u)--(4.5u,-5u){point 1 of virga}..{-(point 1 of virga)}(12u,-6u)--(15u,-2u));

path liquescence_loop;
liquescence_loop=reverse pes_loop rotated 180;

path clivis_end_liquescent;
clivis_end_liquescent=clivis_end&(liquescence_loop shifted (point 1000 of clivis_end - point 0 of liquescence_loop));

path torculus_liquescent;
torculus_liquescent=pes&(clivis_end_liquescent shifted (point 1000 of pes - point 0 of clivis_end_liquescent));

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
% 3 puncta
% 3p
draw punctum withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (4.5u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (9u,9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(3);
% Tractulus
% tr
draw tractulus withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(4);
% Stropha
% st
draw stropha withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(5);
% Distropha
% ds
draw stropha withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(6);
% Tristropha
% ts
draw stropha withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(7);
% Virga
% vi
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(8);
% Virga liq.
% vi)
draw virga_liq withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(9);
% Special virga (?)
% vi*
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw mystery_loop withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(10);
% Virga + oriscus
% vs
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(11);
% Virga + oriscus + 1 subpunctum
% pr
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(12);
% Virga + oriscus + 1 subpunctum + stropha
% pr!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (15u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(13);
% Virga + oriscus + 2 subpuncta
% vssu2
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (6u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (9u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(14);
% Virga + oriscus + 2 subpuncta + stropha
% vssu2!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (6u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (9u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (15u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(15);
% Virga liq. + 1 subpunctum
% vi)su1
draw virga_liq withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (9u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(16);
% Virga liq. + 2 subpuncta
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
% Virga + 3 subpuncta + epiphonus
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
% Virga + 4 subpuncta + stropha
% visu4!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (7u,-8u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (11u,-10u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (21u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(25);
% Virga + 5 subpuncta
% visu5
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (2u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (10u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (14u,-10.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(26);
% Virga with stroke
% vi/
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw short_stroke shifted (-9u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(27);
% Virga liq. with stroke
% vi)/
draw virga_liq withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw short_stroke shifted (-9u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(28);
% Virga + 2 subpuncta + substropha + stropha
% visu3-!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (7.5u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (12u,-12u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (18u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(29);
% Epiphonus
% ep
draw epiphonus withpen pencircle xscaled 4u yscaled 1u rotated 45;
endfig;

beginfig(30);
% 1 prepunctum + epiphonus
% eppp1
draw epiphonus withpen pencircle xscaled 4u yscaled 1u rotated 45;
draw punctum shifted (-6u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(31);
% Pes
% pe
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(32);
% Pes liq.
% pe)
draw pes_liquescent withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(33);
% Pes + 2 subpuncta
% pesu2
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(34);
% Pes + 1 subpunctum + substropha
% pesu2-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (18u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(35);
% Pes + 2 subpuncta + stropha
% pesu2!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (24u, 6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(36);
% Pes + 3 subpuncta
% pesu3
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(37);
% Pes + 2 subpuncta + substropha
% pesu3-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (21u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(38);
% Pes + 3 subpuncta + substropha
% pesu4-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,4u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,2u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (24u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(39);
% Pes + 3 subpuncta + stropha
% pesu3!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (27u,6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(40);
% Pes + 2 subpuncta + substropha + stropha
% pesu3-!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (21u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (27u,6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(41);
% Pes + 4 subpuncta + stropha
% pesu4!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,4u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,2u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (24u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (30u,6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(42);
% 1 prepunctum + pes
% pepp1
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-6u, 0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(43);
% 1 prepunctum + pes liq.
% pe)pp1
draw pes_liquescent withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-6u, 0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(44);
% 1 prepunctum + pes + 3 subpuncta
% pepp1su3
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-6u, 0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(45);
% Torculus resupinus
% pe!po
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw porrectus_end shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(46);
% Pes + oriscus
% pe!or
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(47);
% Pes + oriscus + 1 subpunctum
% pe!pm
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(48);
% Ancus
% an
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw ancus_loop withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(49);
% Clivis
% cl
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(50);
% Clivis liq.
% cl)
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end_liquescent withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(51);
% Clivis with stroke above
% cl-
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw episema shifted (10.5u,3u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(52);
% Clivis with stroke
% cl/
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stroke shifted (-9u,-4.5u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(53);
% Clivis + stropha
% cl!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (15u,-3u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(54);
% Clivis liq. + stropha
% cl)!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end_liquescent withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (15u,-3u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(55);
% 1 prepunctum + clivis
% clpp1
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(56);
% 2 prepuncta + clivis
% clpp2
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u, -21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(57);
% 2 prepuncta + clivis + stropha
% clpp2!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u, -21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (15u,-3u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(58);
% Clivis + 2 subpuncta
% clsu2
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (9u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (13.5u, -12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(59);
% Clivis + 2 subpuncta + stropha
% clsu2!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (9u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (13.5u, -12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (25.5u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(60);
% Clivis + 3 subpuncta
% clsu3
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw clivis_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (9u,-8u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (13.5u, -10u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u, -12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(61);
% Torculus
% to
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(62);
% Torculus + 1 subpunctum
% tosu1
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(63);
% Torculus + oriscus
% to!or
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw connector shifted (point 1000 of torculus) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted ((6u,4u) + (point 1000 of torculus)) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(64);
% Torculus + oriscus + 1 subpunctum
% to!pm
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw connector shifted (point 1000 of torculus) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted ((6u,4u) + (point 1000 of torculus)) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (24u, 3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(65);
% 1 prepunctum + torculus
% topp1
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-6u, 0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(66);
% Porrectus
% po
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw porrectus_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(67);
% 2 prepuncta + porrectus
% popp2
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw porrectus_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u,-21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(68);
% Porrectus liq.
% po)
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw porrectus_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw liquescence_loop shifted (20.5u,-1u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(69);
% Porrectus + oriscus + 1 subpunctum
% po!pm
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw porrectus_end withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted (15u,-2u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (18u, -12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(70);
% Quilisma 2 loops + virga
% qi
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(71);
% Quilisma 2 loops + virga liq.
% qi)
draw pes_liquescent withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(72);
% Quilisma 2 loops + virga + stropha
% qi!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (18u,9u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(73);
% Quilisma 2 loops + clivis
% qi!cl
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(74);
% Quilisma 2 loops + clivis liq.
% qi!cl)
draw torculus_liquescent withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(75);
% Quilisma 2 loops + clivis + 1 subpunctum
% qi!clsu1
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(76);
% Quilisma 2 loops + clivis + 2 subpuncta
% qi!clsu2
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(77);
% 1 prepunctum + quilisma 2 loops + clivis + 1 subpunctum + stropha
% qipp1!clsu1!st
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (27u,9u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(78);
% 1 prepunctum + quilisma 2 loops + clivis
% qipp1!cl
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(79);
% Quilisma 2 loops + clivis + stropha
% qi!cl!st
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (27u,9u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(80);
% 1 prepunctum + quilisma 2 loops + clivis + stropha
% qipp1!cl!st
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (27u,9u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(81);
% Quilisma 2 loops + porrectus
% qi!po
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw porrectus_end shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(82);
% 1 prepunctum + quilisma 2 loops + clivis liq.
% qipp1!cl!or
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw liquescence_loop shifted (point 1000 of torculus - point 0 of liquescence_loop) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(83);
% Quilisma 2 loops + virga + oriscus
% qi!or
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted (12u,15u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(84);
% Quilisma 2 loops + virga + oriscus + 1 subpunctum
% qi!pr
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted (12u,15u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(85);
% Quilisma 2 loops + virga + oriscus liq.
% qi!or)
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw cuoricino shifted (12u,15u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(86);
% Quilisma 2 loops + virga + oriscus liq. + 1 subpunctum
% qi!or)su1
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw cuoricino shifted (12u,15u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (18u,u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(87);
% 1 prepunctum + quilisma 2 loops + virga + oriscus liq. + 1 substropha
% qi!or)-pp1
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw cuoricino shifted (12u,15u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw substropha shifted (18u,3u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(88);
% 1 prepunctum + quilisma 2 loops + virga
% qipp1
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(89);
% Quilisma 2 loops + virga + 2 subpuncta
% qisu2
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(90);
% 1 prepunctum + quilisma 2 loops + virga + 2 subpuncta
% qipp1su2
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(91);
% Quilisma 2 loops + virga + 1 subpunctum + substropha
% qisu2-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (18u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(92);
% 1 prepunctum + quilisma 2 loops + virga + 1 subpunctum + substropha
% qipp1su2-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (18u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(93);
% Quilisma 2 loops + virga + 2 subpuncta + stropha
% qisu2!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (24u,6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(94);
% 1 prepunctum + quilisma 2 loops + virga + 2 subpuncta + stropha
% qipp1su2!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (24u,6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(95);
% Quilisma 2 loops + virga + 3 subpuncta
% qisu3
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(96);
% Quilisma 2 loops + virga + 2 subpuncta + substropha
% qisu3-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (21u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(97);
% 1 prepunctum + quilisma 2 loops + virga + 2 subpuncta + substropha
% qipp1su3-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (21u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(98);
% Quilisma 2 loops + virga + 3 subpuncta + substropha
% qisu4-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,4u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,2u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (24u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(99);
% Quilisma 2 loops + virga + 4 subpuncta + stropha
% qisu4!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,4u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,2u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (24u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (30u,6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(100);
% Quilisma 2 loops + ancus + 2 subpuncta
% qi!ansu2
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw ancus_loop shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,0u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(101);
% Quilisma 3 loops + virga
% ql
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(102);
% Quilisma 3 loops + virga liq.
% ql)
draw pes_liquescent withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(103);
% Quilisma 3 loops + ancus
% ql!an
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw ancus_loop shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(104);
% Quilisma 3 loops + clivis
% ql!cl
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(105);
% Quilisma 3 loops + clivis liq.
% ql!cl)
draw torculus_liquescent withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(106);
% Quilisma 3 loops + clivis + substropha
% ql!cl-
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw substropha shifted (19.5u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(107);
% 1 prepunctum + quilisma 3 loops + clivis
% qlpp1!cl
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(108);
% 1 prepunctum + quilisma 3 loops + clivis + 2 subpuncta
% qlpp1!clsu2
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(109);
% Quilisma 3 loops + clivis + 1 subpunctum
% ql!clsu1
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (19.5u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(110);
% Quilisma 3 loops + clivis + stropha
% ql!cl!st
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw stropha shifted (27u,9u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(111);
% 1 prepunctum + quilisma 3 loops + clivis + stropha
% qlpp1!cl!st
draw torculus withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (27u,9u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(112);
% Quilisma 3 loops + porrectus
% ql!po
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw porrectus_end shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(113);
% 1 prepunctum + quilisma 3 loops + porrectus
% qlpp1!po
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw porrectus_end shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(114);
% Quilisma 3 loops + virga + oriscus
% ql!or
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(115);
% Quilisma 3 loops + virga + oriscus liq.
% ql!or)
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw cuoricino shifted (12u,15u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(116);
% Quilisma 3 loops + virga + oriscus + 1 subpunctum
% ql!pr
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw oriscus shifted point 1000 of pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted point 1000 of pes shifted (0,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(117);
% Quilisma 3 loops + virga + oriscus liq. + 1 subpunctum
% ql!or)su1
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw cuoricino shifted (12u,15u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (20u,u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(118);
% Quilisma 3 loops + virga + 2 subpuncta
% qlsu2
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(119);
% 1 prepunctum + quilisma 3 loops + virga + 2 subpuncta
% qlpp1su2
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(120);
% Quilisma 3 loops + virga + 1 subpunctum + substropha
% qlsu2-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (18u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(121);
% Quilisma 3 loops + virga + 3 subpuncta
% qlsu3
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(122);
% Quilisma 3 loops + virga + 2 subpuncta + substropha
% qlsu3-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (21u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(123);
% 1 prepunctum + quilisma 3 loops + virga + 2 subpuncta + substropha
% qlpp1su3-
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw substropha shifted (21u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(124);
% Quilisma 3 loops + virga + 2 subpuncta + stropha
% qlsu2!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (24u,6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(125);
% 1 prepunctum + quilisma 3 loops + virga + 2 subpuncta + stropha
% qlpp1su2!st
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (15u,4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (24u,6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(126);
% 1 prepunctum + Quilisma 3 loops + virga + 2 subpuncta + substropha
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

beginfig(127);
% 1 prepunctum + Quilisma 3 loops + virga
% qlpp1
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-18u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(128);
% Quilisma 4 loops + virga
% qs
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-18u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(129);
% Quilisma 4 loops + virga + 3 subpuncta
% qssu3
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-18u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (15u,6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (18u,3u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (21u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(130);
% Virga + 2 subpuncta
% ci
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(131);
% Virga with stroke + 2 subpuncta<
% ci/
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw short_stroke shifted (-9u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(132);
% Virga + 2 subpuncta + epiphonus
% ci°
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw epiphonus shifted (10.5u,-12u) withpen pencircle xscaled 4u yscaled 1u rotated 45;
endfig;

beginfig(133);
% Virga + 2 subpuncta + stropha
% ci!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (12u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
endfig;

beginfig(134);
% Virga + 2 subpuncta + stropha + oriscus + 1subpunctum
% ci!st!pm
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (12u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw reversed_oriscus shifted (12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (18u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(135);
% 2 prepuncta + virga + 2 subpuncta
% cipp2
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-12u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u,-21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(136);
% 2 prepuncta + virga + 2 subpuncta + stropha
% cipp2!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-7.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (6u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (12u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u,-21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(137);
% 2 prepuncta + virga
% sc
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u,-21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(138);
% 2 prepuncta + virga + 3 subpuncta
% scsu3
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (7.5u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (12u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-12u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u,-21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(139);
% 2 prepuncta + virga + 3 subpuncta + stropha
% scsu3!st
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (3u,-6u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (7.5u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (12u,-12u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw stropha shifted (18u,-6u) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u,-21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(140);
% 2 prepuncta + virga liq.
% sc)
draw virga_liq withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw punctum shifted (-12u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u,-21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(141);
% 1 prepunctum + tractulus + virga
% sc-
draw virga withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw tractulus shifted (-15u,-16.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u,-21u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(142);
% 1 prepunctum + tractulus + quilisma 3 loops + virga
% sc-!ql
draw pes withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-6u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw pes_loop shifted (-12u,0) withpen pencircle xscaled 4u yscaled 1u rotated 22.5;
draw tractulus shifted (-12u,-4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (-15u,-9u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

beginfig(143);
% Trigonus
% tg
draw punctum shifted (0,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (3u,-4.5u) withpen pencircle xscaled 4u yscaled 2u rotated 20;
draw punctum shifted (9u,0) withpen pencircle xscaled 4u yscaled 2u rotated 20;
endfig;

bye