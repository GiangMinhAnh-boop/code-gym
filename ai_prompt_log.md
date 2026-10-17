# Nhật ký tương tác AI (AI Prompt Log)

## Question 1:
Trong cơ sở dữ liệu MySQL, mặc định từ khóa JOIN khi không ghi rõ LEFT hay RIGHT sẽ hoạt động như thế nào?

## Answer 1:
Mặc định từ khóa `JOIN` trong MySQL hoạt động tương đương với `INNER JOIN`. Nó chỉ giữ lại các bản ghi có sự trùng khớp khóa ở cả hai bảng và loại bỏ các bản ghi không thỏa mãn điều kiện ghép từ cả hai phía.

---

## Question 2:
Sự khác biệt giữa `COUNT(*)` và `COUNT(column_name)` khi kết hợp với `LEFT JOIN` là gì?

## Answer 2:
`COUNT(*)` đếm tất cả các dòng được tạo ra từ kết quả `LEFT JOIN` (bao gồm cả dòng chứa giá trị NULL), khiến bản ghi chưa có dữ liệu ghép cặp bị đếm thành 1. Trong khi đó, `COUNT(column_name)` chỉ đếm các dòng mà giá trị của cột đó khác NULL, do đó trả về đúng 0 cho các bản ghi chưa phát sinh giao dịch.
