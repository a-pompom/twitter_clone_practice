select p.*, u.user_name, u.user_nickname,
 case 
  when login_fa.favorite_post_id is null then false
  else true
 end as login_fav_flg
from tm_post p
inner join ts_favorite fa
on fa.favorite_user_id = 11
and p.post_id = fa.favorite_post_id
inner join tm_user u
on p.post_user_id = u.user_id
left join ts_favorite login_fa
on login_fa.favorite_user_id = 17
and p.post_id = fa.favorite_post_id