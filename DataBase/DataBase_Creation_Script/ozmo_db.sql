/*** LET THERE BE DATABASE ***/
USE ozmoPol;

/* Day #1: Let there be  Tables */
DROP TABLE IF EXISTS X_user_flw_user;
DROP TABLE IF EXISTS X_user_flw_room;
DROP TABLE IF EXISTS Votes;
DROP TABLE IF EXISTS Posts;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Rooms;

/* # Let there be Rooms */
CREATE TABLE Rooms
(
pk_room_id varchar(32) UNIQUE NOT NULL,
room_title varchar(64) NOT NULL UNIQUE,
room_desc text,

PRIMARY KEY (pk_room_id)
);

/* Let there be Users */
CREATE TABLE Users
(
pk_user_id varchar(32)  UNIQUE NOT NULL,
user_name varchar(32) NOT NULL UNIQUE,
user_pass char(64) NOT NULL,
user_email varchar(32) NOT NULL UNIQUE,
user_bday date,

PRIMARY KEY (pk_user_id)
);

/* Let there be Posts */
CREATE TABLE Posts
(
pk_post_id varchar(32) UNIQUE NOT NULL,
post_title varchar(256),
post_content text NOT NULL,
post_c_date DATETIME ,
post_e_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
fk_post_user_id varchar(32) NOT NULL,
fk_post_room_id varchar(32) NOT NULL,
fk_post_prnt_id varchar(32),

PRIMARY KEY (pk_post_id),

FOREIGN KEY (fk_post_user_id) REFERENCES Users(pk_user_id),
FOREIGN KEY (fk_post_room_id) REFERENCES Rooms(pk_room_id),
FOREIGN KEY (fk_post_prnt_id) REFERENCES Posts(pk_post_id)
);

/* Let There be Votes */
CREATE TABLE Votes
(
pk_vote_id varchar(32) UNIQUE NOT NULL,
vote_value TINYINT(1),
fk_vote_user_id varchar(32) NOT NULL,
fk_vote_post_id varchar(32) NOT NULL,

PRIMARY KEY (pk_vote_id),

FOREIGN KEY (fk_vote_user_id) REFERENCES Users(pk_user_id),
FOREIGN KEY (fk_vote_post_id) REFERENCES Posts(pk_post_id),

UNIQUE KEY user_vote_post (fk_vote_user_id, fk_vote_post_id)
);

/* Let Users Follow Rooms */
CREATE TABLE X_user_flw_room
(
pk_userXroom_id varchar(32) UNIQUE NOT NULL,
fk_userXroom_user_id varchar(32) NOT NULL,
fk_userXroom_room_id varchar(32) NOT NULL,

PRIMARY KEY (pk_userXroom_id),

FOREIGN KEY (fk_userXroom_user_id) REFERENCES Users(pk_user_id),
FOREIGN KEY (fk_userXroom_room_id) REFERENCES Rooms(pk_room_id),

UNIQUE KEY user_flw_room (fk_userXroom_user_id,fk_userXroom_room_id)
);

/* Let Users Follow Users */
CREATE TABLE X_user_flw_user
(
pk_userXuser_id varchar(32) UNIQUE NOT NULL,
fk_userXuser_flwr_user_id varchar(32) NOT NULL,
fk_userXuser_flwd_user_id varchar(32) NOT NULL,

PRIMARY KEY (pk_userXuser_id),

FOREIGN KEY (fk_userXuser_flwr_user_id) REFERENCES Users(pk_user_id),
FOREIGN KEY (fk_userXuser_flwd_user_id) REFERENCES Users(pk_user_id),

UNIQUE KEY user_flw_user (fk_userXuser_flwr_user_id, fk_userXuser_flwd_user_id)
);



/* When post is edited, post_e_time is updated */
DELIMITER //

CREATE TRIGGER make_post_c_time 
BEFORE INSERT ON Posts
FOR EACH ROW
BEGIN
  IF NEW.post_c_date IS NULL THEN
    SET NEW.post_c_date = NOW();
  END IF;
END //

DELIMITER ;



/*** And the time came to pass ***/

/*...*/

/*** Day #2: LET THERE BE TUPLES IN TABLES ACCORDINGLY ***/

/* Then Rooms had tuples... */
INSERT INTO Rooms VALUES
('ffffffffffffffff', 'HALL', 'HALL'),
('3uh2gkejasdy9243', 'Dining Hall', 'Wahz cookin doc?'),
('uiybewg4jh3g4gbs', 'Shuttle Hour Updates', 'Shuttles come, Shuttles go, eat a tomato'),
('ju3hyd2762uytgds', 'Music Events', '... d(~_~)b... '),
('rrhysd276185jstf', 'Party Nation', 'This is a serious room'),
('rakhsd2775632g4s', 'Lets Study', 'Seriously?! who the fu... Mom! Get of the internet!'),
('weddweddweddwedd', 'Message from sky', 'I heard something from God');


/* So did Users... */
INSERT INTO Users VALUES
('ffffffffffffffff', 'GOD', 'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff', 'god@ozu.edu.tr', '1000-01-01'),
('bjkweshgk48y93s4', 'Mosey', 'bjkweshgk48y93s4bjkweshgk48y93s4bjkweshgk48y93s4bjkweshgk48y93s4', 'mosey@ozu.edu.tr', '1100-01-01'),
('urb49ne9bek30mme', 'Abey', 'urb49ne9bek30mmeurb49ne9bek30mmeurb49ne9bek30mmeurb49ne9bek30mme', 'abey@ozu.edu.tr', '1000-01-01'),
('bjksefkhjw49ub43', 'Jesey', 'bjksefkhjw49ub43bjksefkhjw49ub43bjksefkhjw49ub43bjksefkhjw49ub43', 'jesey@ozu.edu.tr', '1200-01-01'),
('geidgeidgeidgeid', 'Mary', 'geidgeidgeidgeidgeidgeidgeidgeidgeidgeidgeidgeidgeidgeidgeidgeid', 'mary@ozu.edu.tr', '1150-01-01'),
('euritolfkjnndjfj', 'Mohamad', 'iuryfhnvjmsklsosiuryfhnvjmsklsosiuryfhnvjmsklsosiuryfhnvjmsklsos', 'Mohamad@ozu.edu.tr', '1004-01-01');

/* And Posts started to populate Gods Hall. */


INSERT INTO Posts VALUES
('jdu5oxnwmoylyedr', 'Party at ma haus :D everyone invited... woop woop!!!', 'if you have nothin to do and passing by kadikoy, jus knock n join us. its 24 falan st. no 29. BYOB!!!', NULL , NULL ,'urb49ne9bek30mme', 'rrhysd276185jstf', NULL );

DO SLEEP(2);

INSERT INTO Posts VALUES
('lrncndhrkktnchw0', NULL, 'what time is the parteeey? ', NULL , NULL ,'bjkweshgk48y93s4', 'rrhysd276185jstf', 'jdu5oxnwmoylyedr' );

DO SLEEP(1);

INSERT INTO Posts VALUES
('hhegdteuiwoodadr', NULL, 'anytime after 8 is fine... before 6 in the next morning ofcourse (6_6) ', NULL , NULL ,'urb49ne9bek30mme', 'rrhysd276185jstf', 'lrncndhrkktnchw0' );

DO SLEEP(1);

INSERT INTO Posts VALUES
('krt74yehancleor8', NULL, 'awesome! count me in xoxo ', NULL , NULL ,'bjksefkhjw49ub43', 'rrhysd276185jstf', 'jdu5oxnwmoylyedr' );

DO SLEEP(1);

INSERT INTO Posts VALUES
('63yehcldr24qy3er', NULL, 'woohoo... guess whos da DJ :D ', NULL , NULL ,'urb49ne9bek30mme', 'rrhysd276185jstf', 'krt74yehancleor8' );

DO SLEEP(1);

INSERT INTO Posts VALUES
('blablabla8i3teh6', NULL, 'Probably maybe definitely ADAM hahahaaa', NULL , NULL ,'bjksefkhjw49ub43', 'rrhysd276185jstf', '63yehcldr24qy3er' );

INSERT INTO Posts VALUES
('polishnfnfojndkn', NULL, '...is it Adam?!!', NULL , NULL ,'bjkweshgk48y93s4', 'rrhysd276185jstf', '63yehcldr24qy3er' );

DO SLEEP(1);

INSERT INTO Posts VALUES
('uejd[rotlzbah17f', NULL, 'Hahahaha who else could it be!', NULL , NULL ,'bjkweshgk48y93s4', 'rrhysd276185jstf', 'polishnfnfojndkn' );

DO SLEEP(1);

INSERT INTO Posts VALUES
('owieowieowieowie', NULL, 'Hahahaha what the hell is going on!', NULL , NULL ,'euritolfkjnndjfj', 'weddweddweddwedd', 'polishnfnfojndkn' );

/* And people started Voting for Posts... and it was all good */

INSERT INTO Votes VALUES ('ykdrykdrykdrykdr', '1', 'geidgeidgeidgeid', 'owieowieowieowie');
INSERT INTO Votes VALUES ('dfeldfeldfeldfel', '-1', 'ffffffffffffffff', 'krt74yehancleor8');
INSERT INTO Votes VALUES ('vnbnvnbnvnbnvnbn', '1', 'bjkweshgk48y93s4', 'krt74yehancleor8');
INSERT INTO Votes VALUES ('yuiuyuiuyuiuyuiu', '1', 'euritolfkjnndjfj', 'krt74yehancleor8');
INSERT INTO Votes VALUES ('tqwftqwftqwftqwf', '-1', 'urb49ne9bek30mme', 'owieowieowieowie');
INSERT INTO Votes VALUES ('frgtfrgtfrgtfrgt', '-1', 'euritolfkjnndjfj', 'owieowieowieowie');

/* People also could change her/his opinion.... Don't you think different when you learn something new?? */

UPDATE Votes SET vote_value='-1' WHERE pk_vote_id='ykdrykdrykdrykdr';
UPDATE Votes SET vote_value='1' WHERE pk_vote_id='dfeldfeldfeldfel';
UPDATE Votes SET vote_value='-1' WHERE pk_vote_id='vnbnvnbnvnbnvnbn';
UPDATE Votes SET vote_value='-1' WHERE pk_vote_id='yuiuyuiuyuiuyuiu';
UPDATE Votes SET vote_value='1' WHERE pk_vote_id='tqwftqwftqwftqwf';
UPDATE Votes SET vote_value='1' WHERE pk_vote_id='frgtfrgtfrgtfrgt';

/* So everyone can follow Rooms  */

INSERT INTO X_user_flw_room VALUES('trtgtrtgtrtgtrtg','euritolfkjnndjfj','3uh2gkejasdy9243');
INSERT INTO X_user_flw_room VALUES('reteretereterete' , 'geidgeidgeidgeid' , 'rakhsd2775632g4s');
INSERT INTO X_user_flw_room VALUES('retyretyretyrety', 'bjkweshgk48y93s4' , 'uiybewg4jh3g4gbs');

/* And people can follow other people as well, Intresting!! */

INSERT INTO X_user_flw_user VALUES ('iopliopliopliopl', 'bjksefkhjw49ub43', 'geidgeidgeidgeid');
INSERT INTO X_user_flw_user VALUES ('rthdrthdrthdrthd', 'euritolfkjnndjfj' , 'ffffffffffffffff');
INSERT INTO X_user_flw_user VALUES ('gnvbgnvbgnvbgnvb', 'geidgeidgeidgeid' , 'bjksefkhjw49ub43');
INSERT INTO X_user_flw_user VALUES ('jnmvjnmvjnmvjnmv', 'urb49ne9bek30mme' , 'euritolfkjnndjfj');








