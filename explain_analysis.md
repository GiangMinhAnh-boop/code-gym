# Phân tích hiệu năng EXPLAIN trước và sau tối ưu

## 1. Trước khi tối ưu (Legacy Query)
- **Cột type:** `ALL` (Phải thực hiện Full Table Scan - Quét toàn bộ 5 triệu dòng dữ liệu).
- **Cột rows:** Quét qua toàn bộ ~5,000,000 dòng do dùng hàm `YEAR()` và `MONTH()` trên cột `created_at` khiến MySQL không thể dùng Index.
- **Cột key:** `NULL` (Không sử dụng Index nào).

## 2. Sau khi tối ưu (Optimized Query)
- **Cột type:** `range` (Chỉ quét trong khoảng dữ liệu thỏa mãn điều kiện).
- **Cột key:** `idx_type_date` (Đã áp dụng thành công Composite Index).
- **Cột rows:** Số dòng cần kiểm tra giảm từ 5,000,000 xuống còn khoảng vài nghìn dòng.
- **Kết luận:** Việc loại bỏ hàm trên cột `created_at` giúp truy vấn trở nên SARGable, giải phóng 100% CPU và khắc phục hoàn toàn sự cố Table Lock.
