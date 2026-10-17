# Báo cáo phân tích sự bất nhất (Consistency Gap Analysis)

Cơ sở dữ liệu cũ (Legacy DB) của hệ thống HealthSync gặp 3 lỗi thiết kế nghiêm trọng khiến quy trình nghiệp vụ bị ngưng trệ:

1. **Lỗi quản lý vòng đời trạng thái lịch hẹn:** Việc dùng kiểu dữ liệu `BOOLEAN` (cột `is_active`) chỉ lưu được 2 trạng thái (Đúng/Sai). Điều này làm vô hiệu hóa quy trình 5 bước nghiệp vụ (PENDING -> CONFIRMED -> CHECKED_IN -> COMPLETED -> CANCELLED).
2. **Thiếu hụt dữ liệu tài chính và lý do hủy:** Bảng `Appointments` cũ hoàn toàn thiếu các cột lưu trữ tiền cọc (`deposit_amount`), phí phạt (`penalty_fee`) và lý do hủy (`cancel_reason`), khiến hệ thống không thể xử lý bài toán phạt tiền cọc khi bệnh nhân hủy lịch.
3. **Thiếu bảng Đơn thuốc (`Prescriptions`):** Lập trình viên bỏ quên hoàn toàn việc thiết kế bảng lưu đơn thuốc sau khi khám xong (`COMPLETED`), dẫn đến bác sĩ không thể ghi nhận kết quả khám và kê đơn cho bệnh nhân.
