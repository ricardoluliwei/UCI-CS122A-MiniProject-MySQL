use blurts;

select t.id, t.description, count( b.blurtid)
from topic as t, blurt_analysis as b
where t.id = b.topicid
group by t.id
order by t.id asc;



select u.name, COUNT(f.follower)
from celebrity as c, follow as f, user as u
where c.email = f.followee and c.email = u.email
group by c.email;



select u.name, COUNT(b.blurtid)
from celebrity as c, blurt as b, user as u
where c.email = b.email and c.email = u.email
group by c.email
order by COUNT(b.blurtid) desc;



select u.name
from celebrity as c, user as u
where c.email = u.email and c.email not in
(select c1.email
from celebrity as c1, follow as f
where  c1.email = f.follower);



select v.name, a.email, count(f.follower)
from vendor as v, vendor_ambassador as a, follow as f
where v.id = a.vendorid and f.followee = a.email
group by a.email, v.name;



