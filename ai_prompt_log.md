# Nhật ký tương tác AI (AI Prompt Log)

## Question 1:
Trong MySQL, tại sao việc bọc hàm YEAR() và MONTH() xung quanh cột DATETIME ở mệnh đề WHERE lại gây hiện tượng Full Table Scan?

## Answer 1:
Khi bọc hàm quanh một cột trong mệnh đề WHERE, MySQL phải thực thi hàm đó trên từng dòng dữ liệu của bảng để tính toán giá trị so sánh. Điều này vô hiệu hóa cấu trúc cây B-Tree của Index (hiện tượng Non-SARGable), buộc cơ sở dữ liệu phải duyệt qua toàn bộ dữ liệu (Full Table Scan).

---

## Question 2:
Sự khác biệt giữa `Using index condition` và `Using index` trong cột Extra của kết quả EXPLAIN là gì?

## Answer 2:
- `Using index condition` (Index Condition Pushdown - ICP): MySQL sử dụng Index để lọc bớt dữ liệu ở tầng lưu trữ trước khi trả về tầng máy chủ, nhưng vẫn cần truy cập vào Bảng chính để lấy thêm dữ liệu các cột khác.
- `Using index` (Covering Index): Tất cả các cột cần thiết trong truy vấn đều đã nằm sẵn trong Index, MySQL không cần phải tìm đọc lại dữ liệu trong Bảng chính.
