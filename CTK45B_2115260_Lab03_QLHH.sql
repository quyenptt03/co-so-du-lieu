/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Phan Thanh Thảo Quyên
   MSSV: 2115260
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: ?????
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab03_QLHH
go
use Lab03_QLHH
go

create table HangHoa(
MaHH char(5) primary key,
TenHH nvarchar(40) not null,
DVT char(3) default 'cái',
SoLuongTon tinyint not null
)
go
create table DoiTac(
MaDT char(5) primary key,
TenDT nvarchar(30) not null,
DiaChi nvarchar(50) not null,
DienThoai char(10) not null
)
go
create table KhaNangCC(
MaDT char(5) references DoiTac(MaDT),
MaHH char(5) references HangHoa(MaHH),
primary key(MaDT, MaHH)
)
go
create table HoaDon(
SoHD char(5) primary key,
NgayLapHD datetime,
MaDT char(5) references DoiTac(MaDT),
TongTG int
)
go
create table CT_HoaDon(
SoHD char(5) references HoaDon(SoHD),
MaHH char(5) references HangHoa(MaHH),
DonGia int not null,
SoLuong int not null
)
go
-------------NHAP DU LIEU CHO CAC BANG-----------
insert into HangHoa values('CPU01', 'CPU INTEL,CELERON 600 BOX', 'CÁI',5)
insert into HangHoa values('CPU02', 'CPU INTEL,PIII 700', 'CÁI',10)
insert into HangHoa values('CPU03', 'CPU AMD K7 ATHL, ON 600', 'CÁI',8)
insert into HangHoa values('HDD01', 'HDD 10.2 GB QUANTUM', 'CÁI',10)
insert into HangHoa values('HDD02', 'HDD 13.6 GB SEAGATE', 'CÁI',15)
insert into HangHoa values('HDD03', 'HDD 20 GB QUANTUM', 'CÁI',6)
insert into HangHoa values('KB01', 'KB GENIUS', 'CÁI',12)
insert into HangHoa values('KB02', 'KB MITSUMIMI', 'CÁI',5)
insert into HangHoa values('MB01', 'GIGABYTE CHIPSET INTEL', 'CÁI',10)
insert into HangHoa values('MB02', 'ACOPR BX CHIPSET VIA', 'CÁI',10)
insert into HangHoa values('MB03', 'INTEL PHI CHIPSET INTEL', 'CÁI',10)
insert into HangHoa values('MB04', 'ECS CHIPSET SIS', 'CÁI',10)
insert into HangHoa values('MB05', 'ECS CHIPSET VIA', 'CÁI',10)
insert into HangHoa values('MNT01', 'SAMSUNG 14" SUNCMASTER', 'CÁI',5)
insert into HangHoa values('MNT02', 'LG 14"', 'CÁI',5)
insert into HangHoa values('MNT03', 'ACER 14"', 'CÁI',8)
insert into HangHoa values('MNT04', 'PHILIPS 14"', 'CÁI',6)
insert into HangHoa values('MNT05', 'VIEWSONIC 14"', 'CÁI',7)
select * from HangHoa

insert into DoiTac values('CC001', N'Cty TNC', N'176 BTX Q1 - TPHCM', '08.8250259')
insert into DoiTac values('CC002', N'Cty Hoàng Long', N'15A TTT Q1 - TPHCM', '08.8250898')
insert into DoiTac values('CC003', N'Cty Hợp Nhất',N'152 BTX Q1 - TPHCM', '08.8252376')
insert into DoiTac values('K0001', N'Nguyễn Minh Hải', N'91 Nguyễn Văn Trỗi Tp.Đà Lạt', '063.831129')
insert into DoiTac values('K0002', N'Như Quỳnh', N'21 Điện Biên Phủ N.Trang', '058.590270')
insert into DoiTac values('K0003', N'Trần Nhật Duật', N'Lê Lợi TP.Huế', '054.848376')
insert into DoiTac values('K0004', N'Phan Nguyễn Hùng Anh', N'11 Nam Kỳ Khởi Nghĩa - Tp.Đà Lạt', '063.823409')
select * from DoiTac

insert KhaNangCC values('CC001','CPU01')
insert KhaNangCC values('CC001','HDD03')
insert KhaNangCC values('CC001','KB01')
insert KhaNangCC values('CC001','MB02')
insert KhaNangCC values('CC001','MB04')
insert KhaNangCC values('CC001','MNT01')
insert KhaNangCC values('CC002','CPU01')
insert KhaNangCC values('CC002','CPU02')
insert KhaNangCC values('CC002','CPU03')
insert KhaNangCC values('CC002','KB02')
insert KhaNangCC values('CC002','MB01')
insert KhaNangCC values('CC002','MB05')
insert KhaNangCC values('CC002','MNT03')
insert KhaNangCC values('CC003','HDD01')
insert KhaNangCC values('CC003','HDD02')
insert KhaNangCC values('CC003','HDD03')
insert KhaNangCC values('CC003','MB03')
select * from KhaNangCC

insert HoaDon values('N0001', '2006/01/25', 'CC001', null)
insert HoaDon values('N0002', '2006/05/01', 'CC002', null)
insert HoaDon values('X0001', '2006/05/12', 'K0001', null)
insert HoaDon values('X0002', '2006/06/16', 'K0002', null)
insert HoaDon values('X0003', '2006/04/20', 'K0001', null)
select * from HoaDon

insert CT_HoaDon values('N0001', 'CPU01', 63, 10)
insert CT_HoaDon values('N0001', 'HDD03', 97, 7)
insert CT_HoaDon values('N0001', 'KB01', 3, 5)
insert CT_HoaDon values('N0001', 'MB02', 57, 5)
insert CT_HoaDon values('N0001', 'MNT01', 112, 3)
insert CT_HoaDon values('N0002', 'CPU02', 115, 3)
insert CT_HoaDon values('N0002', 'KB02', 5, 7)
insert CT_HoaDon values('N0002', 'MNT03', 111, 5)
insert CT_HoaDon values('X0001', 'CPU01', 67, 2)
insert CT_HoaDon values('X0001', 'HDD03', 100, 2)
insert CT_HoaDon values('X0001', 'KB01', 5, 2)
insert CT_HoaDon values('X0001', 'MB02', 62, 1)
insert CT_HoaDon values('X0002', 'CPU01', 67, 1)
insert CT_HoaDon values('X0002', 'KB02', 7, 3)
insert CT_HoaDon values('X0002', 'MNT01', 115, 2)
insert CT_HoaDon values('X0003', 'CPU01', 67, 1)
insert CT_HoaDon values('X0003', 'MNT03', 115, 2)
select * from CT_HoaDon

-----------------------------------------------------------------------
---------------------------TRUY VẤN DỮ LIỆU----------------------------
--q1: Liệt kê các mặt hàng thuộc đĩa cứng
select *
from HangHoa
where MaHH like 'HDD%'

--q2: Liệt kê các mặt hàng có số lượng tồn trên 10
select *
from HangHoa
where SoLuongTon > 10

--q3: Cho biết thông tin về các nhà cung cấp ở Thành phố Hồ Chí Minh
select *
from DoiTac
where DiaChi like N'%HCM%'

--q4: Liệt kê hóa đơn nhập hàng trong tháng 5/2006, thông tin hiển thị gồm: sohd, ngaylaphd, ten, diachi, dienthoai nha cung cấp, số mặt hàng
select A.SoHD, NgayLapHD, TenDT, DiaChi, DienThoai, SoLuong
from HoaDon A, DoiTac B, CT_HoaDon C
where A.MaDT=B.MaDT and A.SoHD=C.SoHD and month(NgayLapHD) = '05' and year(NgayLapHD) = '2006'

--q5: Cho biết tên các nhà cung cấp đĩa cứng
select TenDT
from DoiTac A, KhaNangCC B
where A.MaDT=B.MaDT and MaHH like 'HDD%'
group by B.MaDT, TenDT

--q6: Cho biết tên các các nhà cung cấp có thể cung cấp tất cả các loại ổ cứng
select A.MaDT, TenDT
from DoiTac A, KhaNangCC B
where A.MaDT=B.MaDT and MaHH like 'HDD%'
group by A.MaDT, TenDT
having count(B.MaHH) = (select count(C.MaHH)
					  from HangHoa C
					  where C.MaHH like 'HDD%')

--q7: Cho biết tên nhà cung cấp không cung cấp đĩa cứng
Select	MaDT, TenDT
From	DoiTac 
Where	 MaDT like 'CC%' and MaDT NOT IN (	Select	A.MaDT
						From	DoiTac A, KhaNangCC B
						Where	A.MaDT=B.MaDT and MaHH like 'HDD%')

--q8: Cho biết thông tin của mặt hành chưa bán được
Select	MaHH
From	HangHoa 
Where	 MaHH NOT IN (	Select	A.MaHH
						From	HangHoa A, CT_HoaDon B
						Where	A.MaHH=B.MaHH and B.SoHD like 'X%')

--q9: Cho biết tên và tổng số lượng bán của mặt hàng bán chạy nhất (tính theo số lượng)
select TenHH, sum(SoLuong) as TongSoLuong
from HangHoa A, CT_HoaDon B
where A.MaHH = B.MaHH and B.SoHD like 'X%'
group by A.MaHH, TenHH
having sum(SoLuong) >=all (select sum(SoLuong)
						   from CT_HoaDon
						   where SoHD like 'X%'
						   group by MaHH)

--q10: Cho biết tên và tổng số lượng của mặt hàng nhập về ít nhất
select TenHH, sum(SoLuong) as TongSoLuong
from HangHoa A, CT_HoaDon B
where A.MaHH = B.MaHH and B.SoHD like 'N%'
group by A.MaHH, TenHH
having sum(SoLuong) <=all (select sum(SoLuong)
						   from CT_HoaDon
						   where SoHD like 'N%'
						   group by MaHH)

--q11: Cho biết hóa đơn nhập nhiều mặt hàng nhất
select SoHD, count(A.MaHH) as TongMH
from HangHoa A, CT_HoaDon B
where A.MaHH = B.MaHH and B.SoHD like 'N%'
group by SoHD
having count(A.MaHH) >=all (select count(MaHH)
						   from CT_HoaDon
						   where SoHD like 'N%'
						   group by SoHD)

--q12: Cho biết các mặt hàng không được nhập hàng trong tháng 1/2006
Select	MaHH
From	HangHoa 
Where	 MaHH NOT IN (	Select	A.MaHH
						From	HangHoa A, CT_HoaDon B, HoaDon C
						Where	A.MaHH=B.MaHH and B.SoHD=C.SoHD and B.SoHD like 'N%' and month(C.NgayLapHD)='01' and year(C.NgayLapHD)='2006')

--q13: Cho biết tên các mặt hàng không bán được trong tháng 6/2006
Select	MaHH
From	HangHoa 
Where	 MaHH NOT IN (	Select	A.MaHH
						From	HangHoa A, CT_HoaDon B, HoaDon C
						Where	A.MaHH=B.MaHH and B.SoHD=C.SoHD and B.SoHD like 'X%' and month(C.NgayLapHD)='06' and year(C.NgayLapHD)='2006')

--q14: Cho biết cửa hàng bán bao nhiêu mặt hàng
select count(MaHH) SoMatHang
from HangHoa

--q15: Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp
select TenDT as NhaCC, count(MaHH) as SoLuong
from DoiTac A, KhaNangCC B
where A.MaDT=B.MaDT
group by A.MaDT, TenDT

--q16: Cho biết thông tin của khách hàng có giao dịch với nhiều cửa hàng nhiều nhất
select A.MaDT,TenDT, DiaChi, DienThoai
from DoiTac A, HoaDon B
where A.MaDT=B.MaDT and A.MaDT like 'K%'
group by A.MaDT,TenDT, DiaChi, DienThoai
having count(A.MaDT) >=all (select count(MaDT)
						   from HoaDon
						   where SoHD like 'X%'
						   group by MaDT)
						   
--q17: Tính tổng doanh thu năm 2006
select sum(A.DonGia * A.SoLuong) as TongDoanhThu2006
from CT_HoaDon A, HoaDon B
where A.SoHD = B.SoHD and A.SoHD like 'X%' and year(B.NgayLapHD)='2006'

--q18: Cho biết loại mặt hàng bán chạy nhất
select left(MaHH, len(MaHH)-2) as TenLoai, sum(SoLuong) as SoLuong
from CT_HoaDon
where SoHD like 'X%'
group by left(MaHH, len(MaHH)-2)
having sum(SoLuong) >= all(select sum(SoLuong)
							from CT_HoaDon
							where SoHD like 'X%'
							group by left(MaHH, len(MaHH)-2))

--q19: Liệt kê thông tin bán hàng của tháng 5/2006 bao gồm: mahh, dvt, tổng số lượng, tổng thành tiền
select A.MaHH, DVT, SoLuong, SoLuong*DonGia as TongThanhTien
from HangHoa A, CT_HoaDon B, HoaDon C
where A.MaHH=B.MaHH and C.SoHD=B.SoHD and month(NgayLapHD)='05' and year(NgayLapHD) = '2006' and B.SoHD like 'X%'

--q20: Liệt kê thông tin mặt hàng có nhiều người mua nhất.
select A.MaHH, TenHH, DVT, SoLuongTon, count(C.MaDT) as SoLuongNguoiMua
from HangHoa A, CT_HoaDon B, DoiTac C, HoaDon D
where A.MaHH = B.MaHH and D.SoHD = B.SoHD and C.MaDT = D.MaDT and D.SoHD like 'X%'
group by A.MaHH, C.MaDT,TenHH, DVT, SoLuongTon
having count(C.MaDT) >=all (select count(E.MaDT)
							from DoiTac E, CT_HoaDon F, HoaDon G
							where E.MaDT = G.MaDT and G.SoHD = F.SoHD and F.SoHD like 'X%'
							group by F.MaHH, E.MaDT)
--q21: Tính và cập nhật tổng giá trị các hóa đơn
update HoaDon
set TongTG = (select sum(DonGia * SoLuong)
			  from CT_HoaDon
			  where CT_HoaDon.SoHD = HoaDon.SoHD)
select * from HoaDon

------------THỦ TỤC VÀ HÀM----------------
----------A. HÀM--------------
--qA.a tính tổng số lượng nhập trong 1 khoảng thời gian của 1 mặt hàng cho trước
create function fn_TongSLNhapTrongTG(@bd datetime, @kt datetime) returns int
as
begin
	declare @tongsl int
	if exists (select * from HoaDon where SoHD like 'N%' and NgayLapHD between @bd and @kt)
	begin
		select @tongsl = sum(SoLuong)
		from HoaDon A, CT_HoaDon B
		where A.SoHD=B.SoHD and A.SoHD like 'N%' and NgayLapHD between @bd and @kt
	end
	else
		select @tongsl = 0
return @tongsl
end
--thu nghiem
print dbo.fn_TongSLNhapTrongTG('2006/01/20', '2006/03/03')
print dbo.fn_TongSLNhapTrongTG('2001/05/11', '2001/12/22')

--qA.b tính tổng số lượng xuất trong 1 khoảng thời gian của 1 mặt hàng cho trước
create function fn_TongSLXuatTrongTG(@bd datetime, @kt datetime) returns int
as
begin
	declare @tongsl int
	if exists (select * from HoaDon where SoHD like 'X%' and NgayLapHD between @bd and @kt)
	begin
		select @tongsl = sum(SoLuong)
		from HoaDon A, CT_HoaDon B
		where A.SoHD=B.SoHD and A.SoHD like 'X%' and NgayLapHD between @bd and @kt
	end
	else
		select @tongsl = 0
return @tongsl
end
--thu nghiem
print dbo.fn_TongSLXuatTrongTG('2006/01/20', '2006/03/03')
print dbo.fn_TongSLXuatTrongTG('2006/05/11', '2006/05/17')

--qA.c tính tổng doanh thu trong 1 tháng cho trước
create function fn_TinhTongDoanhThu_Thang(@thang char(2)) returns int
as
begin
	declare @tongdoanhthu int
	if exists (select * from HoaDon where SoHD like 'X%' and month(NgayLapHD) = @thang)
	begin
		select @tongdoanhthu = sum(DonGia*SoLuong)
		from HoaDon A, CT_HoaDon B
		where A.SoHD=B.SoHD and A.SoHD like 'X%' and MONTH(NgayLapHD)=@thang
	end
	else
		select @tongdoanhthu=0
return @tongdoanhthu
end
--thu nghiem
print dbo.fn_TinhTongDoanhThu_Thang('04')
print dbo.fn_TinhTongDoanhThu_Thang('01')

--qA.d tính tổng doanh thu một mặt hàng trong 1 khoảng thời gian cho trước
create function fn_TongDoanhThu_1MH_TrongTG(@mahh char(5), @bd datetime, @kt datetime) returns int
as
begin
	declare @tongdoanhthu int
	if exists (select * from HoaDon where SoHD like 'X%' and NgayLapHD between @bd and @kt) and exists (select * from HangHoa where MaHH=@mahh)
	begin
		select @tongdoanhthu = sum(DonGia*SoLuong)
		from HoaDon A, CT_HoaDon B, HangHoa C
		where A.SoHD=B.SoHD and B.MaHH=C.MaHH and C.MaHH=@mahh and A.SoHD like 'X%' and NgayLapHD between @bd and @kt
	end
	else
		select @tongdoanhthu = 0
return @tongdoanhthu
end
--thu nghiem
print dbo.fn_TongDoanhThu_1MH_TrongTG('HDD03', '2006/05/11', '2006/05/17')
print dbo.fn_TongDoanhThu_1MH_TrongTG('MB02', '2006/05/11', '2006/05/17')

--qA.e tính tổng số tiền nhập hàng trong 1 khoảng thời gian cho trước
create function fn_TongTienNhapTrongTG(@bd datetime, @kt datetime) returns int
as
begin
	declare @tongsl int
	if exists (select * from HoaDon where SoHD like 'N%' and NgayLapHD between @bd and @kt)
	begin
		select @tongsl = sum(SoLuong*DonGia)
		from HoaDon A, CT_HoaDon B
		where A.SoHD=B.SoHD and A.SoHD like 'N%' and NgayLapHD between @bd and @kt
	end
	else
		select @tongsl = 0
return @tongsl
end
--thu nghiem
print dbo.fn_TongTienNhapTrongTG('2006/01/20', '2006/03/03')
print dbo.fn_TongTienNhapTrongTG('2001/05/11', '2001/12/22')

--qA.f tính tổng số tiền của một hóa đơn cho trước
create function fn_TongTien_HoaDon(@sohd char(5)) returns int
as
begin
	declare @tongtien int
	if exists (select * from HoaDon where SoHD=@sohd)
	begin
		select @tongtien = sum(SoLuong*DonGia)
		from HoaDon A, CT_HoaDon B
		where A.SoHD=B.SoHD and A.SoHD =@sohd
	end
return @tongtien
end
--thu nghiem
print dbo.fn_TongTien_HoaDon('N0001')
print dbo.fn_TongTien_HoaDon('X0003')
---------B. THỦ TỤC-----------
--qB.a cập nhật số lượng tồn của một mặt hàng khi nhập hàng hoặc xuất hàng
create proc usp_CapNhatSLTon_HangHoa
@mahh char(5)
as
	if exists (select * from HangHoa where MaHH=@mahh)
	begin
		update HangHoa
		set SoLuongTon = (
			select SoLuongTon = (case when SoHD like 'N%' then SoLuongTon + SoLuong else SoLuongTon - SoLuong end)
			from HangHoa A, CT_HoaDon B
			where A.MaHH=B.MaHH and A.MaHH=@mahh
		)
		print N'Đã cập nhật số lượng tồn cho mặt hàng '+@mahh
	end
	else
		print N'Không tồn tại mặt hàng có mã '+@mahh
go
--thu nghiem
exec usp_CapNhatSLTon_HangHoa 'CPU01'
select * from HangHoa

--qB.b cập nhật tổng trị giá của một hóa đơn
create proc usp_CapNhapTGHoaDon
@sohd char(5)
as
	if exists (select * from HoaDon where SoHD=@sohd)
		begin
			update HoaDon
			set TongTG = (select sum(DonGia * SoLuong)
						  from CT_HoaDon
						  where CT_HoaDon.SoHD = HoaDon.SoHD and HoaDon.SoHD=@sohd)
			print N'Đã cập nhật trị giá của hóa đơn '+@sohd
		end
	else
	print N'Không tồn tại hóa đơn '+@sohd
		
go
--thu nghiem
exec usp_CapNhapTGHoaDon 'N0001'
exec usp_CapNhapTGHoaDon 'X0003'

--qB.c in đầy đủ thông tin của một hóa đơn
create proc usp_InThongTinHD
@sohd char(5)
as
	if exists (select * from HoaDon where SoHD=@sohd)
	begin
		select * from HoaDon where SoHD=@sohd
		print N'Thông tin hóa đơn '+@sohd
	end
	else
		print N'Không tồn tại hóa đơn '+@sohd
go
exec usp_InThongTinHD 'N0001'
exec usp_InThongTinHD 'X0003'