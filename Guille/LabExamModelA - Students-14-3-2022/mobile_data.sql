\c mobile


insert into mobile values(1, 'Apple');
insert into mobile values(2, 'Fairphone');
insert into mobile values(3, 'Samsung');
insert into mobile values(4, 'Xiaomi');
insert into mobile values(5, 'Oppo');


insert into component values(100, 'Electronic');
insert into component values(101, 'Box');
insert into component values(102, 'Battery');
insert into component values(103, 'Microphone');
insert into component values(104, 'MicroSD card');
insert into component values(105, 'Foldable');


insert into mobilecomponent values(1, 100);
insert into mobilecomponent values(1, 101);
insert into mobilecomponent values(1, 102);
insert into mobilecomponent values(1, 103);
insert into mobilecomponent values(2, 100);
insert into mobilecomponent values(2, 101);
insert into mobilecomponent values(2, 102);
insert into mobilecomponent values(2, 103);
insert into mobilecomponent values(2, 104);
insert into mobilecomponent values(3, 100);
insert into mobilecomponent values(3, 101);
insert into mobilecomponent values(3, 102);
insert into mobilecomponent values(3, 103);
insert into mobilecomponent values(4, 100);
insert into mobilecomponent values(4, 101);
insert into mobilecomponent values(4, 102);
insert into mobilecomponent values(4, 103);
insert into mobilecomponent values(5, 100);
insert into mobilecomponent values(5, 101);
insert into mobilecomponent values(5, 102);
insert into mobilecomponent values(5, 103);
insert into mobilecomponent values(5, 104);
insert into mobilecomponent values(5, 105);


insert into material values(200, 'nickel');
insert into material values(201, 'coltan');
insert into material values(202, 'lithium');
insert into material values(203, 'magnesium');
insert into material values(204, 'neodymium');
insert into material values(205, 'dysprosium');
insert into material values(206, 'gallium');


insert into componentMaterial values (100, 200);
insert into componentMaterial values(100, 206);
insert into componentMaterial values(101, 200);
insert into componentMaterial values(101, 203);
insert into componentMaterial values(102, 202);
insert into componentMaterial values(102, 200);
insert into componentMaterial values(102, 201);
insert into componentMaterial values (103, 200);
insert into componentMaterial values (103, 204);
insert into componentMaterial values (103, 205);
insert into componentMaterial values (103, 206);


insert into origin values(301, 'Congo');
insert into origin values(302, 'Australia');
insert into origin values(303, 'Brazil');
insert into origin values(304, 'Thailand');
insert into origin values(305, 'Russia');
insert into origin values(306, 'Canada');
insert into origin values(307, 'Argentina');
insert into origin values(308, 'Chile');

insert into materialOrigin values (200, 306);
insert into materialOrigin values (200, 305);
insert into materialOrigin values (201, 301);
insert into materialOrigin values (201, 302);
insert into materialOrigin values (201, 303);
insert into materialOrigin values (201, 304);
insert into materialOrigin values (202, 307);
insert into materialOrigin values (202, 308);




