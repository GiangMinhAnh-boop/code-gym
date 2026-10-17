# Giải trình kỹ thuật về hàm COUNT trong LEFT JOIN

Khi sử dụng `LEFT JOIN` để lấy danh sách tất cả khách hàng cùng với số lượng đơn hàng của họ:

1. **Sử dụng `COUNT(o.order_id)` (Chính xác):** 
   Đối với những khách hàng chưa từng mua hàng (như Charlie), kết quả ghép bảng sẽ trả về giá trị `NULL` ở các cột của bảng `Orders`. Hàm `COUNT(o.order_id)` sẽ bỏ qua các giá trị `NULL` này và đếm ra kết quả là `0` đơn hàng — đúng với thực tế nghiệp vụ.

2. **Nếu sử dụng `COUNT(*)` (Sai sót):**
   Hàm `COUNT(*)` đếm số lượng dòng được trả về sau khi JOIN mà không quan tâm giá trị các cột có `NULL` hay không. Khi khách hàng chưa mua hàng được giữ lại bởi `LEFT JOIN`, dòng dữ liệu đó vẫn tồn tại 1 dòng trong tập kết quả, khiến `COUNT(*)` đếm thành `1` đơn hàng (sai lệch dữ liệu).
