# Bài tập: Chuyển đổi sơ đồ ERD sang Mô hình Quan hệ

## 1. Các bước phân tích
- **Bước 1: Bảng thực thể độc lập** 
  - `NHAPHANPHOI` (MaNPP, TenNPP, Diachi, SoDT)
  - `VATTU` (MaVT, TenVT)
  - `DONDH` (SoSoDH, NgayDH)
  - `PHIEUNHAP` (SoPN, NgayNhap)
  - `PHIEUXUAT` (SoPX, NgayXuat, TenKH)
- **Bước 2: Xử lý mối quan hệ 1-N (Khóa ngoại)**
  - Mối quan hệ 1-N giữa `NHAPHANPHOI` và `DONDH`: Thêm khóa ngoại `MaNPP` vào bảng `DONDH`.
  - Mối quan hệ 1-N giữa `DONDH` và `PHIEUNHAP`: Thêm khóa ngoại `SoSoDH` vào bảng `PHIEUNHAP`.
- **Bước 3: Xử lý thuộc tính đa trị (Số điện thoại)**
  - Tạo bảng riêng `SDT_NPP` (MaNPP, SoDT) liên kết với `NHAPHANPHOI`.
- **Bước 4: Xử lý mối quan hệ N-M (Bảng trung gian / Chi tiết)**
  - `CHI_TIET_DON_HANG` (SoSoDH, MaVT, SoLuong)
  - `CHI_TIET_PHIEU_NHAP` (SoPN, MaVT, DGNhap, SLNhap)
  - `CHI_TIET_PHIEU_XUAT` (SoPX, MaVT, DGXuat, SLXuat)

---

## 2. Mã SQL khởi tạo CSDL

```sql
CREATE DATABASE IF NOT EXISTS quan_ly_cung_cap;
USE quan_ly_cung_cap;

-- 1. Bảng Nhà phân phối
CREATE TABLE NHAPHANPHOI (
    MaNPP VARCHAR(20) PRIMARY KEY,
    TenNPP VARCHAR(100) NOT NULL,
    Diachi VARCHAR(200)
);

-- 2. Bảng Số điện thoại Nhà phân phối (Thuộc tính đa trị)
CREATE TABLE SDT_NPP (
    MaNPP VARCHAR(20),
    SoDT VARCHAR(15),
    PRIMARY KEY (MaNPP, SoDT),
    FOREIGN KEY (MaNPP) REFERENCES NHAPHANPHOI(MaNPP)
);

-- 3. Bảng Đơn đặt hàng
CREATE TABLE DONDH (
    SoSoDH VARCHAR(20) PRIMARY KEY,
    NgayDH DATETIME NOT NULL,
    MaNPP VARCHAR(20),
    FOREIGN KEY (MaNPP) REFERENCES NHAPHANPHOI(MaNPP)
);

-- 4. Bảng Vật tư
CREATE TABLE VATTU (
    MaVT VARCHAR(20) PRIMARY KEY,
    TenVT VARCHAR(100) NOT NULL
);

-- 5. Bảng Chi tiết đơn hàng (Quan hệ N-M)
CREATE TABLE CHI_TIET_DON_HANG (
    SoSoDH VARCHAR(20),
    MaVT VARCHAR(20),
    SoLuong INT NOT NULL,
    PRIMARY KEY (SoSoDH, MaVT),
    FOREIGN KEY (SoSoDH) REFERENCES DONDH(SoSoDH),
    FOREIGN KEY (MaVT) REFERENCES VATTU(MaVT)
);

-- 6. Bảng Phiếu nhập
CREATE TABLE PHIEUNHAP (
    SoPN VARCHAR(20) PRIMARY KEY,
    NgayNhap DATETIME NOT NULL,
    SoSoDH VARCHAR(20),
    FOREIGN KEY (SoSoDH) REFERENCES DONDH(SoSoDH)
);

-- 7. Bảng Chi tiết phiếu nhập (Quan hệ N-M)
CREATE TABLE CHI_TIET_PHIEU_NHAP (
    SoPN VARCHAR(20),
    MaVT VARCHAR(20),
    DGNhap DECIMAL(12, 2) NOT NULL,
    SLNhap INT NOT NULL,
    PRIMARY KEY (SoPN, MaVT),
    FOREIGN KEY (SoPN) REFERENCES PHIEUNHAP(SoPN),
    FOREIGN KEY (MaVT) REFERENCES VATTU(MaVT)
);

-- 8. Bảng Phiếu xuất
CREATE TABLE PHIEUXUAT (
    SoPX VARCHAR(20) PRIMARY KEY,
    NgayXuat DATETIME NOT NULL,
    TenKH VARCHAR(100) NOT NULL
);

-- 9. Bảng Chi tiết phiếu xuất (Quan hệ N-M)
CREATE TABLE CHI_TIET_PHIEU_XUAT (
    SoPX VARCHAR(20),
    MaVT VARCHAR(20),
    DGXuat DECIMAL(12, 2) NOT NULL,
    SLXuat INT NOT NULL,
    PRIMARY KEY (SoPX, MaVT),
    FOREIGN KEY (SoPX) REFERENCES PHIEUXUAT(SoPX),
    FOREIGN KEY (MaVT) REFERENCES VATTU(MaVT)
);
