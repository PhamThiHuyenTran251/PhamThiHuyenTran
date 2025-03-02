USE QLBH2
GO 

CREATE DATABASE QLBH2
ON PRIMARY
( 
NAME= 'QuanLyBH', 
FILENAME = 'C:\CSDL\QLBH2.mdf', 
SIZE = 4048KB, 
MAXSIZE= 10240KB,
FILEGROWTH= 20%
)
LOG ON
(
NAME = 'QLBH_log',
FILENAME = 'C:\CSDL\QLBH_log2.ldf',
SIZE = 1024KB,
MAXSIZE= 10240KB,
FILEGROWTH=10%
)

USE QLBH2
GO
CREATE TABLE NhomSanPham
(
[MaNhom] [int] primary key,
[TenNhom] [nvarchar](15) null
)
Go

GO
CREATE TABLE [dbo].[Nhanvien]
(
[MaNV] [nchar](5) primary key,
[TenNV] [nvarchar](40) not null,
[DiaChi] [nvarchar](60) null,
[Dienthoai] [nvarchar](24) null
) 
GO

GO
CREATE TABLE [dbo].[NhaCungCap]
(
[MaNCC] [int] not null,
[TenNcc] [nvarchar](40) not null,
[Diachi] [nvarchar](60) null,
[Phone] [nvarchar](24) null,
[SoFax] [nvarchar](24) null,
[DCMail] [nvarchar](50) null,
PRIMARY KEY ([MaNCC])
)
GO

GO
CREATE TABLE [dbo].[KhachHang]
(
[MaKh] [nchar](5) not null,
[TenKh] [nvarchar](40) not null,
[LoaiKh] [nvarchar](3) null,
[DiaChi] [nvarchar](60) null,
[Phone] [nvarchar](24) null,
PRIMARY KEY ([MaKh])
) 
GO

CREATE TABLE [dbo].[SanPham]
(
[MaSp] [int] not null, 
[TenSp] [nvarchar](40) not null,
[MaNCC] [int] null,
[MoTa] [nvarchar](50) null,
[MaNhom] [int] null,
[?onvitinh] [nvarchar](20) null,
[GiaGoc] [money] null,
[SLTON] [int] null,
primary key ([MaSp])
)
go

CREATE TABLE [dbo].[HoaDon]
(
[MaHD] [int] not null,
[NgayLapHD] [datetime] null,
[NgayGiao] [datetime] null,
[Noichuyen] [nvarchar](60) not null,
[MaNV] [nchar](5) null,
[MaKh] [nchar](5) null,
primary key ([MaHD])
)
go

go
CREATE TABLE [dbo].[CT_HoaDon]
(
[MaHD] [int] not null,
[MaSp] [int] not null,
[Soluong] [smallint] null,
[Donggia] [money] null,
[chietKhau] [money] null,
primary key clustered
(
[MaHD] ASC,
[MaSp] ASC
)
with
( PAD_index= off,
statistics_norecompute =off,
ignore_dup_key = off,
allow_row_locks =on,
allow_Page_locks =on
)
on [primary]
)
on [primary]
go

alter table [dbo].[HoaDon] add constraint [HD_df] default(getdate()) for [NgayLapHD]
go

alter table [dbo].[KhachHang] with check add constraint [kh_ck] check(([LoaiKh]='VL' or [LoaiKh]='TV' or [LoaiKh]='VIP'))
go
alter table [dbo].[KhachHang] check constraint [kh_ck]
go

alter table [dbo].[SanPham] with check add constraint [sanpham_ck] check(([giagoc]>(0)))
go
alter table [dbo].[SanPham] check constraint [sanpham_ck]
go

alter table [dbo].[SanPham] with check add constraint [sanpham_ck1] check(([slton]>(0)))
go 
alter table [dbo].[SanPham] check constraint [sanpham_ck1] 
go

alter table [dbo].[SanPham] with check add constraint [sp_ck] check (([SLTon]>(0)))
go
alter table [dbo].[SanPham]check constraint [sp_ck]
go

alter table [dbo].[HoaDon] with check add constraint [HD_ck] check (([NgayLapHD]>getdate()))
go
alter table [dbo].[HoaDon] check constraint [HD_ck]
go


alter table [dbo].[CT_HoaDon] with check add check (([chietkhau]>=(0)))
go

alter table [dbo].[CT_HoaDon] with check add check (([soluong]>(0))) 
go 

alter table [dbo].[SanPham] with check add foreign key([MaNCC])
references [dbo].[NhaCungCap] ([MaNCC])
go

alter table [dbo].[Sanpham] with check add foreign key([MaNhom])
references [dbo].[NhomSanPham] ([MaNhom])
go

alter table [dbo].[HoaDon] with check add foreign key ([MaKh])
references [dbo].[KhachHang] ([MaKh])
go

alter table [dbo].[HoaDon] with check add foreign key([MaNV])
references [dbo].[NhanVien] ([MaNV])
go
 
alter table [dbo].[CT_HoaDon] with check add foreign key ([MaHD])
references [dbo].[HoaDon] ([MaHD])
go

alter table [dbo].[CT_HoaDon] with check add foreign key([MaSp])
references [dbo].[SanPham] ([MaSp])
go

use QLBH2