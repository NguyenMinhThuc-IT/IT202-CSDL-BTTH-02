-- tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS BOOK_WORM;
-- sử dụng bảng
USE BOOK_WORM;
-- tạo các bảng Người dùng author, sách book, khách hàng customer
CREATE TABLE authors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_year INT,
    nationality VARCHAR(100)
);

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_name VARCHAR(100) NOT NULL,
    category VARCHAR(100),
    author_id INT,
    price DECIMAL(10, 0) NOT NULL DEFAULT 0,
    publish_year INT,
    -- khóa ngoại liên kết tới bảng authors
    
    -- CONSTRAINT là ràng buộc nếu khớp với các yêu cầu từ các dữ liệu đã gán thì cho nhập còn không thì không cho nhập
    CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES authors(id),
    -- giá bán không được nhỏ hơn 0
    CONSTRAINT chk_price CHECK (price >= 0)
);

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE, -- không được trùng nhau
    phone VARCHAR(20) NOT NULL UNIQUE,  -- không được trùng nhau
    registration_date DATE DEFAULT (CURRENT_DATE) -- mặc định là ngày hiện tại
);

USE BOOK_WORM;

-- 1. Thêm 3 Tác giả
INSERT INTO authors (full_name, birth_year, nationality) VALUES
('Nguyễn Nhật Ánh', 1955, 'Việt Nam'),
('Conan Doyle', 1859, 'Anh'),
('Dale Carnegie', 1888, 'Mỹ');

-- 2. Thêm 8 Cuốn sách (Nhiều thể loại)
INSERT INTO books (book_name, category, author_id, price, publish_year) VALUES
('Mắt Biếc', 'Văn học', 1, 110000, 1990),
('Cho tôi xin một vé đi tuổi thơ', 'Văn học', 1, 85000, 2008),
('Sherlock Holmes', 'Trinh thám', 2, 250000, 1887),
('Chiếc nhẫn tình cờ', 'Trinh thám', 2, 95000, 1888),
('Đắc Nhân Tâm', 'Kỹ năng', 3, 76000, 1936),
('Quẳng gánh lo đi và vui sống', 'Kỹ năng', 3, 82000, 1948),
('Tôi thấy hoa vàng trên cỏ xanh', 'Văn học', 1, 125000, 2010),
('Thung lũng khủng khiếp', 'Trinh thám', 2, 115000, 1915);

-- 3. Thêm 5 Khách hàng
INSERT INTO customers (full_name, email, phone) VALUES
('Nguyễn Văn A', 'vana@gmail.com', '0901234567'),
('Trần Thị B', 'thib@gmail.com', '0912345678'),
('Lê Văn C', 'vanc@gmail.com', '0923456789'),
('Phạm Thị D', 'thid@gmail.com', '0934567890'),
('Hoàng Văn E', 'vane@gmail.com', '0945678901');

-- CỐ TÌNH NHẬP TRÙNG EMAIL ĐỂ KIỂM TRA RÀNG BUỘC UNIQUE
-- INSERT INTO customers (full_name, email, phone) 
-- VALUES ('Nguyễn Lơ Đãng', 'vana@gmail.com', '0999999999');

/* GIẢI THÍCH (COMMENT):
- Khi chạy lệnh này, hệ thống sẽ báo lỗi: "Error Code: 1062. Duplicate entry 'vana@gmail.com' for key 'customers.email'".
- Nguyên nhân: Do chúng ta đã thiết lập ràng buộc UNIQUE cho cột email ở bảng customers.
- Kết quả: Hệ thống CHẶN LẠI hoàn toàn, không cho phép khách hàng "Nguyễn Lơ Đãng" được thêm vào database.
- Tác dụng: Giúp dữ liệu nhà sách luôn sạch, không bị rối loạn khi một email đại diện cho nhiều người.
*/