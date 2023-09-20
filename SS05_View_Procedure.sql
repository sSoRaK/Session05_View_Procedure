create database ss4_QLBH;
use ss4_QLBH;

-- create Category
create table Category(
  CategoryID int primary key auto_increment,
  CategoryName varchar(50) not null unique,
  Description text,
  Status bit default 1
);
-- create Product
create table Product(
  ProductID varchar(5) primary key,
  ProductName varchar(100) not null unique,
  CreateDate date default (curdate()),
  Price float default 0,
  Description text,
  Title varchar(200),
  CategoryID int, 
  foreign key (CategoryID) references Category(CategoryID),
  Status bit default 1
);
-- insert into Category
insert into Category (CategoryName, Description, Status)
values
      ('Category 1', 'Desc 1', 1),
      ('Category 2', 'Desc 2', 0),
      ('Category 3', 'Desc 3', 1),
      ('Category 4', 'Desc 4', 0);
-- insert into Category
insert into Product (ProductID, ProductName, CreateDate, Price, Description, Title, CategoryID, Status)
values
      ('PA001', 'Circurt Board', '1970-05-25', 150.75, 'Electrical', 'Product 1', 1, 0),
      ('PA002', 'Smartphone', '2007-09-05', 550.5, 'Electrical', 'Product 2', 2, 0),
      ('PB001', 'Table', '1998-08-21', 250.75, 'Houseware', 'Product 3', 1, 1),
      ('PC002', 'Jean Cloths', '1987-11-23', 50.4, 'Cloths', 'Product 4', 3, 0),
      ('PD001', 'Hamburger', '2001-03-30', 10.75, 'Foods', 'Product 5', 4, 1);
insert into Product (ProductID, ProductName, CreateDate, Price, Description, Title, CategoryID, Status)
values
      ('PA003', 'RGB Led', '1975-05-25', 150.75, 'Electrical', 'Product 6', 1, 0),
      ('PC001', 'Laptop', '2002-09-05', 20550.5, 'Electrical', 'Product 7', 3, 0),
      ('PB002', 'Lamp', '1999-08-21', 250.75, 'Houseware', 'Product 8', 2, 0),
      ('PC004', 'Jacket', '1987-11-23', 31850.4, 'Cloths', 'Product 9', 4, 0),
      ('PD006', 'Pizza', '2003-03-30', 21070.75, 'Foods', 'Product 10', 1, 1);
      
-- create view 
/*
Tạo view gồm các sản phẩm có giá lớn hơn 20000 gồm các thông tin sau: 
    mã danh mục, tên danh mục, trạng thái danh mục, mã sản phẩm, tên sản phẩm, 
    giá sản phẩm, trạng thái sản phẩm
*/
create view vw_productPrice 
as 
select Category.CategoryID, Category.CategoryName, Category.Status as Category_status, Product.ProductID, Product.ProductName, Product.Price, Product.Status as Product_status
from Category
inner join Product on Product.CategoryID = Category.CategoryID
where Product.Price > 20000;

select * from vw_productPrice;

-- create procedure 
/*
5. Tạo các procedure sau:
    - procedure cho phép thêm, sửa, xóa, lấy tất cả dữ liệu, lấy dữ liệu theo mã
    của bảng danh mục và sản phẩm
    - procedure cho phép lấy ra tất cả các phẩm có trạng thái là 1
    bao gồm mã sản phẩm, tên sản phẩm, giá, tên danh mục, trạng thái sản phẩm
    - procedure cho phép thống kê số sản phẩm theo từng mã danh mục
    - procedure cho phép tìm kiếm sản phẩm theo tên sản phầm: mã sản phẩm, tên
    sản phẩm, giá, trạng thái sản phẩm, tên danh mục, trạng thái danh mục
*/
-- INSERT Category
DELIMITER //
create procedure insert_category (
	in category_name varchar(50),
    in category_des text,
    category_stt bit
)
BEGIN
	insert into Category(CategoryName, Description, Status)
    	values (category_name, category_des, category_stt);
END //
DELIMITER ;
call insert_category('Category 5', 'Desc 5', 1);

-- UPDATE Category
DELIMITER //
create procedure update_category(
	category_id int,
	in category_name varchar(50),
    category_des text,
    category_stt bit
)
BEGIN
	update Category
		set CategoryName = category_name,
			Description = category_des,
	            Status = category_stt
		where CategoryID = category_id;
END //
DELIMITER ;
call update_category(5, 'Category 5 - 1', 'Desc 5', 0);

-- DELETE Category
DELIMITER //
create procedure delete_category(
	category_id int
)
BEGIN
	delete from Category where category_id = categoryID;
END //
DELIMITER ;
call delete_category(5);

-- Get all info Category
DELIMITER //
create procedure get_info_category()
BEGIN
	select * from Category;
END //
DELIMITER ;
call get_info_category;

-- Get Category by ID
DELIMITER //
create procedure get_category_byID(
	in category_id int
)
BEGIN
	select CategoryID, CategoryName, Description, Status
    from Category 
    where category_id = CategoryID;
END //
DELIMITER ;
call get_category_byID (2);

-- Insert Product
DELIMITER //
create procedure insert_product(
	in product_id varchar(5),
    in product_name varchar(100),
    in create_date date,
    in product_price float,
    in product_des text,
    in title varchar(200),
    in category_id int,
    in product_stt bit
)
BEGIN 
	insert into Product
    values(product_id, product_name, create_date, product_price, product_des, title, category_id, product_stt);
END //
DELIMITER ;
call insert_product('PB005', 'Baking soda', '2000-04-15', 27070.75, 'Ingredient', 'Product 11', 2, 0);

-- Update Product
DELIMITER //
create procedure update_product(
	in product_id varchar(5),
    in product_name varchar(100),
    in create_date date,
    in product_price float,
    in product_des text,
    in product_title varchar(200),
    in category_id int,
    in product_stt bit
)
BEGIN
	update Product
    set ProductID = product_id,
		ProductName = product_name,
        CreateDate = create_date,
        Price = product_price,
        Description = product_des,
        Title = product_title,
        CategoryID = category_id,
        Status = product_stt
        where ProductID = product_id;
END //
DELIMITER ;
call update_product('PB005', 'Soda Drink', '2003-03-30', 20070.15, 'Drinks', 'Product 11', 4, 1);

-- DELETE Product
DELIMITER //
create procedure delete_product(
	in product_id varchar(5)
)
BEGIN
	delete from Product where product_id = ProductID;
END //
DELIMITER ;
call delete_product('PB005');

-- Get all info Product
DELIMITER //
create procedure get_info_product()
BEGIN
	select * from Product;
END //
DELIMITER ;
call get_info_product();

-- Get info Product by ID
DELIMITER //
create procedure get_product_byID(
	in product_id varchar(5)
)
BEGIN
	select * from Product where product_id = ProductID;
END //
DELIMITER ;
call get_product_byID('PA003');

-- Get Product have Status = 1 
DELIMITER //
create procedure get_product_bySTT()
BEGIN
	select Product.ProductID, Product.ProductName, Product.Price, Category.CategoryName, Product.Status
    from Product
    inner join Category on Category.CategoryID = Product.CategoryID
    where Product.Status = 1;
END //
DELIMITER ;
call get_product_bySTT();

-- Product Statistical by each CategoryID
DELIMITER //
create procedure product_statistical()
BEGIN
	select Category.CategoryID, count(ProductID) as Quantity
    from Category
    inner join Product on Product.CategoryID = Category.CategoryID
    group by Category.CategoryID
    order by Category.CategoryID;
END //
DELIMITER ;
call product_statistical();

-- Search Product by ProductName
DELIMITER //
create procedure search_product(
	in product_name varchar(100)
)
BEGIN 
	select ProductID, ProductName, Price, Product.Status, Category.CategoryName, Category.Status from Product
    inner join Category on Category.CategoryID = Product.CategoryID
    where ProductName like concat('%', product_name , '%');
END //
DELIMITER ;
call search_product('CloTh');










