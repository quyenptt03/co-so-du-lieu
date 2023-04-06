/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Phan Thanh Thảo Quyên
   MSSV: 2115260
   Lớp: CTK45B
   Ngày bắt đầu: 25/02/2023
   Ngày kết thúc: ?????
*/	
CREATE DATABASE Lab06_QLHV
go
use Lab06_QLHV
go

create table CaHoc
(
Ca tinyint primary key,
GioBatDau time not null,
GioKetThuc time not null
)
go
create table GiaoVien
(
MSGV char(4) primary key,
HoGV nvarchar(20) not null,
TenGV nvarchar(20) not null,
DienThoai nvarchar(11) not null
)
go
create table Lop
(
MaLop char(4) primary key,
TenLop nvarchar(30) not null,
NgayKG datetime not null,
HocPhi int not null,
Ca tinyint references CaHoc(Ca),
SoTiet int not null,
SoHV int not null,
MSGV char(4) references GiaoVien(MSGV)
)
go
create table HocVien
(
MSHV char(6) primary key,
Ho nvarchar(40) not null,
Ten nvarchar(20) not null,
NgaySinh datetime not  null,
Phai nvarchar(3) not null,
MaLop char(4) references Lop(MaLop)
)
go
create table HocPhi
(
SoBL char(4) primary key,
MSHV char(6) references HocVien(MSHV),
NgayThu datetime not null,
SoTien int not null,
NoiDung nvarchar(60) not null,
NguoiThu nvarchar(20) not null
)
go

-------------------CÀI ĐẶT RÀNG BUỘC TOÀN VẸN--------------
/*Q4a Giờ kết thúc của một ca học không được trước giờ bắt đầu ca học đó 
(RBTV liên thuộc tính)*/
Create trigger tr_CaHoc_ins_upd_GioBD_GioKT
On CaHoc  for insert, update
As
if  update(GioBatDau) or update (GioKetThuc)
	     if exists(select * from inserted i where i.GioKetThuc<i.GioBatDau)	
	      begin
	    	 raiserror (N'Giờ kết thúc ca học không thể nhỏ hơn giờ bắt đầu',15,1)
		     rollback tran
	      end
go	
-----thử nghiệm----
insert into CaHoc values(4,'17:00','20:30')
Update CaHoc set GioKetThuc = '5:45' where ca = 1
select * from CaHoc

/* Q4b: Số học viên của 1 lớp không quá 30 và đúng bằng số học viên thuộc lớp đó. (RBTV do thuộc tính tổng hợp)*/
-----RBTV cho Lop--------
create trigger trg_Lop_ins_upd
on Lop for insert,update
AS
if Update(MaLop) or Update(SoHV)
Begin
	if exists(select * from inserted i where i.SOHV>30) 
	begin
		raiserror (N'Số học viên của một lớp không quá 30',15,1)--Thông báo lỗi cho người dùng
		rollback tran --hủy bỏ thao tác thêm lớp học
	end
	if exists (select * from inserted l 
	              where l.SOHV <> (select count(MSHV) 
									from HocVien 
									where HocVien.Malop = l.Malop))
	begin
		raiserror (N'Số học viên của một lớp không bằng số lượng học viên tại lớp đó',15,1)--Thông báo lỗi cho người dùng
		rollback tran --hủy bỏ thao tác thêm lớp học
	end
End
Go
-- Thử nghiệm 
select * from Lop
Set dateformat dmy
go
insert into Lop values('P001',N'Photoshop','1/11/2018',250000,1,100,0,'G004')
update Lop set SoHV = 5 where MaLop = 'P001'

-----RBTV cho HocVien --------
create trigger trg_HocVien_ins_del_upd
on HocVien for insert,delete, update
AS
if Update(MaLop)
Begin
	if exists(select * from inserted i, Lop l where i.MaLop=l.MaLop and l.SOHV>30) 
	begin
		raiserror (N'Số học viên của một lớp không quá 30',15,1)--Thông báo lỗi cho người dùng
		rollback tran --hủy bỏ thao tác thêm lớp học
	end
End
Go


-------------------THỦ TỤC---------------------------------
---Q5a: Thêm dữ liệu vào bảng đám bảo các ràng buộc toàn vẹn liên quan
CREATE PROC usp_ThemCaHoc
	@ca tinyint, @giobd Datetime, @giokt Datetime
As
	If exists(select * from CaHoc where Ca = @ca) --kiểm tra có trùng khóa chính (Ca) 
		print N'Đã có ca học ' +@ca+ N' trong CSDL!'
	Else
		begin
			insert into CaHoc values(@ca, @giobd, @giokt)
			print N'Thêm ca học thành công.'
		end
go
--goi thuc hien thu tuc usp_ThemCaHoc---
exec usp_ThemCaHoc 1,'7:30','10:45'
exec usp_ThemCaHoc 2,'13:30','16:45'
exec usp_ThemCaHoc 3,'17:30','20:45'

select * from CaHoc
---------------------
CREATE PROC usp_ThemGiaoVien
	@msgv char(4), @hogv nvarchar(20), @Tengv nvarchar(20),@dienthoai nvarchar(11)
As
	If exists(select * from GiaoVien where MSGV = @msgv) --kiểm tra có trùng khóa chính (MSGV) 
		print N'Đã có giáo viên có mã số ' +@msgv+ N' trong CSDL!'
	Else
		begin
			insert into GiaoVien values(@msgv, @hogv, @Tengv, @dienthoai)
			print N'Thêm giáo viên thành công.'
		end
go
--goi thuc hien thu tuc usp_ThemGiaoVien---
exec usp_ThemGiaoVien 'G001',N'Lê Hoàng',N'Anh', '858936'
exec usp_ThemGiaoVien 'G002',N'Nguyễn Ngọc',N'Lan', '845623'
exec usp_ThemGiaoVien 'G003',N'Trần Minh',N'Hùng', '823456'
exec usp_ThemGiaoVien 'G004',N'Võ Thanh',N'Trung', '841256'
select * from GiaoVien
---------------------
create PROC usp_ThemLopHoc
@malop char(4), @Tenlop nvarchar(30), 
@NgayKG datetime,@HocPhi int, @Ca tinyint, @sotiet int, @sohv int, 
@msgv char(4)
As
	If exists(select * from CaHoc where Ca = @Ca) and exists(select * from GiaoVien where MSGV=@msgv)--kiểm tra các RBTV khóa ngoại
	  Begin
		if exists(select * from Lop where MaLop = @malop) --kiểm tra có trùng khóa chính của quan hệ Lop 
			print N'Đã có lớp '+ @MaLop +' trong CSDL!'
		else	
			begin
				insert into Lop values(@malop, @Tenlop, @NgayKG, @HocPhi, @Ca, @sotiet, @sohv, @msgv)
				print N'Thêm lớp học thành công.'
			end
	  End
	Else -- Bị vi phạm ràng buộc khóa ngoại
		if not exists(select * from CaHoc where Ca = @Ca)
				print N'Không có ca học '+@Ca+' trong CSDL.'
		else	print N'Không có giáo viên '+@msgv+' trong CSDL.'
go
--goi thuc hien thu tuc usp_ThemLopHoc---
set dateformat dmy
go
exec usp_ThemLopHoc 'A075',N'Access 2-4-6','18/12/2008', 150000,3,60,3,'G003'
exec usp_ThemLopHoc 'E114',N'Excel 3-5-7','02/01/2008', 120000,1,45,3,'G003'
exec usp_ThemLopHoc 'A115',N'Excel 2-4-6','22/01/2008', 120000,3,45,0,'G001'
exec usp_ThemLopHoc 'W123',N'Word 2-4-6','18/02/2008', 100000,3,30,1,'G001'
exec usp_ThemLopHoc 'W124',N'Word 3-5-7','01/03/2008', 100000,1,30,0,'G002'
----------------------

create PROC usp_ThemHocVien
@MSHV char(6), @Ho nvarchar(40), @Ten nvarchar(20),
@NgaySinh Datetime, @Phai	nvarchar(3),@MaLop char(4)
As
	If exists(select * from Lop where MaLop = @MaLop) --kiểm tra có RBTV khóa ngoại
	  Begin
		if exists(select * from HocVien where MSHV = @MSHV) --kiểm tra có trùng khóa chính (MAHV) 
			print N'Đã có mã số học viên này trong CSDL!'
		else
			begin
				insert into HocVien values(@MSHV,@Ho, @Ten,@NgaySinh,@Phai,@MaLop)
				print N'Thêm học viên thành công.'
			end
	  End
	Else
		print N'Lớp '+ @MaLop + N' không tồn tại trong CSDL nên không thể thêm học viên vào lớp này!'
		
go
----goi thuc hien thu tuc usp_ThemHocVien-------
set dateformat dmy
go
exec usp_ThemHocVien 'A07501',N'Lê Văn', N'Minh', '10/06/1988',N'Nam', 'A075'
exec usp_ThemHocVien 'A07502',N'Nguyễn Thị', N'Mai', '20/04/1988',N'Nữ', 'A075'
exec usp_ThemHocVien 'A07503',N'Lê Ngọc', N'Tuấn', '10/06/1984',N'Nam', 'A075'
exec usp_ThemHocVien 'E11401',N'Vương Tuấn', N'Vũ', '25/03/1979',N'Nam', 'E114'
exec usp_ThemHocVien 'E11402',N'Lý Ngọc', N'Hân', '01/12/1985',N'Nữ', 'E114'
exec usp_ThemHocVien 'E11403',N'Trần Mai', N'Linh', '04/06/1980',N'Nữ', 'E114'
exec usp_ThemHocVien 'W12301',N'Nguyễn Ngọc', N'Tuyết', '12/05/1986',N'Nữ', 'W123'
select * from HocVien
----------------------------
create PROC usp_ThemHocPhi
@SoBL char(4),
@MSHV char(6),
@NgayThu Datetime,
@SoTien	int,
@NoiDung nvarchar(60),
@NguoiThu nvarchar(20)
As
	If exists(select * from HocVien where MSHV = @MSHV) --kiểm tra có RBTV khóa ngoại
	  Begin
		if exists(select * from HocPhi where SoBL = @SoBL) --kiểm tra có trùng khóa(SoBL) 
			print N'Đã có số biên lai học phí này trong CSDL!'
		else
		 begin
			insert into HocPhi values(@SoBL,@MSHV,@NgayThu, @SoTien, @NoiDung,@NguoiThu)
			print N'Thêm biên lai học phí thành công.'
		 end
	  End
	Else
		print N'Học viên '+ @MSHV + N' không tồn tại trong CSDL nên không thể thêm biên lai học phí của học viên này!'
go
----goi thuc hien thu tuc usp_ThemHocPhi-------
set dateformat dmy
go
exec usp_ThemHocPhi '0001', 'E11401', '02/01/2008', 120000, 'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi '0002', 'E11402', '02/01/2008', 120000, 'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi '0003', 'E11403', '02/01/2008', 80000, 'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi '0004', 'W12301', '18/02/2008', 100000, 'HP Word 2-4-6', N'Lan'
exec usp_ThemHocPhi '0005', 'A07501', '16/12/2008', 150000, 'HP Access 2-4-6', N'Lan'
exec usp_ThemHocPhi '0006', 'A07502', '16/12/2008', 100000, 'HP Access 2-4-6', N'Lan'
exec usp_ThemHocPhi '0007', 'A07503', '16/12/2008', 150000, 'HP Access 2-4-6', N'Vân'
exec usp_ThemHocPhi '0008', 'A07502', '15/01/2009', 50000, 'HP Access 2-4-6', N'Vân'
select * from HocPhi
--Q5b Cập nhật thông tin của một học viên cho trước
create PROC usp_CapNhatHocVien
@MSHV char(6), @Ho nvarchar(40), @Ten nvarchar(20),
@NgaySinh Datetime, @Phai	nvarchar(3),@MaLop char(4)
as
	if exists (select * from HocVien where @MSHV=MSHV)
		begin
			update HocVien
			set Ho=@Ho, Ten=@Ten, NgaySinh = @NgaySinh, Phai=@Phai, MaLop=@MaLop
			where MSHV=@MSHV
			print N'Cập nhật học viên thành công'
		end
	else
		print N'Không tồn tại học viên '+@MSHV+N' trong CSDL'

go
set dateformat dmy
go
--thu nghiem
usp_CapNhatHocVien 'A07501',N'Lê Văn', N'Hồng', '10/06/2003',N'Nam', 'A075'
select * from HocVien

--Q5c. xoa 1 hoc vien cho truoc
create proc usp_XoaHocVien
@MSHV char(6)
as
	if exists (select * from HocPhi where @MSHV = MSHV)
			if exists(select * from HocVien where MSHV = @MSHV) 
			begin
				delete from HocPhi where HocPhi.MSHV=@MSHV
				delete from HocVien where MSHV = @MSHV
				print N'Xóa học viên thành công.'
			end
		else
			print N'Học viên '+ @MSHV + N' không tồn tại trong CSDL nên không thể xóa học viên này'
	else
		print N'Học viên '+ @MSHV + N' không tồn tại trong CSDL nên không thể xóa học viên này'
go
--thu nghiem
exec usp_XoaHocVien 'A07501'
exec usp_XoaHocVien 'ABCD00'
select * from HocPhi
select * from HocVien

--Q5d Cập nhật thông tin của một lớp học cho trước
create PROC usp_CapNhatLopHoc
@malop char(4), @Tenlop nvarchar(20), 
@NgayKG datetime,@HocPhi int, @Ca tinyint, @sotiet int, @sohv int, 
@msgv char(4)
as
	if exists (select * from Lop where @malop=malop)
		begin
			update Lop
			set TenLop=@Tenlop, NgayKG=@NgayKG, HocPhi=@HocPhi, Ca=@Ca, SoTiet=@sotiet, SoHV=@sohv,MSGV=@msgv
			where @malop=malop
			print N'Cập nhật lớp học thành công'
		end
	else
		print N'Không tồn tại lớp này '+@MaLop+N' trong CSDL'

go
set dateformat dmy
go
--thử nghiệm
exec usp_CapNhatLopHoc 'A075',N'Access 2-4-6','18/12/2008', 250120,3,60,3,'G002'
exec usp_CapNhatLopHoc '1234',N'Access 2-4-6','18/12/2008', 599123,3,60,3,'G002'
select * from Lop

--Q5e Xóa 1 lớp cho trước nếu lớp học này không có học viên
create proc usp_XoaLopNeuLopKhongCoHocVien 
as
	if exists (select * from Lop where SoHV=0) 
		begin
			delete from Lop where SoHV=0
			print N'Xóa thành công các lớp không có học viên'
		end
	else
		print N'Không tồn tại lớp không có học viên'
go
--thu nghiem
exec usp_XoaLopNeuLopKhongCoHocVien
select * from Lop

--Q5f Lập danh sách học viên của 1 lớp cho trước
create proc usp_DSHV_Lop
@malop char(4)
as
	if exists (select * from Lop where malop=@malop)
		begin
			print N'Danh sách học viên của lớp '+@malop
			select * from HocVien where MaLop=@malop
		end
	else
		print N'Không tồn tại lớp '+@malop
go
--thu nghiem
exec usp_DSHV_Lop 'A075'
exec usp_DSHV_Lop 'E114'
exec usp_DSHV_Lop 'acbd'

--Q5g Lập danh sách học viên chưa đóng đủ học phí của một lớp cho trước
create proc usp_DSHVChuaDongDuHP_Lop
@malop char(4)
as
	if exists (select * from Lop where malop=@malop)
		begin
			select B.MaLop, A.MSHV, Ho+' '+Ten as HoTen, sum(SoTien) as TongSoTien
			from HocVien as A, Lop as B, HocPhi as C 
			where A.MSHV=C.MSHV and A.MaLop=B.MaLop and B.MaLop=@malop
			group by B.MaLop, A.MSHV, HocPhi, Ho, Ten
			having sum(SoTien) < HocPhi
		end
	else
		print N'Không tồn tại lớp '+@malop
go
--thu nghiem
exec usp_DSHVChuaDongDuHP_Lop 'A075'
exec usp_DSHVChuaDongDuHP_Lop 'E114'

-------------------HÀM-------------------------------------
--Q6a Hàm tính tổng số học phí đã thu được của một lớp khi biết mã lớp. 
create function fn_TongHocPhi1Lop(@malop char(4)) returns int
As
Begin
	declare @TongTien int
	if exists (select * from Lop where MaLop = @MaLop) ---Nếu tồn tại lớp @malop trong CSDL
		Begin
		--Tính tổng số học phí thu được trên 1 lớp
		select @TongTien = sum(SoTien)
		from	HocPhi A, HocVien B	
		where	A.MSHV = B.MSHV and B.Malop = @malop
		End	
	 	
return @TongTien
End
--- thử nghiệm hàm-------
print dbo.fn_TongHocPhi1Lop('A075')

--Q6b Hàm tính tổng số học phí thu được trong một khoảng thời gian cho trước. 
create function fn_TongHocPhi(@bd datetime,@kt datetime) returns int
As
Begin
	declare @TongTien int
	--Tính tổng số học phí thu được trong khoảng thời gian từ bắt đầu đến kết thúc
	select @TongTien = sum(SoTien)
	from	HocPhi 	
	where	NgayThu between @bd and @kt
return @TongTien
End
--- thu nghiem ham-------
set dateformat dmy
print dbo.fn_TongHocPhi('1/1/2008','15/1/2008')
--Q6c Cho biết một học viên cho trước đã nộp đủ học phí hay chưa. 
create function fn_KTSinhVienDaNopDuHP(@mshv char(6)) returns nvarchar(100)
as
begin
	declare @KQ nvarchar(100)
	if exists (select * from HocVien where MSHV=@mshv)
	begin
		select @KQ = (case when sum(SoTien) < HocPhi then N'HV chưa đóng đủ học phí' else N'HV đã đóng đủ học phí' end)
		from HocVien A, HocPhi B, Lop C
		where A.MaLop=C.MaLop and A.MSHV=B.MSHV and A.MSHV=@mshv
		group by HocPhi
	end
	else 
		select @KQ = N'Không tồn tại học viên trong CSDL'
return @KQ
end
---thu nghiem
print dbo.fn_KTSinhVienDaNopDuHP('W12301')
print dbo.fn_KTSinhVienDaNopDuHP('E11403')
print dbo.fn_KTSinhVienDaNopDuHP('ABCDEF')
select * from HocPhi
--Q6d Hàm sinh mã số học viên theo quy tắc mã số học viên gồm mã lớp của học viên kết hợp với số thứ tự của học viên trong lớp đó. 
alter function SinhMaHV(@MaLop char(4)) returns varchar(6)
as
begin
	declare @MaxMaHV_Lop char(6)
	declare @NewMaHV varchar(6)
	declare @SoKySo int
	declare @stt int
	declare @i int

	if exists (select * from Lop where MaLop=@MaLop)
	begin
		if exists (select * from HocVien where MaLop=@MaLop)
			begin
				select @MaxMaHV_Lop = max(MSHV)
				from HocVien
				where MaLop=@MaLop

				set @stt=convert(int, right(@MaxMaHV_Lop, 2)) + 1
			end
		else
			set @stt=1

		set @SoKySo = len(convert(varchar(2), @stt))
		set @NewMaHV = @MaLop
		set @i=0
		while @i < 2 - @SoKySo
			begin 
				set @NewMaHV = @NewMaHV + '0'
				set @i = @i + 1
			end
			
		set @NewMaHV = @NewMaHV + convert(varchar(2), @stt)
	end

return @newMaHV
end
--Thử hàm sinh mã
select * from HocVien
print dbo.SinhMaHV('W124')
print dbo.SinhMaHV('A075')
