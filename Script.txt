use blurts;

#1
select t.id, t.description, count( b.blurtid)
from topic as t left join blurt_analysis as b
on t.id = b.topicid
group by t.id
order by t.id;


#2
select u.name, COUNT(f.follower)
from user as u left join follow as f
on u.email = f.followee
where u.type = 'C'
group by u.email
order by u.name;


#3
select u.name, COUNT(b.blurtid)
from celebrity as c left join blurt as b on c.email = b.email, user as u
where c.email = u.email
group by c.email
order by COUNT(b.blurtid) desc;


#4
select u.name
from celebrity as c, user as u
where c.email = u.email and c.email not in
(select c1.email
from celebrity as c1, follow as f
where  c1.email = f.follower)
order by u.name;

#5
select v.name, a.email, count(f.follower)
from vendor as v, vendor_ambassador as a, follow as f
where v.id = a.vendorid and f.followee = a.email
group by a.email, v.name
order by v.name, a.email;


#6
select v.name, count(distinct(b.email)) as advertisement_gap
from blurt_analysis as b, vendor_topics as vt, vendor as v
where v.id = vt.vendorid and b.topicid = vt.topicid and b.email not in
(select ua.email
from user_ad as ua, advertisement as a
where ua.adid = a.id and a.vendorid = vt.vendorid)
group by v.name
order by count(distinct(b.email)) desc;


#7
select distinct u1.name, u2.name
from user as u1, user as u2
where u1.email <> u2.email and
exists 
(select ba.topicid
from blurt_analysis as ba
where ba.email = u1.email
and ba.topicid in
(select ba1.topicid
from blurt_analysis as ba1
where ba1.email = u2.email))
and not exists
(select *
from follow as f
where f.followee = u2.email and f.follower = u1.email)
order by u1.name, u2.name;

#8
select distinct u1.email, u2.email, u3.email
from user as u1, follow as f1,user as u2, follow as f2, user as u3
where u1.email = f1.follower and u2.email = f1.followee
and u2.email = f2.follower and u3.email = f2.followee
and u1.email <> u3.email and u1.email not in
(select u4.email
from user as u4, follow as f
where u4.email = f.follower and f.followee = u3.email)
order by u1.email, u2.email, u3.email;


#9
select distinct t.id, t.description, b.location, count(b.blurtid), avg(ba.sentiment)
from  topic as t left join blurt_analysis as ba natural join blurt as b
on t.id = ba.topicid
group by t.id, t.description, b.location
having avg(ba.sentiment) < 0
order by t.id;
