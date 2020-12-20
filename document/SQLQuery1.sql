/*
jdbc:sqlserver://fptproject.database.windows.net:1433;database=CriminalPortal;user=adminfpt@fptproject;password={your_password_here};encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;
Đây là link để kết nối với database trên cloud
*/
USE master
drop database CriminalPortal

/*
drop table dbo.HistoryModified
drop table dbo.Case_Culprit
drop table dbo.Cases
drop table dbo.Culprits
drop table dbo.Users
*/

CREATE TABLE Users (
  id_user int PRIMARY KEY AUTO_INCREMENT,
  username varchar(255) NOT NULL unique,
  password varchar(50000) NOT NULL,
  avatar varchar(50000),
  profile_title text NOT NULL,
  profile_description text NOT NULL,
  full_name text NOT NULL,
  role int NOT NULL,
  created_at timestamp DEFAULT (current_timestamp)
)
GO


CREATE TABLE Culprits (
  id_culprit int PRIMARY KEY AUTO_INCREMENT,
  identity_card varchar(20) NOT NULL unique,
  name text NOT NULL,
  birth int,
  image varchar(50000),
  created_at timestamp DEFAULT (current_timestamp)
)
GO

CREATE TABLE Cases (
  id_case int PRIMARY KEY AUTO_INCREMENT,
  case_name text NOT NULL,
  case_description text NOT NULL,
  date_start timestamp NOT NULL, 
  date_end timestamp,
  image varchar(50000),
  created_at timestamp DEFAULT (current_timestamp)
)
GO

CREATE TABLE Case_Culprit (
  id_case_culprit int PRIMARY KEY AUTO_INCREMENT,
  id_culprit int NOT NULL,
  id_case int NOT NULL,
  information text
)
GO

CREATE TABLE HistoryModified (
  id_history int PRIMARY KEY AUTO_INCREMENT,
  id_user int NOT NULL,
  id_case int,
  id_culprit int,
  modified_at timestamp DEFAULT (current_timestamp)
)
GO

ALTER TABLE Case_Culprit ADD FOREIGN KEY (id_case) REFERENCES Cases (id_case)
GO

ALTER TABLE Case_Culprit ADD FOREIGN KEY (id_culprit) REFERENCES Culprits (id_culprit)
GO

ALTER TABLE HistoryModified ADD FOREIGN KEY (id_user) REFERENCES Users (id_user)
GO



/*
Users: check username and password are unique when insert
Culprits: identity_card is unique
Cases: case_name is unique
Case_Culprit: id_culprit and id_case is unique
*/

insert into Users 
values
('khoa','123456','https://scontent.fdad1-1.fna.fbcdn.net/v/t1.0-9/84728124_2470100726639465_7412986048201883648_n.jpg?_nc_cat=106&_nc_sid=730e14&_nc_ohc=NIWFFZxw9TwAX_SNLzG&_nc_ht=scontent.fdad1-1.fna&oh=76d59a7e07ecda19f54f7ad6b1c5199a&oe=5F2177F3',N'Thành viên của nhóm xây dựng web',N'Một phụ nữ vào tiệm kim hoàng, trông thấy hai chiếc vòng đeo tay giống nhau như đúc, một chiếc giá 2 triệu, một chiếc giá 20 triệu. Không chần chừ, bà ta liền lấy chiếc 20 triệu vì nghĩ rằng đắt tiền chắc chắn sẽ là đồ tốt. Khi vừa quay lưng bước đi, bà nghe nhân viên nói với nhau: "Không ngờ chỉ vì đính sai bảng giá mà chúng ta lời đến 18 triệu đồng!".',N'Đỗ Viết Khoa',0,current_timestamp),
('hieu','123456','https://i.pinimg.com/236x/b7/cc/11/b7cc1193e25c0eab17a1af096bb8a4da.jpg',N'Thành viên của nhóm xây dựng web',N'Chưa có thông tin',N'Võ Văn Hiếu',0,current_timestamp),
('dat','123456','https://scontent.fdad2-1.fna.fbcdn.net/v/t1.0-9/87364787_1415759678602383_2143203416736792576_o.jpg?_nc_cat=107&_nc_sid=09cbfe&_nc_ohc=iz017WtOFfMAX9z82VM&_nc_ht=scontent.fdad2-1.fna&oh=cc1192bb3837f038527d218b10756b93&oe=5F2182B1',N'Thành viên của nhóm xây dựng web',N'Chưa có thông tin',N'Phạm Duy Đạt',0,current_timestamp),
('tin','123456','https://i.pinimg.com/236x/8b/cf/15/8bcf15e8af97cbd56ab29f15e01933aa.jpg',N'Thành viên của nhóm xây dựng web',N'Mặc dù có nhiều trường triết học và nhiều sắc thái khác nhau, mọi triết lý được cho rằng thuộc về 2 phạm trù chính, mà đối ngược với nhau: Chủ nghĩa duy vật và Chủ nghĩa duy tâm. Mệnh đề cơ bản của hai phạm trù này liên quan tới bản chất của thực tế, và sự khác biệt căn bản là câu trả lời của hai câu hỏi cơ bản: "Hiện thực bao gồm những gì?" và "Nó hình thành như thế nào?" Đối với chủ nghĩa duy tâm thì linh hồn hoặc trí óc hoặc các ý tưởng là cơ bản, vật chất là thứ hai. Đới với chủ nghĩa duy vật thì vật chất là cơ bản còn trí óc hay linh hồn là thứ nhì, là sản phẩm của vật chất với vật chất.',N'Đoàn Đức Tín',0,current_timestamp)

select * from Users

delete from Culprits

insert into Culprits
values 
('C440',N'Nguyễn Văn Dung','1962','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp),
('C231',N'Dương Bành Lung','1968','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp),
('C211',N'Đinh Tiến Hữu','1983','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp),
('C342',N'Đinh Thanh Hiểu','1973','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp),
('C431',N'Wang Ming Chao','1954','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp),
('C345',N'Nguyễn Thị Hương Giang','1973','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp),
('C416',N'Phạm Minh Điệp','1966','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp),
('C741',N'Trần Anh Tuấn','1960','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp),
('C822',N'Nguyễn Văn Hùng','2000','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp),
('C912',N'Trần Phi Hổ','1996','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp),
('C100',N'Giàng A Páo','1983','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp),
('C111',N'Giàng A Đanh','1979','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp),
('C619',N'Giàng A Cổ','1972','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp),
('C070',N'Lê Thị Kim Liên','1975','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp),
('C071',N'Đoàn Thị Tuyết','1967','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp),
('C929',N'Trịnh Thị Hoa Trung','1970','https://cdn4.iconfinder.com/data/icons/people-of-crime-and-protection/512/People_Crime_Protection_prisoner_man-19-512.png',current_timestamp)

insert into Cases
values
(N'Vận chuyển trái phép chất ma tuý','https://baotintuc.vn/phap-luat/bat-qua-tang-doi-tuong-van-chuyen-trai-phep-chat-ma-tuy-20200501222653980.htm','12-6-2000 04:00:00:00',null,'https://vinmec-prod.s3.amazonaws.com/images/20190911_092402_772613_xet-nghiem-ma-tuy.max-800x800.jpg',current_timestamp),
(N'Tội mua bán trái phép chất ma tuý','https://baotintuc.vn/phap-luat/phat-hien-bat-giu-nhom-thanh-nien-tu-tapsu-dung-trai-phep-chat-ma-tuy-20200429195422752.htm','5-9-1978 08:13:54:00',null,'https://vinmec-prod.s3.amazonaws.com/images/20190911_092402_772613_xet-nghiem-ma-tuy.max-800x800.jpg',current_timestamp),
(N'Mua bán, đánh tráo hoặc chiếm đoạt trẻ em','https://thanhnien.vn/thoi-su/triet-pha-duong-day-buon-ban-tre-em-xuyen-quoc-gia-1090367.html','2-15-1975 09:04:00:00',null,'https://baodansinh.mediacdn.vn/zoom/480_300/Images/2016/10/28/mua-ban-tre-em-va-cai-gia-cho-hanh-vi-bat-luong1477627952.jpg',current_timestamp),
(N'Vi phạm quy định về cho vay trong hoạt động của các tổ chức tín dụng','https://tuoitre.vn/canh-bao-lua-dao-vay-tien-truc-tuyen-20191205062959051.htm','3-20-1968 08:14:00:00','6-21-2019 08:00:12:00','https://blogsosanh.com/wp-content/uploads/2019/11/hinh-2-canh-bao-5-website-lo-de-online-lua-dao.jpg',current_timestamp),
(N'Buôn lậu','http://tapchitaichinh.vn/tai-chinh-phap-luat/cuoi-nam-hoat-dong-buon-lau-dien-bien-phuc-tap-va-co-chieu-huong-tang-315997.html','2-26-1960 07:11:00:00',null,'https://lh3.googleusercontent.com/proxy/UiYQXjtQFcJglFzuAXjA9XX8_3Wr1uCnmmL3lfMyqss4wPC5gkMkw70maUTBIHTMCFUXZiwmt7t4TtCPpVuFgLoVoi-9hjtaviO0awKEaoHeLRkir3uDpH9kmc2g4JYOPbPxy8BCURb66FuTqhzu2z8cBR0',current_timestamp),
(N'Lạm dụng tín nhiệm chiếm đoạt tài sản','http://noichinh.vn/cong-tac-phong-chong-tham-nhung/201907/bo-cong-an-320-doi-tuong-pham-toi-tham-nhung-bi-xu-ly-trong-6-thang-dau-nam-2019-306028/','1-12-1980 06:09:00:00',null,'https://cafefcdn.com/thumb_w/650/2017/lua-dao-chiem-doat-tai-san-lam-dung-tin-nhiem-chiem-doat-tai-san-1495592958418.jpg',current_timestamp),
(N'Lừa đảo chiếm đoạt tài sản','https://dantri.com.vn/phap-luat/bat-giu-nguoi-nuoc-ngoai-lua-dao-chiem-doat-tai-san-20200630161323566.htm','8-1-1999 05:08:00:00',null,'https://cafefcdn.com/thumb_w/650/2017/lua-dao-chiem-doat-tai-san-lam-dung-tin-nhiem-chiem-doat-tai-san-1495592958418.jpg',current_timestamp),
(N'Tham ô tài sản','http://noichinh.vn/cong-tac-phong-chong-tham-nhung/201907/bo-cong-an-320-doi-tuong-pham-toi-tham-nhung-bi-xu-ly-trong-6-thang-dau-nam-2019-306028/','10-3-2001 02:05:00:00',null,'https://cafefcdn.com/thumb_w/650/2017/lua-dao-chiem-doat-tai-san-lam-dung-tin-nhiem-chiem-doat-tai-san-1495592958418.jpg',current_timestamp),
(N'Cố ý làm trái quy định của NN về QLKT gây hậu quả nghiêm trọng','http://dangcongsan.vn/thoi-su/toi-pham-ve-tham-nhung-van-rat-phuc-tap-533819.html','11-29-2009 05:12:00:152',null,'https://trithuccongdong.net/wp-content/uploads/2020/02/anh-dia-dien-Kh%C3%A1i-ni%E1%BB%87m-suy-tho%C3%A1i-kinh-t%E1%BA%BF-v%C3%A0-10-c%C3%A1ch-%C4%91%E1%BB%83-v%C6%B0%E1%BB%A3t-qua.jpg',current_timestamp),
(N'Giết người,Cố ý gây thương tích','https://laodong.vn/phap-luat/tim-ra-2-nghi-pham-dam-nguoi-dan-ong-chet-truoc-quan-nhau-814158.ldo','7-21-2011 01:11:00:00',null,'https://photo-1-baomoi.zadn.vn/w700_r1/2019_09_01_180_32037114/21cd8da3dde334bd6df2.jpg',current_timestamp)

insert into Case_Culprit
values
('18','5',N'Không có thông tin thêm'),
('18','6',N'Không có thông tin thêm'),
('19','5',N'Không có thông tin thêm'),
('20','1',N'Không có thông tin thêm'),
('21','2',N'Không có thông tin thêm'),
('22','3',N'Không có thông tin thêm'),
('23','7',N'Không có thông tin thêm'),
('23','8',N'Không có thông tin thêm'),
('24','8',N'Không có thông tin thêm'),
('25','2',N'Không có thông tin thêm'),
('25','6',N'Không có thông tin thêm'),
('25','9',N'Không có thông tin thêm'),
('26','10',N'Không có thông tin thêm'),
('27','9',N'Không có thông tin thêm'),
('28','4',N'Không có thông tin thêm'),
('29','7',N'Không có thông tin thêm'),
('30','1',N'Không có thông tin thêm'),
('31','5',N'Không có thông tin thêm'),
('32','10',N'Không có thông tin thêm'),
('33','10',N'Không có thông tin thêm')

insert into HistoryModified
values
(1,2,null,current_timestamp),
(2,3,null,current_timestamp),
(2,null,6,current_timestamp),
(3,null,5,current_timestamp)

select * from Users
select * from Cases
select * from Culprits
select * from Case_Culprit
select * from HistoryModified

-- khi xoa 1 Id nao do trong Cases thi no se xoa trong Case_Culprit lun
create trigger trg_Delete_Cases 
on Cases
INSTEAD OF delete 
as
begin 

Delete Case_Culprit from Case_Culprit inner join deleted 
on Case_Culprit.id_case = deleted.id_case

Delete Cases from Cases inner join deleted 
on Cases.id_case = deleted.id_case

end

-- drop  trigger trg_Delete_Cases

--------------------------------------------------------

-- khi xoa 1 Id nao do trong Culprits thi no se xoa trong Case_Culprit lun
create trigger trg_Delete_culprit 
on Culprits
INSTEAD OF delete 
as
begin 

Delete Case_Culprit from Case_Culprit inner join deleted 
on Case_Culprit.id_culprit = deleted.id_culprit

Delete Culprits from Culprits inner join deleted 
on Culprits.id_culprit = deleted.id_culprit

end

----------------------------------------------------------

-- khi xoa 1 User nao do trong Users thi no se xoa trong HistoryModified lun
create trigger trg_Delete_users 
on Users
INSTEAD OF delete 
as
begin 

Delete HistoryModified from HistoryModified inner join deleted 
on HistoryModified.id_user = deleted.id_user

Delete Users from Users inner join deleted 
on Users.id_user = deleted.id_user

end

----------------------------------------------------------