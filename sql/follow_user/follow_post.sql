-- 自分自身、フォロー中のユーザの投稿を取得
select p.*, u.user_name, u.user_nickname,
 case
  when fa.favorite_post_id is null then false
  else true
 end as login_fav_flg
from tm_post p
-- 指定のユーザIDがフォローしているユーザに自分自身のIDをUNIONで結ぶ
inner join (
 select follower_user_id
 from ts_follow
 where follow_user_id = 17
 union
 -- フォロー・フォロワーが0人の段階ではフォロー情報から自分自身を取得できないので、ユーザテーブルから取得
 select user_id
 from tm_user
 where user_id = 17
) f
-- f.follower_user_idにfollow中のユーザID、自身のユーザIDが格納されているので、結合キーに指定し取得
on p.post_user_id = f.follower_user_id
inner join tm_user u
on p.post_user_id = u.user_id
-- ログインユーザが投稿をお気に入り登録しているかを管理するフラグを取得
left join ts_favorite fa
on fa.favorite_user_id = 17
and p.post_id = fa.favorite_post_id
order by p.post_ts desc