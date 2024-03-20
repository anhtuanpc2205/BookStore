IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'BookStore')
BEGIN
	CREATE DATABASE BookStore;
END;
GO
USE BookStore;
GO

-- Bảng lưu thông tin về các tác giả
CREATE TABLE Author(
    author_id INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính: ID của tác giả
    author_name VARCHAR(255) NOT NULL, -- Tên của tác giả
    description_ TEXT, -- Mô tả về tác giả
	profile_image_url VARCHAR(255) -- Đường dẫn ảnh tác giả
);

-- Tạo bảng Blog
CREATE TABLE Blog (
    blog_id INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính: ID của bài viết trong blog
    blog_title VARCHAR(255) NOT NULL, -- Tiêu đề của bài viết trong blog
    description_ TEXT, -- Mô tả về bài viết trong blog
    content_ TEXT, -- Nội dung của bài viết trong blog
    author_id INT NOT NULL, -- Khóa ngoại: ID của tác giả
	img_url VARCHAR(255),
	views_ INT DEFAULT 0
);

-- Bảng lưu thông tin về các hạng mục sách
CREATE TABLE Category(
    category_id INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính: ID của category
    category_name VARCHAR(50) NOT NULL -- Tên của category
);

-- Bảng lưu thông tin về các thể loại sách
CREATE TABLE Genre(
    genre_id INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính: ID của thể loại sách
    genre_name VARCHAR(50) NOT NULL, -- Tên của thể loại sách
);

-- Bảng lưu thông tin chung về cuốn sách
CREATE TABLE Book (
    book_id INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính: ID của cuốn sách
    title VARCHAR(255) NOT NULL, -- Tiêu đề của cuốn sách
    author_id INT NOT NULL, -- Khóa ngoại: ID của tác giả
	image_url VARCHAR(255), -- Đường dẫn ảnh bìa của cuốn sách
	description_ TEXT, -- Mô tả về cuốn sách
	Publisher VARCHAR(255), --Nhà xuất bản
	language_ VARCHAR(30),
	Illustrations_note VARCHAR(255), --Ghi chú minh họa
	Pages int
);

--Bảng lưu thông tin của định dạng sách
CREATE TABLE Format_ (
    format_id INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính: ID của định dạng
    format_name VARCHAR(50) NOT NULL -- Tên của định dạng
);

-- Bảng lưu thông tin chi tiết về cuốn sách 1-n với Book
CREATE TABLE Book_Detail (
	Book_Detail_id INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính: ID của chi tiết cuốn sách
    book_id INT NOT NULL, -- Khóa ngoại: ID của cuốn sách, tham chiếu từ bảng Book
	ISBN10 CHAR(10),
	ISBN13 CHAR(13),
	format_id INT NOT NULL, --Khóa ngoại: ID của 1 định dạng
    stock_quantity INT NOT NULL, -- Số lượng trong kho của cuốn sách
	views_ INT DEFAULT 0, -- Số lượt xem, mặc định là 0
	price DECIMAL(10, 2) NOT NULL, -- Giá của cuốn sách
	discount DECIMAL(5, 2) DEFAULT 0, -- Giảm giá, mặc định là 0
);
-- Bảng Book_s_Category_And_Genre lưu thông tin về Hạng Mục và thể loại của 1 cuốn sách
-- mô tả mối quan hệ n-n giữa bảng Category và Genre, một cuốn sách có thể có nhiều hạng mục và nhiều thể loại khác nhau
CREATE TABLE Book_s_Category_And_Genre (
	Book_s_Category_And_Genre_id INT IDENTITY(1,1) PRIMARY KEY,
    category_id INT NOT NULL,
    genre_id INT NOT NULL,
    book_id INT NOT NULL
);

-- Bảng lưu thông tin về người dùng
CREATE TABLE User_(
    user_id_ INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính: ID của người dùng
    user_name_ VARCHAR(50) NOT NULL, -- Tên đăng nhập của người dùng
    email VARCHAR(100) NOT NULL, -- Địa chỉ email của người dùng
    password_ VARCHAR(20) NOT NULL, -- Mật khẩu của người dùng
    shipping_address VARCHAR(255), -- Địa chỉ giao hàng của người dùng
    role_ TinyInt NOT NULL, -- Vai trò của người dùng (admin, user, ...) 1 cho admin,2 cho khách hàng
    profile_image_url VARCHAR(255) -- Đường dẫn ảnh đại diện của người dùng
);

-- Bảng lưu thông tin về các đơn hàng
CREATE TABLE Order_(
    order_id INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính: ID của đơn hàng
    user_id_ INT NOT NULL, -- Khóa ngoại: ID của người dùng
    order_date DATE NOT NULL, -- Ngày đặt hàng
    total_amount DECIMAL(10, 2) NOT NULL, -- Tổng số tiền của đơn hàng
    order_status VARCHAR(20) NOT NULL, -- Trạng thái của đơn hàng
    shipping_method VARCHAR(100), -- Phương thức vận chuyển
    payment_method VARCHAR(100), -- Phương thức thanh toán
    shipping_fee DECIMAL(10, 2) -- Phí vận chuyển
);

-- Bảng lưu thông tin về các chi tiết đơn hàng 1-n
CREATE TABLE Order_Detail(
	order_detail_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL, -- Khóa ngoại: ID của đơn hàng
    Book_Detail_id INT NOT NULL, -- Khóa ngoại: ID của chi tiết cuốn sách
    quantity INT NOT NULL, -- Số lượng của cuốn sách trong đơn hàng
);

-- Bảng lưu thông tin về user_wishlist 1-n
CREATE TABLE User_wishlist(
    wishlist_id INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính: ID của wishlist
    user_id_ INT NOT NULL, -- Khóa ngoại: ID của người dùng
    Book_Detail_id INT NOT NULL, -- Khóa ngoại: ID của chi tiết cuốn sách
);

--INSERT BEGIN
-- Insert vào bảng Category các category
INSERT INTO Category(category_name) VALUES 
('Art & Photography'),
('Biography'),
('Children''s Book'),
('Craft & Hobbies'),
('Crime & Thriller'),
('Fantasy & Horror'),
('Fiction'),
('Food & Drink'),
('Graphic,Anime & Manga'),
('Science Fiction');

INSERT INTO Genre(genre_name) VALUES 
('History'),
('Architecture'),
('Art Form');

INSERT INTO User_ (user_name_, email, password_, shipping_address, role_, profile_image_url)
VALUES ('Tran Ngoc Anh Tuan', 'ngocanhtuan2205@gmail.com', '123', '32 Hai Thuong Lan Ong, Vinh City', 1, 'images/users/img-01.jpg');

INSERT INTO Author (author_name, description_, profile_image_url) VALUES 
('John Smith', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', 'images/author/img-01.jpg'),
('Emily Johnson', 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.', 'images/author/img-02.jpg'),
('Michael Brown', 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores.', 'images/author/img-03.jpg'),
('Sarah Williams', 'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'images/author/img-04.jpg'),
('David Jones', 'Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.', 'images/author/img-05.jpg'),
('Jessica Taylor', 'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.', 'images/author/img-06.jpg'),
('Christopher Lee', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'images/author/img-07.jpg'),
('Olivia Martin', 'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?', 'images/author/img-08.jpg'),
('Matthew Wilson', 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', 'images/author/img-09.jpg'),
('Sophia Clark', 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.', 'images/author/img-10.jpg'),
('Ethan Moore', 'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 'images/author/img-11.jpg'),
('Isabella White', 'Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.', 'images/author/img-12.jpg'),
('Alexander Hall', 'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.', 'images/author/img-13.jpg'),
('Ava Thompson', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'images/author/img-14.jpg'),
('William Davis', 'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?', 'images/author/img-15.jpg'),
('Mia Rodriguez', 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', 'images/author/img-16.jpg'),
('James Martinez', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'images/author/img-17.jpg'),
('Emma Anderson', 'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?', 'images/author/img-18.jpg'),
('Benjamin Garcia', 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', 'images/author/img-19.jpg'),
('Charlotte Hernandez', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'images/author/img-20.jpg'),
('Jacob Lopez', 'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?', 'images/author/img-21.jpg'),
('Amelia Nelson', 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', 'images/author/img-22.jpg'),
('Daniel King', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'images/author/img-23.jpg'),
('Harper Carter', 'Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?', 'images/author/img-24.jpg'),
('Scarlet Hawthorne', 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', 'images/author/img-25.jpg'),
('Evelyn Ramirez', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 'images/author/img-26.jpg');

INSERT INTO Format_ (format_name) VALUES 
('Hardback'),
('CD-Audio'),
('Paperback'),
('E-Book');

INSERT INTO Blog (blog_title, description_, content_, author_id, img_url, views_)
VALUES (
    'Where The Wild Things Are',
    'Adventure, Fun',
    'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus.

Eor sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aute fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip apeicommodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim.

Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae.',
    1, -- ID của tác giả
    'images/blog/img-01.jpg', -- Đường dẫn đến hình ảnh
    DEFAULT -- Giá trị mặc định cho views_
),
(
    'Where The Wild Things Are',
    'Adventure, Fun',
    'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus.

Eor sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aute fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip apeicommodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim.

Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae.',
    2, -- ID của tác giả
    'images/blog/img-02.jpg', -- Đường dẫn đến hình ảnh
    DEFAULT -- Giá trị mặc định cho views_
),
(
    'Where The Wild Things Are',
    'Adventure, Fun',
    'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus.

Eor sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aute fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip apeicommodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim.

Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae.',
    3, -- ID của tác giả
    'images/blog/img-03.jpg', -- Đường dẫn đến hình ảnh
    DEFAULT -- Giá trị mặc định cho views_
),
(
    'Where The Wild Things Are',
    'Adventure, Fun',
    'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus.

Eor sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aute fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip apeicommodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim.

Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae.',
    4, -- ID của tác giả
    'images/blog/img-04.jpg', -- Đường dẫn đến hình ảnh
    DEFAULT -- Giá trị mặc định cho views_
),
(
    'Where The Wild Things Are',
    'Adventure, Fun',
    'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus.

Eor sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aute fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip apeicommodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim.

Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae.',
    5, -- ID của tác giả
    'images/blog/img-05.jpg', -- Đường dẫn đến hình ảnh
    DEFAULT -- Giá trị mặc định cho views_
),
(
    'Where The Wild Things Are',
    'Adventure, Fun',
    'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus.

Eor sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aute fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip apeicommodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim.

Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae.',
    6, -- ID của tác giả
    'images/blog/img-06.jpg', -- Đường dẫn đến hình ảnh
    DEFAULT -- Giá trị mặc định cho views_
),
(
    'Where The Wild Things Are',
    'Adventure, Fun',
    'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus.

Eor sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aute fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip apeicommodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim.

Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae.',
    7, -- ID của tác giả
    'images/blog/img-07.jpg', -- Đường dẫn đến hình ảnh
    DEFAULT -- Giá trị mặc định cho views_
),
(
    'Where The Wild Things Are',
    'Adventure, Fun',
    'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus.

Eor sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aute fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip apeicommodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim.

Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae.',
    8, -- ID của tác giả
    'images/blog/img-08.jpg', -- Đường dẫn đến hình ảnh
    DEFAULT -- Giá trị mặc định cho views_
),
(
    'Where The Wild Things Are',
    'Adventure, Fun',
    'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus.

Eor sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aute fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip apeicommodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim.

Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae.',
    9, -- ID của tác giả
    'images/blog/img-09.jpg', -- Đường dẫn đến hình ảnh
    DEFAULT -- Giá trị mặc định cho views_
),
(
    'Where The Wild Things Are',
    'Adventure, Fun',
    'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus.

Eor sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aute fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip apeicommodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim.

Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae.',
    10, -- ID của tác giả
    'images/blog/img-10.jpg', -- Đường dẫn đến hình ảnh
    DEFAULT -- Giá trị mặc định cho views_
),
(
    'Where The Wild Things Are',
    'Adventure, Fun',
    'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus.

Eor sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aute fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip apeicommodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim.

Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae.',
    11, -- ID của tác giả
    'images/blog/img-11.jpg', -- Đường dẫn đến hình ảnh
    DEFAULT -- Giá trị mặc định cho views_
),
(
    'Where The Wild Things Are',
    'Adventure, Fun',
    'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus.

Eor sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aute fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip apeicommodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim.

Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae.',
    12, -- ID của tác giả
    'images/blog/img-12.jpg', -- Đường dẫn đến hình ảnh
    DEFAULT -- Giá trị mặc định cho views_
),
(
    'Where The Wild Things Are',
    'Adventure, Fun',
    'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus.

Eor sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aute fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip apeicommodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim.

Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae.',
    13, -- ID của tác giả
    'images/blog/img-13.jpg', -- Đường dẫn đến hình ảnh
    DEFAULT -- Giá trị mặc định cho views_
),
(
    'Where The Wild Things Are',
    'Adventure, Fun',
    'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus.

Eor sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aute fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip apeicommodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim.

Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae.',
    14, -- ID của tác giả
    'images/blog/img-14.jpg', -- Đường dẫn đến hình ảnh
    DEFAULT -- Giá trị mặc định cho views_
),
(
    'Where The Wild Things Are',
    'Adventure, Fun',
    'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim id est laborum sed ut perspiciatis unde omnis iste natus.

Eor sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aute fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip apeicommodo consequat aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident, sunt in culpa quistan officia deserunt mollit anim.

Laborum sed ut perspiciatis unde omnis iste natus sit voluptatem accusantium doloremque laudantium totam rem aperiam eaque ipsa quae ab illo inventore veritatis etation quasi architecto beatae.',
    15, -- ID của tác giả
    'images/blog/img-15.jpg', -- Đường dẫn đến hình ảnh
    DEFAULT -- Giá trị mặc định cho views_
);
----------------------------------------------------------------------------------------------
-- !Thêm thông tin về các cuốn sách vào bảng Book!
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Where The Wild Things Are', -- Tiêu đề của sách
    1, -- ID của tác giả
    'images/books/img-01.jpg', -- Đường dẫn đến ảnh bìa của sách
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', -- Mô tả về sách
    'Sunshine Orlando', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'b&w images thru-out; 1 x 16pp colour plates', -- Ghi chú về minh họa
    120 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id INT;
SET @book_id = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id, -- ID của cuốn sách
    '1234567890', -- ISBN10 (mã số quốc tế của sách)
    '1234567890123', -- ISBN13 (mã số quốc tế của sách)
    1, -- ID của định dạng sách (giả sử là Hardback)
    100, -- Số lượng sách trong kho
    25.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id, 7, 1),
    (@book_id, 7, 2); 


-- Book 1
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 1', -- Tiêu đề của sách
    3, -- ID của tác giả
    'images/books/img-03.jpg', -- Đường dẫn đến ảnh bìa của sách
    'Description of Book 1', -- Mô tả về sách
    'Publisher 1', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 1', -- Ghi chú về minh họa
    200 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_1 INT;
SET @book_id_1 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_1, -- ID của cuốn sách
    '0123456789', -- ISBN10 (mã số quốc tế của sách)
    '0123456789012', -- ISBN13 (mã số quốc tế của sách)
    1, -- ID của định dạng sách (giả sử là Hardback)
    80, -- Số lượng sách trong kho
    30.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_1, 2, 1),
    (@book_id_1, 3, 2);

-- Tiếp tục cho các cuốn sách còn lại tương tự như trên

-- Book 2
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 2', -- Tiêu đề của sách
    5, -- ID của tác giả
    'images/books/img-02.jpg', -- Đường dẫn đến ảnh bìa của sách
    'Description of Book 2', -- Mô tả về sách
    'Publisher 2', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 2', -- Ghi chú về minh họa
    150 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_2 INT;
SET @book_id_2 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_2, -- ID của cuốn sách
    '123567890', -- ISBN10 (mã số quốc tế của sách)
    '1237567890123', -- ISBN13 (mã số quốc tế của sách)
    2, -- ID của định dạng sách (giả sử là CD-Audio)
    100, -- Số lượng sách trong kho
    24.50 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_2, 1, 3),
    (@book_id_2, 4, 2);

-- Book 5
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 5', -- Tiêu đề của sách
    5, -- ID của tác giả
    'images/books/img-05.jpg', -- Đường dẫn đến ảnh bìa của sách
    'Description of Book 5', -- Mô tả về sách
    'Publisher 5', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 5', -- Ghi chú về minh họa
    220 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_5 INT;
SET @book_id_5 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_5, -- ID của cuốn sách
    '5678901234', -- ISBN10 (mã số quốc tế của sách)
    '5678901234567', -- ISBN13 (mã số quốc tế của sách)
    2, -- ID của định dạng sách (giả sử là CD-Audio)
    75, -- Số lượng sách trong kho
    34.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_5, 3, 2),
    (@book_id_5, 8, 1);

-- Book 6
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 6', -- Tiêu đề của sách
    3, -- ID của tác giả (giống với cuốn số 4)
    'images/books/img-06.jpg', -- Đường dẫn đến ảnh bìa của sách
    'Description of Book 6', -- Mô tả về sách
    'Publisher 6', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 6', -- Ghi chú về minh họa
    180 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_6 INT;
SET @book_id_6 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_6, -- ID của cuốn sách
    '6789012345', -- ISBN10 (mã số quốc tế của sách)
    '6789012345678', -- ISBN13 (mã số quốc tế của sách)
    3, -- ID của định dạng sách (giả sử là Paperback)
    90, -- Số lượng sách trong kho
    19.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_6, 4, 2),
    (@book_id_6, 5, 3);

-- Book 7
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 7', -- Tiêu đề của sách
    2, -- ID của tác giả
    'images/books/img-07.jpg', -- Đường dẫn đến ảnh bìa của sách
    'Description of Book 7', -- Mô tả về sách
    'Publisher 7', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 7', -- Ghi chú về minh họa
    220 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_7 INT;
SET @book_id_7 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_7, -- ID của cuốn sách
    '7890123456', -- ISBN10 (mã số quốc tế của sách)
    '7890123456789', -- ISBN13 (mã số quốc tế của sách)
    4, -- ID của định dạng sách (giả sử là E-Book)
    80, -- Số lượng sách trong kho
    12.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_7, 2, 1),
    (@book_id_7, 3, 1);

-- Book 8
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 8', -- Tiêu đề của sách
    3, -- ID của tác giả
    'images/books/img-08.jpg', -- Đường dẫn đến ảnh bìa của sách
    'Description of Book 8', -- Mô tả về sách
    'Publisher 8', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 8', -- Ghi chú về minh họa
    180 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_8 INT;
SET @book_id_8 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_8, -- ID của cuốn sách
    '8901234567', -- ISBN10 (mã số quốc tế của sách)
    '8901234567890', -- ISBN13 (mã số quốc tế của sách)
    2, -- ID của định dạng sách (giả sử là CD-Audio)
    120, -- Số lượng sách trong kho
    29.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_8, 4, 2),
    (@book_id_8, 5, 1);

-- Book 9
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 9', -- Tiêu đề của sách
    5, -- ID của tác giả
    'images/books/img-09.jpg', -- Đường dẫn đến ảnh bìa của sách
    'Description of Book 9', -- Mô tả về sách
    'Publisher 9', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 9', -- Ghi chú về minh họa
    220 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_9 INT;
SET @book_id_9 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_9, -- ID của cuốn sách
    '9012345678', -- ISBN10 (mã số quốc tế của sách)
    '9012345678901', -- ISBN13 (mã số quốc tế của sách)
    3, -- ID của định dạng sách (giả sử là Paperback)
    150, -- Số lượng sách trong kho
    19.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_9, 1, 3),
    (@book_id_9, 3, 1);

-- Book 10
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 10', -- Tiêu đề của sách
    6, -- ID của tác giả
    'images/books/img-10.jpg', -- Đường dẫn đến ảnh bìa của sách
    'Description of Book 10', -- Mô tả về sách
    'Publisher 10', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 10', -- Ghi chú về minh họa
    180 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_10 INT;
SET @book_id_10 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_10, -- ID của cuốn sách
    '1012345678', -- ISBN10 (mã số quốc tế của sách)
    '1012345678901', -- ISBN13 (mã số quốc tế của sách)
    4, -- ID của định dạng sách (giả sử là E-Book)
    200, -- Số lượng sách trong kho
    14.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_10, 4, 2),
    (@book_id_10, 5, 3);

-- Book 11
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 11', -- Tiêu đề của sách
    6, -- ID của tác giả
    'images/books/img-11.jpg', -- Đường dẫn đến ảnh bìa của sách (để trống)
    'Description of Book 11', -- Mô tả về sách
    'Publisher 11', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 11', -- Ghi chú về minh họa
    180 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_11 INT;
SET @book_id_11 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_11, -- ID của cuốn sách
    '1012345678', -- ISBN10 (mã số quốc tế của sách)
    '1012345678901', -- ISBN13 (mã số quốc tế của sách)
    2, -- ID của định dạng sách (giả sử là CD-Audio)
    80, -- Số lượng sách trong kho
    15.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_11, 2, 2),
    (@book_id_11, 3, 3);

-- Book 12
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 12', -- Tiêu đề của sách
    8, -- ID của tác giả
    'images/books/img-12.jpg', -- Đường dẫn đến ảnh bìa của sách
    'Description of Book 12', -- Mô tả về sách
    'Publisher 12', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 12', -- Ghi chú về minh họa
    200 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_12 INT;
SET @book_id_12 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_12, -- ID của cuốn sách
    '1212345678', -- ISBN10 (mã số quốc tế của sách)
    '1212345678901', -- ISBN13 (mã số quốc tế của sách)
    3, -- ID của định dạng sách (giả sử là Paperback)
    120, -- Số lượng sách trong kho
    20.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_12, 7, 3),
    (@book_id_12, 2, 1);

-- Book 13
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 13', -- Tiêu đề của sách
    9, -- ID của tác giả
    '', -- Đường dẫn đến ảnh bìa của sách (trống)
    'Description of Book 13', -- Mô tả về sách
    'Publisher 13', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 13', -- Ghi chú về minh họa
    180 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_13 INT;
SET @book_id_13 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_13, -- ID của cuốn sách
    '1312345678', -- ISBN10 (mã số quốc tế của sách)
    '1312345678901', -- ISBN13 (mã số quốc tế của sách)
    4, -- ID của định dạng sách (giả sử là E-Book)
    150, -- Số lượng sách trong kho
    15.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_13, 6, 2),
    (@book_id_13, 9, 3);

-- Book 14
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 14', -- Tiêu đề của sách
    10, -- ID của tác giả
    '', -- Đường dẫn đến ảnh bìa của sách (trống)
    'Description of Book 14', -- Mô tả về sách
    'Publisher 14', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 14', -- Ghi chú về minh họa
    200 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_14 INT;
SET @book_id_14 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_14, -- ID của cuốn sách
    '1412345678', -- ISBN10 (mã số quốc tế của sách)
    '1412345678901', -- ISBN13 (mã số quốc tế của sách)
    2, -- ID của định dạng sách (giả sử là CD-Audio)
    120, -- Số lượng sách trong kho
    20.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_14, 3, 1),
    (@book_id_14, 5, 3);


-- Book 15
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 15', -- Tiêu đề của sách
    7, -- ID của tác giả
    '', -- Đường dẫn đến ảnh bìa của sách
    'Description of Book 15', -- Mô tả về sách
    'Publisher 15', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 15', -- Ghi chú về minh họa
    250 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_15 INT;
SET @book_id_15 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_15, -- ID của cuốn sách
    '1512345678', -- ISBN10 (mã số quốc tế của sách)
    '1512345678901', -- ISBN13 (mã số quốc tế của sách)
    3, -- ID của định dạng sách (giả sử là Paperback)
    150, -- Số lượng sách trong kho
    18.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_15, 1, 2),
    (@book_id_15, 2, 3);

-- Book 16
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 16', -- Tiêu đề của sách
    8, -- ID của tác giả
    '', -- Đường dẫn đến ảnh bìa của sách
    'Description of Book 16', -- Mô tả về sách
    'Publisher 16', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 16', -- Ghi chú về minh họa
    300 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_16 INT;
SET @book_id_16 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_16, -- ID của cuốn sách
    '1612345678', -- ISBN10 (mã số quốc tế của sách)
    '1612345678901', -- ISBN13 (mã số quốc tế của sách)
    2, -- ID của định dạng sách (giả sử là CD-Audio)
    200, -- Số lượng sách trong kho
    22.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_16, 3, 1),
    (@book_id_16, 4, 2);

-- Book 17
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 17', -- Tiêu đề của sách
    9, -- ID của tác giả
    NULL, -- Đường dẫn đến ảnh bìa của sách (để trống)
    'Description of Book 17', -- Mô tả về sách
    'Publisher 17', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 17', -- Ghi chú về minh họa
    250 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_17 INT;
SET @book_id_17 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_17, -- ID của cuốn sách
    '1712345678', -- ISBN10 (mã số quốc tế của sách)
    '1712345678901', -- ISBN13 (mã số quốc tế của sách)
    3, -- ID của định dạng sách (giả sử là Paperback)
    150, -- Số lượng sách trong kho
    18.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_17, 10, 3);

-- Book 18
-- Thêm thông tin vào bảng Book
INSERT INTO Book (title, author_id, image_url, description_, Publisher, language_, Illustrations_note, Pages)
VALUES (
    'Book Title 18', -- Tiêu đề của sách
    5, -- ID của tác giả
    NULL, -- Đường dẫn đến ảnh bìa của sách (để trống)
    'Description of Book 18', -- Mô tả về sách
    'Publisher 18', -- Nhà xuất bản
    'English', -- Ngôn ngữ
    'Illustrations note of Book 18', -- Ghi chú về minh họa
    300 -- Số trang
);

-- Lấy ID của cuốn sách vừa thêm vào
DECLARE @book_id_18 INT;
SET @book_id_18 = SCOPE_IDENTITY();

-- Thêm thông tin chi tiết về cuốn sách vào bảng Book_Detail
INSERT INTO Book_Detail (book_id, ISBN10, ISBN13, format_id, stock_quantity, price)
VALUES (
    @book_id_18, -- ID của cuốn sách
    '1812345678', -- ISBN10 (mã số quốc tế của sách)
    '1812345678901', -- ISBN13 (mã số quốc tế của sách)
    2, -- ID của định dạng sách (giả sử là CD-Audio)
    200, -- Số lượng sách trong kho
    12.99 -- Giá sách
);

-- Thêm thông tin về hạng mục và thể loại của cuốn sách vào bảng Book_s_Category_And_Genre
INSERT INTO Book_s_Category_And_Genre (book_id, category_id, genre_id)
VALUES
    (@book_id_18, 10, 3);


-- !Thêm thông tin về các cuốn sách vào bảng Book!
----------------------------------------------------------------------------------------------------

--INSERT END

--FOREIGN KEY BEGIN

-- Thêm khóa ngoại vào bảng Book
ALTER TABLE Book
ADD CONSTRAINT fk_author_id FOREIGN KEY (author_id) REFERENCES Author(author_id);

-- Thêm ràng buộc khóa ngoại vào bảng Book_s_Category_And_Genre
ALTER TABLE Book_s_Category_And_Genre
ADD CONSTRAINT fk_Book_s_Category_And_Genre_book_id FOREIGN KEY (book_id) REFERENCES Book(book_id);

ALTER TABLE Book_s_Category_And_Genre
ADD CONSTRAINT fk_Book_s_Category_And_Genre_CategoryId FOREIGN KEY (category_id) REFERENCES Category(category_id);
ALTER TABLE Book_s_Category_And_Genre
ADD CONSTRAINT fk_Book_s_Category_And_Genre_Genre_id FOREIGN KEY (genre_id) REFERENCES Genre(genre_id);

-- Thêm khóa ngoại vào bảng Book_Detail
ALTER TABLE Book_Detail
ADD CONSTRAINT fk_bookDetail FOREIGN KEY (book_id) REFERENCES Book(book_id);
ALTER TABLE Book_Detail
ADD CONSTRAINT fk_bookDetail_Format_ FOREIGN KEY (format_id) REFERENCES Format_(format_id );

-- Thêm khóa ngoại vào bảng Order_
ALTER TABLE Order_
ADD CONSTRAINT user_id_ FOREIGN KEY (user_id_) REFERENCES User_(user_id_);

-- Thêm khóa ngoại vào bảng Blog
ALTER TABLE Blog
ADD CONSTRAINT fk_Blog_author_id FOREIGN KEY (author_id) REFERENCES Author(author_id);

-- Thêm khóa ngoại vào bảng Order_Detail
ALTER TABLE Order_Detail
ADD CONSTRAINT fk_orderDetail_id FOREIGN KEY (order_id) REFERENCES Order_(order_id);

ALTER TABLE Order_Detail
ADD CONSTRAINT fk_orderDetail_Book_Detail_id FOREIGN KEY (Book_Detail_id) REFERENCES Book_Detail(Book_Detail_id);

-- Thêm khóa ngoại vào bảng user_wishlist
ALTER TABLE User_wishlist
ADD CONSTRAINT fk_user_wishlist_user_id FOREIGN KEY (user_id_) REFERENCES User_(user_id_); 

ALTER TABLE User_wishlist
ADD CONSTRAINT fk_user_wishlist_Book_Detail FOREIGN KEY (Book_Detail_id) REFERENCES Book_Detail(Book_Detail_id);
--FOREIGN KEY END

