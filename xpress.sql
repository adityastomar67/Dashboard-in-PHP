DROP DATABASE IF EXISTS xpress;

CREATE DATABASE xpress;

USE xpress;

CREATE TABLE users (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    phone INT NOT NULL,
    profile_img BLOB,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(45) NOT NULL,
    addr VARCHAR(255),
    city VARCHAR(45) NOT NULL,
    registered_on DATETIME NOT NULL
);

CREATE TABLE administrator (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(45) NOT NULL,
    password VARCHAR(45) NOT NULL
);

CREATE TABLE tasks (
    task_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    task_name VARCHAR(45) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_on DATETIME,
    completed_on DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE customers (
    customer_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE payments (
    payment_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    confirm_ticket BIT NOT NULL,
    package_type VARCHAR(45),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE orders (
    order_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    price INT NOT NULL,
    created_on DATETIME NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE categories (
    category_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(255) NOT NULL
);

CREATE TABLE subcategories (
    subcategory_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    category_id INT NOT NULL,
    subcategory_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE blogs (
    blog_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    subcategory INT NOT NULL,
    created_on DATETIME NOT NULL,
    img BLOB,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (subcategory) REFERENCES subcategories(subcategory_id)
);

CREATE TABLE magzines (
    magzine_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    magzine_title VARCHAR(45) NOT NULL,
    created_on DATETIME NOT NULL,
    img BLOB,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE posts (
    post_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    magzine_id INT NOT NULL,
    blog_id INT NOT NULL,
    post_title VARCHAR(45) NOT NULL,
    post_body VARCHAR(255) NOT NULL,
    created_on DATETIME NOT NULL,
    img BLOB,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (magzine_id) REFERENCES magzines(magzine_id),
    FOREIGN KEY (blog_id) REFERENCES blogs(blog_id)
);

CREATE TABLE comments (
    comment_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    post_id INT NOT NULL,
    username VARCHAR(45) NOT NULL,
    created_on DATETIME NOT NULL,
    content VARCHAR (255),
    FOREIGN KEY (post_id) REFERENCES posts(post_id)
);

CREATE TABLE tags (
    tag_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tag_name VARCHAR(45) NOT NULL
);

CREATE TABLE tag_post_map (
    tag_id INT NOT NULL,
    post_id INT NOT NULL,
    FOREIGN KEY (tag_id) REFERENCES tags(tag_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id)
);