--  検索結果を取得するクエリ
select p.*,
-- ログインユーザ共有フラグ
case
 when sh.share_post_id is null then false
 else true
end as login_share_flg,
-- ログインユーザお気に入りフラグ
case
 when fav.favorite_post_id is null then false
 else true
end as login_fav_flg
from tm_post p
left join ts_share sh
on sh.share_user_id = 11
and p.post_id = sh.share_post_id
left join ts_favorite fav
on fav.favorite_user_id = 11
and p.post_id = fav.favorite_post_id
--  検索文字列による絞り込み
where post like '%テスト%'