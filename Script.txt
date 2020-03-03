use blurts;

#1
select t.id, t.description, count( b.blurtid)
from topic as t, blurt_analysis as b
where t.id = b.topicid
group by t.id
order by t.id;


#2
select u.name, COUNT(f.follower)
from celebrity as c, follow as f, user as u
where c.email = f.followee and c.email = u.email
group by u.name, c.email
order by u.name;


#3
select u.name, COUNT(b.blurtid)
from celebrity as c, blurt as b, user as u
where c.email = b.email and c.email = u.email
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
from blurt_analysis as b, topic as t, vendor_topics as vt, vendor as v
where v.id = vt.vendorid and b.topicid = t.id and t.id = vt.topicid and b.email not in
(select ua.email
from user_ad as ua, advertisement as a
where ua.adid = a.id and a.vendorid = vt.topicid)
group by v.name
order by v.name;


#7
select distinct u1.name, u2.name
from user as u1, blurt_analysis as ba1, user as u2, blurt_analysis ba2
where u1.email = ba1.email and u1.email <> u2.email and u2.email = ba2.email
and ba1.topicid = ba2.topicid and not exists
(select f.follower
from follow as f
where f.followee = u2.email and f.follower = u1.email)
order by u1.name, u2.name;

#8
select u1.name, u2.name, u3.name
from user as u1, follow as f1,user as u2, follow as f2, user as u3
where u1.email = f1.follower and u2.email = f1.followee
and u2.email = f2.follower and u3.email = f2.followee
and u3.email <> f1.followee
order by u1.name, u2.name, u3.name;


#9
select t.id, t.description, b.location, count(distinct(b.blurtid)), avg(ba.sentiment)
from blurt_analysis as ba, blurt as b, topic as t
where ba.blurtid = b.blurtid and ba.topicid = t.id
group by t.id, t.description, b.location
having avg(ba.sentiment) < 0
order by t.id;