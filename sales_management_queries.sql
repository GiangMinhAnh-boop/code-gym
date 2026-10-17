USE QuanLyBanHang;

-- 1. Thêm dữ liệu vào 4 bảng (Customer, Orders, Product, OrderDetail)
INSERT INTO Customer (cID, Name, cAge) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

INSERT INTO Orders (oID, cID, oDate, oTotalPrice) VALUES
(1, 1, '2006-03-21', NULL),
(2, 2, '2006-03-23', NULL),
(3, 1, '2006-03-16', NULL);

INSERT INTO Product (pID, pName, pPrice) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

INSERT INTO OrderDetail (oID, pID, odQTY) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(2, 5, 4),
(2, 3, 3),
(3, 1, 8);

-- 2. Hiển thị các thông tin oID, oDate, oPrice của tất cả các hóa đơn trong bảng Orders
SELECT oID, oDate, oTotalPrice AS oPrice 
FROM Orders;

-- 3. Hiển thị danh sách khách hàng đã mua hàng và danh sách sản phẩm được mua bởi các khách
SELECT C.Name AS CustomerName, P.pName AS ProductName
FROM Customer C
JOIN Orders O ON C.cID = O.cID
JOIN OrderDetail OD ON O.oID = OD.oID
JOIN Product P ON OD.pID = P.pID;

-- 4. Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT Name 
FROM Customer 
WHERE cID NOT IN (SELECT DISTINCT cID FROM Orders);

-- 5. Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn
-- (Giá = tổng odQTY * pPrice)
SELECT O.oID, O.oDate, SUM(OD.odQTY * P.pPrice) AS TotalPrice
FROM Orders O
JOIN OrderDetail OD ON O.oID = OD.oID
JOIN Product P ON OD.pID = P.pID
GROUP BY O.oID, O.oDate;
