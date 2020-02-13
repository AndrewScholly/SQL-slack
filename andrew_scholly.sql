/*Slack SQL file
First, I create each table seperatly, with values relating to them
I first make a users table for each user, using a Userid primary key*/
CREATE TABLE users(
    username varchar(20) CONSTRAINT user_id PRIMARY KEY, password varchar(10),
     status varchar(50), display_name varchar(25),local_time varchar(3)
);
/*then the channels fable*/
CREATE TABLE channels (
	channel_id varchar(25) REFERENCES users(username),
    name varchar(25) CONSTRAINT channel_id PRIMARY KEY, visible varchar(3),
    hidden numeric(1), time_created varchar(10), related varchar(25),
	pinned varchar(25)
);
/*Next I make the table for messages*/
CREATE TABLE messages (
	message_id varchar(25) REFERENCES users(username),
	which_channel varchar(25) REFERENCES channels(name),
    message varchar(25) CONSTRAINT message_id PRIMARY KEY, fonts INT,
    enojis_added INT, time_SENT varchar(10)
);
/*Then the table for the files*/
CREATE TABLE files (
	file_id varchar(25) REFERENCES users(username),
	where_posted varchar(25) REFERENCES channels(name),
    file varchar(25) CONSTRAINT file_id PRIMARY KEY, type varchar(6),
    size BIGSERIAL, time_uploaded varchar(10)
);
/*after that the threads table*/
CREATE TABLE threads (
    user_sent varchar(20), CONSTRAINT thread_id PRIMARY KEY,
    CONSTRAINT user_id FOREIGN KEY REFERENCES users(user_id), time_created varchar(25),
    CONSTRAINT channel_id FOREIGN KEY REFERENCES channel(channel_id),
     emojis_added INT, amount_of_replies int()
);
/*Before values I am going to input joins for the relations*/
SELECT *
FROM users JOIN messages
ON users.user_id = messages.user_id;
/*I join each of the different table user_ids with the main one*/
SELECT *
FROM users JOIN channels
ON users.user_id = channels.user_id;

SELECT *
FROM users JOIN threads
ON users.user_id = threads.user_id;

SELECT *
FROM users JOIN files
ON users.user_id = files.user_id;
/*Next I join the channels primary key which the user who is in it*/
SELECT *
FROM channels JOIN users
ON channels.channel_id = users.channel_id;
/*As well as which users sent/recieve which messages*/
SELECT *
FROM messages JOIN users
ON messages.message_id = users.message_id;
/*I then join the thread and channel ones, for which thread is in which channel*/
SELECT *
FROM channels JOIN threads
ON channels.channel_id = threads.channel_id;
/*Next I join the files for which channel they are in*/
SELECT *
FROM channels JOIN files
ON channels.channel_id = files.channel_id;
/*After that I join messages, channels and threads with users in the opposite way,
as each of those can have multiple users*/
FROM messages JOIN users
ON messages.messages_id = users.messages_id;

SELECT *
FROM channels JOIN users
ON channels.channel_id = users.channel_id;

SELECT *
FROM threads JOIN users
ON threads.thread_id = users.thread_id;
/*Now I will create the values, first the users*/
INSERT INTO users (username, user_id, password, status, display_name, local_time)
VALUES ('zach', '1', 'yaboizach', 'first year instructor', 'zach fedor', 'est');
INSERT INTO users (username, user_id, password, status, display_name, local_time)
VALUES ('nick', '2', 'nickyman', 'student', 'nicky', 'est');
INSERT INTO users (username, user_id, password, status, display_name, local_time)
VALUES ('carni', '3', 'password', 'I exceed the character limit', 'carni', 'est');
/*Next the messages*/
INSERT INTO messages (messages_id, fonts, emojis_added, time_sent)
VALUES ('1', '2', '4', '2:47pm');
INSERT INTO messages (messages_id, fonts, emojis_added, time_sent)
VALUES ('1', '7', '1', '10:10am');
INSERT INTO messages (messages_id, fonts, emojis_added, time_sent)
VALUES ('2', '6', '3', '4:30pm');
/*then the files*/
INSERT INTO files (file_id, type, size, time_uploaded)
VALUES ('1', 'pdf', '4', '2:47pm');
INSERT INTO files (file_id, type, size, time_uploaded)
VALUES ('1', 'jpeg', '4', '3:00pm');
INSERT INTO files (file_id, type, size, time_uploaded)
VALUES ('1', 'gif', '4', '12:00am');
/*then the threads*/
INSERT INTO threads (thread_id, time_created, emojis_added, amount_of_replies)
VALUES ('1', '2:00am', '2', '6');
INSERT INTO threads (thread_id, time_created, emojis_added, amount_of_replies)
VALUES ('1', '5:00pm', '8', '8');
INSERT INTO threads (thread_id, time_created, emojis_added, amount_of_replies)
VALUES ('1', '3:47pm', '3', '4');
/*and finally the channels*/
INSERT INTO channels (channel_id, name, hidden, time_created, related, pinned)
VALUES ('1', 'pizza', '1', '3:40pm', 'almostpizza', 'eat');
INSERT INTO channels (channel_id, name, hidden, time_created, related, pinned)
VALUES ('2', 'notpizza', '1', '3:40pm', 'alsonotpizza', 'burger');
INSERT INTO channels (channel_id, name, hidden, time_created, related, pinned)
VALUES ('3', 'hidden', '2', '7:00am', 'secret', 'eeee');
