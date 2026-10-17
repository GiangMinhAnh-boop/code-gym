-- 1. Tạo CSDL AutoRide
CREATE DATABASE IF NOT EXISTS autoride_db;
USE autoride_db;

-- 2. Tạo bảng Xe (Cars)
CREATE TABLE Cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    license_plate VARCHAR(20) UNIQUE NOT NULL
);

-- 3. Tạo bảng Hợp đồng thuê xe (Rentals) - Đã tối ưu hóa
CREATE TABLE Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    car_id INT,
    customer_name VARCHAR(100) NOT NULL,
    rent_date DATETIME NOT NULL,
    return_date DATETIME,
    status ENUM('BOOKED', 'ACTIVE', 'COMPLETED', 'CANCELLED') DEFAULT 'BOOKED',
    security_deposit DECIMAL(10, 2) DEFAULT 0.00,
    late_fee DECIMAL(10, 2) DEFAULT 0.00,
    damage_fee DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (car_id) REFERENCES Cars(car_id) ON DELETE RESTRICT
);

-- 4. Tạo bảng Biên bản kiểm tra xe (Inspections)
CREATE TABLE Inspections (
    inspection_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    inspection_date DATETIME NOT NULL,
    damage_description TEXT,
    inspector_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (rental_id) REFERENCES Rentals(rental_id) ON DELETE RESTRICT
);

-- KỊCH BẢN DỮ LIỆU THỰC TẾ
-- Bước 1: Thêm thông tin xe
INSERT INTO Cars (model_name, license_plate) VALUES ('Toyota Camry', '30F-123.45');

-- Bước 2: Khách hàng "Nguyen Van A" đặt thuê xe và đóng cọc 10.000.000 VNĐ
INSERT INTO Rentals (car_id, customer_name, rent_date, status, security_deposit)
VALUES (1, 'Nguyen Van A', '2026-10-20 08:00:00', 'ACTIVE', 10000000.00);

-- Bước 3: Khách trả xe, nhân viên kiểm tra phát hiện vỡ đèn pha
INSERT INTO Inspections (rental_id, inspection_date, damage_description, inspector_name)
VALUES (1, '2026-10-22 17:00:00', 'Vỡ đèn pha bên trái', 'Tran Van B');

-- Bước 4: Cập nhật hợp đồng (Trạng thái COMPLETED, tính phí sửa chữa 2.000.000 VNĐ, trễ 0 VNĐ)
UPDATE Rentals 
SET return_date = '2026-10-22 17:00:00',
    status = 'COMPLETED',
    late_fee = 0.00,
    damage_fee = 2000000.00
WHERE rental_id = 1;

-- Bước 5: Câu lệnh tính toán số tiền thực tế cần hoàn trả lại cho khách
SELECT 
    rental_id,
    customer_name,
    security_deposit,
    late_fee,
    damage_fee,
    (security_deposit - late_fee - damage_fee) AS refund_amount
FROM Rentals
WHERE rental_id = 1;
