/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Phan Thanh Thảo Quyên
   MSSV: 2115260
   Lớp: CTK45B
   Ngày bắt đầu: 25/02/2023
   Ngày kết thúc: ?????
*/
CREATE DATABASE Lab07_QLSV
go
use Lab07_QLSV
go

create table Khoa
(
MSKhoa char(2) primary key,
TenKhoa nvarchar(50) not null,
TenTat nvarchar(20) not null
)
go
create table Lop
(
MSLop char(4) primary key,
TenLop nvarchar(40) not null,
MSKhoa char(2) references Khoa(MSKhoa),
NienKhoa int  not null
)
go
create table Tinh
(
MSTinh char(2) primary key,
TenTinh nvarchar(20) not null
)
go
create table SinhVien
(
MSSV char(7) primary key,
Ho nvarchar(40) not null,
Ten nvarchar(20) not null,
NgaySinh datetime not null,
MSTinh char(2) references Tinh(MSTinh),
NgayNhapHoc datetime not null,
MSLop char(4) references Lop(MSLop),
Phai nvarchar(3) not null,
DiaChi nvarchar(100) not null,
DienThoai nvarchar(10)
)
go
create table MonHoc
(
MSMH char(4) primary key,
TenMH nvarchar(40) not null,
HeSo tinyint not null
)
go
create table BangDiem
(
MSSV char(7) references SinhVien(MSSV),
MSMH char(4) references MonHoc(MSMH),
LanThi tinyint not null,
Diem float not null,
primary key(MSSV, MSMH, LanThi)
)
go

insert into Khoa values('01', N'Công nghệ thông tin', 'CNTT')
insert into Khoa values('02', N'Điện tử viễn thông', 'DTVT')
insert into Khoa values('03', N'Quản trị kinh doanh', 'QTKD')
insert into Khoa values('04', N'Công nghệ sinh học', 'CNSH')
select * from Khoa

insert into Lop values('98TH', 'Tin hoc khoa 1998', '01', 1998)
insert into Lop values('98VT', 'Vien thong khoa 1998', '02', 1998)
insert into Lop values('99TH', 'Tin hoc khoa 1999', '01', 1999)
insert into Lop values('99VT', 'Vien thong khoa 1999', '02', 1999)
insert into Lop values('99QT', 'Quan tri khoa 1999', '03', 1999)
select * from Lop

insert into Tinh values('01', 'An Giang')
insert into Tinh values('02', 'TPHCM')
insert into Tinh values('03', 'Dong Nai')
insert into Tinh values('04', 'Long An')
insert into Tinh values('05', 'Hue')
insert into Tinh values('06', 'Ca Mau')
select * from Tinh

insert into SinhVien values('98TH001', 'Nguyen Van', 'An', '1980/08/06', '01', '1998/09/03', '98TH','Yes', '12 Tran Hung Dao, Q.1', '8234512')
insert into SinhVien values('98TH002', 'Le Thi', 'An', '1979/10/17', '01', '03/09/98', '98TH', 'No', '23 CMT8, Q. Tan Binh', '0303234342')
insert into SinhVien values('98VT001', 'Nguyen Duc', 'Binh', '1981/11/25', '02', '03/09/98', '98VT', 'Yes', '245 Lac Long Quan, Q.11', '8654323')
insert into SinhVien values('98VT002', 'Tran Ngoc', 'Anh', '1980/08/19', '02', '03/09/98', '98VT', 'No', '242 Tran Hung Dao, Q.1', null)
insert into SinhVien values('99TH001', 'Ly Van Hung', 'Dung', '1981/09/27', '03', '05/10/99', '99TH', 'Yes', '178 CMT8, Q. Tan Binh', '7563213')
insert into SinhVien values('99TH002', 'Van Minh', 'Hoang', '1981/01/01', '04', '05/10/99', '99TH', 'Yes', '272 Ly Thuong Kiet, Q.10', '8341234')
insert into SinhVien values('99TH003', 'Nguyen', 'Tuan', '1980/01/12', '03', '05/10/99', '99TH', 'Yes', '162 Tran Hung Dao, Q.5', null)
insert into SinhVien values('99TH004', 'Tran Van', 'Minh', '1981/06/25', '04', '05/10/99', '99TH', 'Yes', '147 Dien Bien Phu, Q.3', '7236754')
insert into SinhVien values('99TH005', 'Nguyen Thai', 'Minh', '1980/01/01', '04', '05/10/99', '99TH', 'Yes', '345 Le Dai Hanh, Q.11', null)
insert into SinhVien values('99VT001', 'Le Ngoc', 'Mai', '1982/06/21', '01', '05/10/99', '99VT', 'No', '129 Tran Hung Dao, Q.1', '0903124534')
insert into SinhVien values('99QT001', 'Nguyen Thi', 'Oanh', '1973/08/19', '04', '05/10/99', '99QT', 'No', '76 Hung Vuong, Q.5', '0901656324')
insert into SinhVien values('99QT002', 'Le My', 'Hanh', '1976/05/20', '04', '05/10/99', '99QT', 'No', '12 Pham Ngoc Thach, Q.3', null)
select * from SinhVien

insert into MonHoc values('TA01', 'Nhap mon tin hoc', 2)
insert into MonHoc values('TA02', 'Lap trinh co ban', 3)
insert into MonHoc values('TB01', 'Cau truc du lieu', 2)
insert into MonHoc values('TB02', 'Co so du lieu', 2)
insert into MonHoc values('QA01', 'Kinh te vi mo', 2)
insert into MonHoc values('QA02', 'Quan tri chat luong', 3)
insert into MonHoc values('VA01', 'Dien tu co ban', 2)
insert into MonHoc values('VA02', 'Mach so', 3)
insert into MonHoc values('VB01', 'Truyen so lieu', 3)
insert into MonHoc values('XA01', 'Vat ly dai cuong', 2)
select * from MonHoc

insert into BangDiem values('98TH001', 'TA01', 1, 8.5)
insert into BangDiem values('98TH001', 'TA02', 1, 8)
insert into BangDiem values('98TH002', 'TA01', 1, 4)
insert into BangDiem values('98TH002', 'TA01', 2, 5.5)
insert into BangDiem values('98TH001', 'TB01', 1, 7.5)
insert into BangDiem values('98TH002', 'TB01', 1, 8)
insert into BangDiem values('98VT001', 'VA01', 1, 4)
insert into BangDiem values('98VT001', 'VA01', 2, 5)
insert into BangDiem values('98VT002', 'VA02', 1, 7.5)
insert into BangDiem values('99TH001', 'TA01', 1, 4)
insert into BangDiem values('99TH001', 'TA01', 2, 6)
insert into BangDiem values('99TH001', 'TB01', 1, 6.5)
insert into BangDiem values('99TH002', 'TB01', 1, 10)
insert into BangDiem values('99TH002', 'TB02', 1, 9)
insert into BangDiem values('99TH003', 'TA02', 1, 7.5)
insert into BangDiem values('99TH003', 'TB01', 1, 3)
insert into BangDiem values('99TH003', 'TB01', 2, 6)
insert into BangDiem values('99TH003', 'TB02', 1, 8)
insert into BangDiem values('99TH004', 'TB02', 1, 2)
insert into BangDiem values('99TH004', 'TB02', 2, 4)
insert into BangDiem values('99TH004', 'TB02', 3, 2)
insert into BangDiem values('99QT001', 'QA01', 1, 7)
insert into BangDiem values('99QT001', 'QA02', 1, 6.5)
insert into BangDiem values('99QT002', 'QA01', 1, 8.5)
insert into BangDiem values('99QT002', 'QA02', 1, 9)
select * from BangDiem

select * from Khoa
select * from Lop
select * from Tinh
select * from SinhVien
select * from MonHoc
select * from BangDiem

----------TRUY VẤN ĐƠN GIẢN-----------
--q1: Liệt kê MSSV, họ, tên, địa chỉ của tất cả các sinh viên
select MSSV, Ho, Ten, DiaChi
from SinhVien

--q2: Liệt kê MSSV, họ, tên, MS Tỉnh của tất cả các sinh viên.Sắp xếp kết quả theo MS tỉnh, trong cùng tỉnh sắp xếp theo họ tên của sinh viên
select MSSV, Ho, Ten, MSTinh
from SinhVien
order by MSTinh, Ten
--q3: Liệt kê sinh viên nữ của tỉnh Long An
select MSSV, Ho+' '+Ten, NgaySinh, TenTinh, DiaChi, DienThoai
from SinhVien A, Tinh B
where A.MSTinh=B.MSTinh and A.Phai='No' and  TenTinh = 'Long An'

--q4 Liệt kê các sinh viên có sinh nhật trong tháng giêng
select MSSV, Ho+' '+Ten as HoTen, NgaySinh,DiaChi, DienThoai
from SinhVien
where month(NgaySinh)='01'

--q5 Liệt kê các sinh viên có sinh nhật nhắm ngày 1/1
select MSSV, Ho+' '+Ten as HoTen, NgaySinh,DiaChi, DienThoai
from SinhVien
where month(NgaySinh)='01' and day(NgaySinh)='01'
--q6: Liệt kê sinh viên có số điện thoại
select MSSV, Ho+' '+Ten as HoTen, NgaySinh,DiaChi, DienThoai
from SinhVien
where DienThoai is not null
--q7: Liệt kê các sinh viên có số điện thoại di động
select MSSV, Ho+' '+Ten as HoTen, NgaySinh,DiaChi, DienThoai
from SinhVien
where DienThoai like '0%'
--q8: Liệt kê các sinh viên tên 'Minh' học lớp '99TH'
select MSSV, Ho+' '+Ten as HoTen, NgaySinh,DiaChi, DienThoai, MSLop
from SinhVien
where Ten='Minh' and MSLop='99TH'

--q9: Liệt kê các sinh viên có địa chỉ đường 'Tran Hung Dao'
select MSSV, Ho+' '+Ten as HoTen, NgaySinh,DiaChi, DienThoai
from SinhVien
where DiaChi like '%Tran Hung Dao%'

--q10: Liệt kê các sinh viên có tên lót chữ 'Van' (không liệt kê người họ 'Van')
select MSSV, Ho+' '+Ten as HoTen, NgaySinh,DiaChi, DienThoai
from SinhVien
where Ho like '%Van%' and Ho not like 'Van%'

--q11: Liệt kê MSSV, họ tên (ghép họ và tên thành 1 cột), tuổi các sinh viên ở tỉnh Long An
select MSSV, Ho+' '+Ten, year(GetDate()) - year(NgaySinh) as Tuoi
from SinhVien A, Tinh B
where A.MSTinh=B.MSTinh and  TenTinh = 'Long An'

--q12: Liệt kê các sinh viên nam từ 23 đến 28 tuổi
select MSSV, Ho+' '+Ten as HoTen, year(GetDate()) - year(NgaySinh) as Tuoi
from SinhVien
where Phai='Yes' and year(GetDate()) - year(NgaySinh) >= 23 and year(GetDate()) - year(NgaySinh) <= 28

--q13: Liệt kê các sinh viên nam từ 32 tuổi trở lên và các sinh viên nữ từ 27 tuổi trở lên
select MSSV, Ho+' '+Ten as HoTen,Phai, year(GetDate()) - year(NgaySinh) as Tuoi
from SinhVien
where (Phai='Yes' and year(GetDate()) - year(NgaySinh) >= 32) or (Phai='No' and year(GetDate()) - year(NgaySinh) >= 27)

--q14: Liệt kê các sinh viên khi nhập học còn dưới 18 tuổi hoặc trên 25 tuổi
select MSSV, Ho+' '+Ten as HoTen,Phai, year(NgayNhapHoc) - year(NgaySinh) as TuoiLucNhapHoc
from SinhVien
where (year(NgayNhapHoc) - year(NgaySinh))<18 or (year(NgayNhapHoc) - year(NgaySinh))>25

--q15: Liệt kê danh sách các sinh viên của khóa 99 (MSSV có 2 kí tự đầu là '99')
select *
from SinhVien
where MSSV like '99%'

--q16: Liệt kê MSSV, điểm thi lần 1 môn 'Co so du lieu' của lớp '99TH'
select SinhVien.MSSV, Diem
from BangDiem, MonHoc, SinhVien
where SinhVien.MSSV=BangDiem.MSSV and BangDiem.MSMH=MonHoc.MSMH and LanThi=1 and TenMH='Co so du lieu'

--q17: Liệt kê MSSV, họ tên của các sinh viên lớp '99TH' thi không đạt lần 1 môn 'Co so du lieu'
select SinhVien.MSSV, Diem
from BangDiem, MonHoc, SinhVien
where SinhVien.MSSV=BangDiem.MSSV and BangDiem.MSMH=MonHoc.MSMH and LanThi=1 and TenMH='Co so du lieu' and Diem <4 and MSLop='99TH'

--q18: Liệt kê tất cả các điểm thi của sinh viên có mã số '99TH001' theo mẫu
select MonHoc.MSMH, TenMH, LanThi, Diem
from BangDiem, MonHoc, SinhVien
where SinhVien.MSSV=BangDiem.MSSV and BangDiem.MSMH=MonHoc.MSMH and SinhVien.MSSV='99TH001'

--q19: Liệt kê MSSV, họ tên, mslop của các sinh viên có điểm thi lần 1 môn 'Co so du lieu' từ 8 điểm trở lên
select SinhVien.MSSV, Ho+' '+Ten as HoTen, MSLop
from BangDiem, MonHoc, SinhVien
where SinhVien.MSSV=BangDiem.MSSV and BangDiem.MSMH=MonHoc.MSMH and LanThi=1 and TenMH='Co so du lieu' and Diem >=8

--q20: Liệt kê các tỉnh không có sinh viên theo học
select *
from Tinh 
where MSTinh not in (select A.MSTinh
					from Tinh A, SinhVien B
					where A.MSTinh=B.MSTinh
					group by A.MSTinh
					having count(B.MSSV) >0)
--q21: Liệt kê các sinh viên hiện chưa có điêm thi môn nào
select *
from SinhVien
where MSSV not in (select A.MSSV
					from SinhVien A, BangDiem B
					where A.MSSV=B.MSSV
					group by A.MSSV
					having count(B.Diem) >0)

--------------TRUY VẤN GOM NHÓM-----------------------
--q22: Thống kê số lượng sinh viên ở mỗi lớp theo mẫu sau: MSLop, TenLop, SoLuongSV
select A.MSLop, TenLop, count(MSSV) as SoLuongSV
from Lop A, SinhVien B
where A.MSLop=B.MSLop
group by A.MSLop,TenLop

--q23: Thống kê sô lượng sinh viên ở mỗi tỉnh theo mẫu
select B.MSTinh, 
		TenTinh,
		sum(CASE phai
				WHEN 'Yes' THEN 1
				ELSE 0
				END) as SoSVNam, 
		sum(CASE phai
		WHEN 'No' THEN 1
		ELSE 0
		END) as SoSVNu, 
		count(MSSV) as TongCong
from SinhVien A, Tinh B
where A.MSTinh = B.MSTinh 
group by B.MSTinh, TenTinh
--q24: Thông kê kết quả thi lần 1 môn 'Co so du lieu' ở các lớp theo mẫu sau
select A.MSLop, TenLop,
count(*),
	   sum(case
			when Diem >= 4 then 1
			else 0
			end) as N'Số SV đạt',
		(sum(case
			when Diem >= 4 then 1
			else 0
			end)*100/count(*)) as N'Tỉ lệ đạt %',
		sum(case
			when Diem < 4 then 1
			else 0
		end) as N'Số SV không đạt',
		(sum(case
			when Diem < 4 then 1
			else 0
			end)*100/count(*)) as N'Tỉ lệ không đạt %'
from Lop A, BangDiem B, SinhVien C, MonHoc D
where A.MSLop=C.MSLop and B.MSSV=C.MSSV and D.MSMH=B.MSMH and LanThi=1 and TenMH='Co so du lieu'
group by A.MSLop, TenLop

--q25: Lọc ra điểm cao nhất trong các lần thi cho các sinh viên theo mẫu(điểm in ra của mỗi môn là điểm cao nhất trong các lần thi của môn đó)
select A.MSSV, C.MSMH,TenMH as N'Tên MH', HeSo as N'Hệ số', max(Diem) as N'Điểm', max(Diem)*HeSo as N'Điểm x Hệ số'
from SinhVien A, BangDiem B, MonHoc C
where A.MSSV=B.MSSV and C.MSMH=B.MSMH
group by A.MSSV, C.MSMH, TenMH, HeSo
--q26: Lập bảng tổng kết theo mẫu
select A.MSSV,round(sum(Diem*HeSo)/sum(HeSo), 2)  as 'DTB'
from SinhVien A, BangDiem B, MonHoc C
where A.MSSV=B.MSSV and C.MSMH=B.MSMH
group by A.MSSV
--q27: Thống kê số lượng sinh viên tỉnh Long An đang học ở các khoa theo mẫu
select Year(NgayNhapHoc) as NamHoc,D.MSKhoa, TenKhoa, count(MSSV) as N'Số lượng SV'
from Tinh A, SinhVien B, Lop C, Khoa D
where A.MSTinh = B.MSTinh and C.MSLop=B.MSLop and D.MSKhoa=C.MSKhoa
group by A.MSTinh, D.MSKHoa, Year(NgayNhapHoc), TenTinh, TenKhoa
having TenTinh='Long An'
------------HÀM VÀ THỦ TỤC----------
--q28: Nhập vào MSSV, in ra bảng điểm của sinh viên đó theo mẫu(điểm in ra lấy điểm cao nhất trong các lần thi)
create proc usp_BangDiemTheoMSSV 
@MSSV char(7)
as
	if exists (select * from SinhVien where @MSSV=MSSV)
		begin
			select C.MSMH,TenMH as N'Tên MH', HeSo as N'Hệ số', max(Diem) as N'Điểm'
			from SinhVien A, BangDiem B, MonHoc C
			where A.MSSV=B.MSSV and C.MSMH=B.MSMH and @MSSV=A.MSSV
			group by C.MSMH, TenMH, HeSo
			order by C.MSMH
		end
	else
		print N'Không tồn tại sinh viên có MSSV '+@MSSV + N' trong CSDL'
go
--thu nghiem
exec usp_BangDiemTheoMSSV '99TH001'
exec usp_BangDiemTheoMSSV '99TH003'
exec usp_BangDiemTheoMSSV 'AATH003'

--q29: Nhập vào MSLop, in ra bảng điểm tổng kết của lớp đó theo mẫu
create proc usp_BangDiemTongKet_Lop
@MSLop char(4)
as
	if exists (select * from Lop where @MSLop=MSLop)
		begin
			select A.MSSV,
				Ho as N'Họ', 
				Ten as N'Tên',
				round(sum(Diem*HeSo)/sum(HeSo), 2)  as  N'ĐTB',
				case
				when round(sum(Diem*HeSo)/sum(HeSo), 2) >= 8.5 then N'Giỏi'
				when round(sum(Diem*HeSo)/sum(HeSo), 2) >= 7.0 then N'Khá'
				when round(sum(Diem*HeSo)/sum(HeSo), 2) >= 5.5 then N'Trung bình'
				when round(sum(Diem*HeSo)/sum(HeSo), 2) >= 4.0 then N'Yếu'
				else N'Kém'
				end as N'Xếp loại'
			from SinhVien A, BangDiem B, MonHoc C, Lop D
			where A.MSSV=B.MSSV and C.MSMH=B.MSMH and D.MSLop=A.MSLop and D.MSLop=@MSLop
			group by D.MSLop, A.MSSV, Ho, Ten
		end
	else
		print N'Không tồn tại lớp '+@MSLop +' trong CSDL'

go
--thu nghiem
exec usp_BangDiemTongKet_Lop '99TH'
exec usp_BangDiemTongKet_Lop '98VT'
exec usp_BangDiemTongKet_Lop '00VT'

------------CẬP NHẬT DỮ LIỆU-------------
--q30: Tạo bảng SinhVienTinh trong đó chứa hồ sơ của các sinh viên (lấy từ table SinhVien) có quê quán không phải HCM. 
--Thêm thuộc tính HBong(học bổng cho table SinhVienTinh)
create table SinhVienTinh
(
MSSV char(7) primary key,
Ho nvarchar(40) not null,
Ten nvarchar(20) not null,
NgaySinh datetime not null,
MSTinh char(2) references Tinh(MSTinh),
NgayNhapHoc datetime not null,
MSLop char(4) references Lop(MSLop),
Phai nvarchar(3) not null,
DiaChi nvarchar(100) not null,
DienThoai nvarchar(10),
HBong int
)
go

create PROC usp_ThemSinhVienTinh
@MSSV char(7),
@Ho nvarchar(40),
@Ten nvarchar(20),
@NgaySinh datetime,
@MSTinh char(2),
@NgayNhapHoc datetime,
@MSLop char(4),
@Phai nvarchar(3),
@DiaChi nvarchar(100),
@DienThoai nvarchar(10),
@HBong int
As
	If exists(select * from Lop where MSLop = @MSLop) 
	and exists(select * from Tinh where MSTinh = @MSTinh) 
	and not exists (select * from Tinh where @MSTinh='02') --kiểm tra có RBTV khóa ngoại
	  Begin
		if exists(select * from SinhVienTinh where MSSV = @MSSV) --kiểm tra có trùng khóa chính (MSSV) 
			print N'Đã có mã số học viên này trong CSDL!'
		else
			begin
				insert into SinhVienTinh values(@MSSV,@Ho, @Ten,@NgaySinh,@MSTinh, @NgayNhapHoc, @MSLop, @Phai, @DiaChi, @DienThoai, @HBong)
				print N'Thêm học viên thành công.'
			end
	  End
	Else
		if not exists (select * from Lop where MSLop = @MSLop)
			print N'Lớp '+ @MSLop + N' không tồn tại trong CSDL nên không thể thêm học viên vào lớp này!'
		else if exists (select * from Tinh where @MSTinh='02')
			print N'Sinh viên không phải là sinh viên tỉnh'
		else print N'Không tồn tại tỉnh này trong CSDL'
		
go
--nhap bang
exec usp_ThemSinhVienTinh '98TH001', 'Nguyen Van', 'An', '1980/08/06', '01', '1998/09/03', '98TH','Yes', '12 Tran Hung Dao, Q.1', '8234512', null
exec usp_ThemSinhVienTinh '98TH002', 'Le Thi', 'An', '1979/10/17', '01', '03/09/98', '98TH', 'No', '23 CMT8, Q. Tan Binh', '0303234342', null
exec usp_ThemSinhVienTinh '98VT001', 'Nguyen Duc', 'Binh', '1981/11/25', '02', '03/09/98', '98VT', 'Yes', '245 Lac Long Quan, Q.11', '8654323', null
exec usp_ThemSinhVienTinh '98VT002', 'Tran Ngoc', 'Anh', '1980/08/19', '02', '03/09/98', '98VT', 'No', '242 Tran Hung Dao, Q.1', null, null
exec usp_ThemSinhVienTinh '99TH001', 'Ly Van Hung', 'Dung', '1981/09/27', '03', '05/10/99', '99TH', 'Yes', '178 CMT8, Q. Tan Binh', '7563213', null
exec usp_ThemSinhVienTinh '99TH002', 'Van Minh', 'Hoang', '1981/01/01', '04', '05/10/99', '99TH', 'Yes', '272 Ly Thuong Kiet, Q.10', '8341234', null
exec usp_ThemSinhVienTinh '99TH003', 'Nguyen', 'Tuan', '1980/01/12', '03', '05/10/99', '99TH', 'Yes', '162 Tran Hung Dao, Q.5', null, null
exec usp_ThemSinhVienTinh '99TH004', 'Tran Van', 'Minh', '1981/06/25', '04', '05/10/99', '99TH', 'Yes', '147 Dien Bien Phu, Q.3', '7236754', null
exec usp_ThemSinhVienTinh '99TH005', 'Nguyen Thai', 'Minh', '1980/01/01', '04', '05/10/99', '99TH', 'Yes', '345 Le Dai Hanh, Q.11', null, null
exec usp_ThemSinhVienTinh '99VT001', 'Le Ngoc', 'Mai', '1982/06/21', '01', '05/10/99', '99VT', 'No', '129 Tran Hung Dao, Q.1', '0903124534', null
exec usp_ThemSinhVienTinh '99QT001', 'Nguyen Thi', 'Oanh', '1973/08/19', '04', '05/10/99', '99QT', 'No', '76 Hung Vuong, Q.5', '0901656324', null
exec usp_ThemSinhVienTinh '99QT002', 'Le My', 'Hanh', '1976/05/20', '04', '05/10/99', '99QT', 'No', '12 Pham Ngoc Thach, Q.3', null, null
select * from SinhVienTinh
--q31: Cập nhật thuộc tính HBong trong table SinhVienTinh thành 10000 cho tất cả sinh viên
update SinhVienTinh
set HBong=10000
select * from SinhVienTinh

--q32: Tăng HBong 10% cho sinh viên nữ
update SinhVienTinh
set Hbong=HBong*1.1
where Phai='No'
select * from SinhVienTinh
--q33: Xóa tất cả các sinh viên có quên quán ở Long An ra khỏi table SinhVienTinh
delete from SinhVienTinh where MSTinh = (select MSTinh
										from Tinh
										where TenTinh='Long An')
select * from SinhVienTinh										
