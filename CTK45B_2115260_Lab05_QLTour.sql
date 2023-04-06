/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Phan Thanh Thảo Quyên
   MSSV: 2115260
   Lớp: CTK45B
   Ngày bắt đầu: 24/02/2023
   Ngày kết thúc: ?????
*/	
CREATE DATABASE Lab05_QLTour
go 
use Lab05_QLTour
go

create table Tour
(
MaTour char(4) primary key,
TongSoNgay tinyint not null
)
go
create table ThanhPho
(
MaTP char(2) primary key,
TenTP nvarchar(30) not null
)
go
create table Tour_TP
(
MaTour char(4) references Tour(MaTour),
MaTP char(2) references ThanhPho(MaTP),
SoNgay tinyint not null
primary key(MaTour, MaTP)
)
go
create table Lich_TourDL
(
MaTour char(4) references Tour(MaTour),
NgayKH datetime not null,
TenHDV nvarchar(20) not null,
SoNguoi tinyint not null,
TenKH nvarchar(40) not null,
primary key(MaTour, NgayKH)
)
go

insert into Tour values('T001', 3)
insert into Tour values('T002', 4)
insert into Tour values('T003', 5)
insert into Tour values('T004', 7)
select * from Tour

insert into ThanhPho values('01', N'Đà Lạt')
insert into ThanhPho values('02', N'Nha Trang')
insert into ThanhPho values('03', N'Phan Thiết')
insert into ThanhPho values('04', N'Huế')
insert into ThanhPho values('05', N'Đà Nẵng')
select * from ThanhPho

insert into Tour_TP values('T001', '01',2)
insert into Tour_TP values('T001', '03',1)
insert into Tour_TP values('T002', '01',2)
insert into Tour_TP values('T002', '02',2)
insert into Tour_TP values('T003', '02',2)
insert into Tour_TP values('T003', '01',1)
insert into Tour_TP values('T003', '04',2)
insert into Tour_TP values('T004', '02',2)
insert into Tour_TP values('T004', '05',2)
insert into Tour_TP values('T004', '04',3)
select * from Tour_TP

insert into Lich_TourDL values('T001', '2017/02/14', N'Vân', 20, N'Nguyễn Hoàng')
insert into Lich_TourDL values('T002', '2017/02/14', N'Nam', 30, N'Lê Ngọc')
insert into Lich_TourDL values('T002', '2017/03/06', N'Hùng', 20, N'Lý Dũng')
insert into Lich_TourDL values('T003', '2017/02/18', N'Dũng', 20, N'Lý Dũng')
insert into Lich_TourDL values('T004', '2017/02/18', N'Hùng', 30, N'Dũng Nam')
insert into Lich_TourDL values('T003', '2017/03/10', N'Nam', 45, N'Nguyễn An')
insert into Lich_TourDL values('T002', '2017/04/28', N'Vân', 25, N'Ngọc Dung')
insert into Lich_TourDL values('T004', '2017/04/29', N'Dũng', 35, N'Lê Ngọc')
insert into Lich_TourDL values('T001', '2017/04/30', N'Nam', 25, N'Trần Nam')
insert into Lich_TourDL values('T003', '2017/06/15', N'Vân', 20, N'Trịnh Bá')
select * from Lich_TourDL

select * from Tour
select * from ThanhPho
select * from Tour_TP
select * from Lich_TourDL

--q.a Cho biết các tour du lịch có tổng số ngày của tour từ 3 đến 5 ngày
select *
from Tour A
where A.TongSoNgay >= 3 and A.TongSoNgay <= 5

--q.b Cho biết thông tin các tour được tổ chức trong tháng 2 năm 2017
select *
from Lich_TourDL A
where year(A.NgayKH) = '2017' and month(A.NgayKH) = '02'

--q.c Cho biết các tour không đi qua thành phố Nha Trang
select *
from Tour
where MaTour not in (select MaTour
					from ThanhPho A, Tour_TP B
					where A.MaTP=B.MaTP and TenTP='Nha Trang')

--q.d Cho biết số lượng thành phố du lịch mỗi tour du lịch đi qua
select MaTour, count(MaTP) as SoLuongTPDiQua
from Tour_TP
group by MaTour

--q.e Cho biết sô lượng tour du lịch mỗi hướng dẫn viên hướng dẫn
select TenHDV, count(MaTour) as SoTour
from Lich_TourDL
group by TenHDV
 
--q.f Cho biết tên thành phố có nhiều tour du lịch đi qua nhất
select TenTP
from ThanhPho A, Tour_TP B
where A.MaTP = B.MaTP
group by A.MaTP, TenTP
having count(MaTour) >= all (select count(MaTour)
							 from Tour_TP
							 group by MaTP )

--q.g Cho biết thông tin của tour đi qua tất cả các thành phố
--insert into Tour_TP values('T004', '01',3)
--insert into Tour_TP values('T004', '03',3)
--delete from Tour_TP where MaTour='T004' and MaTP='01'
--delete from Tour_TP where MaTour='T004' and MaTP='03'
select A.MaTour, TongSoNgay
from Tour A, Tour_TP B
where A.MaTour = B.MaTour
group by A.MaTour,TongSoNgay
having count(MaTP) >= all (select count(MaTP)
						   from ThanhPho)

--q.h Lập danh sách các tour đi qua thành phố Đà Lạt, thông tin cần hiển thị gồm: Mã tour, Số ngày
select MaTour, SoNgay
from Tour_TP A, ThanhPho B
where A.MaTP = B.MaTP and TenTP=N'Đà Lạt'

--q.i Cho biết thông tin của tour du lịch có tổng số lượng khách tham gia nhiều nhất
select A.MaTour, TongSoNgay
from Tour A, Lich_TourDL B
where A.MaTour=B.MaTour
group by A.MaTour, TongSoNgay
having sum(SoNguoi) >= all (select sum(SoNguoi)
							from Lich_TourDL
							group by MaTour )
--q.j Cho biết tên thành phố mà tất cả các tour du lịch đều đi qua
--insert into Tour_TP values('T004', '01',3)
--insert into Tour_TP values('T001', '02',3)
--delete from Tour_TP where MaTour='T004' and MaTP='01'
--delete from Tour_TP where MaTour='T001' and MaTP='02'
select TenTP
from Tour_TP A, ThanhPho B
where A.MaTP=B.MaTP
group by B.MaTP, TenTP
having count(MaTour) >= all (select count(MaTour)
							 from Tour)