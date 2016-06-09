CREATE TABLE prices(TDATE,NAME,REMARKS,CURRENCY,HIGH,LOW,LAST,CHANGE,VOLUME,BID,OFFER,MARKET,OPEN,VALUE,CODE not null,DClose, primary key(CODE,TDate));


CREATE INDEX Idx_code On prices ( CODE );


Drop Trigger If Exists insert_code_trim;
Create Trigger insert_code_trim AFTER INSERT On prices 
begin
update prices set code = trim(code) where rowid = new.rowid;
end;

Drop Trigger If Exists update_code_trim;
Create Trigger update_code_trim AFTER UPDATE On prices 
begin
update prices set code = trim(code) where rowid = new.rowid;
end;



Drop View If Exists China_Vol;
Create  View China_Vol As select name, CODE, 
--Create  View MAIN.[China_Vol] As select name, CODE, 
sum(volume)/1000 vol,
sum(value)/1000 val,
round(avg(offer-bid),3) spread, 
round(avg(offer-bid)/avg(last)*100,3) spreadP,
round(avg(last),3) mean 
from prices where CODE in('KT4','HD8','LG9','P58','JK8')
group by name, code order by vol desc;

Drop View If Exists India_Vol;
Create  View India_Vol As select name, CODE,
sum(volume)/1000 vol,
sum(value)/1000 val,
round(avg(offer-bid),3) spread, 
round(avg(offer-bid)/avg(last)*100,3) spreadP,
round(avg(last),3) mean 
from prices where CODE in('I98','G1N','QK9','LG8','HE0')
group by name, code order by vol desc;

Drop View If Exists Etf_Vol;
Create  View Etf_Vol As select name, CODE, 
sum(volume)/1000 vol,
sum(value)/1000 val,
round(avg(offer-bid),3) spread, 
round(avg(offer-bid)/avg(last)*100,3) spreadP,
round(avg(last),3) mean 
from prices where CODE in('A9A','A9B','AO9','CW4','D07','ES3','G1K','G1M','G1N','G3B','H1M','H1N','H1O','H1P','H1Q','HD7','HD8','HD9','HE0','I17','I19','I98','IH0','IH1','IH2','IH3','J0M','J0N','J0O','J0P','J0Q','J0R','JC5','JC6','JC7','JK8','K6K','KF8','KJ7','KT3','KT4','LF1','LF2','LG6','LG7','LG8','LG9','M62','N2E','N2F','O9A','O9B','O9C','O9D','P2P','P2Q','P58','P5P','P60','QK9','QR9','QS0','S27')
group by name, code order by vol desc;

