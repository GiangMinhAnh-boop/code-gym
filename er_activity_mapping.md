# Báo cáo phân tích sự tương thích giữa Activity Diagram và ERD

Cột `damage_fee` trong bảng `Rentals` là trường dữ liệu bắt buộc nhằm đảm bảo tính toàn vẹn của hệ thống AutoRide vì các lý do sau:

1. **Phản ánh đúng luồng nghiệp vụ (Business Workflow):** Lưu đồ hoạt động (Activity Diagram) có nhánh rẽ khi trả xe: nếu xe bị hư hỏng/trầy xước, hệ thống phải ghi nhận chi tiết lỗi và phát sinh Phí sửa chữa (`Damage Fee`).
2. **Khắc phục thất thoát tài chính:** Nếu thiếu cột `damage_fee`, kế toán không có căn cứ dữ liệu để khấu trừ tiền đền bù từ tiền cọc (`security_deposit`), dẫn đến việc phải ghi sổ tay hoặc trả lại toàn bộ tiền cọc cho khách dù xe hư hỏng.
3. **Tự động hóa công thức tính Hoàn tiền:** Giúp hệ thống thực hiện chính xác công thức tài chính: `Tiền hoàn lại = Tiền cọc - Phí trễ hạn - Phí sửa chữa`.
