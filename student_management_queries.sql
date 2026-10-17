USE QuanLySinhVien;

-- 1. Hiển thị tất cả các sinh viên có tên bắt đầu bằng ký tự 'h'
SELECT * 
FROM Student 
WHERE StudentName LIKE 'h%';

-- 2. Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12
SELECT * 
FROM Class 
WHERE MONTH(StartDate) = 12;

-- 3. Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3 đến 5
SELECT * 
FROM Subject 
WHERE Credit BETWEEN 3 AND 5;

-- 4. Thay đổi mã lớp (ClassID) của sinh viên có tên 'Hung' thành 2
UPDATE Student 
SET ClassID = 2 
WHERE StudentName = 'Hung';

-- 5. Hiển thị thông tin StudentName, SubName, Mark (Sắp xếp điểm giảm dần, trùng điểm thì xếp tên tăng dần)
SELECT S.StudentName, Sub.SubName, M.Mark
FROM Mark M
JOIN Student S ON M.StudentId = S.StudentId
JOIN Subject Sub ON M.SubId = Sub.SubId
ORDER BY M.Mark DESC, S.StudentName ASC;
