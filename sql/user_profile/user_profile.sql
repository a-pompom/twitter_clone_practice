select u.user_id, u.user_name, u.user_nickname, u.bio, u.birth_date,
       coalesce(pc.post_count, 0) post_count, coalesce(fc.follow_count, 0) follow_count,
       coalesce(fwc.follower_count, 0) follower_count, coalesce(favc.favorite_count, 0) favorite_count
from tm_user u
-- 投稿数
left join (
 select p.post_user_id, count(*) post_count
 from tm_post p
 where p.post_user_id = 20
 group by p.post_user_id
) pc
on u.user_id = pc.post_user_id
--フォロー数
left join (
 select f.follow_user_id, count(*) follow_count
 from ts_follow f
 where f.follow_user_id = 20
 group by f.follow_user_id
) fc
on u.user_id = fc.follow_user_id
--フォロワー数
left join (
 select f.follower_user_id, count(*) follower_count
 from ts_follow f
 where f.follower_user_id = 20
 group by f.follower_user_id
) fwc
on u.user_id = fwc.follower_user_id
-- お気に入り数
left join (
 select fav.favorite_user_id, count(*) favorite_count
 from ts_favorite fav
 where fav.favorite_user_id = 20
 group by fav.favorite_user_id
) favc
on u.user_id = favc.favorite_user_id
where u.user_id = 20