/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Phan Thanh Thảo Quyên
   MSSV: 2115260
   Lớp: CTK45B
   Ngày bắt đầu: 24/02/2023
   Ngày kết thúc: ?????
*/	
CREATE DATABASE Lab04_QLBao
go
use Lab04_QLBao
go

create table Bao_TChi
(
MaBaoTC char(4) primary key,
Ten nvarchar(50) not null,
DinhKy nvarchar(30) not null,
SoLuong int not null,
GiaBan int not null
)
go
create table PhatHanh
(
MaBaoTC char(4) references Bao_TChi(MaBaoTC),
SoBaoTC int not null,
NgayPH datetime not null,
primary key(MaBaoTC, SoBaoTC)
)
go

create table KhachHang
(
MaKH char(4) primary key,
TenKH nvarchar(40) not null,
DiaChi nvarchar(40) not null,
)
go
create table DatBao
(
MaKH char(4) references KhachHang(MaKH),
MaBaoTC char(4) references Bao_TChi(MaBaoTC),
SLMua int not null,
NgayDM datetime not null
)
go
-----------------THEM DU LIEU VAO BANG----------------
insert into Bao_TChi values('TT01', N'Tuổi trẻ', N'Nhật báo', 1000, 1500)
insert into Bao_TChi values('KT01', N'Kiến thức ngày nay', N'Bán nguyệt san', 3000, 6000)
insert into Bao_TChi values('TN01', N'Thanh niên', N'Nhật báo', 1000, 2000)
insert into Bao_TChi values('PN01', N'Phụ nữ', N'Tuần báo', 2000, 4000)
insert into Bao_TChi values('PN02', N'Phụ nữ', N'Nhật báo', 1000, 2000)
select * from Bao_TChi

insert into PhatHanh values('TT01', 123, '2005/12/15')
insert into PhatHanh values('KT01', 70, '2005/12/15')
insert into PhatHanh values('TT01', 124, '2005/12/16')
insert into PhatHanh values('TN01', 256, '2005/12/17')
insert into PhatHanh values('PN01', 45, '2005/12/23')
insert into PhatHanh values('PN02', 111, '2005/12/18')
insert into PhatHanh values('PN02', 112, '2005/12/19')
insert into PhatHanh values('TT01', 125, '2005/12/17')
insert into PhatHanh values('PN01', 46, '2005/12/30')
select * from PhatHanh

insert into KhachHang values('KH01', N'LAN', N'2 NCT')
insert into KhachHang values('KH02', N'NAM', N'32 THĐ')
insert into KhachHang values('KH03', N'NGỌC', N'16 LHP')
select * from KhachHang

insert into DatBao values('KH01', 'TT01', 100, '2000/01/12')
insert into DatBao values('KH02', 'TN01', 150, '2001/05/01')
insert into DatBao values('KH01', 'PN01', 200, '2001/06/25')
insert into DatBao values('KH03', 'KT01', 50, '2002/03/17')
insert into DatBao values('KH03', 'PN02', 200, '2003/08/26')
insert into DatBao values('KH02', 'TT01', 250, '2004/01/15')
insert into DatBao values('KH01', 'KT01', 300, '2004/10/14')
select * from DatBao

select * from Bao_TChi
select * from PhatHanh
select * from KhachHang
select * from DatBao

----------TRUY VAN DU LIEU--------------
--q1: Cho biết các tờ báo, tạp chí(MABAOTC, TEN, GIABAN) có định kì phát hành hàng tuần (Tuần báo)
select MaBaoTC, Ten, GiaBan
from Bao_TChi
where DinhKy = N'Nhật báo'
--q2: Cho biết thông tin về các tờ báo thuộc loại báo phụ nữ (mã báo tạp chí bắt đầu bằng PN)
select *
from Bao_TChi
where MaBaoTC like'PN%'
--q3: Cho biết tên các khách hàng có đặt mua tất cả báo phụ nữ (mã báo tạp chí bắt đầu bằng PN), không liệt kê khách hàng trùng
select TenKH
from KhachHang A, DatBao B
where A.MaKH = B.MaKH and MaBaoTC like 'PN%'

--q6: Cho biết số tờ báo mà mỗi khách hàng đặt mua
select TenKH, Sum(SLMua) as SoLuong
from KhachHang A, DatBao B
where A.MaKH = B.MaKH 
group by B.MaKH, TenKH

--q7: Cho biết số khách hàng đặt mua báo trong năm 2004
select Count(MaKH) as SoKhachHang
from DatBao
where year(NgayDM) = '2004'

--q8: Cho biết thông tin đặt mua báo của các khách hàng (MaKH, Ten, DinhKy, SLMua, SoTien), trong đó SoTien = SLMua * DonGia
select A.MaKH, TenKH, DinhKy, SLMua, SLMua*GiaBan as SoTien
from KhachHang A, DatBao B, Bao_TChi C
where A.MaKH = B.MaKH and B.MaBaoTC = C.MaBaoTC
order by TenKH

--q9: Cho biết các tờ báo, tạp chí (ten, dinhky), và tổng số lượng đặt mua của các khách hàng đối với tờ báo, tạp chí đó
select Ten, DinhKy, sum(SLMua) as TongSoLuong
from Bao_TChi A, DatBao B
where A.MaBaoTC=B.MaBaoTC
group by B.MaBaoTC, Ten, DinhKy

--q10: Cho biết tên các tờ báo dành cho học sinh, sinh viên (mã báo tạp chí bắt đầu bằng HS)
select Ten
from Bao_TChi
where MaBaoTC like 'HS%'

--q4: Cho biết tên các khách hàng có đặt mua tất cả các báo phụ nữ (mã báo tạp chí bắt đầu bằng PN)
--insert into DatBao values('KH03', 'PN01', 300, '2004/10/14')
--insert into DatBao values('KH01', 'PN02', 300, '2004/10/14')
--delete from DatBao where MaKH='KH03' and MaBaoTC='PN01'
--delete from DatBao where MaKH='KH01' and MaBaoTC='PN02'
select A.MaKH, TenKH
from KhachHang A, DatBao B, Bao_TChi C
where A.MaKH=B.MaKH and C.MaBaoTC = B.MaBaoTC and C.MaBaoTC like 'PN%'
group by A.MaKH, TenKH
having count(C.MaBaoTC) >= all (select count(MaBaoTC)
								from Bao_TChi
								where MaBaoTC like 'PN%')

--q5: Cho biết các khách hàng không đặt mua báo thanh niên
select *
from KhachHang
where MaKH not in (select A.MaKH
					from KhachHang A, DatBao B, Bao_TChi C
					where A.MaKH=B.MaKH and C.MaBaoTC=B.MaBaoTC and Ten=N'Thanh niên')
--q11: Cho biết những tờ báo không có người đặt mua
--insert into Bao_TChi values('SK01', N'Sức khỏe', N'Nhật báo', 100, 1500)
--delete from Bao_TChi where MaBaoTC='SK01'
select *
from Bao_TChi
where MaBaoTC not in (select A.MaBaoTC
					from Bao_TChi A, DatBao B
					where A.MaBaoTC = B.MaBaoTC)
--q12: Cho biết tên, định kỳ những tờ báo có nhiều người đặt mua nhất
select  Ten, DinhKy
from Bao_TChi A, DatBao B
where A.MaBaoTC = B.MaBaoTC
group by A.MaBaoTC, Ten, DinhKy
having count(MaKH) >= all (select count(MaKH) 
							from DatBao
							group by MaBaoTC)
--q13: Cho biết khách hàng đặt mua nhiều báo, tạp chí nhất
select A.MaKH, TenKH, DiaChi
from KhachHang A, DatBao B
where A.MaKH = B.MaKH
group by A.MaKH, TenKH, DiaChi 
having count(MaBaoTC) >= all (select count(MaBaoTC)
							  from DatBao
							  group by MaKH)

--q14: Cho biết các tờ báo phát hành định kỳ một tháng 2 lần
select *
from Bao_TChi
where DinhKy = N'Bán nguyệt san'

--q15: Cho biết các tờ báo, tạp chí có từ 3 khách hàng đặt mua trở lên
select B.MaBaoTC, count(MaKH) as SoKH
from Bao_TChi A, DatBao B
where A.MaBaoTC = B.MaBaoTC
group by B.MaBaoTC
having count(MaKH) >= 3

------------HÀM VÀ THỦ TỤC---------------------------
------A. Hàm ---------
--qA.a Tính tổng số tiền mua báo/tạp chí của 1 khách hàng cho trước
create function fn_TinhTongTien_KhachHang(@makh char(4)) returns int
as
begin
	declare @tongtien int
	if exists (select * from KhachHang where MaKH =@makh)
		begin
			select @tongtien = sum(SLMua*GiaBan)
			from KhachHang A, DatBao B, Bao_TChi C
			where A.MaKH=B.MaKH and C.MaBaoTC=B.MaBaoTC and A.MaKH=@makh
		end
return @tongtien
end
--thu nghiem
print dbo.fn_TinhTongTien_KhachHang('KH01')
print dbo.fn_TinhTongTien_KhachHang('KH03')

--qA.b Tính tổng số tiền thu được cho một tờ báo/ tạp chí cho trước
create function fn_TinhTongTien_BaoTapChi(@mabaotc char(4)) returns int
as
begin
	declare @tongtien int
	if exists (select * from Bao_TChi where MaBaoTC =@mabaotc)
		begin
			select @tongtien = sum(SLMua*GiaBan)
			from DatBao A, Bao_TChi B
			where A.MaBaoTC=B.MaBaoTC and A.MaBaoTC=@mabaotc
		end
return @tongtien
end
--thu nghiem
print dbo.fn_TinhTongTien_BaoTapChi('TT01')

------B. Thủ tục------
--qB.a In danh mục báo, tạp chí phải giao cho 1 khách hàng cho trước
create proc InDanhMuc_KhachHang
@makh char(4)
as
	if exists (select * from KhachHang where MaKH=@makh)
	begin
		select C.MaBaoTC, Ten, DinhKy, SLMua, GiaBan
		from KhachHang A, DatBao B, Bao_TChi C
		where A.MaKH=B.MaKH and C.MaBaoTC=B.MaBaoTC and A.MaKH=@makh
	end
	else
		print N'Không tồn tại khách hàng có mã là '+@makh+' trong CSDL'
go
--thu nghiem
exec InDanhMuc_KhachHang 'KH01'
exec InDanhMuc_KhachHang 'KH10'

--qB.b In danh sách khách hàng đã đặt mua báo/tạp chí cho trước 
create proc InDSKHDaDatMuaBaoTC
@mabaotc char(4)
as
	if exists (select * from Bao_TChi where MaBaoTC=@mabaotc)
	begin
		select B.MaKH, TenKH, DiaChi
		from Bao_TChi A, KhachHang B, DatBao C
		where A.MaBaoTC=C.MaBaoTC and B.MaKH=C.MaKH and A.MaBaoTC=@mabaotc
	end
	else
		print N'Không tồn tại báo/tạp chí có mã '+@mabaotc
go

exec InDSKHDaDatMuaBaoTC 'TT01'
exec InDSKHDaDatMuaBaoTC 'KT01'
exec InDSKHDaDatMuaBaoTC 'FF05'