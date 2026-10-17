# [Thực hành] Quản lý đơn đặt hàng - CodeGym

## 1. Biểu đồ mô hình thực thể (ERD)

```mermaid
erDiagram
    KHAC_HANG ||--o{ DON_DAT_HANG : "dat"
    KHAC_HANG {
        string MaDV PK
        string TenDV
        string DiaChi
        string DienThoai
    }

    NGUOI_DAT ||--o{ DON_DAT_HANG : "thuc_hien"
    NGUOI_DAT {
        string MaSoND PK
        string HoTenND
        string MaDV FK
    }

    HANG ||--o{ CHI_TIET_DON_HANG : "thuoc"
    HANG {
        string MaHang PK
        string TenHang
        string DvTinh
        string MoTaHang
    }

    DON_DAT_HANG ||--|{ CHI_TIET_DON_HANG : "chua"
    DON_DAT_HANG {
        string SoDH PK
        date NgayDat
        string MaSoND FK
    }

    CHI_TIET_DON_HANG {
        string SoDH PK, FK
        string MaHang PK, FK
        int SoLuong
    }

    PHIEU_GIAO_HANG ||--|{ CHI_TIET_PHIEU_GIAO : "chua"
    PHIEU_GIAO_HANG {
        string SoPG PK
        date NgayGiao
        string MaSoNN FK
        string MaSoNG FK
        string MaSoDDG FK
    }

    NGUOI_NHAN ||--o{ PHIEU_GIAO_HANG : "nhan"
    NGUOI_NHAN {
        string MaSoNN PK
        string HoTenNN
        string MaDV FK
    }

    NGUOI_GIAO ||--o{ PHIEU_GIAO_HANG : "giao"
    NGUOI_GIAO {
        string MaSoNG PK
        string HoTenNG
    }

    NOI_GIAO ||--o{ PHIEU_GIAO_HANG : "tai"
    NOI_GIAO {
        string MaSoDDG PK
        string TenNoiGiao
    }

    HANG ||--o{ CHI_TIET_PHIEU_GIAO : "duoc_giao"
    CHI_TIET_PHIEU_GIAO {
        string SoPG PK, FK
        string MaHang PK, FK
        int SoLuong
        decimal DonGia
        decimal ThanhTien
    }

---

## 2. Mã SQL Tạo CSDL và Bảng (MySQL)

CREATE DATABASE IF NOT EXISTS quan_ly_don_hang;
USE quan_ly_don_hang;

-- 1. Bảng Đơn vị / Khách hàng
CREATE TABLE KHAC_HANG (
    MaDV VARCHAR(20) PRIMARY KEY,
    TenDV VARCHAR(100) NOT NULL,
    DiaChi VARCHAR(200),
    DienThoai VARCHAR(15)
);

-- 2. Bảng Người đặt hàng
CREATE TABLE NGUOI_DAT (
    MaSoND VARCHAR(20) PRIMARY KEY,
    HoTenND VARCHAR(100) NOT NULL,
    MaDV VARCHAR(20),
    FOREIGN KEY (MaDV) REFERENCES KHAC_HANG(MaDV)
);

-- 3. Bảng Hàng hóa
CREATE TABLE HANG (
    MaHang VARCHAR(20) PRIMARY KEY,
    TenHang VARCHAR(100) NOT NULL,
    DvTinh VARCHAR(20),
    MoTaHang TEXT
);

-- 4. Bảng Đơn đặt hàng
CREATE TABLE DON_DAT_HANG (
    SoDH VARCHAR(20) PRIMARY KEY,
    NgayDat DATE NOT NULL,
    MaSoND VARCHAR(20),
    FOREIGN KEY (MaSoND) REFERENCES NGUOI_DAT(MaSoND)
);

-- 5. Bảng Chi tiết đơn đặt hàng
CREATE TABLE CHI_TIET_DON_HANG (
    SoDH VARCHAR(20),
    MaHang VARCHAR(20),
    SoLuong INT NOT NULL CHECK (SoLuong > 0),
    PRIMARY KEY (SoDH, MaHang),
    FOREIGN KEY (SoDH) REFERENCES DON_DAT_HANG(SoDH),
    FOREIGN KEY (MaHang) REFERENCES HANG(MaHang)
);

-- 6. Bảng Người nhận
CREATE TABLE NGUOI_NHAN (
    MaSoNN VARCHAR(20) PRIMARY KEY,
    HoTenNN VARCHAR(100) NOT NULL,
    MaDV VARCHAR(20),
    FOREIGN KEY (MaDV) REFERENCES KHAC_HANG(MaDV)
);

-- 7. Bảng Người giao
CREATE TABLE NGUOI_GIAO (
    MaSoNG VARCHAR(20) PRIMARY KEY,
    HoTenNG VARCHAR(100) NOT NULL
);

-- 8. Bảng Nơi giao
CREATE TABLE NOI_GIAO (
    MaSoDDG VARCHAR(20) PRIMARY KEY,
    TenNoiGiao VARCHAR(200) NOT NULL
);

-- 9. Bảng Phiếu giao hàng
CREATE TABLE PHIEU_GIAO_HANG (
    SoPG VARCHAR(20) PRIMARY KEY,
    NgayGiao DATE NOT NULL,
    MaSoNN VARCHAR(20),
    MaSoNG VARCHAR(20),
    MaSoDDG VARCHAR(20),
    FOREIGN KEY (MaSoNN) REFERENCES NGUOI_NHAN(MaSoNN),
    FOREIGN KEY (MaSoNG) REFERENCES NGUOI_GIAO(MaSoNG),
    FOREIGN KEY (MaSoDDG) REFERENCES NOI_GIAO(MaSoDDG)
);

-- 10. Bảng Chi tiết phiếu giao hàng
CREATE TABLE CHI_TIET_PHIEU_GIAO (
    SoPG VARCHAR(20),
    MaHang VARCHAR(20),
    SoLuong INT NOT NULL CHECK (SoLuong > 0),
    DonGia DECIMAL(12, 2) NOT NULL,
    ThanhTien DECIMAL(12, 2) GENERATED ALWAYS AS (SoLuong * DonGia) STORED,
    PRIMARY KEY (SoPG, MaHang),
    FOREIGN KEY (SoPG) REFERENCES PHIEU_GIAO_HANG(SoPG),
    FOREIGN KEY (MaHang) REFERENCES HANG(MaHang)
);
