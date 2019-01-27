-- ユーザ情報
CREATE TABLE tm_user
(user_id SERIAL,
user_name VARCHAR(30) NOT NULL ,
user_nickname VARCHAR(30) ,
bio VARCHAR(255) ,
last_login_ts timestamp ,
create_ts timestamp ,
birth_date date,
delete_flg boolean,
PRIMARY KEY(user_id));

-- 投稿情報
CREATE TABLE tm_post
(post_id SERIAL,
 post TEXT NOT NULL,
 post_user_id integer,
 post_ts timestamp,
 delete_flg boolean,
 PRIMARY KEY(post_id),
 FOREIGN KEY(post_user_id) REFERENCES tm_user(user_id)
);

-- コメント情報
CREATE TABLE ts_comment
(comment_id SERIAL,
 comment_user_id integer,
 comment_post_id integer,
 comment_ts timestamp,
 PRIMARY KEY(comment_id),
 FOREIGN KEY(comment_user_id) REFERENCES tm_user(user_id),
 FOREIGN KEY(comment_post_id) REFERENCES tm_post(post_id)
);

-- 共有情報
CREATE TABLE ts_share
(share_user_id integer,
 share_post_id integer,
 share_ts timestamp,
 PRIMARY KEY(share_user_id, share_post_id),
 FOREIGN KEY(share_user_id) REFERENCES tm_user(user_id),
 FOREIGN KEY(share_post_id) REFERENCES tm_post(post_id)
);

-- フォロー情報
CREATE TABLE ts_follow
(follow_user_id integer,
 follower_user_id integer,
 follow_ts timestamp,
 PRIMARY KEY(follow_user_id, follower_user_id),
 FOREIGN KEY(follow_user_id) REFERENCES tm_user(user_id),
 FOREIGN KEY(follower_user_id) REFERENCES tm_user(user_id) 
);

-- お気に入り情報
CREATE TABLE ts_favorite
(favorite_user_id integer,
 favorite_post_id integer,
 favorite_ts timestamp,
 PRIMARY KEY(favorite_user_id, favorite_post_id),
 FOREIGN KEY(favorite_user_id) REFERENCES tm_user(user_id),
 FOREIGN KEY(favorite_post_id) REFERENCES tm_post(post_id)
);

-- 通知情報
CREATE TABLE ts_notification
(notification_id SERIAL,
 notification_type VARCHAR(30),
 notification_user_from_id integer,
 notification_user_to_id integer,
 notification_post_id integer,
 notification_ts timestamp,
 PRIMARY KEY(notification_id),
 FOREIGN KEY(notification_user_from_id) REFERENCES tm_user(user_id),
 FOREIGN KEY(notification_user_to_id) REFERENCES tm_user(user_id),
 FOREIGN KEY(notification_post_id) REFERENCES tm_post(post_id)
);