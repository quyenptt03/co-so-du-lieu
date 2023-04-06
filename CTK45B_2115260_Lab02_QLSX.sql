/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Phan Thanh Thảo Quyên
   MSSV: 2115260
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: ?????
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE Lab02_QLSX
go
use Lab02_QLSX
go

create table ToSanXuat
(MaTSX	char(4) primary key,		 
TenTSX	nvarchar(10) not null unique
)
go
create table CongNhan
(MaCN char(5) primary key,
Ho nvarchar(20) not null,
Ten nvarchar(10) not null,
Phai nvarchar(3) not null,
NgaySinh datetime,
MaTSX char(4) references ToSanXuat(MaTSX)
)
go
create table SanPham
(
MaSP char(5) primary key,
TenSP nvarchar(30) not null,
DVT char(3) not null,
TienCong int  not null  
)
go
create table ThanhPham
(
MaCN char(5) references CongNhan(MaCN),
MaSP char(5) references SanPham(MaSP),
Ngay datetime not null,
SoLuong int not null,
primary key(MACN,MaSP, Ngay)
)
go
-------------NHAP DU LIEU CHO CAC BANG-----------
insert into ToSanXuat values('TS01', N'Tổ 1')
insert into ToSanXuat values('TS02', N'Tổ 2')
select * from ToSanXuat
--delete from ToSanXuat

insert into CongNhan values('CN001', N'Nguyễn Trường', 'An', 'Nam', '1981/05/12','TS01')
insert into CongNhan values('CN002', N'Lê Thị Hồng', N'Gấm', N'Nữ', '1980/06/04','TS01')
insert into CongNhan values('CN003', N'Nguyễn Công', N'Thành', 'Nam', '1981/05/04','TS02')
insert into CongNhan values('CN004', N'Võ Hữu', N'Hạnh', 'Nam', '1980/02/15','TS02')
insert into CongNhan values('CN005', N'Lý Thanh', N'Hân', N'Nữ', '1981/12/03','TS01')
select * from CongNhan

insert into SanPham values('SP001', N'Nồi đất', N'cái',10000)
insert into SanPham values('SP002', N'Chén', N'cái',2000)
insert into SanPham values('SP003', N'Bình gốm nhỏ', N'cái',20000)
insert into SanPham values('SP004', N'Bình gốm lớn', N'cái',25000)
select * from SanPham

insert into ThanhPham values('CN001', 'SP001', '2007/02/01', 10)
insert into ThanhPham values('CN002', 'SP001', '2007/02/01', 5)
insert into ThanhPham values('CN003', 'SP002', '2007/01/10', 50)
insert into ThanhPham values('CN004', 'SP003', '2007/01/12', 10)
insert into ThanhPham values('CN005', 'SP002', '2007/01/12', 100)
insert into ThanhPham values('CN002', 'SP004', '2007/02/13', 10)
insert into ThanhPham values('CN001', 'SP003', '2007/02/14', 15)
insert into ThanhPham values('CN003', 'SP001', '2007/01/15', 20)
insert into ThanhPham values('CN003', 'SP004', '2007/02/14', 15)
insert into ThanhPham values('CN004', 'SP002', '2007/01/30', 100)
insert into ThanhPham values('CN005', 'SP003', '2007/02/01', 50)
insert into ThanhPham values('CN001', 'SP001', '2007/02/20', 30)
select * from ThanhPham

select * from ToSanXuat
select * from CongNhan
select * from SanPham
select * from ThanhPham

-----------------------------------------------------------------------
---------------------------TRUY VẤN DỮ LIỆU----------------------------
--q1: Liệt kê công nhân theo tổ sản xuất gồm các thông tin: TenTSX, HoTen, NgaySinh, Phái (xép thứ tự tăng dần của tên tổ sản xuất, Tên của công nhân)
select TenTSX, Ho + ' '+ Ten as HoTen, NgaySinh, Phai
from CongNhan A, ToSanXuat B
where A.MaTSX = B.MaTSX
order by TenTSX, Ten

--q2: Liệt kê các thành phẩm mà công nhân 'Nguyễn Trường An' đã làm được gồm các thông tin: TenSP, Ngay, SoLuong, ThanhTien(Xếp thep thứ tự tăng dần của ngày)
select TenSP, Ngay, SoLuong, TienCong*SoLuong as ThanhTien
from SanPham A, ThanhPham B, CongNhan C
where A.MaSP = B.MaSP and B.MaCN = C.MaCN and C.Ho + ' ' + C.Ten = N'Nguyễn Trường An'
order by Ngay

--q3: Liệt kê các nhân viên không sản xuất Bình Gốm Lớn
select *
from CongNhan
where MaCN not in (select B.MaCN
				   from SanPham A, ThanhPham B, CongNhan C
				   where A.MaSP = B.MaSP and B.MaCN=C.MaCN and TenSP = N'Bình gốm lớn')
	  
--q4: Liệt kê thông tin các công nhân có sản xuất cả Nồi đất và Bình gốm nhỏ
select C.MaCN, Ho + ' '+ Ten as HoTen, Phai, NgaySinh, MaTSX
from SanPham A, ThanhPham B, CongNhan C
where A.MaSP = B.MaSP and B.MaCN=C.MaCN and TenSP = N'Bình gốm nhỏ' and C.MaCN in (select D.MaCN
																				   from ThanhPham D, SanPham E
																				   where D.MaSP = E.MaSP and TenSP =N'Nồi đất')
--q5: Thống kê số lượng nhân viên theo từng tổ sản xuất
select TenTSX, Count(MaCN) as SoLuong
from ToSanXuat A, CongNhan B
where A.MaTSX = B.MaTSX
group by A.MaTSX, TenTSX

--q6: Tổng số lượng thành phẩm theo từng loại mà mỗi nhân viên làm được(Ho, Ten, TenSP, TongSLThanhPham, TongThanhTien
select Ho, Ten, TenSP, sum(SoLuong) as TongSLThanhPham, sum(SoLuong*TienCong) as TongThanhTien
from SanPham A, ThanhPham B, CongNhan C
where A.MaSP=B.MaSP and C.MaCN = B.MaCN
group by TenSP, C.MaCN, Ho, Ten
order by Ten

--q7: Tổng số tiền công đã trả cho nhân viên trong tháng 1 năm 2007
select sum(SoLuong*TienCong) as TongTienCong
from ThanhPham A, SanPham B
where A.MaSP=B.MaSP and month(Ngay)='01' and year(Ngay) = '2007'

--q8: Cho biết sản phẩm được sản xuất nhiều nhất trong tháng 2/2007
select B.MaSP,TenSP, sum(SoLuong) as SoLuong
from SanPham A, ThanhPham B
where A.MaSP=B.MaSP and month(Ngay)='02' and year(Ngay)='2007'
group by B.MaSP, TenSP
having sum(SoLuong) >=all (select sum(SoLuong)
							from ThanhPham
							where month(Ngay)='02' and year(Ngay)='2007'
							group by MaSP)
--q9: Cho biết công nhân sản xuất được nhiều chén nhất
select A.MaCN,Ho+' '+Ten as HoTen,Phai, NgaySinh, MaTSX, Sum(SoLuong) as SoLuong
from CongNhan A, ThanhPham B, SanPham C
where A.MaCN=B.MaCN and B.MaSP=C.MaSP and TenSP=N'Chén'
group by A.MaCN,Ho,Ten,Phai, NgaySinh, MaTSX
having sum(SoLuong) >=all (select sum(SoLuong)
							from ThanhPham D, SanPham E
							where D.MaSP=E.MaSP and E.TenSP=N'Chén'
							group by MaCN)

--q10: Tiền công tháng 2/2007 của công nhân có mã số 'CN002'
select sum(SoLuong*TienCong) as TienCong_CN002
from ThanhPham A, SanPham B
where A.MaSP=B.MaSP and month(Ngay)='02' and year(Ngay) = '2007' and MaCN='CN002'

--q11: Liệt kê các công nhân có sản xuất từ 3 sản phẩm trở lên
select A.MaCN, Ho + ' ' + Ten as HoTen
from CongNhan A, ThanhPham B
where A.MaCN=B.MaCN 
group by A.MaCN, Ho, Ten
having Count(MaSP) >= 3

--q12: Cập nhật giá tiền công của các loại bình gốm thêm 1000
update SanPham
set TienCong=TienCong+1000
where TenSP like N'Bình gốm%'
select * from SanPham

--q13: Thêm bộ <'CN006', 'Lê Thị', 'Lan', 'Nữ', 'TS02'> vào bảng công nhân
insert into CongNhan values('CN006', N'Lê Thị', 'Lan', N'Nữ', '1981/05/04', 'TS02')
select * from CongNhan

----------------------THỦ TỤC VÀ HÀM-------------
-----------A. HÀM--------------------------
--qA.a tính tổng số công nhân của một tổ sản xuất cho trước
create function fn_TongSoCN_ToSX(@matsx char(4)) returns int
as
begin
	declare @tongso int
	if exists (select * from ToSanXuat where MaTSX=@matsx)
	begin
		select @tongso=count(MaCN)
		from CongNhan
		where CongNhan.MaTSX = @matsx
	end
return @tongso
end
--thu nghiem
print dbo.fn_TongSoCN_ToSX('TS01')

--qA.b tính tổng sản lượng sản xuất trong một tháng của 1 loại sản phẩm cho trước
create function fn_TongSanLuong_Thang_SP(@thang char(2), @masp char(5)) returns int
as
begin
	declare @tongsl int
	if exists (select * from SanPham where MaSP=@masp)
	begin
		select @tongsl = sum(SoLuong)
		from SanPham A, ThanhPham B
		where A.MaSP=B.MaSP and A.MaSP=@masp and month(Ngay)=@thang
	end
return @tongsl
end
--thu nghiem
print dbo.fn_TongSanLuong_Thang_SP('02', 'SP001')
--qA.c tính tổng tiền công tháng của 1 công nhân cho trước
create function TongTienCong_CongNhan(@macn char(5)) returns int
as
begin
	declare @tong int
	if exists (select * from CongNhan where MaCN=@macn)
	begin
		select @tong=sum(SoLuong*TienCong)
		from CongNhan A, SanPham B, ThanhPham C
		where A.MaCN=C.MaCN and B.MaSP=C.MaSP and A.MaCN=@macn
	end
return @tong
end
--thu nghiem
print dbo.TongTienCong_CongNhan('CN002')
print dbo.TongTienCong_CongNhan('CN005')

--qA.d tính tổng thu nhập trong năm của 1 tổ sản xuát cho trước
create function TongThuNhap_TSX(@matsx char(4)) returns int
as
begin
	declare @tong int
	if exists (select * from ToSanXuat where MaTSX=@matsx)
	begin
		select @tong=sum(SoLuong*TienCong)
		from CongNhan A, SanPham B, ThanhPham C
		where A.MaCN=C.MaCN and B.MaSP=C.MaSP and A.MaTSX=@matsx
	end
return @tong
end
--thu nghiem
print dbo.TongThuNhap_TSX('TS01')
print dbo.TongThuNhap_TSX('TS02')

--qA.e tính tổng sản lượng sản xuất của một loại sản phẩm trong 1 khoảng thời gian cho trước
create function fn_TongSanLuong_SP_TG(@masp char(5), @bd datetime,@kt datetime) returns int
as
begin
	declare @tongsl int
	if exists (select * from SanPham where MaSP=@masp)
	begin
		select @tongsl = sum(SoLuong)
		from SanPham A, ThanhPham B
		where A.MaSP=B.MaSP and A.MaSP=@masp and Ngay between @bd and @kt
	end
return @tongsl
end
--thu nghiem
print dbo.fn_TongSanLuong_SP_TG('SP001', '2007/02/01','2007/02/02')

-----------B. THỦ TỤC----------------------
--qB.a In danh sách các công nhân của một tổ sản xuất cho trước
create proc usp_InDSCN_TSX
@matsx char(4)
as
	if exists (select * from ToSanXuat where MaTSX=@matsx)
	begin
		select * from CongNhan where MaTSX=@matsx
		print N'Danh sách công nhân của tổ sản xuất '+@matsx
	end
	else
		print N'Không tồn tại trong CSDL tổ sản xuất có mã là '+@matsx
go
--thu nghiem
exec usp_InDSCN_TSX 'TS02'
exec usp_InDSCN_TSX 'TS12'
/*qB.b in bảng chấm công sản xuất trong tháng của 1 công nhân cho trước
(bao gồm tên sản phẩm, đơn vị tính, số lượng sản xuất trong tháng, đơn giá, thành tiền)*/
create proc usp_InBangChamCong_CongNhan 
@macn char(5), @thang char(2)
as
	if exists (select * from CongNhan where MaCN=@macn)
	begin
		select B.MaSP,DVT, TenSP, sum(SoLuong) as SoLuong, TienCong as DonGia, TienCong*sum(SoLuong) as ThanhTien
		from CongNhan A, SanPham B,ThanhPham C
		where A.MaCN=C.MaCN and B.MaSP=C.MaSP and A.MaCN=@macn and month(Ngay)=@thang
		group by A.MaCN, B.MaSP,TenSP, DVT,TienCong
	end
	else
		print N'Không tồn tại công nhân có mã '+@macn
go
--thu nghiem
exec usp_InBangChamCong_CongNhan 'CN001','02'
exec usp_InBangChamCong_CongNhan 'CN005','02'