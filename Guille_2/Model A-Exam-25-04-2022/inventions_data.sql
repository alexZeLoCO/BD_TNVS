\c inventions

insert into invention values (100, 'GIF', 1987, 'animated memes', 'Facebook, Instagram');
insert into invention values (101, 'EInk', 1997, 'electronic ink', 'e-readers');
insert into invention values (102, 'Turing test', 1950, 'Method to determine if a machine can think', 'Test CAPTCHA');
insert into invention values (103, 'First algorithm', 1843, 'Calculation of Bernoulli numbers', 'Automatic Processing System');
insert into invention values (104, 'Turing machine', 1936, 'Mathematical model of computation', 'Central Processing Unit (CPU)');
insert into invention values (105, 'TCP/IP protocol', 1973, 'Internet protocol suite', 'WWW, email, file transfer');

insert into inventor values (200, 'Stephen Wilhite', 'Milford (Ohio)', 1948, 'engineer');
insert into inventor values (201, 'J.D.Albert', 'EEUU', 1975, 'teacher');
insert into inventor values (202, 'Barrett Comiskey', 'EEUU', 1975, 'business');
insert into inventor values (203, 'Alan Mathison Turing', 'London', 1912, 'teacher');
insert into inventor values (204, 'Ada Lovelace', 'London', 1815, 'mathematics');
insert into inventor values (205, 'Robert Khan', 'New York', 1938, 'CEO');
insert into inventor values (206, 'Vinton Cerf', 'New Haven', 1943, 'Chief Internet Evangelist of Google');

insert into inventioninventor values (100, 200);
insert into inventioninventor values (101, 201);
insert into inventioninventor values (101, 202);
insert into inventioninventor values (102, 203);
insert into inventioninventor values (103, 204);
insert into inventioninventor values (104, 203);
insert into inventioninventor values (105, 205);
insert into inventioninventor values (105, 206);

insert into workplace values (300, 'CompuServe', 'Columbus (Ohio)', 'EEUU');
insert into workplace values (301, 'University of Pennsylvania', 'Pennsylvania', 'EEUU');
insert into workplace values (302, 'Migo', 'Jakarta', 'Indonesia');
insert into workplace values (303, 'University of Cambridge', 'Cambridge', 'UK');
insert into workplace values (304, 'Ockham Park', 'Surrey', 'UK'); 

insert into inventorworkplace values(200, 300);
insert into inventorworkplace values (201, 301);
insert into inventorworkplace values (202, 302);
insert into inventorworkplace values (203, 303);
insert into inventorworkplace values (204, 304);


insert into formation values (400, 'Computer Science Engineering', null, null, 'Milford', 'EEUU');
insert into formation values (401, 'Mechanical Engineering', 'MIT', null, 'Philadelphia', 'EEUU');
insert into formation values (402, 'Mathematics', 'MIT', null, 'Philadelphia', 'EEUU');
insert into formation values (403, 'Mathematics', 'University of Cambridge', 'Alonzo Church', 'Cambridge', 'UK');
insert into formation values (404, 'Mathematics', null, 'Mary Sumerville', 'Ockham Park', 'UK');



insert into inventorformation values (200, 400);
insert into inventorformation values (201, 401);
insert into inventorformation values (202, 402);
insert into inventorformation values (203, 403);
insert into inventorformation values (204, 404);