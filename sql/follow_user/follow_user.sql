-- フォロー中のユーザのリストを取得
select u.user_id, u.user_name, u.user_nickname, u.bio,
 case 
  when login_f.follower_user_id is null then false
  else true
 end as login_follow_flg
from (
 select follower_user_id
 from ts_follow
 where follow_user_id = 11
) f
inner join tm_user u
on f.follower_user_id = u.user_id
-- ログインユーザがフォローしているか判別するためのフラグを取得
left join ts_follow login_f
on login_f.follow_user_id = 12
and login_f.follower_user_id = f.follower_user_id

-- 自分をフォローしているユーザのリストを取得
select u.user_id, u.user_name, u.user_nickname, u.bio,
 case 
  when login_f.follower_user_id is null then false
  else true
 end as login_follow_flg
from (
 select follow_user_id
 from ts_follow
 where follower_user_id = 16
) f
inner join tm_user u
on f.follow_user_id = u.user_id
-- ログインユーザがフォローしているか判別するためのフラグを取得
left join ts_follow login_f
on login_f.follow_user_id = 12
and login_f.follower_user_id = f.follow_user_id
